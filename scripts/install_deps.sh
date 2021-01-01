#!/bin/bash
conan install . --build=missing --install-folder="cmake" -s compiler.libcxx=libstdc++11