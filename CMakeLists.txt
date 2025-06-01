# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required (VERSION 3.28)

message("Bare metal template from the top here")

# initialize pico-sdk from submodule
# note: this must happen before project()
include($ENV{PICO_SDK_PATH}/pico_sdk_init.cmake)

project ("BareMental")
enable_language( C CXX ASM )

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

#set(CMAKE_VERBOSE_MAKEFILE ON)

# Provide path for Protomorph lib to find platofrm.h
list(APPEND ProtmorphLibPlatformIncludePaths
          "${CMAKE_CURRENT_SOURCE_DIR}/Project"
      )

# Local varible with Protomorh lib root
#set(PTMH_CHECKOUT_PATH "../Protomorph/head")
get_filename_component(PTMH_CHECKOUT_PATH "../Protomorph/head" ABSOLUTE)

include("${PTMH_CHECKOUT_PATH}/CMake/Protomorph.cmake")

# Add the Protomorh lib sources
add_subdirectory ("${PTMH_CHECKOUT_PATH}/Protomorph" "Protomorph")
add_subdirectory ("Project")
add_subdirectory ("HollowPi")

