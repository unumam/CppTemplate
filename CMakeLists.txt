cmake_minimum_required(VERSION 3.7.2)
project(CppTemplate)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
message("CMAKE_BINARY_DIR is ${CMAKE_BINARY_DIR}")
message("CMAKE_CURRENT_BINARY_DIR is ${CMAKE_CURRENT_BINARY_DIR}")
message("CMAKE_SOURCE_DIR is ${CMAKE_SOURCE_DIR}")

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RELEASE)
  message(STATUS "Build type not specified: Use RELEASE by default")
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS OFF)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# General flags.
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse -msse4.2 -mavx2") # -march=native
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse -msse4.2 -mavx2") # -march=native
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wnon-virtual-dtor -Woverloaded-virtual")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-missing-field-initializers")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-builtin-memcmp")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wreorder -Wunused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wno-unknown-pragmas")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -frtti")

# Debugging flags.
# https://code.visualstudio.com/docs/cpp/faq-cpp#_how-do-i-enable-debug-symbols
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -DDEBUG_SAFE_MODE -g")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG_SAFE_MODE -g")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -DNDEBUG -O2")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -DNDEBUG -O2")


if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fstrict-vtable-pointers")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ferror-limit=1")
  # Riscky Performance Optimization, that require tuning.
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -momit-leaf-frame-pointer")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -funsafe-math-optimizations")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fno-omit-frame-pointer")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmax-errors=1")  
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
endif()

# If you aren't using Conan, you should manually lookup and link all the libs.
# find_package(benchmark REQUIRED)
# find_package(fmt REQUIRED)
# target_link_libraries(main_app benchmark::benchmark fmt::fmt)
include(${CMAKE_SOURCE_DIR}/cmake/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(main_test main_test.cxx)
target_link_libraries(main_test ${CONAN_LIBS})

add_executable(main_bench main_bench.cxx)
target_link_libraries(main_bench ${CONAN_LIBS})
