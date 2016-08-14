# Makefile
# Author: Ross
# This Makefile is intended to build source for the Arduboy

# use local directory
#arduino_mk_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

# use debian installation path, used for included vagrant
arduino_mk_path := /usr/share/arduino
current_dir := $(shell pwd)

TARGET         = test_game

PROJECT_DIR    = $(current_dir)

CFLAGS_STD       = -std=gnu11
CXXFLAGS_STD     = -std=gnu++11 -fno-threadsafe-statics

CXXFLAGS        += -pedantic -Wall -Wextra

#CXX              = g++
#LD               = g++ -o
#LFAGS            = -mconsole

CURRENT_DIR      = $(shell basename $(CURDIR))
OBJDIR           = $(PROJECT_DIR)/bin/Arduboy/$(CURRENT_DIR)

SDL_OBJDIR       = $(PROJECT_DIR)/obj

SDL_TARGET       = game
SDL_SOURCE      := $(wildcard $(PROJECT_DIR)/src/*.cpp)
SDL_INCLUDE     := $(wildcard $(PROJECT_DIR)/src/*.h)
SDL_OBJECTS     := $(SDL_SOURCE:$(PROJECT_DIR)/src/%.cpp=$(SDL_OBJDIR)/%.o)

TARGET_BIN_SDL = $(PROJECT_DIR)/bin/$(SDL_TARGET)

RM = rm -f
MKDIR = mkdir -p

arduboy_output = $(info $(1))

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

$(call arduboy_output,$(CURRENT_OS))

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

include $(arduino_mk_path)/Arduino.mk
