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

# 打包相关
set(CPACK_GENERATOR "DEB")
# set(CPACK_PACKAGE_NAME ${PROJECT_NAME})

set(CPACK_PACKAGE_FILE_NAME ${PROJECT_NAME}_${PROJECT_VERSION}_${DPKG_ARCH}_${LSB_RELEASE_ID_SHORT})
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CMAKE_INSTALL_PREFIX})
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})
set(CPACK_OUTPUT_FILE_PREFIX packages)

# 描述
# set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "math library")

# 供应商信息
set(CPACK_PACKAGE_VENDOR shandow)
set(CPACK_PACKAGE_CONTACT shandow@shandow.tech)

# 版本相关
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

# 平台相关
set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME})
set(CPACK_PACKAGE_ARCHITECTURE ${DPKG_ARCH})
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${DPKG_ARCH})
# set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)  # dpkg 自动生成依赖树

# 安装自动化控制脚本
set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA 
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/preinst;"
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst;"
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/prerm;"
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm"
)

# 为脚本添加可执行权限
execute_process(COMMAND chmod 0755 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/preinst)
execute_process(COMMAND chmod 0755 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst)
execute_process(COMMAND chmod 0755 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/prerm)
execute_process(COMMAND chmod 0755 ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm)


# 定义组件
set(CPACK_COMPONENTS_ALL runtime dev)
set(CPACK_DEB_COMPONENT_INSTALL ON)
set(CPACK_DEBIAN_ENABLE_COMPONENT_DEPENDS ON)

# 设置组件描述
set(CPACK_DEBIAN_RUNTIME_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_COMPONENT_RUNTIME_DESCRIPTION "Add function library - shared libraries\n It provides the shared libraries.")
# 为运行时包单独增加自动化脚本
# set(CPACK_DEBIAN_RUNTIME_PACKAGE_CONTROL_EXTRA 
#   "${CMAKE_CURRENT_SOURCE_DIR}/scripts/preinst;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/prerm;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm")

set(CPACK_DEBIAN_DEV_PACKAGE_NAME ${PROJECT_NAME}-dev)
set(CPACK_COMPONENT_DEV_DESCRIPTION "Add function library - development files\n It provides the development libraries, header files.")
set(CPACK_COMPONENT_DEV_DEPENDS runtime)
# 为开发包单独增加自动化脚本
# set(CPACK_DEBIAN_DEV_PACKAGE_CONTROL_EXTRA 
#   "${CMAKE_CURRENT_SOURCE_DIR}/scripts/preinst;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/prerm;
#    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm")


include(CPack)
