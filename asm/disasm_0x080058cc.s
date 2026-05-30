@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080058cc, 0x080058fc)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80058cc --end 0x80058fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080058cc: b510        push	{r4, lr}
@   0x080058ce: 1c04        adds	r4, r0, #0
@   0x080058d0: f004        fd02 	bl	0xa2d8
@   0x080058d4: f7fb        f802 	bl	0x8dc
@   0x080058d8: f004        fd26 	bl	0xa328
@   0x080058dc: f003        fe0c 	bl	0x94f8
@   0x080058e0: f004        f850 	bl	0x9984
@   0x080058e4: 1c20        adds	r0, r4, #0
@   0x080058e6: f7ff        fd8d 	bl	0x5404
@   0x080058ea: 4903        ldr	r1, [pc, #12]	@ (0x58f8)
@   0x080058ec: 6948        ldr	r0, [r1, #20]
@   0x080058ee: 3001        adds	r0, #1
@   0x080058f0: 6148        str	r0, [r1, #20]
@   0x080058f2: bc10        pop	{r4}
@   0x080058f4: bc01        pop	{r0}
@   0x080058f6: 4700        bx	r0
@   0x080058f8: 5330        strh	r0, [r6, r4]
@   0x080058fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080058CC
sub_080058CC: @ 0x080058cc
        .incbin "frog_us_baserom.gba", 0x58cc, 0x30
        thumb_func_end sub_080058CC
