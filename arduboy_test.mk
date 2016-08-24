include Common.mk

ARDUBOY := $(HOME)/Arduboy

AVR := /usr/lib/avr/include

ARDUINO = /var/tmp/Arduboy/arduino-nightly

ARDUINO_LIBS := $(ARDUINO)/hardware/arduino/avr/libraries

AVR_DEFINES = -DF_CPU=16000000L -D__AVR_ATmega32U4__ -D__PROG_TYPES_COMPAT__

get_library_files = $(if $(and $(wildcard $(1)/src), $(wildcard $(1)/library.properties)), \
		    $(call rwildcard,$(1)/src/,*.$(2)), \
		    $(wildcard $(1)/*.$(2) $(1)/utility/*.$(2)))

ARDUBOY_SOURCE  = $(call get_library_files,$(ARDUBOY),cpp)
ARDUBOY_SOURCE += $(call get_library_files,$(ARDUBOY),c)

ARDUINO_INCLUDE := $(ARDUINO)/hardware/arduino/avr/cores/arduino \
		   $(ARDUINO)/hardware/arduino/avr/variants/leonardo

ARDUINO_INCLUDE := $(addprefix -I, $(ARDUINO_INCLUDE))

$(call print_output,$(ARDUBOY_SOURCE))

CXXFLAGS += -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections \
	    -fdata-sections -fno-threadsafe-statics

OBJDIR = obj

MKDIR = mkdir -p

$(OBJDIR)/Arduboy.o: $(ARDUBOY_SOURCE)
	@echo $@
	@rm -rf obj/*
	@$(MKDIR) $(dir $@)
	$(CXX) $(CXXFLAGS) $(AVR_DEFINES) -Iinclude -I$(AVR) $(ARDUINO_INCLUDE) -I$(ARDUINO_LIBS)/SPI/src -I$(ARDUINO_LIBS)/EEPROM/src -c $< -o $@

clean:
	rm -rf obj/*.o

.PHONEY: clean
