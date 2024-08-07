set(LUA_SRC
    "lua/lapi.c"
    "lua/lauxlib.c"
    "lua/lbaselib.c"
    "lua/lcode.c"
    "lua/ldblib.c"
    "lua/ldebug.c"
    "lua/ldo.c"
    "lua/ldump.c"
    "lua/lfunc.c"
    "lua/lgc.c"
    "lua/linit.c"
    "lua/liolib.c"
    "lua/llex.c"
    "lua/lmathlib.c"
    "lua/lmem.c"
    "lua/loadlib.c"
    "lua/lobject.c"
    "lua/lopcodes.c"
    "lua/loslib.c"
    "lua/lparser.c"
    "lua/lstate.c"
    "lua/lstring.c"
    "lua/lstrlib.c"
    "lua/ltable.c"
    "lua/ltablib.c"
    "lua/ltm.c"
    "lua/lundump.c"
    "lua/lvm.c"
    "lua/lzio.c")

set(LUA_HPP
    "lua/lapi.h"
    "lua/lauxlib.h"
    "lua/lcode.h"
    "lua/ldebug.h"
    "lua/lfunc.h"
    "lua/lgc.h"
    "lua/llex.h"
    "lua/llimits.h"
    "lua/lmem.h"
    "lua/lobject.h"
    "lua/lopcodes.h"
    "lua/lparser.h"
    "lua/lstate.h"
    "lua/lstring.h"
    "lua/ltable.h"
    "lua/ltm.h"
    "lua/lua.h"
    "lua/luaconf.h"
    "lua/lualib.h"
    "lua/lundump.h"
    "lua/lvm.h"
    "lua/lzio.h")

source_group("" FILES ${LUA_SRC})
source_group("" FILES ${LUA_HPP})

add_library("lua" STATIC ${LUA_SRC} ${LUA_HPP})

set_property(TARGET "lua" PROPERTY FOLDER "External Libraries")

# include_directories(src)

if(MSVC)
  sm_add_compile_definition("lua" _CRT_SECURE_NO_WARNINGS)
  set_source_files_properties(${LUA_SRC} PROPERTIES LANGUAGE CXX)
endif(MSVC)
