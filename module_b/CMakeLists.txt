cmake_minimum_required(VERSION 3.15)
project(sub VERSION 1.0.6)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

include(cmake/package.cmake)
include(GNUInstallDirs)

add_library(${PROJECT_NAME} sub.cc)

# -----------------------------------------------------
# Install include files and targets
# -----------------------------------------------------
install(
  FILES
  ${CMAKE_SOURCE_DIR}/sub.h
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
  cmake/sub-config.cmake.in
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
  DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)

# -----------------------------------------------------
# Install pkg-config file
# -----------------------------------------------------
configure_file(cmake/sub.pc.in ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc @ONLY)

install(
  FILES
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/pkgconfig
)
