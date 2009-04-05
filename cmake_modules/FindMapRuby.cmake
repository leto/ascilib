# - Find BioLib for Ruby settings
#
# Expects M_NAME, M_VERSION to be set!
#
# Special parameters are:
#
#   USE_INCLUDEPATH - find module include files here
#   USE_SWIG_INCLUDEALL - tell SWIG to parse all include files for 
#     info (not recommended as all C headers are pulled in too)
#   USE_RLIB - link the R libraries
#   USE_ZLIB - link Zlib
#   USE_BIOLIBCORE - link the core lib

SET (M_MODULE ${M_NAME})

message("Creating Ruby module ${M_MODULE} (${M_VERSION})")
FIND_PACKAGE(BioLib REQUIRED)
FIND_PACKAGE(Ruby REQUIRED)

# ---- Setting the default Ruby include path
INCLUDE_DIRECTORIES(${RUBY_INCLUDE_PATH})
SET (RUBY_LIB_PATH ${RUBY_INCLUDE_PATH})

FIND_PACKAGE(BioLibModule REQUIRED)
FIND_PACKAGE(BioLibLibraries REQUIRED)

SET (USE_LANGUAGE "ruby")
SET (USE_LANGUAGE_LIBRARY ${RUBY_LIBRARY})
SET (USE_SWIG_FLAGS ";-prefix;'biolib::'")

FIND_PACKAGE(BioLibSWIG REQUIRED)

MESSAGE( STATUS "RUBY_LIB_PATH=${RUBY_LIB_PATH}")

