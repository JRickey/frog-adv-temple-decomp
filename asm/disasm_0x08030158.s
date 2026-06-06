@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08030158, 0x080301c4)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8030158 --end 0x80301c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030158: b510        push	{r4, lr}
@   0x0803015a: 1c01        adds	r1, r0, #0
@   0x0803015c: 0409        lsls	r1, r1, #16
@   0x0803015e: 0c09        lsrs	r1, r1, #16
@   0x08030160: 2080        movs	r0, #128	@ 0x80
@   0x08030162: 0440        lsls	r0, r0, #17
@   0x08030164: f003        febe 	bl	0x33ee4
@   0x08030168: 4c0c        ldr	r4, [pc, #48]	@ (0x3019c)
@   0x0803016a: 4004        ands	r4, r0
@   0x0803016c: 0424        lsls	r4, r4, #16
@   0x0803016e: 1424        asrs	r4, r4, #16
@   0x08030170: 1c20        adds	r0, r4, #0
@   0x08030172: f004        fb61 	bl	0x34838
@   0x08030176: 1c02        adds	r2, r0, #0
@   0x08030178: 2c00        cmp	r4, #0
@   0x0803017a: da03        bge.n	0x30184
@   0x0803017c: 4908        ldr	r1, [pc, #32]	@ (0x301a0)
@   0x0803017e: f004        f8a5 	bl	0x342cc
@   0x08030182: 1c02        adds	r2, r0, #0
@   0x08030184: 4807        ldr	r0, [pc, #28]	@ (0x301a4)
@   0x08030186: 1c11        adds	r1, r2, #0
@   0x08030188: f004        f982 	bl	0x34490
@   0x0803018c: f003        fe0e 	bl	0x33dac
@   0x08030190: 0400        lsls	r0, r0, #16
@   0x08030192: 0c00        lsrs	r0, r0, #16
@   0x08030194: bc10        pop	{r4}
@   0x08030196: bc02        pop	{r1}
@   0x08030198: 4708        bx	r1
@   0x0803019a: 0000        movs	r0, r0
@   0x0803019c: ffc0        0000 	vaddl.u8	q8, d0, d0
@   0x080301a0: 0000        movs	r0, r0
@   0x080301a2: 4780        blx	r0
@   0x080301a4: 0000        movs	r0, r0
@   0x080301a6: 4b80        ldr	r3, [pc, #512]	@ (0x303a8)
@   0x080301a8: b500        push	{lr}
@   0x080301aa: 4348        muls	r0, r1
@   0x080301ac: 21fa        movs	r1, #250	@ 0xfa
@   0x080301ae: 0249        lsls	r1, r1, #9
@   0x080301b0: f003        fe98 	bl	0x33ee4
@   0x080301b4: 2800        cmp	r0, #0
@   0x080301b6: d100        bne.n	0x301ba
@   0x080301b8: 2001        movs	r0, #1
@   0x080301ba: 28ff        cmp	r0, #255	@ 0xff
@   0x080301bc: d900        bls.n	0x301c0
@   0x080301be: 20ff        movs	r0, #255	@ 0xff
@   0x080301c0: bc02        pop	{r1}
@   0x080301c2: 4708        bx	r1

        thumb_func_start sub_08030158
sub_08030158: @ 0x08030158
        .incbin "frog_us_baserom.gba", 0x30158, 0x6c
        thumb_func_end sub_08030158
