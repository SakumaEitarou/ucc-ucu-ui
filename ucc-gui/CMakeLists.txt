
find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2 DBus)

qt_add_executable(ucc-gui-ucu
    main.cpp
)

qt_add_qml_module(ucc-gui-ucu
    URI UCC.UCU
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/pages/Dashboard.qml
        qml/pages/Presets.qml
        qml/pages/FanControl.qml
        qml/pages/Hydro.qml
        qml/pages/Keyboard.qml
        qml/pages/LightBar.qml
)

target_link_libraries(ucc-gui-ucu PRIVATE Qt6::Core Qt6::Gui Qt6::Quick Qt6::QuickControls2 Qt6::DBus libucc-dbus)
install(TARGETS ucc-gui-ucu DESTINATION bin)
