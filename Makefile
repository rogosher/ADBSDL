# Makefile
# Author: Ross
# This Makefile is intended to build source for the Arduboy
TARGET         = test_game
PROJECT_DIR    = G:/share/projects/arduboy/adbsdl

ARDMK_DIR      = $(PROJECT_DIR)/tmp/Arduino-Makefile

### ARDUINO_DIR
### Uncomment the directory that holds your Arduino IDE
#ARDUINO_DIR    = /Applications/Arduino.app/Contents/Java
#ARDUINO_DIR    = /usr/share/Arduino
ARDUINO_DIR    = $(PROJECT_DIR)/lib/Arduino
ARDUINO_SKETCHBOOK = $(PROJECT_DIR)/sketchbook

AVR_LD_PATH = $(ARDUINO_DIR)/hardware/tools/avr/avr/bin
#PATH := $(sed 's/\//\\/g' <<< $(AVR_LD_PATH));$(PATH)

#ARDUINO_LIBS = 
#USER_LIB_PATH := $(PROJECT_DIR)/lib/

BOARD_TAG      = leonardo

### MONITOR_BAUDRATE
### Set to the serial baudrate for leonardo
MONITOR_BAUDRATE = 1115200

### MONITOR_PORT
### The port your Arduboy is connected to. Using an '*' tries all the ports to
### find the correct a board.
MONITOR_PORT     = COM3

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
#	@$(RM) $(SDL_OBJECTS)

include $(ARDMK_DIR)/Arduino.mk
