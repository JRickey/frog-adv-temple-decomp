@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080201c8, 0x080201e8)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80201c8 --end 0x80201e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080201c8: b500        push	{lr}
@   0x080201ca: 4905        ldr	r1, [pc, #20]	@ (0x201e0)
@   0x080201cc: 4805        ldr	r0, [pc, #20]	@ (0x201e4)
@   0x080201ce: 7880        ldrb	r0, [r0, #2]
@   0x080201d0: 0080        lsls	r0, r0, #2
@   0x080201d2: 1840        adds	r0, r0, r1
@   0x080201d4: 6800        ldr	r0, [r0, #0]
@   0x080201d6: f013        fd7f 	bl	0x33cd8
@   0x080201da: bc01        pop	{r0}
@   0x080201dc: 4700        bx	r0
@   0x080201de: 0000        movs	r0, r0
@   0x080201e0: 8ad4        ldrh	r4, [r2, #22]
@   0x080201e2: 0830        lsrs	r0, r6, #32
@   0x080201e4: 3480        adds	r4, #128	@ 0x80
@   0x080201e6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080201C8
sub_080201C8: @ 0x080201c8
        .incbin "frog_us_baserom.gba", 0x201c8, 0x20
        thumb_func_end sub_080201C8
