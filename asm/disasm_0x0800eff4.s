@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800eff4, 0x0800f014)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800eff4 --end 0x800f014 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800eff4: b500        push	{lr}
@   0x0800eff6: 2002        movs	r0, #2
@   0x0800eff8: f7ff        fc30 	bl	0xe85c
@   0x0800effc: f7ff        fd8e 	bl	0xeb1c
@   0x0800f000: 2002        movs	r0, #2
@   0x0800f002: f000        f923 	bl	0xf24c
@   0x0800f006: 2002        movs	r0, #2
@   0x0800f008: f7ff        fde8 	bl	0xebdc
@   0x0800f00c: f007        fd18 	bl	0x16a40
@   0x0800f010: bc01        pop	{r0}
@   0x0800f012: 4700        bx	r0

        thumb_func_start sub_0800EFF4
sub_0800EFF4: @ 0x0800eff4
        .incbin "frog_us_baserom.gba", 0xeff4, 0x20
        thumb_func_end sub_0800EFF4
