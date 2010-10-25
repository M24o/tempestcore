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

# output generic information about the core and buildtype chosen

message("")
message("* MythCore revision   : ${hg_rev_id_str} (${hg_rev_hash_str})")
if( UNIX )
  message("* Build binaries in      : ${CMAKE_BUILD_TYPE} mode")
endif()
message("")

# output information about installation-directories and locations

message("* Install core to        : ${CMAKE_INSTALL_PREFIX}")
if( UNIX )
  message("* Install libraries to   : ${LIBSDIR}")
  message("* Install configs to     : ${CONF_DIR}")
endif()
message("")

# Show infomation about the options selected during configuration

if( SERVERS )
  message("* Build world/auth       : Yes (default)")
else()
  message("* Build world/authserver : No")
endif()

if( SCRIPTS )
  message("* Build with scripts     : Yes (default)")
  add_definitions(-DSCRIPTS)
else()
  message("* Build with scripts     : No")
  set(USE_SCRIPTPCH 0)
endif()

if( TOOLS )
  message("* Build map/vmap tools   : Yes")
else()
  message("* Build map/vmap tools   : No  (default)")
endif()

if( USE_COREPCH )
  message("* Build core w/PCH       : Yes (default)")
else()
  message("* Build core w/PCH       : No")
endif()

if( USE_SCRIPTPCH )
  message("* Build scripts w/PCH    : Yes (default)")
else()
  message("* Build scripts w/PCH    : No")
endif()

if( USE_SFMT )
  message("* Use SFMT for RNG       : Yes")
  add_definitions(-DUSE_SFMT_FOR_RNG)
else()
  message("* Use SFMT for RNG       : No  (default)")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings      : Yes")
else()
  message("* Show compile-warnings  : No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug     : Yes")
  add_definitions(-DTRINITY_DEBUG)
else()
  message("* Use coreside debug     : No  (default)")
endif()

if( WITH_SQLDEBUG )
  message("* Use SQL-query logging  : Yes")
  add_definitions(-DSQLQUERY_LOG)
else()
  message("* Use SQL-query logging  : No  (default)")
endif()

if( WIN32 )
  if( USE_MYSQL_SOURCES )
    message("* Use MySQL sourcetree   : Yes (default)")
  else()
    message("* Use MySQL sourcetree   : No")
  endif()
endif( WIN32 )

if( WITH_SQL )
  message("* Install SQL-files      : Yes")
else()
  message("* Install SQL-files      : No  (default)")
endif()

message("")
