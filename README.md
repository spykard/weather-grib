# Ocean-Route - Weather Map & Forecast Visualization

## Build Guide & Changelog

1. Install Qt and QtCreator. Select MinGW compiler, CMake and Ninja during the installation process as well.  
	- Tested on Qt 5.15.0 32-bit with MinGW 8.1.0 32-bit
2. Use the "Open" command of QtCreator and select CMakeLists.txt  
3. Link the libraries, can be done by adding the following lines to CMakeLists.txt  
 set(BZIP2_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(BZIP2_LIBRARIES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libbz2.a")  
 set(LIBNOVA_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(LIBNOVA_LIBRARY "${CMAKE_CURRENT_SOURCE_DIR}/lib/libnova.a")  
 set(OPENJPEG_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(OPENJPEG_LIBRARIES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libopenjp2.dll")  
 set(PNG_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(PNG_LIBRARIES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libpng.a")  
 set(PROJ4_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(PROJ4_LIBRARIES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libproj.a")  
 set(ZLIB_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")  
 set(ZLIB_LIBRARIES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libz.a")  
4. Build and Compile, the few errors that occur can be easily fixed one by one.  
5. Copy the "/OceanRoute/data/" file to output folder that includes the "OceanRoute.exe" executable.

### Task: Change Icon

1. Change icons at "/win_online_installer/".
2. Change three of the icons at "/data/img/".

### Task: Change Title

1. Change `Version.h.in:line 62`.

### Task: Create an Installer

1. Add repogen.exe to PATH.

### Task: Make the .exe file runable in a standalone fashion instead of it only being able to run through Qt

1. Add compiler/bin to PATH (C:\Qt\5.15.0\mingw81_32\bin).
2. Add libopenjp2.dll to the folder.  
