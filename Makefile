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

print_output = $(info $(1))
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

CXXFLAGS_STD     = -nostdin -std=gnu++11 -fno-threadsafe-statics
CXXFLAGS        += -nostdinc -pedantic -Wall -Wextra

CURRENT_DIR      = $(shell basename $(CURDIR))
OBJDIR           := $(PROJECT_DIR)/obj

SDL_OBJDIR       = $(PROJECT_DIR)/obj

SDL_SOURCE      := $(wildcard $(PROJECT_DIR)/src/*.cpp)
SDL_INCLUDE     := $(wildcard $(PROJECT_DIR)/src/*.h)

SDL_OBJECTS     := $(SDL_SOURCE:$(PROJECT_DIR)/src/%.cpp=$(SDL_OBJDIR)/%.o)

RM = rm -f
MKDIR = mkdir -p

########################################################################

define ARDUBOY_HELP
Available targets:
  make                   - compile the code
  make sdl               - compile SDL2 project
endef

export ARDUBOY_HELP

SDL_EXTRALIBS = -lSDL2_image
BINARIES = game game_win32

ARDUBOY_LIB  := $(HOME)/Arduboy/src
ARDUBOY_USER_LIB  := $(HOME)/Arduboy
#ARDUBOY_LIBS := $(PROJECT_DIR)/include $(ARDUBOY_LIB)

ARDUBOY_LIBS := $(addprefix -I, $(ARDUBOY_LIBS))

ARDUINO_LIBS = -I/var/tmp/Arduboy/arduino-nightly/hardware/arduino/avr/cores/arduino \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/arduino/avr/variants/leonardo \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/tools/avr/avr/include \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/arduino/avr/libraries/EEPROM/src \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/arduino/avr/libraries/SPI/src \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/tools/avr/lib/gcc/avr/4.9.2/include \
		-I/var/tmp/Arduboy/arduino-nightly/hardware/tools/avr/lib/gcc/avr/4.9.2/include-fixed

ARDUINO_FLAGS = -MMD -DUSB_VID=0x2341 -DUSB_PID=0x8039 -DF_CPU=16000000L -DARDUINO=night -DARDUINO_ARCH_AVR -D__AVR_ATmega32u4__ -D__PROG_TYPES_COMPAT__


CPPFLAGS += $(ARDUINO_FLAGS) $(ARDUINO_LIBS) -I$(ARDUBOY_LIB)

game_win32: CC := i686-w64-mingw32-gcc
game_win32: CXX := i686-w64-mingw32-g++
game_win32: LD := i686-w64-mingw32-g++
#game_win32: LDFLAGS := -static -static-libgcc
game_win32: CXXFLAGS += -Wl,-subsytem,windows
####
# Linux standard
####
#$(TARGET_BIN_SDL): $(SDL_OBJECTS)
#	$(LD) $@ $(LFLAGS) $(SDL_OBJECTS) `sdl-config --libs`

#$(SDL_OBJECTS): $(SDL_OBJDIR)/%.o : $(PROJECT_DIR)/src/%.cpp
#	$(CXX) $(CXXFLAGS) `sdl2-config --cflags` -c $< -o $@
ECHO = printf
RM = rm -f
RMDIR = rm -rf
LDFLAGS =

sdl_cflags := $(shell $(win32_usr_path)/sdl2-config --cflags)
sdl_libs := $(shell $(win32_usr_path)/sdl2-config --libs)

#$(call print_output, $(sdl_cflags))
#$(call print_output, $(sdl_libs))

override CXXFLAGS += $(sdl_cflags)
override LIBS += $(sdl_libs)

# recursive wildcard
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

get_library_includes = $(if $(and $(wildcard $(1)/src), $(wildcard $(1)/library.properties)), \
		       -I$(1)/src, \
		       $(addprefix -I,$(1) $(wildcard $(1)/utility)))

get_library_files = $(if $(and $(wildcard $(1)/src), $(wildcard $(1)/library.properties)), \
		   $(call rwildcard,$(1)/src/,*.$(2)), \
		   $(wildcard $(1)/*.$(2) $(1)/utility/*.$(2)))

LOCAL_CPP_SRCS ?= $(wildcard src/*.cpp)
LOCAL_INO_SRCS ?= $(wildcard src/*.ino)
LOCAL_SRCS = $(LOCAL_INO_SRCS) $(LOCAL_CPP_SRCS)
LOCAL_OBJ_FILES = $(LOCAL_INO_SRCS:.ino=.ino.o) $(LOCAL_CPP_SRCS:.cpp=.cpp.o)
LOCAL_OBJS = $(patsubst %,$(OBJDIR)/%,$(LOCAL_OBJ_FILES))

LIB_CPP_SOURCES := $(call get_library_files,$(ARDUBOY_USER_LIB),cpp)
LIB_C_SOURCES := $(call get_library_files,$(ARDUBOY_USER_LIB),c)

LIB_OBJS = $(patsubst $(ARDUBOY_LIB)/%.cpp,$(OBJDIR)/%.cpp.o,$(LIB_CPP_SOURCES)) \
	   $(patsubst $(ARDUBOY_LIB)/%.c,$(OBJDIR)/%.c.o,$(LIB_C_SOURCES))

#$(call print_output,$(ARDUBOY_USER_LIB))
#$(call print_output,$(LIB_CPP_SOURCES))
#$(call print_output,$(LIB_OBJS))

$(call print_output,$(LOCAL_OBJS))
$(call print_output,$(LIB_OBJS))

#CPPFLAGS  += -I/opt/Arduboy/include -I/$(HOME)/Arduboy/src

#CPPFLAGS += $(ARDUBOY_LIBS)


$(OBJDIR)/%.cpp.o: $(ARDUBOY_LIB)/%.cpp | $(OBJDIR)
	@$(MKDIR) $(dir $@)
	$(CXX) -x c++ $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.c.o: $(ARDUBOY_LIB)/%.c | $(OBJDIR)
	@$(MKDIR) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.cpp.o: %.cpp | $(OBJDIR)
	@$(MKDIR) $(dir $@)
	$(CXX) -x c++ $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.ino.o: %.ino | $(OBJDIR)
	@$(MKDIR) $(dir $@)
	$(CXX) -x c++ $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

# Targets

all: game_win32

game: $(SDL_OBJECTS)
	$(CXX) $(LIBS) $^ -o $@

game_win32: $(LOCAL_OBJS) $(LIB_OBJS)
	$(CXX) $(LOCAL_OBJS) $(LIB_OBJS) -o bin/$@.exe $(LIBS) 
help:
	echo "$$ARDUBOY_HELP"
clean:
	$(RMDIR) obj/*
	$(RM) obj/*.o
	$(RM) $(addprefix bin/, $(BINARIES))
	$(RM) $(addprefix bin/, $(addsuffix .exe, $(BINARIES)))

.PHONEY: all help clean game game_win32
