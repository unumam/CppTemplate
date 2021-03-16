#!/usr/bin/env bash

if test -f "conda.yml"; then
    echo "Anaconda config found! Let's install some Python/C++ dependencies"
    # Linking with Anaconda commands:
    # https://stackoverflow.com/a/64815977
    source ~/miniconda3/etc/profile.d/conda.sh
    # Activate the Conda environment:
    # https://docs.conda.io/projects/conda/en/latest/commands/update.html
    # conda env create -f conda.yml
    conda env update -f conda.yml --prune && conda activate CppTemplate
fi

if test -f "requirements.txt"; then
    echo "PIP config found! Let's install some Python dependencies"
    pip install -r requirements.txt -U
fi

if test -f "conanfile.py"; then
    echo "ConanFile config found! Let's install some C++ dependencies"
    conan profile new --detect default
    conan profile update settings.compiler.libcxx=libstdc++11 default
    conan install . --build=missing --install-folder="cmake" -s compiler.libcxx=libstdc++11
fi
