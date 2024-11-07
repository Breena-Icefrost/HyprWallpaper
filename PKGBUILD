# Maintainer: Breena Stoneglove <stoneglove-breena@protonmail.com>
pkgname=hyprwallpaper-cli
pkgver=0.0.2
pkgrel=1
pkgdesc="A cli tool to change your wallpapers! Also compatible with HyprConfig soon."
arch=(x86_64)
url="https://github.com/Breena-Icefrost/HyprWallpaper"
license=('GPL')
depends=(hyprland hyprpaper)
makedepends=(git make)
optdepends=()
provides=()
conflicts=()
changelog=
source=("git+$url")
sha256sums=('SKIP')

prepare() {
	cd "$pkgname-$pkgver"
	patch -p1 -i "$srcdir/$pkgname-$pkgver.patch"
}

build() {
	cd "$pkgname-$pkgver"
	./configure --prefix=/usr
	make
}

check() {
	cd "$pkgname-$pkgver"
	make -k check
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir/" install
}
