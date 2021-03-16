#!/usr/bin/env bash
# Visualizing the dependencies graph.
# https://cmake.org/cmake/help/latest/module/CMakeGraphVizOptions.html#module:CMakeGraphVizOptions
# Debug vs Release:
# https://stackoverflow.com/a/7725055
mkdir -p build_release && cd build_release &&
    cmake -DCMAKE_BUILD_TYPE=Release .. --graphviz="graphviz/all.dot" &&
    make -j4 && cd ..
