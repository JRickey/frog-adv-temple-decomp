@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080277f4, 0x0802782c)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80277f4 --end 0x802782c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080277f4: b500        push	{lr}
@   0x080277f6: f7ff        fd9f 	bl	0x27338
@   0x080277fa: f7ff        fdc3 	bl	0x27384
@   0x080277fe: f7ff        fde7 	bl	0x273d0
@   0x08027802: f7ff        fe29 	bl	0x27458
@   0x08027806: f7ff        fbfb 	bl	0x27000
@   0x0802780a: f7ff        fe81 	bl	0x27510
@   0x0802780e: f7ff        fc57 	bl	0x270c0
@   0x08027812: f7ff        fc91 	bl	0x27138
@   0x08027816: f7ff        fef1 	bl	0x275fc
@   0x0802781a: f7ff        ff31 	bl	0x27680
@   0x0802781e: f7ff        ff6d 	bl	0x276fc
@   0x08027822: f7ff        ffa5 	bl	0x27770
@   0x08027826: bc01        pop	{r0}
@   0x08027828: 4700        bx	r0

        thumb_func_start sub_080277F4
sub_080277F4: @ 0x080277f4
        .incbin "baserom.gba", 0x277f4, 0x38
        thumb_func_end sub_080277F4
