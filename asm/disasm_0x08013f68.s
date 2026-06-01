@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013f68, 0x08013f94)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013f68 --end 0x8013f94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013f68: b500        push	{lr}
@   0x08013f6a: 2002        movs	r0, #2
@   0x08013f6c: f7fa        fc76 	bl	0xe85c
@   0x08013f70: 4907        ldr	r1, [pc, #28]	@ (0x13f90)
@   0x08013f72: 2000        movs	r0, #0
@   0x08013f74: 7008        strb	r0, [r1, #0]
@   0x08013f76: f7fa        fdd1 	bl	0xeb1c
@   0x08013f7a: 2002        movs	r0, #2
@   0x08013f7c: f7fb        f966 	bl	0xf24c
@   0x08013f80: 2002        movs	r0, #2
@   0x08013f82: f7fa        fe2b 	bl	0xebdc
@   0x08013f86: f002        fd5b 	bl	0x16a40
@   0x08013f8a: bc01        pop	{r0}
@   0x08013f8c: 4700        bx	r0
@   0x08013f8e: 0000        movs	r0, r0
@   0x08013f90: 3610        adds	r6, #16
@   0x08013f92: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013F68
sub_08013F68: @ 0x08013f68
        .incbin "frog_us_baserom.gba", 0x13f68, 0x2c
        thumb_func_end sub_08013F68
