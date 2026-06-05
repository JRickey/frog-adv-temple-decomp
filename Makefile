# Adapted from the Metroid Fusion decompilation
# (https://github.com/metroidret/mf). MIT, Copyright (c) 2025 YohannDR.
# See LICENSE for full attribution.

# Disable built-in rules
.SUFFIXES:

REGION ?= us
# Frogger's Adventures: Temple of the Frog is a 4MB ROM. PAD_TO is the end
# address the binary should be padded out to (ROM_BASE + ROM size).
PAD_TO = 0x08400000

ifeq ($(REGION),us)
	TARGET = frog_us
	GAME_TITLE = FROG: TEMPLE
	GAME_CODE = AFRE
	MAKER_CODE = A4
	CPPFLAGS += -DREGION_US
	ASFLAGS += --defsym REGION_US=1
endif

ifeq ($(DEBUG),1)
	CPPFLAGS += -DDEBUG
	ASFLAGS += --defsym DEBUG=1
	TARGET := $(TARGET)_debug
endif

BASEROM := $(TARGET)_baserom.gba
TARGET := $(TARGET).gba

# Default target
.PHONY: all
all: $(TARGET)

ELF = $(TARGET:.gba=.elf)
MAP = $(TARGET:.gba=.map)
SHA1FILE = $(TARGET:.gba=.sha1)
DUMPS = $(BASEROM:.gba=.dump) $(TARGET:.gba=.dump)
LD_SCRIPT = linker.ld.pp

# ROM header
GAME_REVISION = 00

# Binaries
CPP = cpp
LDSCRIPT_CPP = $(CPP)
# macOS: Apple's `cpp` keeps `//` comments which agbcc (gcc 2.x) can't parse,
# and it silently drops -o on .ld files. Use Homebrew GNU `cpp-15` for the
# C-source pipeline and `cc -E -P -x c` for the linker-script step.
ifeq ($(shell uname -s),Darwin)
    CPP = cpp-15 -P
    LDSCRIPT_CPP = cc -E -P -x c
endif
TOOLCHAIN ?= arm-none-eabi-
AS = $(TOOLCHAIN)as
LD = $(TOOLCHAIN)ld
OBJCOPY = $(TOOLCHAIN)objcopy
OBJDUMP = $(TOOLCHAIN)objdump

CC = agbcc

DIFF = diff -u
HOSTCC = cc
MKDIR = mkdir -p
RM = rm -f
SHA1SUM = sha1sum
TAIL = tail

# Tools
include make_tools.mk
GBAFIX = $(TOOLS_DIR)/gbafix/gbafix
PYTHON = python3
EXTRACTOR = $(PYTHON) $(TOOLS_DIR)/extractor.py
PREPROC = $(TOOLS_DIR)/preproc/preproc

# Flags
ASFLAGS += -mcpu=arm7tdmi
CFLAGS = -Werror -O2 -mthumb-interwork -fhex-asm
CPPFLAGS += -nostdinc -Iinclude/
PREPROCFLAGS = charmap.txt

# Objects
CSRC = $(wildcard src/**.c) $(wildcard src/**/**.c) $(wildcard src/**/**/**.c) $(wildcard src/**/**/**/**.c)
.PRECIOUS: $(CSRC:.c=.s)
ASMSRC = $(CSRC:.c=.s) $(wildcard asm/*.s) $(wildcard asm/**/*.s) $(wildcard sound/*.s) $(wildcard sound/**/*.s)
OBJ = $(ASMSRC:.s=.o)

# Detect if agbcc was installed into the project
ifneq (,$(wildcard tools/agbcc))
	AGBCC_BIN := tools/agbcc/bin/agbcc
	OLD_AGBCC_BIN := tools/agbcc/bin/old_agbcc
	AGBCC_LIB := tools/agbcc/lib
	CC = $(OLD_AGBCC_BIN)
else
	AGBCC_BIN := $(shell which agbcc)
	OLD_AGBCC_BIN := $(shell which old_agbcc)
	AGBCC_DIR := $(dir $(AGBCC_BIN))/
	AGBCC_LIB := $(abspath $(AGBCC_DIR))
