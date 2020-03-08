cmake_minimum_required(VERSION 3.13)
if (WIN OR WIN32)
    MESSAGE(FATAL_ERROR "CANNOT BUILD ON WINDOWS")
ENDIF ()
project(WiringPiMain)
# Install targets
#install(TARGETS WiringPiMain
#        RUNTIME DESTINATION bin
#        LIBRARY DESTINATION lib
#        ARCHIVE DESTINATION lib
#        )
set(LIB_OUTPATH include/wiringpi/)
FILE(MAKE_DIRECTORY ${LIB_OUTPATH}lib)
FILE(MAKE_DIRECTORY ${LIB_OUTPATH}include)
FILE(MAKE_DIRECTORY ${LIB_OUTPATH}bin)

add_subdirectory(devLib)
add_subdirectory(wiringPi)
add_subdirectory(gpio)




