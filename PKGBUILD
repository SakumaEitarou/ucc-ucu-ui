
# Maintainer: Volodymyr Derkach
pkgname=ucc-ucu-ui
pkgver=1.0.0
pkgrel=1
pkgdesc="Uniwill Control Center with UCU Fluent UI for XMG Neo A25 (CachyOS)"
arch=('x86_64')
url="https://github.com/nanomatters/ucc"
license=('GPL3')
depends=('qt6-base' 'qt6-declarative' 'qt6-tools' 'tuxedo-drivers')
makedepends=('cmake' 'ninja')
source=("git+https://github.com/nanomatters/ucc.git"
        "qml-ui::git+https://github.com/Uniwill-Control-Utility/Uniwill-Control-Utility.git")
sha256sums=('SKIP' 'SKIP')

prepare() {
  cp -r $srcdir/ucc-ucu-fork/* $srcdir/ucc/ || true
}

build() {
  cmake -B build -S ucc -DCMAKE_BUILD_TYPE=Release -G Ninja
  cmake --build build
}

package() {
  DESTDIR="$pkgdir" cmake --install build
}
