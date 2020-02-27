
include(vcpkg_common_functions)
if (NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
    message(FATAL_ERROR "You must compile on arm architecture. Please ensure VCPKG_TARGET_ARCHITECTURE is set to arm")
endif ()

## define the toolchain file to
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/armCMAKE.cmake)
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO bramburn/wiringpi
        REF v2.6.1
        SHA512 d8bd44439100772929eb8a4eb4aebfd66fa54562c838eb4c081a382dc1d73c545faa6d9675e320864d9b533e4a0c4a673e44058c7f643ccd56ec90830cdfaf45
        HEAD_REF master
)


set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")

## Copy default files
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS_RELEASE -DINSTALL_HEADERS=ON
        OPTIONS_DEBUG -DINSTALL_HEADERS=OFF

)

vcpkg_install_cmake()

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING.LESSER DESTINATION ${CURRENT_PACKAGES_DIR}/share/wiringpi/copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# # Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME wiringpi)
