@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08030264, 0x08030290)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8030264 --end 0x8030290 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030264: b530        push	{r4, r5, lr}
@   0x08030266: 4809        ldr	r0, [pc, #36]	@ (0x3028c)
@   0x08030268: 6800        ldr	r0, [r0, #0]
@   0x0803026a: 1c05        adds	r5, r0, #0
@   0x0803026c: 35f4        adds	r5, #244	@ 0xf4
@   0x0803026e: 6868        ldr	r0, [r5, #4]
@   0x08030270: 2800        cmp	r0, #0
@   0x08030272: d008        beq.n	0x30286
@   0x08030274: 7eac        ldrb	r4, [r5, #26]
@   0x08030276: 2000        movs	r0, #0
@   0x08030278: 76a8        strb	r0, [r5, #26]
@   0x0803027a: 6828        ldr	r0, [r5, #0]
@   0x0803027c: 6929        ldr	r1, [r5, #16]
@   0x0803027e: 1a09        subs	r1, r1, r0
@   0x08030280: f7fe        f87e 	bl	0x2e380
@   0x08030284: 76ac        strb	r4, [r5, #26]
@   0x08030286: bc30        pop	{r4, r5}
@   0x08030288: bc01        pop	{r0}
@   0x0803028a: 4700        bx	r0
@   0x0803028c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803028e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08030264
sub_08030264: @ 0x08030264
        .incbin "frog_us_baserom.gba", 0x30264, 0x2c
        thumb_func_end sub_08030264
