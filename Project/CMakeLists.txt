# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required (VERSION 3.10)

message("Bare metal template from the top here")

parc_gen(TestDemoEndpoint
  "${PTMH_CHECKOUT_PATH}/Protomorph/PARC/Gen/Test/Test_One.h"
  "${PTMH_CHECKOUT_PATH}/Protomorph/PARC/Gen/Test/Test_Too.h"
  "${PTMH_CHECKOUT_PATH}/Protomorph/PARC/Gen/Test/Test_The.h"
)

add_executable(
  Template
  EXCLUDE_FROM_ALL
  main.cpp
  "${CMAKE_CURRENT_SOURCE_DIR}/TestDemoEndpointBase.h"
 "Test.cpp" "platform.h")

 target_include_directories(
  Template
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(Template
  PRIVATE Protomorph
  gcc
  nosys
  stdc++_nano
  c
)

target_link_options(Template
  PUBLIC
    LINKER:-Map=$<TARGET_FILE:Template>.map
)

#ADD_CUSTOM_COMMAND(OUTPUT ${TARGET}.bin DEPENDS ${TARGET}.elf COMMAND ${CMAKE_OBJCOPY} -O binary ${TARGET}.elf ${TARGET}.bin)
#ADD_CUSTOM_COMMAND(OUTPUT ${TARGET}.hex DEPENDS ${TARGET}.elf COMMAND ${CMAKE_OBJCOPY} -O ihex ${TARGET}.elf ${TARGET}.hex)
#ADD_CUSTOM_TARGET(${TARGET}_bin DEPENDS ${TARGET}.bin)
#ADD_CUSTOM_TARGET(${TARGET}_hex DEPENDS ${TARGET}.hex)

message("APPLICATION:${APPLICATION}")
message("TARGET:${TARGET}")
message("CMAKE_OBJCOPY:${CMAKE_OBJCOPY}")
message("CMAKE_SIZE:${CMAKE_SIZE}")

#add_custom_target(Template_post_build
#DEPENDS Template
#COMMAND ${CMAKE_OBJCOPY} -O binary Template Template.bin
#COMMAND ${CMAKE_OBJCOPY} -O ihex Template Template.hex
#BYPRODUCTS Template.bin Template.hex
#COMMAND ${CMAKE_SIZE} -B -x Template
#)
#add_dependencies(Template_post_build Template)

add_custom_command(TARGET Template
POST_BUILD
COMMAND ${CMAKE_OBJCOPY} -O binary Template Template.bin
COMMAND ${CMAKE_OBJCOPY} -O ihex Template Template.hex
BYPRODUCTS Template.bin Template.hex
COMMAND ${CMAKE_SIZE} -B -x Template
)

#add_custom_command(TARGET ${APPLICATION}
#    POST_BUILD
#    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
#    COMMAND ${OBJCOPY} ARGS -O binary ${APPLICATION} ${APPLICATION_BIN}
#    COMMAND ${OBJCOPY} ARGS -O ihex -R .eeprom -R .fuse -R .lock -R .signature ${APPLICATION} ${APPLICATION_HEX}
#)

message("CMAKE_EXE_LINKER_FLAGS: ${CMAKE_EXE_LINKER_FLAGS}")

