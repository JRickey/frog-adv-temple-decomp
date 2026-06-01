@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022b4c, 0x08022b90)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022b4c --end 0x8022b90 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022b4c: b500        push	{lr}
@   0x08022b4e: 480f        ldr	r0, [pc, #60]	@ (0x22b8c)
@   0x08022b50: 3031        adds	r0, #49	@ 0x31
@   0x08022b52: 2100        movs	r1, #0
@   0x08022b54: 7001        strb	r1, [r0, #0]
@   0x08022b56: f7ff        fed1 	bl	0x228fc
@   0x08022b5a: f7ff        fdfd 	bl	0x22758
@   0x08022b5e: f7ff        fe3d 	bl	0x227dc
@   0x08022b62: f7ff        fea3 	bl	0x228ac
@   0x08022b66: f7ff        ff5f 	bl	0x22a28
@   0x08022b6a: f7ff        fe07 	bl	0x2277c
@   0x08022b6e: f7ff        ff3f 	bl	0x229f0
@   0x08022b72: f7ff        fe45 	bl	0x22800
@   0x08022b76: f7ff        fc5d 	bl	0x22434
@   0x08022b7a: f7ff        faf1 	bl	0x22160
@   0x08022b7e: f7ff        fecf 	bl	0x22920
@   0x08022b82: f7ff        ffa1 	bl	0x22ac8
@   0x08022b86: bc01        pop	{r0}
@   0x08022b88: 4700        bx	r0
@   0x08022b8a: 0000        movs	r0, r0
@   0x08022b8c: 6110        str	r0, [r2, #16]
@   0x08022b8e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022B4C
sub_08022B4C: @ 0x08022b4c
        .incbin "frog_us_baserom.gba", 0x22b4c, 0x44
        thumb_func_end sub_08022B4C
