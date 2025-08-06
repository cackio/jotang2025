# Question

## Cutlass (Cute)

### Cute 是如何解决线程 Layout 映射的？

layout抽象是由两个整型元组组合而成，layout=shape+stride，shape 描述多维张量结构，stride 定义每个维度的线性偏移。CuTe允许定义线程分配的数据块（block/tile）大小，然后使用线程布局将线程编号映射到对应数据子块中,进一步在 kernel 中使用类似 local_partition(tile, ThreadLayout{}, threadIdx.x) 将 block 内 tensor 块按线程编号进行切片映射，每个线程处理自己的一小块值布局.

### Cutlass4.0 (Cute DSL)

在今年6月的 CUTLASS 4.0 中，NV首次引入CuTe DSL，这是一个Python原生 DSL，用于设备端GPU kernel设计，功能与CuTe C++一致，但语法更直观且编译速度极快。
>* 采用纯 Python 语法，使用`pip install nvidia-cutlass-dsl`即可调用 GPU kernels，无需 NVCC，编译速度比 C++ 快 100 倍以上，但仍保持与 CuTe C++ 同等效率
>* DSL 暴露与 CuTe C++ 完全一致的抽象接口，例如：Layouts、Tensors、hardware atoms 等，便于性能控制与复用

CuTe DSL 将 GPU Kernel 开发的性能与灵活性完整保留，同时用 Python 大幅降低了学习门槛与迭代成本。

## Pytorch 算子 下降到底层 CUDA 代码 的过程

整体大致流程：
1. Python 前端调用
2. Dispatcher 调度
3. Meta + Impl 处理
4. CUDA Kernel 启动
5. Autograd 记录

1.Python 前端调用
* 在 Python 层调用诸如 torch.add(a, b)、torch.matmul(a, b) 等函数，最终会调用 C++ 扩展接口，如 torch._C._VariableFunctions.add。

2.Dispatcher 调度
* DispatchKey：每个 Tensor 带有一组标签（CPU、CUDA、AutogradCUDA 等）。
* Operator 注册：编译时根据 native_functions.yaml 生成注册表，把 aten::add、aten::matmul 等映射到不同后端。
* 选择实现：调用时，Dispatcher 根据第一个张量的最高优先级 DispatchKey，路由到 CUDA 分支或 CPU 分支。

3.Meta + Impl 处理
* Meta会检查输入的形状、dtype 是否符合要求，根据需求分配或调整输出张量的元信息
* Impl阶段会调用 TensorIterator 将多输入张量“打平”成可并行迭代的形式，TensorIterator 会自动为不同数据类型、不同设备选择最优路径，最终通过 gpu_kernel 模板，发起具体的 CUDA kernel 调用。

4.CUDA Kernel 启动
* Launcher：对应的 C++ 函数（如 launch_add、launch_matmul）会负责launch kernal

5.Autograd 记录
* 前向时，AutogradCUDA 会在 Dispatcher 中插入计算节点，记录输入、输出和 backward 函数。
* 反向时，再次走 Dispatcher → CUDA kernel（如 matmul_backward_kernel）计算梯度。

## ThunderKittens
ThunderKittens（TK） 是一个专为 AI 内核（kernels）开发而设计的 C++ 嵌入式框架，它通过少量关键抽象，简化在 NVIDIA GPU（尤其是 Tensor Core）上编写高性能深度学习算子的流程，同时保持极高的执行效率。

>* 上手简单：API 设计贴近 CUDA 原生风格，却大幅减少模板啰嗦。
>* 高度可扩展:原生嵌入 CUDA，缺少某特性时可直接调用底层并自定义扩展，不受框架限制。
>* 性能竞争力:生成的 kernel 在 GEMM、FlashAttention-3 等任务上可 匹配或超过 cuBLAS性能
>* 新硬件特性支持：在 Blackwell 架构上，利用专门的tensor memory（额外 ~256 KB寄存器）和CTA Pair协作特性，进一步提升数据流水效率与吞吐量

ThunderKittens用极简的几何抽象和分层编程模型，在保持与手写CUDA同级别性能的同时，大幅降低了内核开发的复杂度。