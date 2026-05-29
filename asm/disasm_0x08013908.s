@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013908, 0x08013920)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013908 --end 0x8013920 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013908: b500        push	{lr}
@   0x0801390a: 4904        ldr	r1, [pc, #16]	@ (0x1391c)
@   0x0801390c: 2000        movs	r0, #0
@   0x0801390e: 7008        strb	r0, [r1, #0]
@   0x08013910: 2002        movs	r0, #2
@   0x08013912: f7fb        fa8f 	bl	0xee34
@   0x08013916: bc01        pop	{r0}
@   0x08013918: 4700        bx	r0
@   0x0801391a: 0000        movs	r0, r0
@   0x0801391c: 3610        adds	r6, #16
@   0x0801391e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013908
sub_08013908: @ 0x08013908
        .incbin "frog_us_baserom.gba", 0x13908, 0x18
        thumb_func_end sub_08013908
