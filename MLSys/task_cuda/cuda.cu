#include <cmath>
#include <cuda.h>
#include <cuda_runtime.h>
#include <torch/extension.h>
#include <iostream>

#define FLOAT4(value) (reinterpret_cast<float4 *>(&(value))[0])
#define CFLOAT4(value) (reinterpret_cast<const float4 *>(&(value))[0])

__global__ void kernel(const float *__restrict__ A_ptr,
                       const float *__restrict__ B_ptr,
                       float *__restrict__ result_ptr,
                       const int num_elements) {
  // TODO: Implement the Kernel Logic
    int idx = 4 * (blockIdx.x * blockDim.x + threadIdx.x);
        if (idx < num_elements) {
            auto a = CFLOAT4(A_ptr[idx]);
            auto b = CFLOAT4(B_ptr[idx]);
            float4 c;
            c.x = a.x + b.x;
            c.y = a.y + b.y;
            c.z = a.z + b.z;
            c.w = a.w + b.w;
            FLOAT4(result_ptr[idx]) = c;
        }
  // Sum up all the elements in the input tensor
}

static void launch_kernel(const void *A_ptr, const void *B_ptr, void *output_ptr,
                          const int num_elements) {
  // TODO: Implement the LaunchKernel Logic
  dim3 block_size(num_elements<512 ? num_elements/4 : 128);     
  dim3 grid_size((num_elements + block_size.x*4 - 1) / (block_size.x * 4));
  kernel<<<grid_size, block_size>>>(
    (const float*)A_ptr, (const float*)B_ptr, (float*)output_ptr, num_elements
  );
  //std::cout << "\n\nWarning: Need to implement the this!!\n\n" << std::endl;
  cudaDeviceSynchronize();
}

torch::Tensor test_kernel(const torch::Tensor &A, const torch::Tensor &B) {
  torch::Tensor result_tensor = torch::empty_like(A);
  const int element_count = A.numel();

  launch_kernel(A.data_ptr<float>(), B.data_ptr<float>(), result_tensor.data_ptr<float>(),
                element_count);

  return result_tensor;
}

PYBIND11_MODULE(CUDA_Test, m) {
  m.def("test_kernel", &test_kernel, "Test kernel");
}