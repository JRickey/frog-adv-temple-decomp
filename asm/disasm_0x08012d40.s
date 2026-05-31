@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012d40, 0x08012d88)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012d40 --end 0x8012d88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012d40: b500        push	{lr}
@   0x08012d42: 490d        ldr	r1, [pc, #52]	@ (0x12d78)
@   0x08012d44: 2300        movs	r3, #0
@   0x08012d46: 2008        movs	r0, #8
@   0x08012d48: 7308        strb	r0, [r1, #12]
@   0x08012d4a: 2004        movs	r0, #4
@   0x08012d4c: 7008        strb	r0, [r1, #0]
@   0x08012d4e: 490b        ldr	r1, [pc, #44]	@ (0x12d7c)
@   0x08012d50: 2010        movs	r0, #16
@   0x08012d52: 7308        strb	r0, [r1, #12]
@   0x08012d54: 2002        movs	r0, #2
@   0x08012d56: 7008        strb	r0, [r1, #0]
@   0x08012d58: 4909        ldr	r1, [pc, #36]	@ (0x12d80)
@   0x08012d5a: 2201        movs	r2, #1
@   0x08012d5c: 2001        movs	r0, #1
@   0x08012d5e: 7008        strb	r0, [r1, #0]
@   0x08012d60: 728b        strb	r3, [r1, #10]
@   0x08012d62: 4808        ldr	r0, [pc, #32]	@ (0x12d84)
@   0x08012d64: 3040        adds	r0, #64	@ 0x40
@   0x08012d66: 7801        ldrb	r1, [r0, #0]
@   0x08012d68: 4311        orrs	r1, r2
@   0x08012d6a: 7001        strb	r1, [r0, #0]
@   0x08012d6c: 2004        movs	r0, #4
@   0x08012d6e: 2104        movs	r1, #4
@   0x08012d70: f7fd        fdf2 	bl	0x10958
@   0x08012d74: bc01        pop	{r0}
@   0x08012d76: 4700        bx	r0
@   0x08012d78: 6410        str	r0, [r2, #64]	@ 0x40
@   0x08012d7a: 0300        lsls	r0, r0, #12
@   0x08012d7c: 6400        str	r0, [r0, #64]	@ 0x40
@   0x08012d7e: 0300        lsls	r0, r0, #12
@   0x08012d80: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08012d82: 0300        lsls	r0, r0, #12
@   0x08012d84: 60a0        str	r0, [r4, #8]
@   0x08012d86: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012D40
sub_08012D40: @ 0x08012d40
        .incbin "frog_us_baserom.gba", 0x12d40, 0x48
        thumb_func_end sub_08012D40
