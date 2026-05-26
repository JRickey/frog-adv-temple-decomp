@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001174, 0x08001198)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001174 --end 0x8001198 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001174: b570        push	{r4, r5, r6, lr}
@   0x08001176: 1c04        adds	r4, r0, #0
@   0x08001178: 1c0d        adds	r5, r1, #0
@   0x0800117a: 1c16        adds	r6, r2, #0
@   0x0800117c: f008        fd4a 	bl	0x9c14
@   0x08001180: 2800        cmp	r0, #0
@   0x08001182: d101        bne.n	0x1188
@   0x08001184: 2007        movs	r0, #7
@   0x08001186: 7020        strb	r0, [r4, #0]
@   0x08001188: 1c28        adds	r0, r5, #0
@   0x0800118a: 1c31        adds	r1, r6, #0
@   0x0800118c: 2203        movs	r2, #3
@   0x0800118e: f00a        fb0f 	bl	0xb7b0
@   0x08001192: bc70        pop	{r4, r5, r6}
@   0x08001194: bc01        pop	{r0}
@   0x08001196: 4700        bx	r0

        thumb_func_start sub_08001174
sub_08001174: @ 0x08001174
        .incbin "frog_us_baserom.gba", 0x1174, 0x24
        thumb_func_end sub_08001174
