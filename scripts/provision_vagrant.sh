#!/usr/bin/env bash

# Vagrant provisioning for Ubuntu and the Arduboy cross compiler.

################################################################################
# quickfix for ubuntu xenial

if ! grep -q $(cat /etc/hostname) /etc/hosts; then
	echo >> /etc/hosts
	echo 127.0.0.1 $(cat /etc/hostname) >> /etc/hosts
fi

################################################################################
# provision system packages

apt-get update
#apt-get upgrade

apt-get install -y build-essential

# arduino-makefile dependencies
apt-get install -y arduino-mk arduino-core python-serial

# SDL2 dependencies
apt-get install -y libsdl2-2.0 libsdl2-dev

# mingw packages for compliation to Windows
apt-get install -y mingw-w64 libc6-dev-i386

# copy messsage of the day message
cp /opt/Arduboy/scripts/motd /etc/motd

# building a package for release, not needed yet.
#apt-get build-dep arduino-mk
#apt-get install -y dpkg-dev fakeroot devscripts

#################https://lists.gnu.org/archive/html/grub-devel/2012-07/msg00051.html###############################################################
# download and expand the SDL2 libraries
# packages:
#   SDL2 Image - https://www.libsdl.org/projects/SDL_image/

# install iconv library
#cd /tmp/
#wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz

#cd libconv-1.14/
#./configure --prefix=/usr/x86_64-w64-mingw32 --enable-static=yes

# fix for newerd https://lists.gnu.org/archive/html/grub-devel/2012-07/msg00051.htmldebian build
# source: https://lists.gnu.org/archive/html/grub-devel/2012-07/msg00051.html
#sed -i -e '/gets is a security/d' srclib/stdio.in.h

#make
#make install

sdl2_output=/tmp/Arduboy_SDL2
mkdir -p $sdl2_output

# download_and_unpack
# parameters [ url, file, output location ]
function download_and_unpack {
	wget --progress=bar:force $1/$2 -O $3/$2
	tar -xzf $3/$2 -C $sdl2_output
}

# download and unpack main release
sdl2_suffix=devel-2.0.1-mingw.tar.gz
sdl2_url=https://www.libsdl.org
sdl2_download_url=https://www.libsdl.org/release

download_and_unpack $sdl2_download_url SDL2-$sdl2_suffix $sdl2_output

# download sdl packages
sdl2_projects_url=https://www.libsdl.org/projects
sdl2_packages=(image)

for package in ${sdl2_packages[@]}; do
	package_name=SDL2_${package}
	download_and_unpack	"$sdl2_projects_url/SDL_${package}/release" \
				"SDL2_${package}-$sdl2_suffix" \
				$sdl2_output
done

# install the SDL2 development libraries
# search through all folders in `sdl_output`
for d in $sdl2_output/* ; do
	if [ -d $d ]; then
		echo "making $d..."
		cd $d
		make cross CROSS_PATH=/usr
	fi
done
