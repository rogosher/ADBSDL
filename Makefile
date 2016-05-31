TARGET	= game

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib
INC_DIR = -I./include/Arduboy/src -I./tmp/avr-libc-2.0.0/include -I./include -I./include/Arduino/hardware/arduino/avr/cores/arduino

CC	= g++
CFLAGS	= -Wall -I. $(INC_DIR)

LD	= g++ -o
LFLAGS	= -Wall -I. -lSDL2 -I$(INC_DIR)

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
INCLUDES := $(wildcard $(SRC_DIR)/*.h)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
rm	= rm -f

$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@$(LD) $@ $(LFLAGS) $(OBJECTS) `sdl2-config --libs`

#$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
#	@$(CC) $(CFLAGS) -v -c $< -o $@

$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	@$(CC) $(CFLAGS) `sdl2-config --cflags` -c $< -o $@

.PHONEY: clean
clean:
	@$(rm) $(OBJECTS)
