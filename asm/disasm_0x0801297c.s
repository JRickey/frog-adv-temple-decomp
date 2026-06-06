@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801297c, 0x08012a6c)  (240 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801297c --end 0x8012a6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801297c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801297e: 464f        mov	r7, r9
@   0x08012980: 4646        mov	r6, r8
@   0x08012982: b4c0        push	{r6, r7}
@   0x08012984: 4b27        ldr	r3, [pc, #156]	@ (0x12a24)
@   0x08012986: 1c1c        adds	r4, r3, #0
@   0x08012988: 3420        adds	r4, #32
@   0x0801298a: 4927        ldr	r1, [pc, #156]	@ (0x12a28)
@   0x0801298c: 4a27        ldr	r2, [pc, #156]	@ (0x12a2c)
@   0x0801298e: 1888        adds	r0, r1, r2
@   0x08012990: 2700        movs	r7, #0
@   0x08012992: 5fc0        ldrsh	r0, [r0, r7]
@   0x08012994: 0042        lsls	r2, r0, #1
@   0x08012996: 1812        adds	r2, r2, r0
@   0x08012998: 0412        lsls	r2, r2, #16
@   0x0801299a: 4825        ldr	r0, [pc, #148]	@ (0x12a30)
@   0x0801299c: 1809        adds	r1, r1, r0
@   0x0801299e: 2700        movs	r7, #0
@   0x080129a0: 5fc9        ldrsh	r1, [r1, r7]
@   0x080129a2: 0048        lsls	r0, r1, #1
@   0x080129a4: 1840        adds	r0, r0, r1
@   0x080129a6: 0400        lsls	r0, r0, #16
@   0x080129a8: 0c00        lsrs	r0, r0, #16
@   0x080129aa: 4684        mov	ip, r0
@   0x080129ac: 0c12        lsrs	r2, r2, #16
@   0x080129ae: 4690        mov	r8, r2
@   0x080129b0: 7f1d        ldrb	r5, [r3, #28]
@   0x080129b2: 7f98        ldrb	r0, [r3, #30]
@   0x080129b4: 4681        mov	r9, r0
@   0x080129b6: 6a9e        ldr	r6, [r3, #40]	@ 0x28
@   0x080129b8: 7824        ldrb	r4, [r4, #0]
@   0x080129ba: 0923        lsrs	r3, r4, #4
@   0x080129bc: 2101        movs	r1, #1
@   0x080129be: 1c18        adds	r0, r3, #0
@   0x080129c0: 4008        ands	r0, r1
@   0x080129c2: 2280        movs	r2, #128	@ 0x80
@   0x080129c4: 0492        lsls	r2, r2, #18
@   0x080129c6: 2800        cmp	r0, #0
@   0x080129c8: d000        beq.n	0x129cc
@   0x080129ca: 4a1a        ldr	r2, [pc, #104]	@ (0x12a34)
@   0x080129cc: 4c1a        ldr	r4, [pc, #104]	@ (0x12a38)
@   0x080129ce: 8b61        ldrh	r1, [r4, #26]
@   0x080129d0: 4660        mov	r0, ip
@   0x080129d2: 4348        muls	r0, r1
@   0x080129d4: 4440        add	r0, r8
@   0x080129d6: 0040        lsls	r0, r0, #1
@   0x080129d8: 1812        adds	r2, r2, r0
@   0x080129da: 68b1        ldr	r1, [r6, #8]
@   0x080129dc: 2000        movs	r0, #0
@   0x080129de: 1c1e        adds	r6, r3, #0
@   0x080129e0: 4548        cmp	r0, r9
@   0x080129e2: d216        bcs.n	0x12a12
@   0x080129e4: 46a4        mov	ip, r4
@   0x080129e6: 2300        movs	r3, #0
@   0x080129e8: 1c44        adds	r4, r0, #1
@   0x080129ea: 42ab        cmp	r3, r5
@   0x080129ec: d208        bcs.n	0x12a00
@   0x080129ee: 8808        ldrh	r0, [r1, #0]
@   0x080129f0: 8010        strh	r0, [r2, #0]
@   0x080129f2: 3102        adds	r1, #2
@   0x080129f4: 3202        adds	r2, #2
@   0x080129f6: 1c58        adds	r0, r3, #1
@   0x080129f8: 0600        lsls	r0, r0, #24
@   0x080129fa: 0e03        lsrs	r3, r0, #24
@   0x080129fc: 42ab        cmp	r3, r5
@   0x080129fe: d3f6        bcc.n	0x129ee
@   0x08012a00: 4663        mov	r3, ip
@   0x08012a02: 8b5b        ldrh	r3, [r3, #26]
@   0x08012a04: 1b58        subs	r0, r3, r5
@   0x08012a06: 0040        lsls	r0, r0, #1
@   0x08012a08: 1812        adds	r2, r2, r0
@   0x08012a0a: 0620        lsls	r0, r4, #24
@   0x08012a0c: 0e00        lsrs	r0, r0, #24
@   0x08012a0e: 4548        cmp	r0, r9
@   0x08012a10: d3e9        bcc.n	0x129e6
@   0x08012a12: 2101        movs	r1, #1
@   0x08012a14: 1c30        adds	r0, r6, #0
@   0x08012a16: 4008        ands	r0, r1
@   0x08012a18: 2800        cmp	r0, #0
@   0x08012a1a: d011        beq.n	0x12a40
@   0x08012a1c: 4905        ldr	r1, [pc, #20]	@ (0x12a34)
@   0x08012a1e: 4a07        ldr	r2, [pc, #28]	@ (0x12a3c)
@   0x08012a20: e011        b.n	0x12a46
@   0x08012a22: 0000        movs	r0, r0
@   0x08012a24: 6e64        ldr	r4, [r4, #100]	@ 0x64
@   0x08012a26: 0830        lsrs	r0, r6, #32
@   0x08012a28: 3720        adds	r7, #32
@   0x08012a2a: 0300        lsls	r0, r0, #12
@   0x08012a2c: 0692        lsls	r2, r2, #26
@   0x08012a2e: 0000        movs	r0, r0
@   0x08012a30: 0694        lsls	r4, r2, #26
@   0x08012a32: 0000        movs	r0, r0
@   0x08012a34: 0000        movs	r0, r0
@   0x08012a36: 0201        lsls	r1, r0, #8
@   0x08012a38: 60a0        str	r0, [r4, #8]
@   0x08012a3a: 0300        lsls	r0, r0, #12
@   0x08012a3c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08012a40: 2180        movs	r1, #128	@ 0x80
@   0x08012a42: 0489        lsls	r1, r1, #18
@   0x08012a44: 4a07        ldr	r2, [pc, #28]	@ (0x12a64)
@   0x08012a46: 2001        movs	r0, #1
@   0x08012a48: 4006        ands	r6, r0
@   0x08012a4a: 1c30        adds	r0, r6, #0
@   0x08012a4c: f7fd        fb4a 	bl	0x100e4
@   0x08012a50: 4905        ldr	r1, [pc, #20]	@ (0x12a68)
@   0x08012a52: 2000        movs	r0, #0
@   0x08012a54: 7288        strb	r0, [r1, #10]
@   0x08012a56: bc18        pop	{r3, r4}
@   0x08012a58: 4698        mov	r8, r3
@   0x08012a5a: 46a1        mov	r9, r4
@   0x08012a5c: bcf0        pop	{r4, r5, r6, r7}
@   0x08012a5e: bc01        pop	{r0}
@   0x08012a60: 4700        bx	r0
@   0x08012a62: 0000        movs	r0, r0
@   0x08012a64: e000        b.n	0x12a68
@   0x08012a66: 0600        lsls	r0, r0, #24
@   0x08012a68: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012a6a: 0300        lsls	r0, r0, #12

        thumb_func_start BlitEntityTileFrame2
BlitEntityTileFrame2: @ 0x0801297c
        .incbin "frog_us_baserom.gba", 0x1297c, 0xf0
        thumb_func_end BlitEntityTileFrame2
