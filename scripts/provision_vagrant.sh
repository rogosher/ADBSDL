#!/usr/bin/env bash

# Vagrant provisioning for Ubuntu and the Arduboy cross compiler.

################################################################################
# quickfix for ubuntu xenial
#

if ! grep -q $(cat /etc/hostname) /etc/hosts; then
	echo >> /etc/hosts
	echo 127.0.0.1 $(cat /etc/hostname) >> /etc/hosts
fi

################################################################################
# provision system packages
#

apt-get update
#apt-get upgrade

apt-get install build-essential

# arduino-makefile dependencies
apt-get install -y arduino-mk arduino-core python-serial

# SDL2 dependencies
apt-get install -y libsdl2-2.0 libsdl2-dev

# mingw packages for compliation to Windows
apt-get install -y mingw-w64


# building a package for release, not needed yet.
#apt-get build-dep arduino-mk
#apt-get install -y dpkg-dev fakeroot devscripts

################################################################################
# download and expand the SDL2 libraries
# packages:
#   SDL2 Image - https://www.libsdl.org/projects/SDL_image/
#

# create the output directory
sdl2_output=/tmp/Arduboy_SDL2
mkdir -p $sdl2_output

function download_and_unpack {
	# parameters [ url, file, output location ]
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

exit

# TODO: iterate through folders at /tmp/Arduboy_SDL2 and run make in each

# install the SDL2 development libraries
cd /tmp/SDL2
make cross CROSS_PATH=/usr

