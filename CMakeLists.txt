
cmake_minimum_required(VERSION 3.20)
project(ucc-ucu VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2 DBus)

add_subdirectory(libucc-dbus)
add_subdirectory(ucc-gui)
