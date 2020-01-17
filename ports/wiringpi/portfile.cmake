
include(vcpkg_common_functions)
vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO bramburn/WiringPi
        REF master
        SHA512 af5ea614734a8506bf89b25cd437559f10e4229c1273aa376172a2274a532e3bee6357cb44eb4f3d38d4143a79a841e9512f002e6ccf4091989a3ffa7e010785
)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}

)

vcpkg_install_cmake()


# # Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING.LESSER DESTINATION ${CURRENT_PACKAGES_DIR}/share/wiringpi/copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# # Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME wiringpi)
