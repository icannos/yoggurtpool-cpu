cmake_minimum_required(VERSION 3.7.2)


set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)
project(asr1)

set (CMAKE_CXX_STANDARD 11)
set(CXX_FLAGS "-Wall -O3")

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(simu.src)
