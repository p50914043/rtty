set(CMAKE_C_COMPILER gcc-7)
set(CMAKE_CXX_COMPILER g++-7)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")


# Note: Wno-noexcept-type  warning was deactivated for Werror in GCC7 because of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80985 under the assumption that C++14 and C++17 binaries won't get mixed on customer side.
set(CMAKE_CXX_FLAGS "-fPIC -Wall -Wextra -Wnon-virtual-dtor -Wconversion -Wold-style-cast -pedantic -Wshadow -Wno-error=deprecated-declarations -Wno-error=noexcept-type")
set(CMAKE_C_FLAGS "-fPIC  -Wshadow")
set(C_CXX_LINKER_FLAGS "")

set(CXX_GTEST_FLAGS "-fPIC")
set(C_GTEST_FLAGS "")

if (ENABLE_COLOR)
  set(CXX_COMPILE_FLAGS "${CXX_COMPILE_FLAGS} -fdiagnostics-color=always")
  set(C_COMPILE_FLAGS "${C_COMPILE_FLAGS} -fdiagnostics-color=always")
endif()

set(CXX_COMPILE_FLAGS_THIRD_PARTY "")
set(C_COMPILE_FLAGS_THIRD_PARTY "")


set(C_CXX_LINKER_FLAGS_THIRD_PARTY "")
