#include <stdio.h>

__global__ void add(int *a, int *b, int *c) {
    int i = threadIdx.x;
    c[i] = a[i] + b[i];
}

int main(int argc, char *argv[]) {
    int a[5] = {1,2,3,4,5};
    int b[5] = {10,20,30,40,50};
    int c[5];

    int *d_a, *d_b, *d_c;

    cudaMalloc((void**)&d_a, 5*sizeof(int));
    cudaMalloc((void**)&d_b, 5*sizeof(int));
    cudaMalloc((void**)&d_c, 5*sizeof(int));

    cudaMemcpy(d_a, a, 5*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, 5*sizeof(int), cudaMemcpyHostToDevice);

    add<<<1,5>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, 5*sizeof(int), cudaMemcpyDeviceToHost);

    printf("Result:\n");
    for(int i=0;i<5;i++) {
        printf("%d ", c[i]);
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
