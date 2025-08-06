#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define X 10240
#define Y 10240
#define BLUR_SIZE 4
#define ITERATIONS 10

#define MIN(a,b) ((a) < (b) ? (a) : (b))

static int image[X * Y];
static int image_blur_origin[X * Y];
static int image_blur_tile[X * Y];
static int image_blur_tile_threads[X * Y];
static int image_blur_tile_lessif[X * Y];
static int image_blur_tile_lessif_threads[X * Y];

void blur_y(const int *image, int *image_blur) {
    for (int j = 0; j < Y; j++) {
        for (int i = 0; i < X; i++) {
            int sum = 0;
            for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                int ii = i + t;
                if (ii >= 0 && ii < X) {
                    sum += image[ii * Y + j];
                }
            }
            image_blur[i * Y + j] = sum / (2 * BLUR_SIZE + 1);
        }
    }
}

void blur_y_tile_SIMD(const int *image, int *image_blur) {
    for (int j = 0; j < Y; j += 16) {
        int tile_h = MIN(16, Y - j);
        for (int i = 0; i < X; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / (2 * BLUR_SIZE + 1);
            }
        }
    }
}
void blur_y_tile_SIMD_threads(const int *image, int *image_blur) {
    #pragma omp parallel for schedule(dynamic)
    for (int j = 0; j < Y; j += 16) {
        int tile_h = MIN(16, Y - j);
        for (int i = 0; i < X; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / (2 * BLUR_SIZE + 1);
            }
        }
    }
}
void blur_y_tile_SIMD_lessif(const int * image, int * image_blur) {
    const int D = 2 * BLUR_SIZE + 1; // =9

    for (int j = 0; j < Y; j += 16) {
        int tile_h = MIN(16, Y - j);

        for (int i = 0; i < BLUR_SIZE; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }

        for (int i = BLUR_SIZE; i < X - BLUR_SIZE; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    sum += image[(i + t) * Y + (j + k)];
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }
        for (int i = X - BLUR_SIZE; i < X; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }
    }
}

void blur_y_tile_SIMD_lessif_threads(const int * image, int * image_blur) {
    const int D = 2 * BLUR_SIZE + 1; // =9
    #pragma omp parallel for schedule(dynamic)
    for (int j = 0; j < Y; j += 16) {
        int tile_h = MIN(16, Y - j);

        for (int i = 0; i < BLUR_SIZE; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }

        for (int i = BLUR_SIZE; i < X - BLUR_SIZE; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    sum += image[(i + t) * Y + (j + k)];
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }
        for (int i = X - BLUR_SIZE; i < X; i++) {
            for (int k = 0; k < tile_h; k++) {
                int sum = 0;
                for (int t = -BLUR_SIZE; t <= BLUR_SIZE; t++) {
                    int ii = i + t;
                    if (ii >= 0 && ii < X) {
                        sum += image[ii * Y + (j + k)];
                    }
                }
                image_blur[i * Y + (j + k)] = sum / D;
            }
        }
    }
}

double now_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1000.0 + ts.tv_nsec / 1e6;
}

int main(void) {
    // 初始化随机数
    srand(0);
    for (int idx = 0; idx < X * Y; idx++) {
        image[idx] = rand() & 0xFF;
    }

    // 基准测试 blur_y
    double t0 = now_ms();
    for (int it = 0; it < ITERATIONS; it++) {
        blur_y(image, image_blur_origin);
    }
    double t1 = now_ms();
    double avg_y = (t1 - t0) / ITERATIONS;


    double t2 = now_ms();
    for (int it = 0; it < ITERATIONS; it++) {
        blur_y_tile_SIMD(image, image_blur_tile);
    }
    double t3 = now_ms();
    double avg_tile = (t3 - t2) / ITERATIONS;



    double t4 = now_ms();
    for (int it = 0; it < ITERATIONS; it++) {
        blur_y_tile_SIMD_lessif(image, image_blur_tile_lessif);
    }
    double t5 = now_ms();
    double avg_tile_lessif = (t5 - t4) / ITERATIONS;

    omp_set_num_threads(8);
    double t6 = now_ms();
    for (int it = 0; it < ITERATIONS; it++) {
        blur_y_tile_SIMD_lessif_threads(image, image_blur_tile_lessif_threads);
    }
    double t7 = now_ms();
    double avg_tile_lessif_threads = (t7 - t6) / ITERATIONS;

    omp_set_num_threads(8);
    double t8 = now_ms();
    for (int it = 0; it < ITERATIONS; it++) {
        blur_y_tile_SIMD_threads(image, image_blur_tile_threads);
    }
    double t9 = now_ms();
    double avg_tile_threads = (t9 - t8) / ITERATIONS;



    // 输出结果
    printf("Average time over %d runs:\n", ITERATIONS);
    printf("  blur_y:      %.3f ms\n", avg_y);
    printf("  blur_y_tile_SIMD: %.3f ms\n", avg_tile);
    printf("  blur_y_tile_SIMD_threads: %.3f ms\n", avg_tile_threads);
    printf("  blur_y_tile_SIMD_lessif: %.3f ms\n", avg_tile_lessif);
    printf("  blur_y_tile_SIMD_lessif_threads: %.3f ms\n", avg_tile_lessif_threads);
    return 0;
}
