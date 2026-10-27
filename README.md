
# ucc-ucu-ui - Uniwill Control Center with UCU Fluent UI

Форк https://github.com/nanomatters/ucc с интерфейсом как у https://github.com/Uniwill-Control-Utility/Uniwill-Control-Utility

Цель: сохранить бэкенд uccd + libucc-dbus, полностью переписать ucc-gui на Qt6 QML в стиле WPF Fluent (темная тема, NavigationView, карточки Dashboard, Hydro UI).

## Фичи из UCU которые перенесены
- Dashboard с 4 телеметриями CPU/GPU/FAN/LIQUID
- Presets Office/Gaming/Turbo + Custom
- Fan Control с графиком
- Hydro UI OASIS - помпа + RGB
- Keyboard per-key RGB + Light Bar
- Fluent темная тема #1a1a1f / акцент #6c5cff

## Сборка на CachyOS / Arch

```bash
sudo pacman -S qt6-base qt6-declarative qt6-tools cmake
git clone https://github.com/YOUR_USER/ucc-ucu-ui
cd ucc-ucu-ui
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
sudo cmake --install build
# запуск
./build/ucc-gui/ucc-gui-ucu
```

## Интеграция с оригинальным uccd
Этот форк использует тот же D-Bus интерфейс org.ucc.daemon. Достаточно чтобы uccd был запущен:
```
systemctl --user status uccd
```
Если у тебя стоит оригинальный ucc - просто замени бинарник ucc-gui на ucc-gui-ucu.

## PKGBUILD для AUR
см. PKGBUILD в корне.

## Скриншоты - смотри веб-превью в artifact
