cmake_minimum_required(VERSION 3.13)
message(STATUS "OUTPUT dir is ${CMAKE_BINARY_DIR}")


project(wiringPi)
set(LIB_INSTALL_PATH "lib")
set(LIB_INSTALL_HEADERS_PATH "include")
set(SRC_FILES wiringPi.c
        wiringSerial.c
        wiringShift.c
        piHiPri.c
        piThread.c
        wiringPiSPI.c
        wiringPiI2C.c
        softPwm.c
        softTone.c
        mcp23008.c
        mcp23016.c
        mcp23017.c
        mcp23s08.c
        mcp23s17.c
        sr595.c
        pcf8574.c
        pcf8591.c
        mcp3002.c
        mcp3004.c
        mcp4802.c
        mcp3422.c
        max31855.c
        max5322.c
        ads1115.c
        sn3218.c
        bmp180.c
        htu21d.c
        ds18b20.c
        rht03.c
        drcSerial.c
        drcNet.c
        pseudoPins.c
        wpiExtensions.c
        )

#the headers are ok to be transferred over to the include file.

SET(HEADER_FILES
        ads1115.h
        bmp180.h
        drcNet.h
        drcSerial.h
        ds18b20.h
        htu21d.h
        max31855.h
        max5322.h
        mcp23008.h
        mcp23016.h
        mcp23016reg.h
        mcp23017.h
        mcp23s08.h
        mcp23s17.h
        mcp23x08.h
        mcp23x0817.h
        mcp3002.h
        mcp3004.h
        mcp3422.h
        mcp4802.h
        pcf8574.h
        pcf8591.h
        pseudoPins.h
        rht03.h
        sn3218.h
        softPwm.h
        softServo.h
        softTone.h
        sr595.h
        wiringPi.h
        wiringPiI2C.h
        wiringPiSPI.h
        wiringSerial.h
        wiringShift.h
        wpiExtensions.h
        )


add_library(libwiringPi SHARED ${SRC_FILES})



target_link_libraries(libwiringPi -lm -lpthread -lrt -lcrypt)
#set(LIBRARY_OUTPUT_PATH ${LIB_INSTALL_PATH})
set_target_properties(libwiringPi PROPERTIES OUTPUT_NAME "wiringPi")

if (INSTALL_HEADERS)
    install(FILES ${HEADER_FILES} DESTINATION include/wiringpi)
endif ()

message(STATUS "Installing the file at ${LIB_OUTPATH}${LIB_INSTALL_PATH}")
install(TARGETS libwiringPi DESTINATION ${LIB_OUTPATH}${LIB_INSTALL_PATH})
