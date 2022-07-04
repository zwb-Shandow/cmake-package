cmake_minimum_required(VERSION 3.15)
project(div VERSION 1.0.0)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()
set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

include(cmake/package.cmake)
include(GNUInstallDirs)

add_library(${PROJECT_NAME} SHARED div.cc)


#-----------------------------------------------------
# Install include files and targets
#-----------------------------------------------------
install(
  FILES
  ${CMAKE_SOURCE_DIR}/div.h
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
#-----------------------------------------------------
# Install PkgConfig file
#-----------------------------------------------------

configure_file(cmake/div.pc.in ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc @ONLY)

install(
  FILES
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/pkgconfig
)
