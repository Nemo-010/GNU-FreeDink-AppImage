#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm    \
    fluidsynth             \
    glm                    \
    help2man               \
    intltool               \
    python-distutils-extra \
    python-setuptools      \
    rsync                  \
    sdl2_gfx               \
    sdl2_mixer             \
    sdl2_ttf               \
    wxwidgets-gtk3

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

# Comment this out if you need an AUR package
#make-aur-package cxxtest
#make-aur-package this was being used to compile the PKGBUILD

echo "Building cxxtest..."
echo "---------------------------------------------------------------"
REPO="https://github.com/CxxTest/cxxtest"
git clone --depth 1 "$REPO" ./cxxtest

cd ./cxxtest/python
python setup.py install --root="/usr" --optimize=1
cd ../..

echo "Building GNU FreeDink..."
echo "---------------------------------------------------------------"
VERSION=109.6
echo "$VERSION" > ~/version
REPO="https://ftp.gnu.org/gnu/freedink/freedink-${VERSION}.tar.gz"

#minimal rest of pkgbuild compile steps  without bashism here
