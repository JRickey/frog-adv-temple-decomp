@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e3f8, 0x0802e418)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e3f8 --end 0x802e418 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e3f8: b500        push	{lr}
@   0x0802e3fa: 4806        ldr	r0, [pc, #24]	@ (0x2e414)
@   0x0802e3fc: 6800        ldr	r0, [r0, #0]
@   0x0802e3fe: 30bb        adds	r0, #187	@ 0xbb
@   0x0802e400: 7801        ldrb	r1, [r0, #0]
@   0x0802e402: 3901        subs	r1, #1
@   0x0802e404: 7001        strb	r1, [r0, #0]
@   0x0802e406: 0609        lsls	r1, r1, #24
@   0x0802e408: 2900        cmp	r1, #0
@   0x0802e40a: d101        bne.n	0x2e410
@   0x0802e40c: f007        fcc2 	bl	0x35d94
@   0x0802e410: bc01        pop	{r0}
@   0x0802e412: 4700        bx	r0
@   0x0802e414: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e416: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802E3F8
sub_0802E3F8: @ 0x0802e3f8
        .incbin "frog_us_baserom.gba", 0x2e3f8, 0x20
        thumb_func_end sub_0802E3F8
