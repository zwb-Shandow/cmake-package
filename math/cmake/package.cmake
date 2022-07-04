# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Configuration
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators

# 查找命令, 获取系统参数
find_program(LSB_RELEASE_EXEC lsb_release)
execute_process(
  COMMAND ${LSB_RELEASE_EXEC} -c -s
  OUTPUT_VARIABLE LSB_RELEASE_ID_SHORT
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

find_program(DPKG_EXEC dpkg)
execute_process(
  COMMAND ${DPKG_EXEC} --print-architecture
  OUTPUT_VARIABLE DPKG_ARCH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Retrieve the machine supported by the toolchain
if(DEFINED CMAKE_TOOLCHAIN_FILE)
  execute_process(
    COMMAND ${CMAKE_C_COMPILER} -dumpmachine
    OUTPUT_VARIABLE TOOLCHAIN_MACHINE OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  if(${TOOLCHAIN_MACHINE} STREQUAL "arm-linux-gnueabihf")
    set(DPKG_ARCH armhf)
  endif()
  if(${TOOLCHAIN_MACHINE} STREQUAL "aarch64-linux-gnu")
    set(DPKG_ARCH arm64)
  endif()
endif()

# 打包相关
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})


set(CPACK_PACKAGE_FILE_NAME ${PROJECT_NAME}_${PROJECT_VERSION}_${DPKG_ARCH}_${LSB_RELEASE_ID_SHORT})
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CMAKE_INSTALL_PREFIX})
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})
set(CPACK_OUTPUT_FILE_PREFIX packages)


# 描述
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "math library")

# 供应商信息
set(CPACK_PACKAGE_VENDOR trunk)
set(CPACK_PACKAGE_CONTACT trunk@trunk.tech)

# 版本相关
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

# 平台相关
set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME})
set(CPACK_PACKAGE_ARCHITECTURE ${DPKG_ARCH})
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${DPKG_ARCH})

# 依赖
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
endif()

include(CPack)
