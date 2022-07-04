find_package(PkgConfig QUIET)

if(PKG_CONFIG_FOUND)
  pkg_check_modules(PC_DIV QUIET div)

  if(PC_DIV_FOUND)
    set(DIV_FOUND ${PC_DIV_FOUND})
    set(DIV_INCLUDE_DIRS ${PC_DIV_INCLUDE_DIRS})
    set(DIV_LIBRARY_DIRS ${PC_DIV_LIBRARY_DIRS})
    set(DIV_LIBRARIES ${PC_DIV_LIBRARIES})

    mark_as_advanced(DIV_FOUND)
    mark_as_advanced(DIV_INCLUDE_DIRS)
    mark_as_advanced(DIV_LIBRARY_DIRS)
    mark_as_advanced(DIV_LIBRARIES)
  else()
    message(FATAL_ERROR "div not found. Please install div and try again.")
  endif()
endif()
