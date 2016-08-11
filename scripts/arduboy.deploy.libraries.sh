#! /bin/bash

GIT_USER="Arduboy"

GIT_SERVER="https://github.com"

GIT_URL="$GIT_SERVER/$GIT_USER"

LIBRARY_DIR="arduboy_libraries"

function eko {
	echo "$1" | tee build.out
}

function clone_repo {
	REPO="$GIT_URL/$1.git"
	eko "Cloning $REPO..."
	git clone $GIT_URL/$1.git
}

clone_repo "Arduboy"
