@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e1c8, 0x0802e220)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e1c8 --end 0x802e220 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e1c8: b510        push	{r4, lr}
@   0x0802e1ca: 1c03        adds	r3, r0, #0
@   0x0802e1cc: 2b00        cmp	r3, #0
@   0x0802e1ce: d00d        beq.n	0x2e1ec
@   0x0802e1d0: 0c1a        lsrs	r2, r3, #16
@   0x0802e1d2: 20ff        movs	r0, #255	@ 0xff
@   0x0802e1d4: 4002        ands	r2, r0
@   0x0802e1d6: 4807        ldr	r0, [pc, #28]	@ (0x2e1f4)
@   0x0802e1d8: 6804        ldr	r4, [r0, #0]
@   0x0802e1da: 2190        movs	r1, #144	@ 0x90
@   0x0802e1dc: 0049        lsls	r1, r1, #1
@   0x0802e1de: 1860        adds	r0, r4, r1
@   0x0802e1e0: 6801        ldr	r1, [r0, #0]
@   0x0802e1e2: 0090        lsls	r0, r2, #2
@   0x0802e1e4: 1840        adds	r0, r0, r1
@   0x0802e1e6: 6800        ldr	r0, [r0, #0]
@   0x0802e1e8: 4298        cmp	r0, r3
@   0x0802e1ea: d005        beq.n	0x2e1f8
@   0x0802e1ec: 2001        movs	r0, #1
@   0x0802e1ee: 4240        negs	r0, r0
@   0x0802e1f0: e012        b.n	0x2e218
@   0x0802e1f2: 0000        movs	r0, r0
@   0x0802e1f4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e1f6: 0300        lsls	r0, r0, #12
@   0x0802e1f8: 2a03        cmp	r2, #3
@   0x0802e1fa: dc04        bgt.n	0x2e206
@   0x0802e1fc: 00d0        lsls	r0, r2, #3
@   0x0802e1fe: 308c        adds	r0, #140	@ 0x8c
@   0x0802e200: 1820        adds	r0, r4, r0
@   0x0802e202: 79c0        ldrb	r0, [r0, #7]
@   0x0802e204: e008        b.n	0x2e218
@   0x0802e206: 3a04        subs	r2, #4
@   0x0802e208: 1c20        adds	r0, r4, #0
@   0x0802e20a: 30c8        adds	r0, #200	@ 0xc8
@   0x0802e20c: 0191        lsls	r1, r2, #6
@   0x0802e20e: 6800        ldr	r0, [r0, #0]
@   0x0802e210: 1840        adds	r0, r0, r1
@   0x0802e212: 3024        adds	r0, #36	@ 0x24
@   0x0802e214: 79c0        ldrb	r0, [r0, #7]
@   0x0802e216: 0840        lsrs	r0, r0, #1
@   0x0802e218: bc10        pop	{r4}
@   0x0802e21a: bc02        pop	{r1}
@   0x0802e21c: 4708        bx	r1

        thumb_func_start sub_0802E1C8
sub_0802E1C8: @ 0x0802e1c8
        .incbin "frog_us_baserom.gba", 0x2e1c8, 0x58
        thumb_func_end sub_0802E1C8
