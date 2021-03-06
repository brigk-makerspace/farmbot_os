ALL :=
CLEAN :=

ifeq ($(ERL_EI_INCLUDE_DIR),)

$(warning ERL_EI_INCLUDE_DIR not set. Invoke via mix)

else

ALL += fbos_build_calendar_nif
CLEAN += fbos_clean_build_calendar_nif
endif

ifeq ($(ARDUINO_BUILD),)

$(warning ARDUINO_BUILD is not set. No arduino assets will be built.)

else

ALL += fbos_arduino_firmware
CLEAN += fbos_clean_arduino_firmware

endif

.PHONY: $(ALL) $(CLEAN) all clean

all: $(ALL)

clean: $(CLEAN)

fbos_arduino_firmware:
	cd c_src/farmbot-arduino-firmware && make all BUILD_DIR=$(PWD)/_build FBARDUINO_FIRMWARE_SRC_DIR=$(PWD)/c_src/farmbot-arduino-firmware/src BIN_DIR=$(PWD)/priv

fbos_clean_arduino_firmware:
	cd c_src/farmbot-arduino-firmware && make clean BUILD_DIR=$(PWD)/_build FBARDUINO_FIRMWARE_SRC_DIR=$(PWD)/c_src/farmbot-arduino-firmware/src BIN_DIR=$(PWD)/priv

fbos_build_calendar_nif:
	make -f c_src/build_calendar/Makefile all ERL_EI_INCLUDE_DIR=$(ERL_EI_INCLUDE_DIR) ERL_EI_LIBDIR=$(ERL_EI_LIBDIR)

fbos_clean_build_calendar_nif:
	make -f c_src/build_calendar/Makefile clean ERL_EI_INCLUDE_DIR=$(ERL_EI_INCLUDE_DIR) ERL_EI_LIBDIR=$(ERL_EI_LIBDIR)
