import numpy as np

arr = np.array([[1, 2], [3, 4]])  # 2x2

exp1 = arr[:, :, None]  # Shape: (2,2,1)
exp2 = arr[None, :, :]  # Shape: (1,2,2)
print(exp1.shape, exp2.shape)  # Output: (2, 2, 1) (1, 2, 2)
