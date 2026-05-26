@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080201a8, 0x080201c8)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80201a8 --end 0x80201c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080201a8: b500        push	{lr}
@   0x080201aa: 4905        ldr	r1, [pc, #20]	@ (0x201c0)
@   0x080201ac: 4805        ldr	r0, [pc, #20]	@ (0x201c4)
@   0x080201ae: 7840        ldrb	r0, [r0, #1]
@   0x080201b0: 0080        lsls	r0, r0, #2
@   0x080201b2: 1840        adds	r0, r0, r1
@   0x080201b4: 6800        ldr	r0, [r0, #0]
@   0x080201b6: f013        fd8f 	bl	0x33cd8
@   0x080201ba: bc01        pop	{r0}
@   0x080201bc: 4700        bx	r0
@   0x080201be: 0000        movs	r0, r0
@   0x080201c0: 8ac8        ldrh	r0, [r1, #22]
@   0x080201c2: 0830        lsrs	r0, r6, #32
@   0x080201c4: 34a0        adds	r4, #160	@ 0xa0
@   0x080201c6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080201A8
sub_080201A8: @ 0x080201a8
        .incbin "frog_us_baserom.gba", 0x201a8, 0x20
        thumb_func_end sub_080201A8
