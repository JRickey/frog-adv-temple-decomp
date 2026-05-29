@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ef58, 0x0800ef90)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ef58 --end 0x800ef90 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ef58: b500        push	{lr}
@   0x0800ef5a: 2002        movs	r0, #2
@   0x0800ef5c: f7ff        fc7e 	bl	0xe85c
@   0x0800ef60: 4809        ldr	r0, [pc, #36]	@ (0xef88)
@   0x0800ef62: 2105        movs	r1, #5
@   0x0800ef64: f007        f9fc 	bl	0x16360
@   0x0800ef68: f7ff        fdd8 	bl	0xeb1c
@   0x0800ef6c: 2002        movs	r0, #2
@   0x0800ef6e: f000        f96d 	bl	0xf24c
@   0x0800ef72: 2002        movs	r0, #2
@   0x0800ef74: f7ff        fe32 	bl	0xebdc
@   0x0800ef78: f007        fd62 	bl	0x16a40
@   0x0800ef7c: 4903        ldr	r1, [pc, #12]	@ (0xef8c)
@   0x0800ef7e: 2000        movs	r0, #0
@   0x0800ef80: 6008        str	r0, [r1, #0]
@   0x0800ef82: bc01        pop	{r0}
@   0x0800ef84: 4700        bx	r0
@   0x0800ef86: 0000        movs	r0, r0
@   0x0800ef88: 6944        ldr	r4, [r0, #20]
@   0x0800ef8a: 0830        lsrs	r0, r6, #32
@   0x0800ef8c: 6420        str	r0, [r4, #64]	@ 0x40
@   0x0800ef8e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800EF58
sub_0800EF58: @ 0x0800ef58
        .incbin "frog_us_baserom.gba", 0xef58, 0x38
        thumb_func_end sub_0800EF58
