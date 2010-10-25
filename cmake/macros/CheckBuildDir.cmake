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

#
# Force out-of-source build
#

string(COMPARE EQUAL "${CMAKE_SOURCE_DIR}" "${CMAKE_BINARY_DIR}" BUILDING_IN_SOURCE)

if( BUILDING_IN_SOURCE )
  message(FATAL_ERROR "
    This project requires an out of source build. Remove the file 'CMakeCache.txt'
    found in this directory before continuing, create a separate build directory
    and run 'cmake path_to_project [options]' from there.
  ")
endif()
