@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080297f0, 0x08029828)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80297f0 --end 0x8029828 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080297f0: b530        push	{r4, r5, lr}
@   0x080297f2: 2400        movs	r4, #0
@   0x080297f4: 4d0b        ldr	r5, [pc, #44]	@ (0x29824)
@   0x080297f6: 00a0        lsls	r0, r4, #2
@   0x080297f8: 1940        adds	r0, r0, r5
@   0x080297fa: 6800        ldr	r0, [r0, #0]
@   0x080297fc: 1c21        adds	r1, r4, #0
@   0x080297fe: 3157        adds	r1, #87	@ 0x57
@   0x08029800: f7f8        f8dc 	bl	0x219bc
@   0x08029804: 1c60        adds	r0, r4, #1
@   0x08029806: 0600        lsls	r0, r0, #24
@   0x08029808: 0e04        lsrs	r4, r0, #24
@   0x0802980a: 2c01        cmp	r4, #1
@   0x0802980c: d9f3        bls.n	0x297f6
@   0x0802980e: 2057        movs	r0, #87	@ 0x57
@   0x08029810: 2158        movs	r1, #88	@ 0x58
@   0x08029812: f7f7        fbe7 	bl	0x20fe4
@   0x08029816: 2057        movs	r0, #87	@ 0x57
@   0x08029818: 2158        movs	r1, #88	@ 0x58
@   0x0802981a: f7dc        fa79 	bl	0x5d10
@   0x0802981e: bc30        pop	{r4, r5}
@   0x08029820: bc01        pop	{r0}
@   0x08029822: 4700        bx	r0
@   0x08029824: 7ab0        ldrb	r0, [r6, #10]
@   0x08029826: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080297F0
sub_080297F0: @ 0x080297f0
        .incbin "baserom.gba", 0x297f0, 0x38
        thumb_func_end sub_080297F0
