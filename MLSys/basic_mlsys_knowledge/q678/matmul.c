#include <immintrin.h>
#include <stddef.h>
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define INTER 2000
double now_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1000.0 + ts.tv_nsec / 1e6;
}

inline void matmul_avx2_row(const float *restrict rowA,
                                   const float *restrict B,
                                   float *restrict       rowC,
                                   size_t N, size_t K)
{
    const size_t simd_w = 8;
    size_t j;
    for (j = 0; j + simd_w <= N; j += simd_w) {
        __m256 vsum = _mm256_setzero_ps();
        for (size_t k = 0; k < K; k++) {
            __m256 va = _mm256_set1_ps(rowA[k]);
            __m256 vb = _mm256_loadu_ps(&B[k*N + j]);
            vsum = _mm256_fmadd_ps(va, vb, vsum);
        }
        _mm256_storeu_ps(&rowC[j], vsum);
    }
}

//按行分块
void matmul_avx2_mt(const float *restrict A,
                    const float *restrict B,
                    float *restrict       C,
                    size_t M, size_t N, size_t K)
{

    #pragma omp parallel for schedule(static)
    for (size_t i = 0; i < M; i++) {
        const float *rowA = A + i*K;
        float       *rowC = C + i*N;
        matmul_avx2_row(rowA, B, rowC, N, K);
    }
}

int main() {
    size_t M = 256, K = 256, N = 256;
    float *A = malloc(sizeof(float)*M*K);
    float *B = malloc(sizeof(float)*K*N);
    float *C = malloc(sizeof(float)*M*N);

    for (size_t i = 0; i < M*K; i++) A[i] = (float)i;
    for (size_t i = 0; i < K*N; i++) B[i] = (float)(2*i);
    omp_set_num_threads(16);
    double t0 = now_ms();
    for (int it = 0; it < INTER; it++) {
        matmul_avx2_mt(A,B,C,M,N,K);
    }
    double t1 = now_ms();
    double tm = (t1 - t0) / INTER;

    printf("matmul: %.6f ms, C[0]=%.2f\n", tm, C[0]);      //防止算子被DCE优化掉

    free(A);
    free(B);
    free(C);
    return 0;
}