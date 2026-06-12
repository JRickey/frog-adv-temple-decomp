@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080262f4, 0x08026330)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80262f4 --end 0x8026330 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080262f4: b500        push	{lr}
@   0x080262f6: f7ff        fb65 	bl	0x259c4
@   0x080262fa: f7ff        fd0b 	bl	0x25d14
@   0x080262fe: f7ff        fd2f 	bl	0x25d60
@   0x08026302: f7ff        fd53 	bl	0x25dac
@   0x08026306: f7ff        fd79 	bl	0x25dfc
@   0x0802630a: f7ff        fdd3 	bl	0x25eb4
@   0x0802630e: f7ff        fe13 	bl	0x25f38
@   0x08026312: f7ff        ff3b 	bl	0x2618c
@   0x08026316: f7ff        fa09 	bl	0x2572c
@   0x0802631a: f7ff        fe4f 	bl	0x25fbc
@   0x0802631e: f7ff        fe7f 	bl	0x26020
@   0x08026322: f7ff        fed7 	bl	0x260d4
@   0x08026326: f7ff        ffa1 	bl	0x2626c
@   0x0802632a: bc01        pop	{r0}
@   0x0802632c: 4700        bx	r0

        thumb_func_start sub_080262F4
sub_080262F4: @ 0x080262f4
        .incbin "baserom.gba", 0x262f4, 0x3c
        thumb_func_end sub_080262F4
