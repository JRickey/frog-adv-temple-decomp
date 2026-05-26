@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001140, 0x08001174)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001140 --end 0x8001174 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001140: b530        push	{r4, r5, lr}
@   0x08001142: 1c04        adds	r4, r0, #0
@   0x08001144: 1c0d        adds	r5, r1, #0
@   0x08001146: f009        f8c7 	bl	0xa2d8
@   0x0800114a: f7ff        fbc7 	bl	0x8dc
@   0x0800114e: f009        f8eb 	bl	0xa328
@   0x08001152: f008        f9d1 	bl	0x94f8
@   0x08001156: f008        fc15 	bl	0x9984
@   0x0800115a: 1c20        adds	r0, r4, #0
@   0x0800115c: 1c29        adds	r1, r5, #0
@   0x0800115e: f7ff        fe55 	bl	0xe0c
@   0x08001162: 4903        ldr	r1, [pc, #12]	@ (0x1170)
@   0x08001164: 6948        ldr	r0, [r1, #20]
@   0x08001166: 3001        adds	r0, #1
@   0x08001168: 6148        str	r0, [r1, #20]
@   0x0800116a: bc30        pop	{r4, r5}
@   0x0800116c: bc01        pop	{r0}
@   0x0800116e: 4700        bx	r0
@   0x08001170: 5330        strh	r0, [r6, r4]
@   0x08001172: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001140
sub_08001140: @ 0x08001140
        .incbin "frog_us_baserom.gba", 0x1140, 0x34
        thumb_func_end sub_08001140
