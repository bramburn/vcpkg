# This is the toolchain file settings for the ARM linux builds.
# Make sure you have arm-linux gnu compilers installed or else it will not work.
if (NOT _VCPKG_ARM`_TOOLCHAIN)
    if (_VCPKG_TARGET_TRIPLET_ARCH STREQUAL "arm")
        set(_VCPKG_ARM`_TOOLCHAIN 1)
        ## todo: we need to check if this exists
        set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
        set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")

        get_property(_CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)
        if (NOT _CMAKE_IN_TRY_COMPILE)
            string(APPEND CMAKE_C_FLAGS_INIT " -fPIC ${VCPKG_C_FLAGS} ")
            string(APPEND CMAKE_CXX_FLAGS_INIT " -fPIC ${VCPKG_CXX_FLAGS} ")
            string(APPEND CMAKE_C_FLAGS_DEBUG_INIT " ${VCPKG_C_FLAGS_DEBUG} ")
            string(APPEND CMAKE_CXX_FLAGS_DEBUG_INIT " ${VCPKG_CXX_FLAGS_DEBUG} ")
            string(APPEND CMAKE_C_FLAGS_RELEASE_INIT " ${VCPKG_C_FLAGS_RELEASE} ")
            string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " ${VCPKG_CXX_FLAGS_RELEASE} ")

            string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
            string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
            if (VCPKG_CRT_LINKAGE STREQUAL "static")
                string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT "-static ")
                string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT "-static ")
            endif ()
        endif ()
    endif ()

else ()
    message(FATAL_ERROR "You can only build this on ARM targets, please set VCPKG_TARGET_TRIPLET")
endif ()
