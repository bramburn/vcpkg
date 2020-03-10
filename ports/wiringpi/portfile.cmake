
include(vcpkg_common_functions)
if (NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
    message(FATAL_ERROR "You must compile on arm architecture. Please ensure VCPKG_TARGET_ARCHITECTURE is set to arm")
endif ()

## define the toolchain file to
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/armCMAKE.cmake)
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO bramburn/WiringPi
        REF 2.6.3
        SHA512 5bd954f33ef564425e39c3a2f59d9dfe4598df625e53175b434632e212a454692196878993038412551104709b98fb8f21ad0a9c7299001a5cf3333194963be5
        HEAD_REF master
)

#make sure we this is running
# we are using the arm gnu c and c++ compilers, make sure they are installed

set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")

## Copy default cmake files
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/devLib/CMakeLists.txt DESTINATION ${SOURCE_PATH}/devLib)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/wiringPi/CMakeLists.txt DESTINATION ${SOURCE_PATH}/wiringPi)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS_RELEASE -DINSTALL_HEADERS=ON
        OPTIONS_DEBUG -DINSTALL_HEADERS=OFF
)

vcpkg_install_cmake()

# # Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING.LESSER DESTINATION ${CURRENT_PACKAGES_DIR}/share/wiringpi/copyright)
# Delete redundant debug/ folders
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()


# # Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME wiringpi)
