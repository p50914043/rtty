set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
 
set(target_arch aarch64-linux-gnu)
set(CMAKE_LIBRARY_ARCHITECTURE ${target_arch} CACHE STRING "" FORCE)

set(TARGET_ROOTFS /opt/aarch64/aarch64-buildroot-linux-gnu/sysroot)
set(TOOLCHAIN_PATH /usr/bin)

# 启用查找根路径模式（取消注释）
set(CMAKE_FIND_ROOT_PATH ${TARGET_ROOTFS})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# 只设置一次编译器标志，避免重复添加
if(NOT DEFINED CMAKE_C_FLAGS_ALREADY_SET)
    set(CMAKE_C_FLAGS "--sysroot=${TARGET_ROOTFS}" CACHE STRING "" FORCE)
    set(CMAKE_CXX_FLAGS "--sysroot=${TARGET_ROOTFS}" CACHE STRING "" FORCE)
    set(CMAKE_C_LINK_FLAGS "--sysroot=${TARGET_ROOTFS}" CACHE STRING "" FORCE)
    set(CMAKE_CXX_LINK_FLAGS "--sysroot=${TARGET_ROOTFS}" CACHE STRING "" FORCE)
    set(CMAKE_C_FLAGS_ALREADY_SET ON)
endif()

# 指定工具链程序
set(CMAKE_C_COMPILER "/opt/aarch64/bin/aarch64-buildroot-linux-gnu-gcc")
set(CMAKE_CXX_COMPILER "/opt/aarch64/bin/aarch64-buildroot-linux-gnu-g++")

# 设置链接器标志
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--allow-shlib-undefined" CACHE STRING "" FORCE)

# 为nvcc指定交叉编译器
set(CMAKE_CUDA_FLAGS "-ccbin ${CMAKE_CXX_COMPILER} -Xcompiler -fPIC" CACHE STRING "" FORCE)