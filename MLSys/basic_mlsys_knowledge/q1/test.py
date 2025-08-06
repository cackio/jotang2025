import onnxruntime as ort
from transformers import AutoTokenizer
import numpy as np

# 加载 tokenizer
model_name_or_path = "tiny-gpt2-onnx/"
tokenizer = AutoTokenizer.from_pretrained(model_name_or_path,use_fast=True)
if tokenizer.pad_token_id is None:
    tokenizer.pad_token_id = tokenizer.eos_token_id

# 创建 ONNX 推理 Session（这里只用 CPU）
ort_sess = ort.InferenceSession(
    "tiny-gpt2-onnx/model.onnx",
    providers=["CPUExecutionProvider"],
)

# 单步前向，新增 position_ids
def onnx_step(input_ids, attention_mask, position_ids):
    ort_inputs = {
        "input_ids":      input_ids.astype(np.int64),
        "attention_mask": attention_mask.astype(np.int64),
        "position_ids":   position_ids.astype(np.int64),
    }

    logits = ort_sess.run(["logits"], ort_inputs)[0]
    return logits

def generate_onnx(prompt: str, max_new_tokens: int = 50):
    # 初始编码
    enc = tokenizer(prompt, return_tensors="np")
    input_ids      = enc["input_ids"]      # shape (1, seq_len)
    attention_mask = enc["attention_mask"]  # shape (1, seq_len)

    seq_len = input_ids.shape[1]
    position_ids = np.arange(seq_len, dtype=np.int64)[None, :]

    for _ in range(max_new_tokens):
        logits = onnx_step(input_ids, attention_mask, position_ids)
        next_token_logits = logits[:, -1, :]                # shape (1, vocab)
        next_token = np.argmax(next_token_logits, axis=-1)  # shape (1,)
        next_token = next_token[:, None]                    # reshape to (1,1)

        # 拼接新 token
        input_ids      = np.concatenate([input_ids,      next_token], axis=1)
        attention_mask = np.concatenate([attention_mask, np.ones_like(next_token)], axis=1)

        new_pos = position_ids[:, -1:] + 1
        position_ids = np.concatenate([position_ids, new_pos], axis=1)

        if next_token.item() == tokenizer.eos_token_id:
            break

    return tokenizer.decode(input_ids[0], skip_special_tokens=True)

# 5. 测试
if __name__ == "__main__":
    print(generate_onnx("Hello, how are you?", max_new_tokens=30))
