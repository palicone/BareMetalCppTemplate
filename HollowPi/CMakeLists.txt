cmake_minimum_required (VERSION 3.28)

add_executable(hollow_pi EXCLUDE_FROM_ALL
    hollow_pi.c
)

# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(hollow_pi pico_stdlib)

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(hollow_pi)