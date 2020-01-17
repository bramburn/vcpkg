IF (NOT _VCPKG_ARM`_TOOLCHAIN)
    set(_VCPKG_ARM`_TOOLCHAIN 1)

    set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
    set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")
ENDIF ()