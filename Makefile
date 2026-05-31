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
	CC = $(AGBCC_BIN)
else
	AGBCC_BIN := $(shell which agbcc)
	OLD_AGBCC_BIN := $(shell which old_agbcc)
	AGBCC_DIR := $(dir $(AGBCC_BIN))/
	AGBCC_LIB := $(abspath $(AGBCC_DIR))
endif

LIBS := $(AGBCC_LIB)/libgcc.a $(AGBCC_LIB)/libc.a

# Per-file compiler overrides. Some translation units in the baserom were
# built with the older gcc-2.x snapshot bundled by pret as `old_agbcc` —
# notably, it avoids the redundant `push {lr}; pop {r1}; bx r1` epilogue
# that the newer `agbcc` emits for any function with a control-flow join.
# When you discover that a function only matches under old_agbcc, add the
# source file here. See docs/codegen-notes.md.
src/game/sub_08033910.s: CC = $(OLD_AGBCC_BIN)
src/system/init.s: CC = $(OLD_AGBCC_BIN)
src/system/init1.s: CC = $(OLD_AGBCC_BIN)
src/system/vblank.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800a710.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800a83c.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800b7b0.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800cd88.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800cb80.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08006600.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_080066c4.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08006948.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_0800586c.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08006b88.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_0800679c.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_0800336c.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_080018f8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800cdcc.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800ce10.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800ce54.s: CC = $(OLD_AGBCC_BIN)
src/system/sub_08032894.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08032b18.s: CC = $(OLD_AGBCC_BIN)
src/system/sub_0802e7c4.s: CC = $(OLD_AGBCC_BIN)
src/system/sub_0802e13c.s: CC = $(OLD_AGBCC_BIN)
src/system/sub_0802e100.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08005ed8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_080106b8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800e600.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800fcc8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800ee94.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800ee34.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800e060.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800dd80.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800de80.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800df7c.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_08009884.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08007874.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_080077ac.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08007dd0.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08009984.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_080031d4.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08003254.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_08003254.s: CFLAGS += -ffixed-r3
# Loop reverses to a `bge.n` countdown under strength reduction; the baserom
# keeps a signed count-up (`ble.n`). Disabling strength reduction restores it.
src/game/sub_08003b8c.s: CFLAGS += -fno-strength-reduce
# Keeps the scroll-object address arithmetic in the baserom's non-hoisted form.
src/engine/sub_0800f24c.s: CFLAGS += -fno-strength-reduce
src/engine/sub_0800f2f8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800f2f8.s: CFLAGS += -fno-strength-reduce
# Keeps the duplicated window step value in the baserom's r6/sl allocation.
src/engine/sub_0801a894.s: CFLAGS += -fno-rerun-cse-after-loop
src/game/sub_0800088c.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0800dffc.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_0803299c.s: CC = $(OLD_AGBCC_BIN)
src/game/sub_0802d8f8.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_080217d4.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0801129c.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_0801d4cc.s: CC = $(OLD_AGBCC_BIN)
src/engine/sub_08020f3c.s: CC = $(OLD_AGBCC_BIN)


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
