#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <cmath>

/*
# profiling

编译命令行：g++ -O3 -std=c++11 test_fuse.cpp -o test_fuse
运行结果：
```
Two-step version time: 0.0900965 seconds
Fused version time: 0.0940577 seconds
```
差距不是特别明显，关掉编译器优化再测一遍。

编译命令行：g++ -O0 -std=c++11 test_fuse.cpp -o test_fuse
运行结果：
```
Two-step version time: 0.589289 seconds
Fused version time: 0.609387 seconds
```
可以看到算子融合能带来很好的性能提升
*/

using namespace std;
using namespace std::chrono;

// sigmoid
inline double sigmoid(double x) {
    return 1.0 / (1.0 + exp(-x));
}


int main() {
    const int m = 512, n = 512, k = 512;

    random_device rd;
    mt19937 gen(rd());
    uniform_real_distribution<> dis(0.0, 1.0);

    // 初始化
    vector<vector<double>> x(m, vector<double>(k));
    vector<vector<double>> weight(k, vector<double>(n));
    vector<double> bias(n);

    for (int i = 0; i < m; ++i)
        for (int j = 0; j < k; ++j)
            x[i][j] = dis(gen);

    for (int i = 0; i < k; ++i)
        for (int j = 0; j < n; ++j)
            weight[i][j] = dis(gen);

    for (int j = 0; j < n; ++j)
        bias[j] = dis(gen);

    vector<vector<double>> result(m, vector<double>(n, 0.0));


    auto start1 = high_resolution_clock::now();


    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            double sum = 0.0;
            for (int a = 0; a < k; ++a) {
                sum += x[i][a] * weight[a][j];
            }
            result[i][j] = sum + bias[j];
        }
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            result[i][j] = sigmoid(result[i][j]);
        }
    }

    auto end1 = high_resolution_clock::now();
    duration<double> duration1 = end1 - start1;


    cout << "Two-step version time: " << duration1.count() << " seconds\n";

    //fused
    //清零
    for (auto& row : result) {
        fill(row.begin(), row.end(), 0.0);
    }

    auto start2 = high_resolution_clock::now();

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            double sum = 0.0;
            for (int a = 0; a < k; ++a) {
                sum += x[i][a] * weight[a][j];
            }
            sum += bias[j];
            result[i][j] = sigmoid(sum);
        }
    }

    auto end2 = high_resolution_clock::now();
    duration<double> duration2 = end2 - start2;

    cout << "Fused version time: " << duration2.count() << " seconds\n";

    return 0;
}
