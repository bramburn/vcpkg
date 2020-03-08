cmake_minimum_required(VERSION 3.13)

project(WiringPiMain)
# Install targets
install(TARGETS WiringPiMain
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        )


add_subdirectory(devLib)
add_subdirectory(wiringPi)
add_subdirectory(gpio)


# Install headers
if (INSTALL_HEADERS)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/devLib/*.h DESTINATION include/wiringpi)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/wiringPi/*.h DESTINATION include/wiringpi)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/gpio/*.h DESTINATION include/wiringpi)
endif ()