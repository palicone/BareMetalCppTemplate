# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required (VERSION 3.28)

message("Bare metal template from the top here")

if (DEFINED ENV{PICO_SDK_PATH})
# initialize pico-sdk from submodule
# note: this must happen before project()
include($ENV{PICO_SDK_PATH}/pico_sdk_init.cmake)
endif()

project ("BareMental")
enable_language( C CXX ASM )

if (DEFINED ENV{PICO_SDK_PATH})
# initialize the Raspberry Pi Pico SDK
pico_sdk_init()
endif()

#set(CMAKE_VERBOSE_MAKEFILE ON)

add_subdirectory ("Project")
if (DEFINED ENV{PICO_SDK_PATH})
add_subdirectory ("HollowPi")
endif()

