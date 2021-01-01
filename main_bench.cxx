#include <iostream>
#include <string>
#include <benchmark/benchmark.h>

#include "main.hpp"

using namespace unum;

static void bench_add(benchmark::State &state) {
    for (auto _ : state)
        benchmark::DoNotOptimize(add(rand(), rand()));
    state.counters["ops/s"] = benchmark::Counter();
}

BENCHMARK(bench_add);

static void bench_sub(benchmark::State &state) {
    for (auto _ : state)
        benchmark::DoNotOptimize(sub(rand(), rand()));
}

BENCHMARK(bench_sub);

BENCHMARK_MAIN();