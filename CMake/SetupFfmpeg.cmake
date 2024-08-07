if(CMAKE_GENERATOR MATCHES "Ninja")
  message(
    FATAL_ERROR
      "You cannot use the Ninja generator when building the bundled ffmpeg library."
    )
endif()

set(SM_FFMPEG_SRC_DIR "${SM_LIB_DIR}/ffmpeg")
set(SM_FFMPEG_CONFIGURE_EXE "${SM_FFMPEG_SRC_DIR}/configure")

list(APPEND FFMPEG_CONFIGURE
            "${SM_FFMPEG_CONFIGURE_EXE}"
            "--disable-programs"
            "--disable-doc"
            "--disable-avdevice"
            "--disable-swresample"
            "--disable-postproc"
            "--disable-avfilter"
            "--disable-shared"
            "--enable-static")

if(CMAKE_POSITION_INDEPENDENT_CODE)
  list(APPEND FFMPEG_CONFIGURE "--enable-pic")
endif()

if(MACOSX)
  find_program(FFMPEG_YASM_EXECUTABLE yasm
               PATHS /usr/bin /usr/local/bin /opt/local/bin)
  list(APPEND FFMPEG_CONFIGURE "--yasmexe=${FFMPEG_YASM_EXECUTABLE}")
  list(APPEND FFMPEG_PATCH_COMMAND "rm")
  list(APPEND FFMPEG_PATCH_COMMAND "-f")
  list(APPEND FFMPEG_PATCH_COMMAND "${SM_FFMPEG_SRC_DIR}/VERSION")
endif()

if(WITH_GPL_LIBS)
  list(APPEND FFMPEG_CONFIGURE "--enable-gpl")
endif()

if(WITH_CRYSTALHD_DISABLED)
  list(APPEND FFMPEG_CONFIGURE "--disable-crystalhd")
endif()

if(NOT WITH_EXTERNAL_WARNINGS)
  list(APPEND FFMPEG_CONFIGURE "--extra-cflags=-w")
endif()

list(APPEND SM_FFMPEG_MAKE $(MAKE))
if(WITH_FFMPEG_JOBS GREATER 0)
  list(APPEND SM_FFMPEG_MAKE "-j${WITH_FFMPEG_JOBS}")
endif()

if(IS_DIRECTORY "${SM_FFMPEG_SRC_DIR}")
  externalproject_add("ffmpeg"
                      SOURCE_DIR
                      "${SM_FFMPEG_SRC_DIR}"
                      CONFIGURE_COMMAND
                      ${FFMPEG_CONFIGURE}
                      BUILD_COMMAND
                      "${SM_FFMPEG_MAKE}"
                      UPDATE_COMMAND
                      ""
                      INSTALL_COMMAND
                      ""
                      TEST_COMMAND
                      ""
                      PATCH_COMMAND
                      ${FFMPEG_PATCH_COMMAND})
else()
  message(
    FATAL_ERROR
    "Unable to find the ffmpeg library (did you run 'git submodule update --recursive'?)"
  )
endif()

externalproject_get_property("ffmpeg" BINARY_DIR)
set(SM_FFMPEG_ROOT ${BINARY_DIR})
