# The version number.
set(RTTY_VERSION_MAJOR 9)
set(RTTY_VERSION_MINOR 0)
set(RTTY_VERSION_PATCH 4)

message(STATUS "${CMAKE_SYSTEM_PROCESSOR} build")

if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
# Check the third party Libraries
set(LIBEV_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/thirdparty/ev_aarch64/include)   
set(LIBEV_LIBRARY ${PROJECT_SOURCE_DIR}/thirdparty/ev_aarch64/lib/libev.a)   
# find_package(Libev REQUIRED)
else()
# Check the third party Libraries
find_package(Libev REQUIRED)
endif()


aux_source_directory(. SRCS)
aux_source_directory(log SRCS)
aux_source_directory(buffer SRCS)

add_executable(rtty ${SRCS})
target_compile_definitions(rtty PRIVATE _GNU_SOURCE)
target_compile_options(rtty PRIVATE -O -Wall -Werror --std=gnu99)
target_include_directories(rtty PRIVATE ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/buffer ${LIBEV_INCLUDE_DIR}
)
target_link_libraries(rtty PRIVATE ${LIBEV_LIBRARY} util 
${PROJECT_SOURCE_DIR}/thirdparty/ev_aarch64/lib/libcrypt.a 
m
)

add_subdirectory(ssl)
if(SSL_SUPPORT)
    message(ERROR "SSL support: ${PROJECT_SOURCE_DIR}/thirdparty/ev_aarch64/lib/libssl.a ${PROJECT_SOURCE_DIR}/thirdparty/ev_aarch64/lib/libcrypto.a")
    target_link_libraries(rtty PRIVATE ${SSL_TARGET} )
endif()

# configure a header file to pass some of the CMake settings to the source code
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.in ${CMAKE_CURRENT_BINARY_DIR}/config.h)

install(
    TARGETS rtty
    DESTINATION bin
)
