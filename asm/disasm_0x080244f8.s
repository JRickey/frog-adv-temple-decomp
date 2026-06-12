@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080244f8, 0x08024534)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80244f8 --end 0x8024534 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080244f8: b500        push	{lr}
@   0x080244fa: f7ff        fd57 	bl	0x23fac
@   0x080244fe: f7ff        fdb7 	bl	0x24070
@   0x08024502: f7ff        fded 	bl	0x240e0
@   0x08024506: f7ff        f85f 	bl	0x235c8
@   0x0802450a: f7ff        fe5f 	bl	0x241cc
@   0x0802450e: f7ff        fea7 	bl	0x24260
@   0x08024512: f7ff        fef7 	bl	0x24304
@   0x08024516: f7ff        facd 	bl	0x23ab4
@   0x0802451a: f7ff        f8af 	bl	0x2367c
@   0x0802451e: f7ff        f8e9 	bl	0x236f4
@   0x08024522: f7ff        fb4d 	bl	0x23bc0
@   0x08024526: f7ff        fd7d 	bl	0x24024
@   0x0802452a: f7ff        ffa1 	bl	0x24470
@   0x0802452e: bc01        pop	{r0}
@   0x08024530: 4700        bx	r0

        thumb_func_start sub_080244F8
sub_080244F8: @ 0x080244f8
        .incbin "baserom.gba", 0x244f8, 0x3c
        thumb_func_end sub_080244F8
