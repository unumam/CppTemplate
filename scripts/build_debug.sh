#!/usr/bin/env bash
# Visualizing the dependencies graph.
# https://cmake.org/cmake/help/latest/module/CMakeGraphVizOptions.html#module:CMakeGraphVizOptions
# Debug vs Release:
# https://stackoverflow.com/a/7725055
mkdir -p build_debug && cd build_debug &&
    cmake -DCMAKE_BUILD_TYPE=Debug .. --graphviz="graphviz/all.dot" &&
    make -j4 && cd ..
