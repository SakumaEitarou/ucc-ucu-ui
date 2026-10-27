
add_library(libucc-dbus STATIC
    dbus_client.cpp
    dbus_client.h
)
target_link_libraries(libucc-dbus PUBLIC Qt6::Core Qt6::DBus)
target_include_directories(libucc-dbus PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
