cmake_minimum_required(VERSION 3.6)
project(bioplib)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_COMPILER "clang")
set(SOURCE_FILES
        pdbtagvars/main.c
#        pdbtagvars/pdbtagvars.c
#        pdbtagvars/pdbtagvars.h
        src/ReadPDB.c)

add_executable(bioplib ${SOURCE_FILES})