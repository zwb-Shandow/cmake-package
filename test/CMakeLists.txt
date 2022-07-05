cmake_minimum_required(VERSION 3.15)
project(test)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

# 支持 find_package 及 pkg-config 找包方式
# find_package(math REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_search_module(MATH REQUIRED math)

include_directories(${MATH_INCLUDE_DIRS})

link_directories(${MATH_LIBRARY_DIRS})

add_executable(${PROJECT_NAME} main.cc)
target_link_libraries(
  ${PROJECT_NAME}
  ${MATH_LIBRARIES}
)
