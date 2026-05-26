@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009984, 0x08009a58)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009984 --end 0x8009a58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009984: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009986: 4e25        ldr	r6, [pc, #148]	@ (0x9a1c)
@   0x08009988: 2004        movs	r0, #4
@   0x0800998a: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x0800998c: 4008        ands	r0, r1
@   0x0800998e: 2800        cmp	r0, #0
@   0x08009990: d15b        bne.n	0x9a4a
@   0x08009992: 4c23        ldr	r4, [pc, #140]	@ (0x9a20)
@   0x08009994: 7e20        ldrb	r0, [r4, #24]
@   0x08009996: 7e61        ldrb	r1, [r4, #25]
@   0x08009998: 2308        movs	r3, #8
@   0x0800999a: 5ee2        ldrsh	r2, [r4, r3]
@   0x0800999c: 250a        movs	r5, #10
@   0x0800999e: 5f63        ldrsh	r3, [r4, r5]
@   0x080099a0: f003        f9f2 	bl	0xcd88
@   0x080099a4: 0600        lsls	r0, r0, #24
@   0x080099a6: 0e05        lsrs	r5, r0, #24
@   0x080099a8: 1c28        adds	r0, r5, #0
@   0x080099aa: f016        fd7b 	bl	0x204a4
@   0x080099ae: 1c20        adds	r0, r4, #0
@   0x080099b0: 2110        movs	r1, #16
@   0x080099b2: f7fd        f8f7 	bl	0x6ba4
@   0x080099b6: 0600        lsls	r0, r0, #24
@   0x080099b8: 2800        cmp	r0, #0
@   0x080099ba: d002        beq.n	0x99c2
@   0x080099bc: 1c28        adds	r0, r5, #0
@   0x080099be: f7ff        ff61 	bl	0x9884
@   0x080099c2: 1c20        adds	r0, r4, #0
@   0x080099c4: 2140        movs	r1, #64	@ 0x40
@   0x080099c6: f7fd        f8ed 	bl	0x6ba4
@   0x080099ca: 0600        lsls	r0, r0, #24
@   0x080099cc: 2800        cmp	r0, #0
@   0x080099ce: d012        beq.n	0x99f6
@   0x080099d0: 7e20        ldrb	r0, [r4, #24]
@   0x080099d2: 7e61        ldrb	r1, [r4, #25]
@   0x080099d4: 2708        movs	r7, #8
@   0x080099d6: 5fe2        ldrsh	r2, [r4, r7]
@   0x080099d8: 270a        movs	r7, #10
@   0x080099da: 5fe3        ldrsh	r3, [r4, r7]
@   0x080099dc: f003        fa3a 	bl	0xce54
@   0x080099e0: 0600        lsls	r0, r0, #24
@   0x080099e2: 0e00        lsrs	r0, r0, #24
@   0x080099e4: 2801        cmp	r0, #1
@   0x080099e6: d100        bne.n	0x99ea
@   0x080099e8: 75f0        strb	r0, [r6, #23]
@   0x080099ea: 2802        cmp	r0, #2
@   0x080099ec: d100        bne.n	0x99f0
@   0x080099ee: 75f0        strb	r0, [r6, #23]
@   0x080099f0: 2803        cmp	r0, #3
@   0x080099f2: d100        bne.n	0x99f6
@   0x080099f4: 75f0        strb	r0, [r6, #23]
@   0x080099f6: 2d07        cmp	r5, #7
@   0x080099f8: d114        bne.n	0x9a24
@   0x080099fa: 4a09        ldr	r2, [pc, #36]	@ (0x9a20)
@   0x080099fc: 2002        movs	r0, #2
@   0x080099fe: 7b11        ldrb	r1, [r2, #12]
@   0x08009a00: 4008        ands	r0, r1
@   0x08009a02: 2800        cmp	r0, #0
@   0x08009a04: d10e        bne.n	0x9a24
@   0x08009a06: 4805        ldr	r0, [pc, #20]	@ (0x9a1c)
@   0x08009a08: 7e80        ldrb	r0, [r0, #26]
@   0x08009a0a: 2803        cmp	r0, #3
@   0x08009a0c: d80a        bhi.n	0x9a24
@   0x08009a0e: 2180        movs	r1, #128	@ 0x80
@   0x08009a10: 0109        lsls	r1, r1, #4
@   0x08009a12: 1c10        adds	r0, r2, #0
@   0x08009a14: f7fd        f8b8 	bl	0x6b88
@   0x08009a18: e017        b.n	0x9a4a
@   0x08009a1a: 0000        movs	r0, r0
@   0x08009a1c: 3720        adds	r7, #32
@   0x08009a1e: 0300        lsls	r0, r0, #12
@   0x08009a20: 35e0        adds	r5, #224	@ 0xe0
@   0x08009a22: 0300        lsls	r0, r0, #12
@   0x08009a24: 2d08        cmp	r5, #8
@   0x08009a26: d001        beq.n	0x9a2c
@   0x08009a28: 2d0b        cmp	r5, #11
@   0x08009a2a: d10e        bne.n	0x9a4a
@   0x08009a2c: 4a08        ldr	r2, [pc, #32]	@ (0x9a50)
@   0x08009a2e: 2002        movs	r0, #2
@   0x08009a30: 7b13        ldrb	r3, [r2, #12]
@   0x08009a32: 4018        ands	r0, r3
@   0x08009a34: 2800        cmp	r0, #0
@   0x08009a36: d108        bne.n	0x9a4a
@   0x08009a38: 4806        ldr	r0, [pc, #24]	@ (0x9a54)
@   0x08009a3a: 7e80        ldrb	r0, [r0, #26]
@   0x08009a3c: 2803        cmp	r0, #3
@   0x08009a3e: d804        bhi.n	0x9a4a
@   0x08009a40: 2180        movs	r1, #128	@ 0x80
@   0x08009a42: 0189        lsls	r1, r1, #6
@   0x08009a44: 1c10        adds	r0, r2, #0
@   0x08009a46: f7fd        f89f 	bl	0x6b88
@   0x08009a4a: bcf0        pop	{r4, r5, r6, r7}
@   0x08009a4c: bc01        pop	{r0}
@   0x08009a4e: 4700        bx	r0
@   0x08009a50: 35e0        adds	r5, #224	@ 0xe0
@   0x08009a52: 0300        lsls	r0, r0, #12
@   0x08009a54: 3720        adds	r7, #32
@   0x08009a56: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08009984
sub_08009984: @ 0x08009984
        .incbin "frog_us_baserom.gba", 0x9984, 0xd4
        thumb_func_end sub_08009984
