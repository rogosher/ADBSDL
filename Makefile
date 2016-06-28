CXX	= g++

TARGET	= game

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

CFLAGS_STD = -std=gnu11

CXXFLAGS_STD = -std=gnu++11
CXXFLAGS += -pedantic -Wall -Wextra

LD	= g++ -o
LFLAGS	= -mconsole

# Definitions need for the Arduino platform
BOARD_TAG = leonardo
ARDUINO_LIBS = EEPROM SPI

MONITOR_PORT = COM3

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
INCLUDES := $(wildcard $(SRC_DIR)/*.h)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
rm	= rm -f

$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@$(LD) $@ $(LFLAGS) $(OBJECTS) `sdl2-config --libs`

$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	@$(CC) $(CFLAGS) `sdl2-config --cflags` -c $< -o $@

.PHONEY: clean
clean:
	@$(rm) $(OBJECTS)
