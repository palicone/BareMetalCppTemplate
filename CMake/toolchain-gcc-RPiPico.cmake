message("Raspberry Pi Pico GCC toolchain here from the top here")

set(PICO_TOOLCHAIN_PATH $ENV{ARM_NONE_EABI_GCC})
message("PICO_TOOLCHAIN_PATH: ${PICO_TOOLCHAIN_PATH}")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(toolchain_bin_path ${PICO_TOOLCHAIN_PATH}/bin)

if(WIN32)
    set(exe_extension .exe)
endif()

set(CMAKE_C_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc${exe_extension} CACHE FILEPATH "ARM C compiler (GCC)")
set(CMAKE_CXX_COMPILER ${toolchain_bin_path}/arm-none-eabi-g++${exe_extension} CACHE FILEPATH "ARM C++ compiler (GCC)")
set(CMAKE_ASM_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc${exe_extension} CACHE INTERNAL "ARM Assembler (GCC)")

include($ENV{PICO_SDK_PATH}/cmake/preload/toolchains/pico_arm_cortex_m0plus_gcc.cmake)

add_link_options(
  -Wl,-Map=$<TARGET_PROPERTY:ARCHIVE_OUTPUT_DIRECTORY>.map
  -Wl,--print-memory-usage
)