endif

LIBS := $(AGBCC_LIB)/libgcc.a $(AGBCC_LIB)/libc.a

# Most decompiled units match the baserom with pret's older gcc-2.x snapshot.
# Keep the newer agbcc only for the units where the old snapshot diverges.
src/game/sub_08002ae8.s: CC = $(AGBCC_BIN)
src/engine/sub_0800f24c.s: CC = $(AGBCC_BIN)
src/engine/sub_08012d40.s: CC = $(AGBCC_BIN)
src/engine/sub_08013040.s: CC = $(AGBCC_BIN)
src/engine/sub_0800d808.s: CC = $(OLD_AGBCC_BIN)
# sub_0800E4BC is a nested-switch link handshake; -fforce-addr keeps the
# 0x03005370 base in a register before the 15-mask constant (the baserom's
# operand order for `mask & ctrl[N]`), and -fno-expensive-optimizations keeps
# the per-test mask copy (`adds r0, maskreg, #0`) instead of a folded in-place
# `ands`. Together they match the baserom's coloring of both inner switches.
src/engine/sub_0800e4bc.s: CFLAGS += -fforce-addr -fno-expensive-optimizations
# Keep the inner tilemap loop indexing `col*2 + row_ptr` per iteration
# (baserom does not reduce it to a pointer increment), which raises the
# register pressure that drives base/oldPal/newPal into sl/r9/r8.
src/engine/sub_080184dc.s: CFLAGS += -fno-strength-reduce
# Matches the state-byte dispatcher prologue in the baserom.
src/game/sub_08001214.s: CFLAGS += -fforce-addr -fno-expensive-optimizations
src/game/sub_080019b4.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/game/sub_08002184.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/game/sub_08002524.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/game/mode_15.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/game/sub_08004938.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/game/sub_08009d9c.s: CFLAGS += -fno-gcse
src/game/sub_0802bc24.s: CFLAGS += -fno-gcse
src/engine/sub_08012f00.s: CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse
src/engine/sub_0801621c.s: CFLAGS += -fno-expensive-optimizations
src/game/sub_08002b58.s: CFLAGS += -fforce-addr -fno-expensive-optimizations
src/system/sub_08001508.s: CFLAGS += -fforce-addr -fno-expensive-optimizations
src/game/sub_08003254.s: CFLAGS += -ffixed-r3
# sub_0800A580's dense motion-descriptor switch: free the callee-saved low regs
# so agbcc keeps the two delta bytes in their incoming r2/r3 and emits the
# baserom's frameless prologue (record pointer cached in ip, no push/pop).
src/game/sub_0800a520.s: CFLAGS += -ffixed-r4 -ffixed-r5 -ffixed-r6 -ffixed-r7
src/game/sub_08006a0c.s: CFLAGS += -O1
# Loop reverses to a `bge.n` countdown under strength reduction; the baserom
# keeps a signed count-up (`ble.n`). Disabling strength reduction restores it.
src/game/sub_08003b8c.s: CFLAGS += -fno-strength-reduce
# Keeps the loop-invariant gIwram_6110 base in r7 across the loop instead of
# GCSE-reloading it from the constant pool each iteration (matches baserom).
src/engine/sub_08015930.s: CFLAGS += -fno-gcse
# Keeps the scroll-object address arithmetic in the baserom's non-hoisted form.
src/engine/sub_0800f24c.s: CFLAGS += -fno-strength-reduce
src/engine/sub_0800f2f8.s: CFLAGS += -fno-strength-reduce
# -O1 prevents agbcc from hoisting loop-body updates ahead of the OAM inner loop.
src/engine/sub_0801b9e4.s: CFLAGS += -O1
src/engine/sub_0801a6d4.s: CC = $(AGBCC_BIN)
src/engine/sub_0801a6d4.s: CFLAGS += -fno-strength-reduce
# Keeps the duplicated window step value in the baserom's r6/sl allocation.
src/engine/sub_0801a894.s: CFLAGS += -fno-rerun-cse-after-loop
src/engine/sub_0801c078.s: CFLAGS += -fno-caller-saves
src/engine/sub_08022360.s: CFLAGS += -fno-gcse
# Current forced-C lanes for split sound NON_MATCHING candidates.
src/system/sound_pitch.s: CC = $(OLD_AGBCC_BIN)
src/system/sound_pitch.s: CFLAGS += -fforce-addr -fno-gcse -fno-expensive-optimizations
src/system/sound_channel_envelope_a.s: CC = $(OLD_AGBCC_BIN)
src/system/sound_channel_stream.s: CC = $(OLD_AGBCC_BIN)
src/system/sound_channel_stream.s: CFLAGS += -fforce-addr -fno-gcse -fno-cse-follow-jumps
src/system/sound_envelope_dual.s: CFLAGS += -fforce-addr -fno-gcse -fno-expensive-optimizations
src/system/sound_envelope_slide.s: CC = $(AGBCC_BIN)
src/system/sound_envelope_slide.s: CFLAGS += -fforce-addr -fno-gcse
src/system/sound_channel_state.s: CC = $(OLD_AGBCC_BIN)
src/system/sound_mixer.s: CFLAGS += -fforce-addr -fno-gcse
src/system/sound_mixer_tail.s: CC = $(OLD_AGBCC_BIN)
src/system/sound_mixer_tail.s: CFLAGS += -fforce-addr -fno-gcse -fno-cse-follow-jumps
# __fixunssfsi uses `pop {r4, pc}` (non-interwork form); override interwork flag.
src/game/sub_08033da8.s: CFLAGS += -mno-thumb-interwork
# sub_08034760 uses `pop {r4, pc}` epilogue
src/game/sub_08034760.s: CFLAGS += -mno-thumb-interwork
# sub_08034898 uses `pop {pc}` epilogue
src/game/sub_08034898.s: CFLAGS += -mno-thumb-interwork
# sub_080340D4 uses `pop {r4, pc}` epilogue
src/game/sub_080340d4.s: CFLAGS += -mno-thumb-interwork
# sub_0803401C (float-reassembly companion to sub_080340D4) uses `pop {r4-r6, pc}`
src/game/sub_0803401c.s: CFLAGS += -mno-thumb-interwork
# sub_08034924 uses `pop {pc}` epilogue
src/game/sub_08034924.s: CFLAGS += -mno-thumb-interwork
# sub_0803493C uses `pop {r4, r5, r6, pc}` epilogue
src/game/sub_0803493c.s: CFLAGS += -mno-thumb-interwork
# sub_0803457C uses `pop {r4, pc}` epilogue
src/game/sub_0803457c.s: CFLAGS += -mno-thumb-interwork




