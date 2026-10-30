
.SUFFIXES:
.PHONY:

# Making sure devkitARM exists and is set up.
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# Including devkitARM tool definitions
include $(DEVKITARM)/base_tools
# defining path of lyn
LYN := "C:/devkitPro/lyn.exe"
INCLUDE := C:/devkitPro/FE-Clib_2025/Include

all: FloodCore.bin C_Code.lyn.event

# FloodCore.c replaces vanilla MapFloodCore, which is copied to IWRAM along with MapFloodCoreStep.
# So it's ARM, linked at MapFloodCore's address, and has to fit before ARMCodeToCopy_End.
FLOOD_ORIGIN := 0x08000874
FLOOD_LIMIT  := 0x1AC
FLOOD_CFLAGS := -mcpu=arm7tdmi -marm -mthumb-interwork -Wall -mtune=arm7tdmi -O2 -fno-jump-tables

FloodCore.bin: FloodCore.c C_Code.h Definitions.s
	$(CC) $(FLOOD_CFLAGS) -c $< -I $(INCLUDE) -o FloodCore.o
	$(AS) -mcpu=arm7tdmi -mthumb-interwork Definitions.s -o Definitions.o
	$(PREFIX)ld -Ttext=$(FLOOD_ORIGIN) --no-warn-rwx-segments -e MapFloodCoreSafe FloodCore.o Definitions.o -o FloodCore.elf
	$(OBJCOPY) -O binary -j .text FloodCore.elf $@
	rm FloodCore.o FloodCore.elf Definitions.o
	@size=$$(stat -c %s $@); if [ $$size -gt $$(($(FLOOD_LIMIT))) ]; then echo "$@ is $$size bytes, max $$(($(FLOOD_LIMIT)))"; rm $@; exit 1; fi

# setting up compilation flags
ARCH   := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS := $(ARCH) -Wall -mtune=arm7tdmi -O2 -mlong-calls

# C to ASM rule
C_Code.s: C_Code.c C_Code.h
	$(CC) $(CFLAGS) -S $< -I $(INCLUDE) -o $@ -fverbose-asm -mlong-calls

# OBJ to EVENT rule
%.lyn.event: %.o
	$(MAKE) $(dir $<)Definitions.o
	$(LYN) "$<" "$(dir $<)Definitions.o" > "$@"
	rm $(dir $<)Definitions.o

# ASM to OBJ
%.o: %.s *.s
	$(AS) $(ARCH) $< -o $@
