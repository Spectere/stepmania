if(WITH_SYSTEM_ZLIB)
  find_package(ZLIB REQUIRED)
else()
  list(APPEND ZLIB_SRC
              "zlib/adler32.c"
              "zlib/compress.c"
              "zlib/crc32.c"
              "zlib/deflate.c"
              "zlib/gzclose.c"
              "zlib/gzlib.c"
              "zlib/gzread.c"
              "zlib/gzwrite.c"
              "zlib/infback.c"
              "zlib/inffast.c"
              "zlib/inflate.c"
              "zlib/inftrees.c"
              "zlib/trees.c"
              "zlib/uncompr.c"
              "zlib/zutil.c"
  )

  list(APPEND ZLIB_HPP
              "zlib/adler32.c"
              "zlib/compress.c"
              "zlib/crc32.c"
              "zlib/deflate.c"
              "zlib/gzclose.c"
              "zlib/gzlib.c"
              "zlib/gzread.c"
              "zlib/gzwrite.c"
              "zlib/inflate.c"
              "zlib/infback.c"
              "zlib/inftrees.c"
              "zlib/inffast.c"
              "zlib/trees.c"
              "zlib/uncompr.c"
              "zlib/zutil.c"
  )

  source_group("" FILES ${ZLIB_SRC} ${ZLIB_HPP})

  add_library("zlib" ${ZLIB_SRC} ${ZLIB_HPP})

  set_property(TARGET "zlib" PROPERTY FOLDER "External Libraries")

  disable_project_warnings("zlib")

  if(MSVC)
    sm_add_compile_definition("zlib" _MBCS)
  endif(MSVC)
  if(MACOSX OR LINUX)
    sm_add_compile_definition("zlib" HAVE_UNISTD_H)
  endif(MACOSX OR LINUX)
endif()
