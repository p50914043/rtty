cmake_minimum_required(VERSION 3.10)
project(rtty VERSION 1.0 LANGUAGES C)

# 配置 - 所有 CPack 相关变量应在 include(CPack) 之前设置
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_CONTACT "panchangyuan@zhito.com")
set(CPACK_PACKAGE_VENDOR "ZhiTO")
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_FILE_NAME "rtty-h2pu_${CPACK_PACKAGE_VERSION}_arm64")

# Debian特定配置 - 必须在include(CPack)之前设置
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "panchangyuan")
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "rtty - remote tty utility for H2PU")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.14)")
set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "arm64")

# 检查并添加控制脚本
set(CONTROL_FILES "")
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/preinst")
    list(APPEND CONTROL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/preinst")
    message(STATUS "Including preinst script in the package.")
endif()

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/postinst")
    list(APPEND CONTROL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/postinst")
    message(STATUS "Including postinst script in the package.")
endif()

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/prerm")
    list(APPEND CONTROL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/prerm")
endif()

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/postrm")
    list(APPEND CONTROL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/postrm")
endif()

if(CONTROL_FILES)
    list(JOIN CONTROL_FILES ";" CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA)
endif()

# 启用 CPack - 必须在所有CPack变量设置之后
include(CPack)

# 安装规则 - 使用正确的路径和权限
install(DIRECTORY 
    ${CMAKE_CURRENT_SOURCE_DIR}/../build/aarch64/bin/ 
    DESTINATION /usr/bin
    FILE_PERMISSIONS 
        OWNER_READ OWNER_WRITE OWNER_EXECUTE 
        GROUP_READ GROUP_EXECUTE 
        WORLD_READ WORLD_EXECUTE
)

install(DIRECTORY 
    ${CMAKE_CURRENT_SOURCE_DIR}/../thirdparty/ev_aarch64/lib/ 
    DESTINATION /usr/lib
    FILE_PERMISSIONS 
        OWNER_READ OWNER_WRITE 
        GROUP_READ 
        WORLD_READ
)