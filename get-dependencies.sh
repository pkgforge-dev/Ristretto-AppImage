#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm ristretto doxygen

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ! llvm

# Comment this out if you need an AUR package
make-aur-package gdk-pixbuf2-noglycin
make-aur-package libjxl-noglycin
make-aur-package librsvg-noglycin

# archlinux arm does not have svt-av1
if [ "$ARCH" = 'x86_64' ]; then
	make-aur-package libheif-noglycin
	make-aur-package libavif-noglycin
fi

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
