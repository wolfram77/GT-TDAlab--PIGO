#include <iostream>
#include "release/pigo.hpp"
#include "test-include/main.hxx"

using namespace std;




#pragma region CONFIGURATION
#ifndef MAX_THREADS
/** Maximum number of threads to use. */
#define MAX_THREADS 64
#endif
#ifndef REPEAT_METHOD
/** Number of times to repeat each method. */
#define REPEAT_METHOD 5
#endif
#ifndef MEASURE_CSR
/** Whether to measure CSR methods. */
#define MEASURE_CSR 1
#endif
#pragma endregion




/**
 * Main function.
 * @param argc argument count
 * @param argv argument values
 * @returns zero on success, non-zero on failure
 */
int main(int argc, char** argv) {
  char *file = argv[1];
  int repeat = REPEAT_METHOD;
  printf("Loading graph %s ...\n", file);
  for (int i=0; i<repeat; ++i) {
    auto  t0 = timeNow();
    #if MEASURE_CSR==1
    pigo::Graph x { file };
    #else
    pigo::COO x { file };
    #endif
    auto  t1 = timeNow();
    printf("order: %zu, size: %zu {}\n", size_t(x.n()), size_t(x.m()));
    float tl = duration(t0, t1);
    printf("{%09.1fms} pigo_Graph\n", tl);
    #if MEASURE_CSR==1
    float ts = measureDuration([&]() { x.sort(); });
    printf("{%09.1fms} pigo_Graph_sort\n", ts);
    #endif
    #if LOG_EDGES==1
    uint32_t n = x.n();
    for (uint32_t u=0; u<n; ++u) {
      uint32_t d = x.degree(u);
      printf("%zu: %zu\n", u, d);
    }
    for (uint32_t u=0; u<n; ++u) {
      for (auto v : x.neighbors(u)) {
        printf("%zu %zu\n", u, v);
      }
    }
    #endif
    x.free();
  }
  printf("\n");
  return 0;
}
