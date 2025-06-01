message("Raspberry Pi Pico GCC toolchain here from the top here")

set(PICO_TOOLCHAIN_PATH $ENV{ARM_NONE_EABI_GCC})
message("PICO_TOOLCHAIN_PATH: ${PICO_TOOLCHAIN_PATH}")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(compiler_path_prefix ${CMAKE_SOURCE_DIR}/../Tools/arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi)

set(toolchain_bin_path ${compiler_path_prefix}/bin)

set(CMAKE_C_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc.exe CACHE FILEPATH "ARM C compiler (GCC)")
set(CMAKE_CXX_COMPILER ${toolchain_bin_path}/arm-none-eabi-g++.exe CACHE FILEPATH "ARM C++ compiler (GCC)")
set(CMAKE_ASM_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc.exe CACHE INTERNAL "ARM Assembler (GCC)")

include($ENV{PICO_SDK_PATH}/cmake/preload/toolchains/pico_arm_cortex_m0plus_gcc.cmake)
