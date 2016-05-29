TARGET	= game

CC	= g++
CFLAGS	= -Wall -I.

LD	= g++ -o
LFLAGS	= -Wall -I. -lSDL2

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
INCLUDES := $(wildcard $(SRC_DIR)/*.h)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
rm	= rm -f

$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@$(LD) $@ $(LFLAGS) $(OBJECTS)

$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	@$(CC) $(CFLAGS) -c $< -o $@

.PHONEY: clean
clean:
	@$(rm) $(OBJECTS)
