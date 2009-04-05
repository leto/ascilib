# This CMake script tries to locate the clib module and shared library
# in the source tree and 
#
# It uses
#
#   M_NAME
#   M_VERSION
#   USE_INCLUDE_PATH
#
# to return
#
#   MODULE_SOURCE_PATH
#   MODULE_LIBRARY

SET (MODULE_NAME ${M_NAME})

IF(M_VERSION)
  SET (MODULE_NAME ${M_NAME}-${M_VERSION})
ENDIF(M_VERSION)

# ---- Find the shared library include and lib path
SET (MODULE_SOURCE_PATH ${MAP_CLIBS_PATH}/${MODULE_NAME})

message("PROJECT=${PROJECT_LABEL}")
message("MODULE_SOURCE_PATH=${MODULE_SOURCE_PATH}")

IF(NOT IS_DIRECTORY ${MODULE_SOURCE_PATH})
  MESSAGE(FATAL_ERROR "${MODULE_SOURCE_PATH} does not exist")
ENDIF(NOT IS_DIRECTORY ${MODULE_SOURCE_PATH})

SET(_LIBNAME ${MAP_projectname}_${M_NAME}-${MAP_VERSION})
MESSAGE("Looking for lib${_LIBNAME}.so")
IF(BUILD_LIBS)
	# This section gets run when cmake is invoked from the top level dir
  SET(MODULE_LIBRARY ${_LIBNAME})
ELSE(BUILD_LIBS)
  # This section gets run when CMake is invoked from a node - it needs
	# an explicit path as is has been pre-built and CMake is not aware...
  FIND_LIBRARY(MODULE_LIBRARY NAMES lib${_LIBNAME}.so PATHS ${MODULE_SOURCE_PATH} ${MODULE_SOURCE_PATH}/build ${MODULE_SOURCE_PATH}/src)
ENDIF(BUILD_LIBS)
message("MODULE_LIBRARY=${MODULE_LIBRARY}")
INCLUDE_DIRECTORIES(${MODULE_SOURCE_PATH}/include)
INCLUDE_DIRECTORIES(${MODULE_SOURCE_PATH}/src)
INCLUDE_DIRECTORIES(${MODULE_SOURCE_PATH})
IF(USE_INCLUDEPATH)
  INCLUDE_DIRECTORIES(${MODULE_SOURCE_PATH}/${USE_INCLUDEPATH})
ENDIF(USE_INCLUDEPATH)

# UNSET(_LIBNAME)
SET(_LIBNAME 'unknown')

MARK_AS_ADVANCED(
  MODULE_SOURCE_PATH
	MODULE_LIBRARY
)

