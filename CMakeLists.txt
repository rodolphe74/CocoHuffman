cmake_minimum_required(VERSION 3.0)

project(trees LANGUAGES C)

set(cflags "-g -Wall -Wpedantic -fsanitize=address -DPRINTF_FORMAT=2")
# set (cflags "-DPRINTF_FORMAT=2")
set(CMAKE_C_FLAGS ${cflags})

add_executable(trees main.c Tree.c Huffman.c Useful.c BitField.c)
add_executable(huffbuf HuffBuffer.c Tree.c Huffman.c Useful.c BitField.c)

add_custom_target(test
    COMMAND make
    COMMAND ./huffbuf
)


install(TARGETS trees RUNTIME DESTINATION bin)
