cmake_minimum_required(VERSION 3.10)

project(rtty C)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules/")

#set(CMAKE_VERBOSE_MAKEFILE ON)

add_subdirectory(src)

if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/ev_aarch64/lib DESTINATION lib)

endif()