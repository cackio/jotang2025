#include <cstdint>
#include <iostream>
#include <thread>
#include <chrono>


struct data {
    alignas(64) int a;
    char pad[64 - sizeof(int)];
    alignas(64) int b;
    char pad2[64 - sizeof(int)];
};

void add_a(data &global_data) {
  for (int i = 0; i < 500000000; ++i) {
    global_data.a++;
  }
}

void add_b(data &global_data) {
  for (int i = 0; i < 500000000; ++i) {
    global_data.b++;
  }
}

void foo() {
  data data_x = {0,0};
  std::thread t1([&data_x]() { add_a(data_x); });
  std::thread t2([&data_x]() { add_b(data_x); });

  t1.join();
  t2.join();
  uint64_t sum = data_x.a + data_x.b;
  std::cout << "Sum foo : " << sum << std::endl;
}

void bar() {
  data data_y = {0,0};
  add_a(data_y);
  add_b(data_y);

  uint64_t sum = data_y.a + data_y.b;
  std::cout << "Sum bar : " << sum << std::endl;
}

int main()
{
    auto t1 = std::chrono::high_resolution_clock::now();
    foo();
    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration1 = std::chrono::duration_cast<std::chrono::milliseconds>(t2 - t1).count();

    auto t3 = std::chrono::high_resolution_clock::now();
    bar();
    auto t4 = std::chrono::high_resolution_clock::now();
    auto duration2 = std::chrono::duration_cast<std::chrono::milliseconds>(t4 - t2).count();


    std::cout << "foo耗时: " << duration1 << " ms\n";
    std::cout << "bar耗时: " << duration2 << " ms\n";
    return 0;
}