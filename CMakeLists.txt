cmake_minimum_required(VERSION 3.10.0)
project(moonbit_cxx_ffi VERSION 0.1.0 LANGUAGES C CXX)


set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

message("$ENV{MOON_HOME}")
file(TO_CMAKE_PATH "$ENV{MOON_HOME}" MOON_HOME)
include_directories(${PROJECT_SOURCE_DIR}/src/raylib/include)
include_directories(${MOON_HOME}/include)
add_executable(main main.c)
