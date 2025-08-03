message("ARM GCC toolchain here from the top here")

set(CMAKE_SYSTEM_NAME  Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(ARMV7M_TOOLCHAIN_PATH $ENV{ARM_NONE_EABI_GCC})
message("ARMV7M_TOOLCHAIN_PATH: ${ARMV7M_TOOLCHAIN_PATH}")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(toolchain_bin_path ${ARMV7M_TOOLCHAIN_PATH}/bin)

set(CMAKE_C_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc.exe CACHE FILEPATH "ARM C compiler (GCC)")
set(CMAKE_CXX_COMPILER ${toolchain_bin_path}/arm-none-eabi-g++.exe CACHE FILEPATH "ARM C++ compiler (GCC)")
set(CMAKE_ASM_COMPILER ${toolchain_bin_path}/arm-none-eabi-gcc.exe CACHE INTERNAL "ARM Assembler (GCC)")
set(CMAKE_SIZE ${toolchain_bin_path}/arm-none-eabi-size.exe CACHE INTERNAL "Binutils size (GCC)")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(architecture_flags "-march=armv7e-m -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")
set(exception_flags "-fno-exceptions")

set(CMAKE_C_FLAGS           "${architecture_flags} -gdwarf-4 -gstrict-dwarf -g3                           -fsingle-precision-constant -ffunction-sections -fdata-sections -Wall") 
set(CMAKE_CXX_FLAGS         "${architecture_flags} -gdwarf-4 -gstrict-dwarf -g3 ${exception_flags} -fno-rtti -fsingle-precision-constant -ffunction-sections -fdata-sections -Wall") 
set(CMAKE_EXE_LINKER_FLAGS  "${architecture_flags} -nostartfiles -Wl,--no-warn-rwx-segments,--script=${CMAKE_SOURCE_DIR}/Devices/STM32_RAM.ld,-n,--gc-sections -nostdlib -nodefaultlibs ${exception_flags} -fno-rtti --specs=nano.specs") 


add_link_options(
  -Wl,-Map=$<TARGET_PROPERTY:ARCHIVE_OUTPUT_DIRECTORY>.map
  -Wl,--print-memory-usage
)

#--no-warn-rwx-segments https://www.redhat.com/en/blog/linkers-warnings-about-executable-stacks-and-segments
