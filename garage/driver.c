#include <stdio.h>
#include <stdlib.h>

// Declare the LLVM IR function so we can link to it.
extern void matmul(
    int M, int N, int K,
    float *A_alloc, float *A_aligned, long A_offset, long A_size0, long A_size1, long A_stride0, long A_stride1,
    float *B_alloc, float *B_aligned, long B_offset, long B_size0, long B_size1, long B_stride0, long B_stride1,
    float *C_alloc, float *C_aligned, long C_offset, long C_size0, long C_size1, long C_stride0, long C_stride1);

int main() {
    int M = 1000, N = 1000, K = 1000;

    // Allocate matrices
    float *A = (float*)aligned_alloc(64, M * K * sizeof(float));
    float *B = (float*)aligned_alloc(64, K * N * sizeof(float));
    float *C = (float*)aligned_alloc(64, M * N * sizeof(float));

    // Initialize with simple values
    for (int i = 0; i < M*K; i++) A[i] = 1.0f;
    for (int i = 0; i < K*N; i++) B[i] = 1.0f;
    for (int i = 0; i < M*N; i++) C[i] = 0.0f;

    // Call the lowered MLIR/LLVM matmul
    matmul(M, N, K,
           A, A, 0, M, K, K, 1,
           B, B, 0, K, N, N, 1,
           C, C, 0, M, N, N, 1);

    printf("C[0,0] = %f\n", C[0]);  // sanity check

    free(A);
    free(B);
    free(C);

    return 0;
}
