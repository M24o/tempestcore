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

if( WITH_SQL )
  add_subdirectory(updates)
  add_subdirectory(base)
  add_subdirectory(create)
endif()
