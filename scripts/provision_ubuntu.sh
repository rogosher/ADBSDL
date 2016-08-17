#!/usr/bin/env bash
apt-get update
apt-get upgrade
apt-get build-dep arduino-mk
apt-get install -y arduino-core build-essential dpkg-dev fakeroot devscripts
apt-get install -y arduino-mk python-serial arduino-core

apt-get install -y libsdl2-2.0 libsdl2-dev

apt-get install -y mingw-w64

cd /tmp
sdl2_mingw_devel=SDL2_image-devel-2.0.1-mingw.tar.gz
wget --progress=bar:force https://www.libsdl.org/projects/SDL_image/release/$sdl2_mingw_devel
tar -xzf $sdl2_mingw_devel --strip-components=1