# Enable verbose output
ifeq ($(V),1)
	Q =
	MSG = @:
else
	Q = @
	MSG = @echo " "
endif

# Rules that do not require scanning for dependencies
RULES_NO_SCAN += dump diff extract clean tidy

# Generate tools before building anything
SETUP_PREREQS ?= 1
ifneq (,$(MAKECMDGOALS))
  ifeq (,$(filter-out $(RULES_NO_SCAN),$(MAKECMDGOALS)))
    SETUP_PREREQS := 0
  endif
endif
.SHELLSTATUS ?= 0
ifeq ($(SETUP_PREREQS),1)
  $(foreach line, $(shell $(MAKE) -f make_tools.mk | sed "s/ /__SPACE__/g"), $(info $(subst __SPACE__, ,$(line))))
  ifneq ($(.SHELLSTATUS),0)
    $(error Errors occurred while building tools. See error messages above for more details)
  endif
endif

.PHONY: check
check: all
	$(MSG) SHA1SUM $(SHA1FILE)
	$Q$(SHA1SUM) -c $(SHA1FILE)

.PHONY: dump
dump: $(DUMPS)

.PHONY: diff
diff: $(DUMPS)
	$(MSG) DIFF $^
	$Q$(DIFF) $^

.PHONY: extract
extract:
	$(MSG) Extracting
	$Q$(EXTRACTOR) -r $(REGION)

.PHONY: clean
clean: clean-tools tidy

