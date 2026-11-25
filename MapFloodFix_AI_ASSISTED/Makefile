
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

all: FloodCore.bin C_Code.lyn.event FloodCore_FE6.bin C_Code_FE6.lyn.event FloodCore_FE7.bin C_Code_FE7.lyn.event

# FloodCore.c replaces vanilla MapFloodCore, which is copied to IWRAM along with MapFloodCoreStep.
# So it's ARM, linked at MapFloodCore's address, and has to fit before ARMCodeToCopy_End.
# MapFloodCore is at 0x874 in FE6 and FE8, 0x850 in FE7, and 0x1AC bytes in all three.
FLOOD_LIMIT  := 0x1AC
FLOOD_CFLAGS := -mcpu=arm7tdmi -marm -mthumb-interwork -Wall -mtune=arm7tdmi -O2 -fno-jump-tables

FloodCore.bin:     FLOOD_ORIGIN := 0x08000874
FloodCore.bin:     FLOOD_DEFS := Definitions.s
FloodCore_FE6.bin: FLOOD_ORIGIN := 0x08000874
FloodCore_FE6.bin: FLOOD_DEFS := FE6_defs.s
FloodCore_FE7.bin: FLOOD_ORIGIN := 0x08000850
FloodCore_FE7.bin: FLOOD_DEFS := FE7_defs.s

FloodCore.bin FloodCore_FE6.bin FloodCore_FE7.bin: FloodCore.c C_Code.h Definitions.s FE6_defs.s FE7_defs.s
	$(CC) $(FLOOD_CFLAGS) -c $< -I $(INCLUDE) -o $(basename $@).o
	$(AS) -mcpu=arm7tdmi -mthumb-interwork $(FLOOD_DEFS) -o $(basename $@)_defs.o
	$(PREFIX)ld -Ttext=$(FLOOD_ORIGIN) --no-warn-rwx-segments -e MapFloodCoreSafe $(basename $@).o $(basename $@)_defs.o -o $(basename $@).elf
	$(OBJCOPY) -O binary -j .text $(basename $@).elf $@
	rm $(basename $@).o $(basename $@).elf $(basename $@)_defs.o
	@size=$$(stat -c %s $@); if [ $$size -gt $$(($(FLOOD_LIMIT))) ]; then echo "$@ is $$size bytes, max $$(($(FLOOD_LIMIT)))"; rm $@; exit 1; fi

# C_Code.c is the same for every game, only the addresses it links against differ
C_Code_FE6.lyn.event C_Code_FE7.lyn.event: C_Code_%.lyn.event: C_Code.o %_defs.s
	$(AS) $(ARCH) $*_defs.s -o $*_defs.o
	$(LYN) C_Code.o $*_defs.o > "$@"
	rm $*_defs.o

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
