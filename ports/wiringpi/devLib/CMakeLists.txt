cmake_minimum_required(VERSION 3.13)
project(devLib)
set(LIB_INSTALL_PATH "lib")
set(LIB_INSTALL_HEADERS_PATH "include")

set(SRC_FILES
        ds1302.c
        gertboard.c
        lcd.c
        lcd128x64.c
        maxdetect.c
        piFace.c

        piGlow.c
        piNes.c
        scrollPhat.c
        )

SET(HEADER_FILEs
        ds1302.h
        font.h
        gertboard.h
        lcd.h
        lcd128x64.h
        maxdetect.h
        piFace.h
        piGlow.h
        piNes.h
        scrollPhat.h
        scrollPhatFont.h
        )


add_library(libwiringPiDev SHARED ${SRC_FILES})


set_target_properties(libwiringPiDev PROPERTIES OUTPUT_NAME "wiringPiDev")
if (INSTALL_HEADERS)
    install(FILES ${HEADER_FILES} DESTINATION ${LIB_OUTPATH}include)
endif ()

install(TARGETS libwiringPiDev DESTINATION ${LIB_OUTPATH}${LIB_INSTALL_PATH})