.PHONY: tidy
tidy:
	$(MSG) RM roms
	$Qfind . -type f -name "*.gba" -a ! -name "*baserom.gba" -delete
	$(MSG) RM elf
	$Q$(RM) *.elf
	$(MSG) RM map
	$Q$(RM) *.map

	$(MSG) RM \*.dump
	$Q$(RM) $(DUMPS)
	$(MSG) RM \*.o
	$Q$(RM) $(OBJ)
	$(MSG) RM data/*.s
	$(MSG) RM src/\*\*/\*.s
	$Q$(RM) $(CSRC:.c=.s)
	$(MSG) RM $(GBAFIX)
	$Q$(RM) $(GBAFIX)
ifeq ($(DATA),1)
	$(MSG) RM data/
	$Q$(RM) -r data
	$(MSG) RM sound/direct_sound_samples
	$Q$(RM) -r sound/direct_sound_samples
endif
	$(MSG) RM linker.ld.pp
	$Q$(RM) linker.ld.pp

.PHONY: help
help:
	@echo 'Targets:'
	@echo '  all: build the ROM'
	@echo '  check: checksum the ROM'
	@echo '  dump: dump the ROMs'
	@echo '  diff: compare the ROM with the original'
	@echo '  clean: remove the ROM and intermediate files'
	@echo '  	DATA=1: removes the data folder generated by the extractor'
	@echo '  help: show this message'
	@echo ''
	@echo 'Flags:'
	@echo '  V=1: enable verbose output'
	@echo '  REGION=<region>: selects the region of the ROM (currently only "us")'
	@echo '  DEBUG=1: enables the debug code'

$(TARGET): $(ELF)
	$(MSG) OBJCOPY $@
	$Q$(OBJCOPY) -O binary --gap-fill 0xff --pad-to $(PAD_TO) $< $@
	$(MSG) GBAFIX $@
	$Q$(GBAFIX) $@ -t"$(GAME_TITLE)" -c$(GAME_CODE) -m$(MAKER_CODE) -r$(GAME_REVISION)

$(ELF) $(MAP): $(OBJ) $(LD_SCRIPT)
	$(MSG) LD $@
	$Q$(LD) $(LDFLAGS) -n -T $(LD_SCRIPT) -Map=$(MAP) $(LIBS) -o $@

$(LD_SCRIPT): linker.ld
	$(MSG) CPP $@
	$Q$(LDSCRIPT_CPP) $(CPPFLAGS) $< -o $@

%.dump: %.gba
	$(MSG) OBJDUMP $@
	$Q$(OBJDUMP) -D -bbinary -marm7tdmi -Mforce-thumb  $< | $(TAIL) -n+3 >$@

%.o: %.s
	$(MSG) AS $@
	$Q$(AS) $(ASFLAGS) $< -o $@

%.s: %.c
	$(MSG) CC $@
	$Q$(PREPROC) $< $(PREPROCFLAGS) | $(CPP) $(CPPFLAGS) | $(CC) -o $@ $(CFLAGS) && printf '\t.align 2, 0 @ dont insert nops\n' >> $@

.PHONY: us
us:
	$(MAKE) REGION=us
# Matches the baserom epilogue (pop {r4,r5,pc} instead of bx r1);
# the TU was compiled without -mthumb-interwork.
src/game/sub_0803578c.s: CFLAGS = -Werror -O2 -fhex-asm

# sub_080342CC is __addsf3 from libgcc fp-bit.c, compiled without -mthumb-interwork.
# The epilogue is pop {r4, pc} instead of pop {r4}; pop {r1}; bx r1.
src/game/sub_080342cc.s: CFLAGS = -Werror -O2 -fhex-asm

# IntrMain is an ARM-mode function; agbcc always marks NAKED functions as
# .thumb_func, which would make the linker resolve IntrMain references to
# 0x0800012D (Thumb bit set) instead of 0x0800012C. Strip the .thumb_func
# directive from the generated .s before assembling so IntrMain lands with
# a clean even address in the ELF symbol table.
src/system/intr_main.o: src/system/intr_main.s
	$(MSG) AS $@
	$Q sed 's/^	\.thumb_func$$/	.arm/' $< | $(AS) $(ASFLAGS) - -o $@
