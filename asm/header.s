@ ============================================================================
@ GBA cartridge header (0x080000000 - 0x080000BF, 192 bytes).
@ ============================================================================
@
@ Contents:
@   0x00   entry branch         (ARM `b 0x080000C0` to crt0)
@   0x04   Nintendo logo        (156 bytes, fixed; BIOS checks it)
@   0xA0   game title           ("FROG: TEMPLE", 12 bytes, NUL-padded)
@   0xAC   game code            ("AFRE", 4 bytes)
@   0xB0   maker code           ("A4" = Konami, 2 bytes)
@   0xB2   fixed value          (0x96)
@   0xB3   main unit code       (0x00)
@   0xB4   device type          (0x00)
@   0xB5-0xBB  reserved         (7 bytes, 0x00)
@   0xBC   software version     (0x00)
@   0xBD   header complement    (computed; gbafix recomputes)
@   0xBE-0xBF  reserved         (2 bytes, 0x00)
@
@ The title/code/maker/version/complement bytes get overwritten by gbafix
@ at the end of the build using the values from the Makefile; including
@ them here as raw bytes is fine because they match what gbafix will
@ produce.

@ Note: bytes 0x00..0x04 (the entry branch) have been peeled off into
@ asm/disasm_0x08000000.s. This file now covers 0x04..0xC0 — the Nintendo
@ logo plus the cartridge metadata block.

        .section .text, "ax", %progbits
        .arm
        .align  2
        .global gba_header
        .type   gba_header, %object
gba_header:
        .incbin "frog_us_baserom.gba", 0x4, 0xBC
        .size   gba_header, . - gba_header
