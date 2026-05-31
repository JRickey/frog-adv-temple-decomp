@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080118d8, 0x080118fc)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80118d8 --end 0x80118fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080118d8: b500        push	{lr}
@   0x080118da: 2002        movs	r0, #2
@   0x080118dc: f7fc        ffbe 	bl	0xe85c
@   0x080118e0: f7ff        fe1a 	bl	0x11518
@   0x080118e4: f7fd        f91a 	bl	0xeb1c
@   0x080118e8: 2002        movs	r0, #2
@   0x080118ea: f7fd        fcaf 	bl	0xf24c
@   0x080118ee: 2002        movs	r0, #2
@   0x080118f0: f7fd        f974 	bl	0xebdc
@   0x080118f4: f005        f8a4 	bl	0x16a40
@   0x080118f8: bc01        pop	{r0}
@   0x080118fa: 4700        bx	r0

        thumb_func_start sub_080118D8
sub_080118D8: @ 0x080118d8
        .incbin "frog_us_baserom.gba", 0x118d8, 0x24
        thumb_func_end sub_080118D8
