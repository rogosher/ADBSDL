# Makefile
# Author: Ross
# This Makefile is intended to build source for the Arduboy

# use local directory for arduino-makefile
#arduino_mk_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

# use debian installation path, used for included vagrant
arduino_mk_path := /usr/share/arduino
current_dir     := $(shell pwd)

TARGET = game

PROJECT_DIR = $(current_dir)

CFLAGS_STD       = -std=gnu11

CC               = gcc
CXX              = g++
#LD               = g++ -o
#LFAGS            = -mconsole

CXXFLAGS_STD     = -std=gnu++11 -fno-threadsafe-statics
CXXFLAGS        += -pedantic -Wall -Wextra


CURRENT_DIR      = $(shell basename $(CURDIR))
OBJDIR           = $(PROJECT_DIR)/bin/Arduboy/$(CURRENT_DIR)

SDL_OBJDIR       = $(PROJECT_DIR)/obj

SDL_TARGET       = game
SDL_SOURCE      := $(wildcard $(PROJECT_DIR)/src/*.cpp)
SDL_INCLUDE     := $(wildcard $(PROJECT_DIR)/src/*.h)

SDL_OBJECTS       := $(SDL_SOURCE:$(PROJECT_DIR)/src/%.cpp=$(SDL_OBJDIR)/%.o)
SDL_OBJECTS_WIN32 := $(SDL_SOURCE:$(PROJECT_DIR)/src/%.cpp=$(SDL_OBJDIR)/win32/%.o)

SDL_LDFLAGS = `$(SDL_ROOT_DIR)/sdl2-config --libs` \
	      -static-libgcc -static-libstdc++

TARGET_BIN_SDL = $(PROJECT_DIR)/bin/$(SDL_TARGET)

RM = rm -f
MKDIR = mkdir -p

print_output = $(info $(1))

#$(TARGET_BIN_SDL): $(SDL_OBJECTS)
#	@echo $@
#	@$(LD) $@ $(LFLAGS) $(SDL_OBJECTS) `sdl2-config --libs`

#$(SDL_OBJECTS): $(SDL_OBJDIR)/%.o : $(PROJECT_DIR)/src/%.cpp
#	@echo $@
#	@$(CC) $(CFLAGS) `sdl2-config --cflags` -c $< -o $@

########################################################################
#
# Detect OS
ifeq ($(OS),Windows_NT)
    CURRENT_OS = WINDOWS
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CURRENT_OS = LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CURRENT_OS = MAC
    endif
endif

$(call print_output,$(CURRENT_OS))
define ARDUBOY_HELP
Available targets:
  make                   - compile the code
  make sdl               - compile SDL2 project
endef

export ARDUBOY_HELP

$(call print_output,$(MAKECMDGOALS))

ECHO = printf

ifeq (sdl_win,$(MAKECMDGOALS))
    CXX = x86_64-w64-mingw32-g++
endif

SDL_LIBS = 
SDL_EXTRALIBS = -lSDL2_image

win32: CROSS_TOOLS_LOC := /usr/x86_64-w64-mingw32
win32: CXX := x86_64-mingw32-g++
win32: CXXFLAGS := -I$(CROSS_TOOLS_LOC)/lib

$(SDL_OBJECTS_WIN32): CROSS_TOOLS_LOC := /usr/x86_64-w64-mingw32
$(SDL_OBJECTS_WIN32): CXX := x86_64-w64-mingw32-g++
$(SDL_OBJECTS_WIN32): CXXFLAGS := -I$(CROSS_TOOLS_LOC)/include/SDL2

$(TARGET_BIN_SDL)_win32: LD := x86_64-w64-mingw32-g++
$(TARGET_BIN_SDL)_win32: LFLAGS := -static -static-libgcc
####
# Linux standard
####
#$(TARGET_BIN_SDL): $(SDL_OBJECTS)
#	$(LD) $@ $(LFLAGS) $(SDL_OBJECTS) `sdl-config --libs`

#$(SDL_OBJECTS): $(SDL_OBJDIR)/%.o : $(PROJECT_DIR)/src/%.cpp
#	$(CXX) $(CXXFLAGS) `sdl2-config --cflags` -c $< -o $@

####
# Windows attempt using mingw
###
$(TARGET_BIN_SDL): $(SDL_OBJECTS_WIN32)
	$(LD) $@ $(LFLAGS) $(SDL_OBJECTS_WIN) `sdl-config --libs`

$(SDL_OBJECTS_WIN32): $(SDL_OBJDIR)/win32/%.o : $(PROJECT_DIR)/src/%.cpp
	$(CXX) $(CXXFLAGS) `sdl2-config --cflags` -c $< -o $@

####
# Targets
####
sdl_win:
	echo "building SDL2..."
help:
	echo "$$ARDUBOY_HELP"

#rule1:
#	@echo  $@
#rule2:
#	@echo $@
#	date
#rule3:
#	@echo $@
#	$(MAKE) rule1

#$(SDL_OBJDIR):
#	@echo $@
#	$(MKDIR) $(SDL_OBJDIR) 

#.PHONEY: clean-arduboy test

#clean-arduboy:
#	@$(RM) $(SDL_OBJECTS)https://github.com/rogosher/ADBSDL/tree/develop

# Arduino Content
#include $(arduino_mk_path)/Arduino.mk
