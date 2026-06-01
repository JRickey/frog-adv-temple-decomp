@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022b90, 0x08022bb0)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022b90 --end 0x8022bb0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022b90: b500        push	{lr}
@   0x08022b92: 2080        movs	r0, #128	@ 0x80
@   0x08022b94: 04c0        lsls	r0, r0, #19
@   0x08022b96: 8801        ldrh	r1, [r0, #0]
@   0x08022b98: 2380        movs	r3, #128	@ 0x80
@   0x08022b9a: 015b        lsls	r3, r3, #5
@   0x08022b9c: 1c1a        adds	r2, r3, #0
@   0x08022b9e: 4311        orrs	r1, r2
@   0x08022ba0: 8001        strh	r1, [r0, #0]
@   0x08022ba2: f7ff        fed9 	bl	0x22958
@   0x08022ba6: f7ff        fefd 	bl	0x229a4
@   0x08022baa: bc01        pop	{r0}
@   0x08022bac: 4700        bx	r0

        thumb_func_start sub_08022B90
sub_08022B90: @ 0x08022b90
        .incbin "frog_us_baserom.gba", 0x22b90, 0x20
        thumb_func_end sub_08022B90
