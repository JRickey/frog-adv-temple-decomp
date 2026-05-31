@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012e2c, 0x08012e64)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012e2c --end 0x8012e64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012e2c: 4909        ldr	r1, [pc, #36]	@ (0x12e54)
@   0x08012e2e: 2200        movs	r2, #0
@   0x08012e30: 2008        movs	r0, #8
@   0x08012e32: 7308        strb	r0, [r1, #12]
@   0x08012e34: 2004        movs	r0, #4
@   0x08012e36: 7008        strb	r0, [r1, #0]
@   0x08012e38: 4907        ldr	r1, [pc, #28]	@ (0x12e58)
@   0x08012e3a: 2010        movs	r0, #16
@   0x08012e3c: 7308        strb	r0, [r1, #12]
@   0x08012e3e: 2002        movs	r0, #2
@   0x08012e40: 7008        strb	r0, [r1, #0]
@   0x08012e42: 4806        ldr	r0, [pc, #24]	@ (0x12e5c)
@   0x08012e44: 3040        adds	r0, #64	@ 0x40
@   0x08012e46: 2101        movs	r1, #1
@   0x08012e48: 7803        ldrb	r3, [r0, #0]
@   0x08012e4a: 4319        orrs	r1, r3
@   0x08012e4c: 7001        strb	r1, [r0, #0]
@   0x08012e4e: 4804        ldr	r0, [pc, #16]	@ (0x12e60)
@   0x08012e50: 7282        strb	r2, [r0, #10]
@   0x08012e52: 4770        bx	lr
@   0x08012e54: 6410        str	r0, [r2, #64]	@ 0x40
@   0x08012e56: 0300        lsls	r0, r0, #12
@   0x08012e58: 6400        str	r0, [r0, #64]	@ 0x40
@   0x08012e5a: 0300        lsls	r0, r0, #12
@   0x08012e5c: 60a0        str	r0, [r4, #8]
@   0x08012e5e: 0300        lsls	r0, r0, #12
@   0x08012e60: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08012e62: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012E2C
sub_08012E2C: @ 0x08012e2c
        .incbin "frog_us_baserom.gba", 0x12e2c, 0x38
        thumb_func_end sub_08012E2C
