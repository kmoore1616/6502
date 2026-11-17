CA65 ?= ca65
LD65 ?= ld65
PYTHON ?= python3

BUILD_DIR := build
BIOS_DIR := src/bios
ROM := $(BUILD_DIR)/6502.bin
OBJECT := $(BUILD_DIR)/6502.o
LABELS := $(BUILD_DIR)/6502.lbl
BIOS_SOURCES := \
	$(BIOS_DIR)/wozmon.s \
	$(BIOS_DIR)/cassette_read.s \
	$(BIOS_DIR)/math.s

.PHONY: all clean check kcs-example

all: $(ROM)

$(BUILD_DIR):
	mkdir -p $@

$(OBJECT): $(BIOS_SOURCES) | $(BUILD_DIR)
	cd $(BIOS_DIR) && $(CA65) wozmon.s -o ../../$@

$(ROM): $(OBJECT) $(BIOS_DIR)/config.cfg
	$(LD65) -C $(BIOS_DIR)/config.cfg $(OBJECT) -o $@ -Ln $(LABELS)

kcs-example: | $(BUILD_DIR)
	$(PYTHON) tools/kcs/kcs_encode.py examples/kcs/fibonacci.hex $(BUILD_DIR)/fibonacci.wav

check:
	$(PYTHON) -m py_compile tools/kcs/kcs_encode.py tools/kcs/kcs_decode.py

clean:
	rm -rf $(BUILD_DIR)
