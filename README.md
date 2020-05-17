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
- Ninja
- *Optional:* CMake 3.12.4

### Pre-requisite

You need to make sure you have ninja installed. Here is the code:

```shell script

git clone https://github.com/ninja-build/ninja.git
cd ninja
./configure.py --bootstrap

sudo mv ninja /usr/local/bin


```


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

## Contributing
Vcpkg is built with your contributions. Here are some ways you can contribute:

* [Submit Issues](https://github.com/bramburn/vcpkg/issues) in vcpkg or existing packages

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

Every time you need to install a custom build for raspberryPI please use `arm-rasp` triplet like so
```shell script

./vcpkg install wiringpi:arm-rasp

```
The above command will install wiringpi with the arm GNU c/c++ compiler.

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


## integration into clion or 

Running the code below will give you the flags to add to your compiler
```shell script

./vcpkg integrate install

```


```

-DCMAKE_TOOLCHAIN_FILE=/home/xxxx/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=arm-rasp
```