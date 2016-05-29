TARGET	= game

CC	= g++
CFLAGS	= -Wall -I.

LD	= g++ -o
LFLAGS	= -Wall -I. -lSDL2

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

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
