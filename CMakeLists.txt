cmake_minimum_required(VERSION 3.28)

project(StepMania)

include(StepmaniaCore.cmake)

# The external libraries need to be included.
add_subdirectory(extern)
add_subdirectory(Lib)

# The internal libraries and eventual executable to be used.
add_subdirectory(src)
