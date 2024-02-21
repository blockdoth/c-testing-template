cmake_minimum_required(VERSION 3.10)
project(C_TEMPLATE)

set(CMAKE_C_STANDARD 23)

# Source and test files
set(SOURCE_FILES main.c)
set(TEST_SOURCE_FILES tests/test.c tests/test_framework.h)

# Add any additional compile definitions (equivalent to -D flags in CFLAGS)
# set(FEATURES "-DSEQUENTIAL")

# Compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -Werror -Wextra -Wno-unused-parameter -Wno-unused-variable -pedantic ${FEATURES}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lpthread -lrt")

# Main and tests executable
add_executable(main ${SOURCE_FILES})
add_executable(test_suite ${TEST_SOURCE_FILES})

# Specify additional dependencies for the main executable if needed
# target_link_libraries(main some_library)

# Specify additional dependencies for the test executable if needed
# target_link_libraries(test_suite some_library)

# Specify the Valgrind command for main and test executables
set(VALGRIND_CMD valgrind --tool=memcheck)

