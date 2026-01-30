set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
 
set(target_arch aarch64-linux-gnu)
set(CMAKE_LIBRARY_ARCHITECTURE ${target_arch} CACHE STRING "" FORCE)

set(TARGET_ROOTFS /host/rootfs/)
set(TOOLCHAIN_PATH /usr/bin)

# Configure cmake to look for libraries, include directories and
# packages inside the target root prefix.
# set(CMAKE_FIND_ROOT_PATH ${TARGET_ROOTFS})
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# compiler/linker flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --sysroot=${TARGET_ROOTFS}" CACHE INTERNAL "" FORCE)
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} --sysroot=${TARGET_ROOTFS}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --sysroot=${TARGET_ROOTFS}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} --sysroot=${TARGET_ROOTFS}" CACHE INTERNAL "" FORCE)

# specify the toolchain programs
set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/aarch64-linux-gnu-g++)
 
# Not all shared libraries dependencies are instaled in host machine.
# Make sure linker doesn't complain.
set(CMAKE_EXE_LINKER_FLAGS_INIT -Wl,--allow-shlib-undefined)
 
# instruct nvcc to use our cross-compiler
set(CMAKE_CUDA_FLAGS "-ccbin ${CMAKE_CXX_COMPILER} -Xcompiler -fPIC" CACHE STRING "" FORCE)
