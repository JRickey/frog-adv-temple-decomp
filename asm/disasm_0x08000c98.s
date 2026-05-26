@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000c98, 0x08000cb0)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000c98 --end 0x8000cb0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000c98: b500        push	{lr}
@   0x08000c9a: 4b04        ldr	r3, [pc, #16]	@ (0xcac)
@   0x08000c9c: 2201        movs	r2, #1
@   0x08000c9e: 729a        strb	r2, [r3, #10]
@   0x08000ca0: 2212        movs	r2, #18
@   0x08000ca2: f00a        fd85 	bl	0xb7b0
@   0x08000ca6: bc01        pop	{r0}
@   0x08000ca8: 4700        bx	r0
@   0x08000caa: 0000        movs	r0, r0
@   0x08000cac: 5330        strh	r0, [r6, r4]
@   0x08000cae: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000C98
sub_08000C98: @ 0x08000c98
        .incbin "frog_us_baserom.gba", 0xc98, 0x18
        thumb_func_end sub_08000C98
