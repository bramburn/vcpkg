# Vcpkg

## Overview
Vcpkg helps you manage C and C++ libraries on Windows, Linux and MacOS. This tool and ecosystem are constantly evolving; your involvement is vital to its success!

This particular fork is purposely built for [**WiringPi**](https://github.com/bramburn/WiringPi) you can find more about our build in the link

For short description of available commands, run `vcpkg help`.

* Github: [https://github.com/microsoft/vcpkg](https://github.com/microsoft/vcpkg)
* Slack: [https://cpplang.now.sh/](https://cpplang.now.sh/), the #vcpkg channel
* Docs: [Documentation](docs/index.md)

| Windows (Arm Raspberry)  |
| ------------- |
| [![Build Status](https://dev.azure.com/nitr021/vcpkg%20and%20WiringPi%20build%20test/_apis/build/status/bramburn.vcpkg?branchName=master)](https://dev.azure.com/nitr021/vcpkg%20and%20WiringPi%20build%20test/_build/latest?definitionId=8&branchName=master) |

## Quick Start
Prerequisites:
- Windows 10, 8.1, 7, Linux, or MacOS
- Visual Studio 2015 Update 3 or newer (on Windows)
- Git
- gcc >= 7 or equivalent clang (on Linux)
- *Optional:* CMake 3.12.4

To get started:
```
> git clone https://github.com/Microsoft/vcpkg.git
> cd vcpkg

PS> .\bootstrap-vcpkg.bat -useSystemBinaries
Linux:~/$ ./bootstrap-vcpkg.sh -useSystemBinaries
```




Then, to hook up user-wide [integration](docs/users/integration.md), run (note: requires admin on first use)
```
PS> .\vcpkg integrate install
Linux:~/$ ./vcpkg integrate install
```

Install any packages with
```
PS> .\vcpkg install sdl2 curl
Linux:~/$ ./vcpkg install sdl2 curl
```

The best way to use installed libraries with CMake is via the toolchain file `scripts\buildsystems\vcpkg.cmake`. To use this file, you simply need to add it onto your CMake command line as `-DCMAKE_TOOLCHAIN_FILE=[vcpkg root]\scripts\buildsystems\vcpkg.cmake`.

In Visual Studio, you can create a New Project (or open an existing one). All installed libraries are immediately ready to be `#include`'d and used in your project without additional configuration.

For more information, see our [using a package](docs/examples/installing-and-using-packages.md) example for the specifics. If your library is not present in vcpkg catalog, you can open an [issue on the GitHub repo](https://github.com/microsoft/vcpkg/issues) where the dev team and the community can see it and potentially create the port file for this library.

Additional notes on macOS and Linux support can be found in the [official announcement](https://blogs.msdn.microsoft.com/vcblog/2018/04/24/announcing-a-single-c-library-manager-for-linux-macos-and-windows-vcpkg/).

## Tab-Completion / Auto-Completion
`vcpkg` supports auto-completion of commands, package names, options etc in Powershell and bash. To enable tab-completion, use one of the following:
```
PS> .\vcpkg integrate powershell
Linux:~/$ ./vcpkg integrate bash
```
and restart your console.


## Examples
See the [documentation](docs/index.md) for specific walkthroughs, including [installing and using a package](docs/examples/installing-and-using-packages.md), [adding a new package from a zipfile](docs/examples/packaging-zipfiles.md), and [adding a new package from a GitHub repo](docs/examples/packaging-github-repos.md).

Our docs are now also available online at ReadTheDocs: <https://vcpkg.readthedocs.io/>!

See a 4 minute [video demo](https://www.youtube.com/watch?v=y41WFKbQFTw).

## Contributing
Vcpkg is built with your contributions. Here are some ways you can contribute:

* [Submit Issues](https://github.com/Microsoft/vcpkg/issues) in vcpkg or existing packages
* [Submit Fixes and New Packages](https://github.com/Microsoft/vcpkg/pulls)

Please refer to our [Contribution guidelines](CONTRIBUTING.md) for more details.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## License

Code licensed under the [MIT License](LICENSE.txt).


## Installation

To install you need to run the following

Download the clone script here:

```shell script
git clone https://github.com/bramburn/vcpkg.git
```

### Raspberry PI

```shell script
cd vcpkg
./bootstrap-vcpkg.sh
```

### all other system

Then you need to run the following code to install the system

```shell script
cd vcpkg
./bootstrap-vcpkg.sh -useSystemBinaries
```

## Configuration

As we have installed our own arm-rasp triplet we need install the package into the arm-rasp.

Part of build you need to do the following

### Step 1

First, create a folder to contain your custom triplets:
Start off by creating a custom build

```shell script
~/vcpkg$ mkdir ../custom-triplets
```

### Step 2

Now create the raspberry PI cmake

```shell script
~/vcpkg$ cp ./triplets/arm-uwp.cmake ../custom-triplets/arm-rasp.cmake
```

### Step 3

Edit the new Cmake file using the following

```cmake
 set(VCPKG_TARGET_ARCHITECTURE arm)
 set(VCPKG_CRT_LINKAGE dynamic)
 set(VCPKG_LIBRARY_LINKAGE dynamic)
 set(VCPKG_CMAKE_SYSTEM_NAME Linux)
 set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf-g++")
 set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf-gcc")
```

### Step 4

Call the `./vcpkg` on your debian so that you can build the c++ files on your Debian WSL.

```shell script
./vcpkg install python3:arm-rasp --overlay-triplets=../custom-triplets/
```

But if you're running it on your raspberry pi you can just run it as follows:

```shell script
./vcpkg install wiringpi
```


### Cmake module
To enable you to work on cmake and to enable

```cmake
# THIS INCLUDES THE REVISION TO WORK ON THE DEBIAN BUILD

find_library(wiringpi_LIBRARY libwiringPi.so
        PATH_SUFFIXES lib
        PATHS /usr/local
        )

message(STATUS "Loading findingwiring --- ${wiringpi_LIBRARY}")
find_path(wiringpi_INCLUDE_DIR wiringPi.h wiringPiI2C.h
        PATH_SUFFIXES include
        PATHS /usr/local
        )

MESSAGE(STATUS "The include folder for wiringpi is ${wiringpi_INCLUDE_DIR}")
```