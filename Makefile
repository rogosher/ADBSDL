# Makefile
# Author: Ross
# This Makefile is intended to build source for the Arduboy

# use local directory for arduino-makefile
#arduino_mk_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

# use debian installation path, used for included vagrant
arduino_mk_path := /usr/share/arduino
win32_usr_path  := /usr/i686-w64-mingw32/bin
current_dir     := $(shell pwd)

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

PROJECT_DIR = $(current_dir)

CFLAGS_STD       = -std=gnu11

# other library flags to consider
# static-libgcc
# static-libstdc++

CXXFLAGS_STD     = -std=gnu++11 -fno-threadsafe-statics
CXXFLAGS        += -pedantic -Wall -Wextra

CURRENT_DIR      = $(shell basename $(CURDIR))
OBJDIR           = $(PROJECT_DIR)/bin/Arduboy/$(CURRENT_DIR)

SDL_OBJDIR       = $(PROJECT_DIR)/obj

SDL_SOURCE      := $(wildcard $(PROJECT_DIR)/src/*.cpp)
SDL_INCLUDE     := $(wildcard $(PROJECT_DIR)/src/*.h)

SDL_OBJECTS     := $(SDL_SOURCE:$(PROJECT_DIR)/src/%.cpp=$(SDL_OBJDIR)/%.o)

RM = rm -f
MKDIR = mkdir -p

print_output = $(info $(1))

########################################################################

define ARDUBOY_HELP
Available targets:
  make                   - compile the code
  make sdl               - compile SDL2 project
endef

export ARDUBOY_HELP

$(call print_output,$(CURRENT_OS))
$(call print_output,$(MAKECMDGOALS))

SDL_EXTRALIBS = -lSDL2_image
BINARIES = game game_win32

game_win32: CC := i686-w64-mingw32-gcc
game_win32: CXX := i686-w64-mingw32-g++
game_win32: LD := i686-w64-mingw32-g++
#game_win32: LDFLAGS := -static -static-libgcc
game_win32: CXXFLAGS += -Wl,-subsytem,windows -I/usr/i686-w64-mingw32/include
####
# Linux standard
####
#$(TARGET_BIN_SDL): $(SDL_OBJECTS)
#	$(LD) $@ $(LFLAGS) $(SDL_OBJECTS) `sdl-config --libs`

#$(SDL_OBJECTS): $(SDL_OBJDIR)/%.o : $(PROJECT_DIR)/src/%.cpp
#	$(CXX) $(CXXFLAGS) `sdl2-config --cflags` -c $< -o $@
ECHO = printf
RM = rm -f

LDFLAGS =

sdl_cflags := $(shell $(win32_usr_path)/sdl2-config --cflags)
sdl_libs := $(shell $(win32_usr_path)/sdl2-config --libs)

#$(call print_output, $(sdl_cflags))
#$(call print_output, $(sdl_libs))

override CXXFLAGS += $(sdl_cflags)
override LIBS += $(sdl_libs)

####
# Targets
####

all: game_win32

game: $(SDL_OBJECTS)
	$(CXX) $(LIBS) $^ -o $@

game_win32: $(SDL_OBJECTS)
	$(CXX) $^ -o bin/$@.exe $(LIBS) 

$(SDL_OBJECTS): $(SDL_OBJDIR)/%.o : $(PROJECT_DIR)/src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
help:
	echo "$$ARDUBOY_HELP"
clean:
	$(RM) obj/*.o
	$(RM) $(addprefix bin/, $(BINARIES))
	$(RM) $(addprefix bin/, $(addsuffix .exe, $(BINARIES)))

.PHONEY: all help clean game game_win32

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
