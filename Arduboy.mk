# Arduboy.mk

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
