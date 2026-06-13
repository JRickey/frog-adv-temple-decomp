@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028858, 0x08028a98)  (576 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028858 --end 0x8028a98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028858: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802885a: 464f        mov	r7, r9
@   0x0802885c: 4646        mov	r6, r8
@   0x0802885e: b4c0        push	{r6, r7}
@   0x08028860: b084        sub	sp, #16
@   0x08028862: 480d        ldr	r0, [pc, #52]	@ (0x28898)
@   0x08028864: 2108        movs	r1, #8
@   0x08028866: 2200        movs	r2, #0
@   0x08028868: f7dd        ff98 	bl	0x679c
@   0x0802886c: 0600        lsls	r0, r0, #24
@   0x0802886e: 2800        cmp	r0, #0
@   0x08028870: d100        bne.n	0x28874
@   0x08028872: e105        b.n	0x28a80
@   0x08028874: 2500        movs	r5, #0
@   0x08028876: 4f09        ldr	r7, [pc, #36]	@ (0x2889c)
@   0x08028878: 4809        ldr	r0, [pc, #36]	@ (0x288a0)
@   0x0802887a: 19c0        adds	r0, r0, r7
@   0x0802887c: 4680        mov	r8, r0
@   0x0802887e: 1c29        adds	r1, r5, #0
@   0x08028880: 3122        adds	r1, #34	@ 0x22
@   0x08028882: 00c8        lsls	r0, r1, #3
@   0x08028884: 1a40        subs	r0, r0, r1
@   0x08028886: 00c0        lsls	r0, r0, #3
@   0x08028888: 19c4        adds	r4, r0, r7
@   0x0802888a: 7ea0        ldrb	r0, [r4, #26]
@   0x0802888c: 1c0e        adds	r6, r1, #0
@   0x0802888e: 2801        cmp	r0, #1
@   0x08028890: d008        beq.n	0x288a4
@   0x08028892: 2802        cmp	r0, #2
@   0x08028894: d014        beq.n	0x288c0
@   0x08028896: e062        b.n	0x2895e
@   0x08028898: 6110        str	r0, [r2, #16]
@   0x0802889a: 0300        lsls	r0, r0, #12
@   0x0802889c: 3720        adds	r7, #32
@   0x0802889e: 0300        lsls	r0, r0, #12
@   0x080288a0: 07fa        lsls	r2, r7, #31
@   0x080288a2: 0000        movs	r0, r0
@   0x080288a4: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080288a6: 2280        movs	r2, #128	@ 0x80
@   0x080288a8: 0212        lsls	r2, r2, #8
@   0x080288aa: 1c10        adds	r0, r2, #0
@   0x080288ac: 4008        ands	r0, r1
@   0x080288ae: 2800        cmp	r0, #0
@   0x080288b0: d055        beq.n	0x2895e
@   0x080288b2: 2002        movs	r0, #2
@   0x080288b4: 4308        orrs	r0, r1
@   0x080288b6: 3a01        subs	r2, #1
@   0x080288b8: 1c11        adds	r1, r2, #0
@   0x080288ba: 4008        ands	r0, r1
@   0x080288bc: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080288be: e04e        b.n	0x2895e
@   0x080288c0: 2180        movs	r1, #128	@ 0x80
@   0x080288c2: 0209        lsls	r1, r1, #8
@   0x080288c4: 1c08        adds	r0, r1, #0
@   0x080288c6: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x080288c8: 4010        ands	r0, r2
@   0x080288ca: 2800        cmp	r0, #0
@   0x080288cc: d042        beq.n	0x28954
@   0x080288ce: 1c28        adds	r0, r5, #0
@   0x080288d0: 3025        adds	r0, #37	@ 0x25
@   0x080288d2: 4a1b        ldr	r2, [pc, #108]	@ (0x28940)
@   0x080288d4: 00a9        lsls	r1, r5, #2
@   0x080288d6: 1889        adds	r1, r1, r2
@   0x080288d8: 6809        ldr	r1, [r1, #0]
@   0x080288da: 4a1a        ldr	r2, [pc, #104]	@ (0x28944)
@   0x080288dc: 9200        str	r2, [sp, #0]
@   0x080288de: 2209        movs	r2, #9
@   0x080288e0: 9201        str	r2, [sp, #4]
@   0x080288e2: 2203        movs	r2, #3
@   0x080288e4: 9202        str	r2, [sp, #8]
@   0x080288e6: 9203        str	r2, [sp, #12]
@   0x080288e8: 2210        movs	r2, #16
@   0x080288ea: 2342        movs	r3, #66	@ 0x42
@   0x080288ec: f7f8        fbd8 	bl	0x210a0
@   0x080288f0: 2d00        cmp	r5, #0
@   0x080288f2: d10a        bne.n	0x2890a
@   0x080288f4: 4814        ldr	r0, [pc, #80]	@ (0x28948)
@   0x080288f6: 9000        str	r0, [sp, #0]
@   0x080288f8: 200e        movs	r0, #14
@   0x080288fa: 9001        str	r0, [sp, #4]
@   0x080288fc: 9502        str	r5, [sp, #8]
@   0x080288fe: 2024        movs	r0, #36	@ 0x24
@   0x08028900: 4912        ldr	r1, [pc, #72]	@ (0x2894c)
@   0x08028902: 2210        movs	r2, #16
@   0x08028904: 2340        movs	r3, #64	@ 0x40
@   0x08028906: f7f8        fc1b 	bl	0x21140
@   0x0802890a: 2001        movs	r0, #1
@   0x0802890c: 76a0        strb	r0, [r4, #26]
@   0x0802890e: 2002        movs	r0, #2
@   0x08028910: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08028912: 4308        orrs	r0, r1
@   0x08028914: 4a0e        ldr	r2, [pc, #56]	@ (0x28950)
@   0x08028916: 1c11        adds	r1, r2, #0
@   0x08028918: 4008        ands	r0, r1
@   0x0802891a: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802891c: 2d00        cmp	r5, #0
@   0x0802891e: d001        beq.n	0x28924
@   0x08028920: 2d02        cmp	r5, #2
@   0x08028922: d11c        bne.n	0x2895e
@   0x08028924: 00e8        lsls	r0, r5, #3
@   0x08028926: 1b40        subs	r0, r0, r5
@   0x08028928: 00c0        lsls	r0, r0, #3
@   0x0802892a: 22ee        movs	r2, #238	@ 0xee
@   0x0802892c: 00d2        lsls	r2, r2, #3
@   0x0802892e: 18b9        adds	r1, r7, r2
@   0x08028930: 1840        adds	r0, r0, r1
@   0x08028932: 2124        movs	r1, #36	@ 0x24
@   0x08028934: 2206        movs	r2, #6
@   0x08028936: 230a        movs	r3, #10
@   0x08028938: f7f8        f9d0 	bl	0x20cdc
@   0x0802893c: e00f        b.n	0x2895e
@   0x0802893e: 0000        movs	r0, r0
@   0x08028940: 7b10        ldrb	r0, [r2, #12]
@   0x08028942: 0831        lsrs	r1, r6, #32
@   0x08028944: 02e5        lsls	r5, r4, #11
@   0x08028946: 0000        movs	r0, r0
@   0x08028948: 02c5        lsls	r5, r0, #11
@   0x0802894a: 0000        movs	r0, r0
@   0x0802894c: 785c        ldrb	r4, [r3, #1]
@   0x0802894e: 0831        lsrs	r1, r6, #32
@   0x08028950: 7fff        ldrb	r7, [r7, #31]
@   0x08028952: 0000        movs	r0, r0
@   0x08028954: 2d02        cmp	r5, #2
@   0x08028956: d002        beq.n	0x2895e
@   0x08028958: 2001        movs	r0, #1
@   0x0802895a: 4641        mov	r1, r8
@   0x0802895c: 7008        strb	r0, [r1, #0]
@   0x0802895e: 4826        ldr	r0, [pc, #152]	@ (0x289f8)
@   0x08028960: 1c31        adds	r1, r6, #0
@   0x08028962: f7de        f803 	bl	0x696c
@   0x08028966: 1c68        adds	r0, r5, #1
@   0x08028968: 0600        lsls	r0, r0, #24
@   0x0802896a: 0e05        lsrs	r5, r0, #24
@   0x0802896c: 2d02        cmp	r5, #2
@   0x0802896e: d986        bls.n	0x2887e
@   0x08028970: 2022        movs	r0, #34	@ 0x22
@   0x08028972: 2124        movs	r1, #36	@ 0x24
@   0x08028974: f7dd        f9cc 	bl	0x5d10
@   0x08028978: 2500        movs	r5, #0
@   0x0802897a: 4e20        ldr	r6, [pc, #128]	@ (0x289fc)
@   0x0802897c: 2208        movs	r2, #8
@   0x0802897e: 4691        mov	r9, r2
@   0x08028980: 481f        ldr	r0, [pc, #124]	@ (0x28a00)
@   0x08028982: 4680        mov	r8, r0
@   0x08028984: 1c28        adds	r0, r5, #0
@   0x08028986: 3025        adds	r0, #37	@ 0x25
@   0x08028988: 00c1        lsls	r1, r0, #3
@   0x0802898a: 1a09        subs	r1, r1, r0
@   0x0802898c: 00c9        lsls	r1, r1, #3
@   0x0802898e: 198b        adds	r3, r1, r6
@   0x08028990: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x08028992: 2108        movs	r1, #8
@   0x08028994: 4011        ands	r1, r2
@   0x08028996: 1c07        adds	r7, r0, #0
@   0x08028998: 2900        cmp	r1, #0
@   0x0802899a: d143        bne.n	0x28a24
@   0x0802899c: 7e9c        ldrb	r4, [r3, #26]
@   0x0802899e: 2c02        cmp	r4, #2
@   0x080289a0: d13c        bne.n	0x28a1c
@   0x080289a2: 2180        movs	r1, #128	@ 0x80
@   0x080289a4: 0209        lsls	r1, r1, #8
@   0x080289a6: 1c08        adds	r0, r1, #0
@   0x080289a8: 4010        ands	r0, r2
@   0x080289aa: 2800        cmp	r0, #0
@   0x080289ac: d005        beq.n	0x289ba
@   0x080289ae: 2002        movs	r0, #2
@   0x080289b0: 4310        orrs	r0, r2
@   0x080289b2: 4a14        ldr	r2, [pc, #80]	@ (0x28a04)
@   0x080289b4: 1c11        adds	r1, r2, #0
@   0x080289b6: 4008        ands	r0, r1
@   0x080289b8: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x080289ba: 2104        movs	r1, #4
@   0x080289bc: 5e58        ldrsh	r0, [r3, r1]
@   0x080289be: 4540        cmp	r0, r8
@   0x080289c0: dd24        ble.n	0x28a0c
@   0x080289c2: 1c29        adds	r1, r5, #0
@   0x080289c4: 3122        adds	r1, #34	@ 0x22
@   0x080289c6: 00c8        lsls	r0, r1, #3
@   0x080289c8: 1a40        subs	r0, r0, r1
@   0x080289ca: 00c0        lsls	r0, r0, #3
@   0x080289cc: 1980        adds	r0, r0, r6
@   0x080289ce: 7684        strb	r4, [r0, #26]
@   0x080289d0: 2102        movs	r1, #2
@   0x080289d2: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x080289d4: 4311        orrs	r1, r2
@   0x080289d6: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080289d8: 4648        mov	r0, r9
@   0x080289da: 8e99        ldrh	r1, [r3, #52]	@ 0x34
@   0x080289dc: 4308        orrs	r0, r1
@   0x080289de: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x080289e0: 00e8        lsls	r0, r5, #3
@   0x080289e2: 1b40        subs	r0, r0, r5
@   0x080289e4: 00c0        lsls	r0, r0, #3
@   0x080289e6: 4a08        ldr	r2, [pc, #32]	@ (0x28a08)
@   0x080289e8: 18b1        adds	r1, r6, r2
@   0x080289ea: 1840        adds	r0, r0, r1
@   0x080289ec: 2100        movs	r1, #0
@   0x080289ee: 2200        movs	r2, #0
@   0x080289f0: 2300        movs	r3, #0
@   0x080289f2: f7e1        fdc5 	bl	0xa580
@   0x080289f6: e011        b.n	0x28a1c
@   0x080289f8: 6110        str	r0, [r2, #16]
@   0x080289fa: 0300        lsls	r0, r0, #12
@   0x080289fc: 3720        adds	r7, #32
@   0x080289fe: 0300        lsls	r0, r0, #12
@   0x08028a00: 03d7        lsls	r7, r2, #15
@   0x08028a02: 0000        movs	r0, r0
@   0x08028a04: 7fff        ldrb	r7, [r7, #31]
@   0x08028a06: 0000        movs	r0, r0
@   0x08028a08: 0818        lsrs	r0, r3, #32
@   0x08028a0a: 0000        movs	r0, r0
@   0x08028a0c: 1c28        adds	r0, r5, #0
@   0x08028a0e: 3022        adds	r0, #34	@ 0x22
@   0x08028a10: 00c1        lsls	r1, r0, #3
@   0x08028a12: 1a09        subs	r1, r1, r0
@   0x08028a14: 00c9        lsls	r1, r1, #3
@   0x08028a16: 1989        adds	r1, r1, r6
@   0x08028a18: 2001        movs	r0, #1
@   0x08028a1a: 7688        strb	r0, [r1, #26]
@   0x08028a1c: 4814        ldr	r0, [pc, #80]	@ (0x28a70)
@   0x08028a1e: 1c39        adds	r1, r7, #0
@   0x08028a20: f7dd        ffa4 	bl	0x696c
@   0x08028a24: 1c68        adds	r0, r5, #1
@   0x08028a26: 0600        lsls	r0, r0, #24
@   0x08028a28: 0e05        lsrs	r5, r0, #24
@   0x08028a2a: 2d02        cmp	r5, #2
@   0x08028a2c: d9aa        bls.n	0x28984
@   0x08028a2e: 4d11        ldr	r5, [pc, #68]	@ (0x28a74)
@   0x08028a30: 4811        ldr	r0, [pc, #68]	@ (0x28a78)
@   0x08028a32: 1829        adds	r1, r5, r0
@   0x08028a34: 2408        movs	r4, #8
@   0x08028a36: 1c20        adds	r0, r4, #0
@   0x08028a38: 8809        ldrh	r1, [r1, #0]
@   0x08028a3a: 4008        ands	r0, r1
@   0x08028a3c: 2800        cmp	r0, #0
@   0x08028a3e: d107        bne.n	0x28a50
@   0x08028a40: 2025        movs	r0, #37	@ 0x25
@   0x08028a42: 2126        movs	r1, #38	@ 0x26
@   0x08028a44: f7f8        face 	bl	0x20fe4
@   0x08028a48: 2025        movs	r0, #37	@ 0x25
@   0x08028a4a: 2126        movs	r1, #38	@ 0x26
@   0x08028a4c: f7dd        f960 	bl	0x5d10
@   0x08028a50: 4a0a        ldr	r2, [pc, #40]	@ (0x28a7c)
@   0x08028a52: 18a9        adds	r1, r5, r2
@   0x08028a54: 1c20        adds	r0, r4, #0
@   0x08028a56: 8809        ldrh	r1, [r1, #0]
@   0x08028a58: 4008        ands	r0, r1
@   0x08028a5a: 2800        cmp	r0, #0
@   0x08028a5c: d114        bne.n	0x28a88
@   0x08028a5e: 2027        movs	r0, #39	@ 0x27
@   0x08028a60: 2127        movs	r1, #39	@ 0x27
@   0x08028a62: f7f8        fabf 	bl	0x20fe4
@   0x08028a66: 2027        movs	r0, #39	@ 0x27
@   0x08028a68: 2127        movs	r1, #39	@ 0x27
@   0x08028a6a: f7dd        f951 	bl	0x5d10
@   0x08028a6e: e00b        b.n	0x28a88
@   0x08028a70: 6110        str	r0, [r2, #16]
@   0x08028a72: 0300        lsls	r0, r0, #12
@   0x08028a74: 3720        adds	r7, #32
@   0x08028a76: 0300        lsls	r0, r0, #12
@   0x08028a78: 084c        lsrs	r4, r1, #1
@   0x08028a7a: 0000        movs	r0, r0
@   0x08028a7c: 08bc        lsrs	r4, r7, #2
@   0x08028a7e: 0000        movs	r0, r0
@   0x08028a80: 2022        movs	r0, #34	@ 0x22
@   0x08028a82: 2124        movs	r1, #36	@ 0x24
@   0x08028a84: f7dd        f944 	bl	0x5d10
@   0x08028a88: b004        add	sp, #16
@   0x08028a8a: bc18        pop	{r3, r4}
@   0x08028a8c: 4698        mov	r8, r3
@   0x08028a8e: 46a1        mov	r9, r4
@   0x08028a90: bcf0        pop	{r4, r5, r6, r7}
@   0x08028a92: bc01        pop	{r0}
@   0x08028a94: 4700        bx	r0

        thumb_func_start sub_08028858
sub_08028858: @ 0x08028858
        .incbin "baserom.gba", 0x28858, 0x240
        thumb_func_end sub_08028858
