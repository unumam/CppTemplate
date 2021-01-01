from conans import ConanFile, CMake
from conans.tools import SystemPackageTool
import os


class CppTemplateConan(ConanFile):
    # Default source:
    # https://conan.io/center/
    # Remotes to add:
    # conan remote add conan-center https://api.bintray.com/conan/conan/conan-center

    name = "CppTemplate"
    version = "0.0.1"
    url = "https://github.com/UnumAM/CppTemplate"

    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake", "cmake_paths", "cmake_find_package"
    default_options = {}

    def configure(self):
        # To avoid linking problems - link to C++11 ABI
        # https://github.com/conan-io/conan/issues/2115#issuecomment-353020236
        # https://docs.conan.io/en/latest/howtos/manage_gcc_abi.html
        if self.settings.compiler.libcxx == "libstdc++":
            raise Exception("This package is only compatible with libstdc++11")
        
    def build(self):

        # It's recommended to use CMake.
        # https://docs.conan.io/en/latest/reference/conanfile/methods.html#build

        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def requirements(self):

        # Your library dependencies go here.
        # https://docs.conan.io/en/latest/reference/conanfile/methods.html#requirements

        self.requires("fmt/7.1.2")
        self.requires("taskflow/2.7.0")
        self.requires("eigen/3.3.8")

        # Benchmarking and Testing
        self.requires("benchmark/1.5.2")
        self.requires("gtest/1.10.0")

        # Language Bindings
        self.requires("pybind11/2.5.0")

    def system_requirements(self):
        # If you nees some other package, missing in Conan-Center,
        # use this method to invoke the "System Package Tool".
        # https://docs.conan.io/en/latest/reference/conanfile/methods.html?#system-requirements
        # SystemPackageTool().install("libtorch")
        pass
