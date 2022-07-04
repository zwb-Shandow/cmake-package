cmake_minimum_required(VERSION 3.15)
project(math VERSION 1.0.0)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

include(cmake/package.cmake)
include(GNUInstallDirs)

# Make sure we can import out CMake functions
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

find_package(add REQUIRED)
find_package(sub REQUIRED)
find_package(DIV REQUIRED)

include_directories(
  ${add_INCLUDE_DIRS}
  ${sub_INCLUDE_DIRS}
  ${DIV_INCLUDE_DIRS}
)

link_directories(
  ${add_LIBRARY_DIRS}
  ${sub_LIBRARY_DIRS}
  ${DIV_LIBRARY_DIRS}
)

add_library(${PROJECT_NAME} SHARED math.cc)
target_link_libraries(
  ${PROJECT_NAME}
  ${add_LIBRARIES}
  ${sub_LIBRARIES}
  ${DIV_LIBRARIES}
)

# -----------------------------------------------------
# Install include files and targets
# -----------------------------------------------------
install(
  FILES
  ${CMAKE_SOURCE_DIR}/math.h
  DESTINATION include
)

install(
  TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}-targets
  LIBRARY DESTINATION lib
)

install(
  EXPORT ${PROJECT_NAME}-targets
  FILE ${PROJECT_NAME}-targets.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)

# -----------------------------------------------------
# Install CMake config file
# -----------------------------------------------------
include(CMakePackageConfigHelpers)

# set(INCLUDE_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR})
# set(LIB_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
configure_package_config_file(
  cmake/math-config.cmake.in
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
  PATH_VARS CMAKE_INSTALL_INCLUDEDIR CMAKE_INSTALL_LIBDIR
)

write_basic_package_version_file(
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

install(
  FILES
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindDIV.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)
