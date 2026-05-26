@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a7a8, 0x0800a83c)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a7a8 --end 0x800a83c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a7a8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800a7aa: 4647        mov	r7, r8
@   0x0800a7ac: b480        push	{r7}
@   0x0800a7ae: 0600        lsls	r0, r0, #24
@   0x0800a7b0: 0e05        lsrs	r5, r0, #24
@   0x0800a7b2: 0409        lsls	r1, r1, #16
@   0x0800a7b4: 0c0e        lsrs	r6, r1, #16
@   0x0800a7b6: 0412        lsls	r2, r2, #16
@   0x0800a7b8: 0c12        lsrs	r2, r2, #16
@   0x0800a7ba: 2400        movs	r4, #0
@   0x0800a7bc: 4813        ldr	r0, [pc, #76]	@ (0xa80c)
@   0x0800a7be: 4684        mov	ip, r0
@   0x0800a7c0: 062b        lsls	r3, r5, #24
@   0x0800a7c2: 1619        asrs	r1, r3, #24
@   0x0800a7c4: 0048        lsls	r0, r1, #1
@   0x0800a7c6: 1840        adds	r0, r0, r1
@   0x0800a7c8: 0080        lsls	r0, r0, #2
@   0x0800a7ca: 4460        add	r0, ip
@   0x0800a7cc: 7800        ldrb	r0, [r0, #0]
@   0x0800a7ce: 0600        lsls	r0, r0, #24
@   0x0800a7d0: 1600        asrs	r0, r0, #24
@   0x0800a7d2: 4284        cmp	r4, r0
@   0x0800a7d4: da2a        bge.n	0xa82c
@   0x0800a7d6: 2004        movs	r0, #4
@   0x0800a7d8: 4460        add	r0, ip
@   0x0800a7da: 4680        mov	r8, r0
@   0x0800a7dc: 0430        lsls	r0, r6, #16
@   0x0800a7de: 1407        asrs	r7, r0, #16
@   0x0800a7e0: 0410        lsls	r0, r2, #16
@   0x0800a7e2: 1406        asrs	r6, r0, #16
@   0x0800a7e4: 1619        asrs	r1, r3, #24
@   0x0800a7e6: 0048        lsls	r0, r1, #1
@   0x0800a7e8: 1840        adds	r0, r0, r1
@   0x0800a7ea: 0080        lsls	r0, r0, #2
@   0x0800a7ec: 4440        add	r0, r8
@   0x0800a7ee: 0622        lsls	r2, r4, #24
@   0x0800a7f0: 1613        asrs	r3, r2, #24
@   0x0800a7f2: 6801        ldr	r1, [r0, #0]
@   0x0800a7f4: 0098        lsls	r0, r3, #2
@   0x0800a7f6: 1841        adds	r1, r0, r1
@   0x0800a7f8: 2400        movs	r4, #0
@   0x0800a7fa: 5f08        ldrsh	r0, [r1, r4]
@   0x0800a7fc: 4287        cmp	r7, r0
@   0x0800a7fe: d107        bne.n	0xa810
@   0x0800a800: 2402        movs	r4, #2
@   0x0800a802: 5f08        ldrsh	r0, [r1, r4]
@   0x0800a804: 4286        cmp	r6, r0
@   0x0800a806: d103        bne.n	0xa810
@   0x0800a808: 1c18        adds	r0, r3, #0
@   0x0800a80a: e011        b.n	0xa830
@   0x0800a80c: 0b00        lsrs	r0, r0, #12
@   0x0800a80e: 080c        lsrs	r4, r1, #32
@   0x0800a810: 2080        movs	r0, #128	@ 0x80
@   0x0800a812: 0440        lsls	r0, r0, #17
@   0x0800a814: 1812        adds	r2, r2, r0
@   0x0800a816: 062b        lsls	r3, r5, #24
@   0x0800a818: 1619        asrs	r1, r3, #24
@   0x0800a81a: 0048        lsls	r0, r1, #1
@   0x0800a81c: 1840        adds	r0, r0, r1
@   0x0800a81e: 0080        lsls	r0, r0, #2
@   0x0800a820: 4460        add	r0, ip
@   0x0800a822: 0e14        lsrs	r4, r2, #24
@   0x0800a824: 7800        ldrb	r0, [r0, #0]
@   0x0800a826: 0600        lsls	r0, r0, #24
@   0x0800a828: 4282        cmp	r2, r0
@   0x0800a82a: dbdb        blt.n	0xa7e4
@   0x0800a82c: 2001        movs	r0, #1
@   0x0800a82e: 4240        negs	r0, r0
@   0x0800a830: bc08        pop	{r3}
@   0x0800a832: 4698        mov	r8, r3
@   0x0800a834: bcf0        pop	{r4, r5, r6, r7}
@   0x0800a836: bc02        pop	{r1}
@   0x0800a838: 4708        bx	r1

        thumb_func_start sub_0800A7A8
sub_0800A7A8: @ 0x0800a7a8
        .incbin "frog_us_baserom.gba", 0xa7a8, 0x94
        thumb_func_end sub_0800A7A8
