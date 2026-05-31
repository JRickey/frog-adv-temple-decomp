@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012b78, 0x08012bb4)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012b78 --end 0x8012bb4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012b78: b500        push	{lr}
@   0x08012b7a: 2002        movs	r0, #2
@   0x08012b7c: f7fb        fe6e 	bl	0xe85c
@   0x08012b80: 480a        ldr	r0, [pc, #40]	@ (0x12bac)
@   0x08012b82: 2100        movs	r1, #0
@   0x08012b84: 60c1        str	r1, [r0, #12]
@   0x08012b86: 2208        movs	r2, #8
@   0x08012b88: 6102        str	r2, [r0, #16]
@   0x08012b8a: 62c1        str	r1, [r0, #44]	@ 0x2c
@   0x08012b8c: 6302        str	r2, [r0, #48]	@ 0x30
@   0x08012b8e: 4808        ldr	r0, [pc, #32]	@ (0x12bb0)
@   0x08012b90: 7001        strb	r1, [r0, #0]
@   0x08012b92: f7fb        ffc3 	bl	0xeb1c
@   0x08012b96: 2002        movs	r0, #2
@   0x08012b98: f7fc        fb58 	bl	0xf24c
@   0x08012b9c: 2002        movs	r0, #2
@   0x08012b9e: f7fc        f81d 	bl	0xebdc
@   0x08012ba2: f003        ff4d 	bl	0x16a40
@   0x08012ba6: bc01        pop	{r0}
@   0x08012ba8: 4700        bx	r0
@   0x08012baa: 0000        movs	r0, r0
@   0x08012bac: 60a0        str	r0, [r4, #8]
@   0x08012bae: 0300        lsls	r0, r0, #12
@   0x08012bb0: 3610        adds	r6, #16
@   0x08012bb2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012B78
sub_08012B78: @ 0x08012b78
        .incbin "frog_us_baserom.gba", 0x12b78, 0x3c
        thumb_func_end sub_08012B78
