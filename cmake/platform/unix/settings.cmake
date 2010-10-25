# Copyright (C) 2005-2009 MaNGOS project <http://getmangos.com/>
#
# Copyright (C) 2005-2010 Trinity <http://www.trinitycore.org/>
#
# Copyright (C) 2010 Myth Project <http://code.google.com/p/mythcore/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# set default configuration directory
if( NOT CONF_DIR )
  set(CONF_DIR ${CMAKE_INSTALL_PREFIX}/etc)
  message(STATUS "UNIX: Using default configuration directory")
endif()

# set default library directory
if( NOT LIBSDIR )
  set(LIBSDIR ${CMAKE_INSTALL_PREFIX}/lib)
  message(STATUS "UNIX: Using default library directory")
endif()

# configure uninstaller
configure_file(
  "${CMAKE_SOURCE_DIR}/cmake/platform/unix/cmake_uninstall.in.cmake"
  "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake"
  @ONLY
)
message(STATUS "UNIX: Configuring uninstall target")

# create uninstaller target (allows for using "make uninstall")
add_custom_target(uninstall
  "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
)
message(STATUS "UNIX: Created uninstall target")

include(${CMAKE_SOURCE_DIR}/cmake/compiler/gcc/settings.cmake)
