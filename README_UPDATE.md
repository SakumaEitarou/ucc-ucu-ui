
# Обновление для SakumaEitarou/ucc-ucu-ui - интеграция реального uccd

Ты уже запушил базу. Теперь нужно подключить реальный бэкенд nanomatters/ucc.

Выполни:

cd ~/Downloads/ucc-ucu-ui

# 1. Добавь оригинальный ucc как сабмодуль для бэкенда
git submodule add https://github.com/nanomatters/ucc upstream
git submodule update --init

# 2. Замени libucc-dbus на настоящий
rm -rf libucc-dbus
cp -r upstream/libucc-dbus libucc-dbus
cp -r upstream/uccd uccd_real

# 3. Обнови CMakeLists.txt чтобы линковать настоящий lib
cat > CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.20)
project(ucc-ucu VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2 DBus)
add_subdirectory(libucc-dbus)
add_subdirectory(ucc-gui)
EOF

# 4. Обнови ucc-gui/main.cpp для реального моста
# Смотри файл main_v2.cpp в этом архиве

# 5. Коммит и пуш
git add .
git commit -m "feat: integrate real uccd backend from nanomatters/ucc"
git push origin main
