@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e060, 0x0800e174)  (276 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e060 --end 0x800e174 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e060: b500        push	{lr}
@   0x0800e062: b081        sub	sp, #4
@   0x0800e064: 4804        ldr	r0, [pc, #16]	@ (0xe078)
@   0x0800e066: 7a80        ldrb	r0, [r0, #10]
@   0x0800e068: 3801        subs	r0, #1
@   0x0800e06a: 280f        cmp	r0, #15
@   0x0800e06c: d82b        bhi.n	0xe0c6
@   0x0800e06e: 0080        lsls	r0, r0, #2
@   0x0800e070: 4902        ldr	r1, [pc, #8]	@ (0xe07c)
@   0x0800e072: 1840        adds	r0, r0, r1
@   0x0800e074: 6800        ldr	r0, [r0, #0]
@   0x0800e076: 4687        mov	pc, r0
@   0x0800e078: 5330        strh	r0, [r6, r4]
@   0x0800e07a: 0300        lsls	r0, r0, #12
@   0x0800e07c: e080        b.n	0xe180
@   0x0800e07e: 0800        lsrs	r0, r0, #32
@   0x0800e080: e0c6        b.n	0xe210
@   0x0800e082: 0800        lsrs	r0, r0, #32
@   0x0800e084: e0c6        b.n	0xe214
@   0x0800e086: 0800        lsrs	r0, r0, #32
@   0x0800e088: e0c0        b.n	0xe20c
@   0x0800e08a: 0800        lsrs	r0, r0, #32
@   0x0800e08c: e0c6        b.n	0xe21c
@   0x0800e08e: 0800        lsrs	r0, r0, #32
@   0x0800e090: e0c6        b.n	0xe220
@   0x0800e092: 0800        lsrs	r0, r0, #32
@   0x0800e094: e0c0        b.n	0xe218
@   0x0800e096: 0800        lsrs	r0, r0, #32
@   0x0800e098: e0c6        b.n	0xe228
@   0x0800e09a: 0800        lsrs	r0, r0, #32
@   0x0800e09c: e0c6        b.n	0xe22c
@   0x0800e09e: 0800        lsrs	r0, r0, #32
@   0x0800e0a0: e0c0        b.n	0xe224
@   0x0800e0a2: 0800        lsrs	r0, r0, #32
@   0x0800e0a4: e0c6        b.n	0xe234
@   0x0800e0a6: 0800        lsrs	r0, r0, #32
@   0x0800e0a8: e0c6        b.n	0xe238
@   0x0800e0aa: 0800        lsrs	r0, r0, #32
@   0x0800e0ac: e0c6        b.n	0xe23c
@   0x0800e0ae: 0800        lsrs	r0, r0, #32
@   0x0800e0b0: e0c6        b.n	0xe240
@   0x0800e0b2: 0800        lsrs	r0, r0, #32
@   0x0800e0b4: e0c6        b.n	0xe244
@   0x0800e0b6: 0800        lsrs	r0, r0, #32
@   0x0800e0b8: e0c0        b.n	0xe23c
@   0x0800e0ba: 0800        lsrs	r0, r0, #32
@   0x0800e0bc: e0c6        b.n	0xe24c
@   0x0800e0be: 0800        lsrs	r0, r0, #32
@   0x0800e0c0: 491e        ldr	r1, [pc, #120]	@ (0xe13c)
@   0x0800e0c2: 2000        movs	r0, #0
@   0x0800e0c4: 8008        strh	r0, [r1, #0]
@   0x0800e0c6: 4669        mov	r1, sp
@   0x0800e0c8: 4a1d        ldr	r2, [pc, #116]	@ (0xe140)
@   0x0800e0ca: 1c10        adds	r0, r2, #0
@   0x0800e0cc: 8008        strh	r0, [r1, #0]
@   0x0800e0ce: 4b1d        ldr	r3, [pc, #116]	@ (0xe144)
@   0x0800e0d0: 6019        str	r1, [r3, #0]
@   0x0800e0d2: 481d        ldr	r0, [pc, #116]	@ (0xe148)
@   0x0800e0d4: 6058        str	r0, [r3, #4]
@   0x0800e0d6: 481d        ldr	r0, [pc, #116]	@ (0xe14c)
@   0x0800e0d8: 6098        str	r0, [r3, #8]
@   0x0800e0da: 6898        ldr	r0, [r3, #8]
@   0x0800e0dc: 491c        ldr	r1, [pc, #112]	@ (0xe150)
@   0x0800e0de: 2201        movs	r2, #1
@   0x0800e0e0: 700a        strb	r2, [r1, #0]
@   0x0800e0e2: 2003        movs	r0, #3
@   0x0800e0e4: 7108        strb	r0, [r1, #4]
@   0x0800e0e6: 720a        strb	r2, [r1, #8]
@   0x0800e0e8: 2009        movs	r0, #9
@   0x0800e0ea: 7308        strb	r0, [r1, #12]
@   0x0800e0ec: 7408        strb	r0, [r1, #16]
@   0x0800e0ee: 4819        ldr	r0, [pc, #100]	@ (0xe154)
@   0x0800e0f0: 7002        strb	r2, [r0, #0]
@   0x0800e0f2: 4819        ldr	r0, [pc, #100]	@ (0xe158)
@   0x0800e0f4: 6018        str	r0, [r3, #0]
@   0x0800e0f6: 4a19        ldr	r2, [pc, #100]	@ (0xe15c)
@   0x0800e0f8: 605a        str	r2, [r3, #4]
@   0x0800e0fa: 4819        ldr	r0, [pc, #100]	@ (0xe160)
@   0x0800e0fc: 6098        str	r0, [r3, #8]
@   0x0800e0fe: 6898        ldr	r0, [r3, #8]
@   0x0800e100: 4818        ldr	r0, [pc, #96]	@ (0xe164)
@   0x0800e102: 6800        ldr	r0, [r0, #0]
@   0x0800e104: 2800        cmp	r0, #0
@   0x0800e106: d009        beq.n	0xe11c
@   0x0800e108: 4917        ldr	r1, [pc, #92]	@ (0xe168)
@   0x0800e10a: 3801        subs	r0, #1
@   0x0800e10c: 0080        lsls	r0, r0, #2
@   0x0800e10e: 1840        adds	r0, r0, r1
@   0x0800e110: 6800        ldr	r0, [r0, #0]
@   0x0800e112: 6018        str	r0, [r3, #0]
@   0x0800e114: 605a        str	r2, [r3, #4]
@   0x0800e116: 4815        ldr	r0, [pc, #84]	@ (0xe16c)
@   0x0800e118: 6098        str	r0, [r3, #8]
@   0x0800e11a: 6898        ldr	r0, [r3, #8]
@   0x0800e11c: f012        fd20 	bl	0x20b60
@   0x0800e120: 2003        movs	r0, #3
@   0x0800e122: f012        fda9 	bl	0x20c78
@   0x0800e126: 4812        ldr	r0, [pc, #72]	@ (0xe170)
@   0x0800e128: 2101        movs	r1, #1
@   0x0800e12a: 7e02        ldrb	r2, [r0, #24]
@   0x0800e12c: 4311        orrs	r1, r2
@   0x0800e12e: 7601        strb	r1, [r0, #24]
@   0x0800e130: 2106        movs	r1, #6
@   0x0800e132: 6041        str	r1, [r0, #4]
@   0x0800e134: b001        add	sp, #4
@   0x0800e136: bc01        pop	{r0}
@   0x0800e138: 4700        bx	r0
@   0x0800e13a: 0000        movs	r0, r0
@   0x0800e13c: 0050        lsls	r0, r2, #1
@   0x0800e13e: 0400        lsls	r0, r0, #16
@   0x0800e140: f039        0000 	bics.w	r0, r9, #0
@   0x0800e144: 00d4        lsls	r4, r2, #3
@   0x0800e146: 0400        lsls	r0, r0, #16
@   0x0800e148: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800e14c: 0400        lsls	r0, r0, #16
@   0x0800e14e: 8100        strh	r0, [r0, #8]
@   0x0800e150: 5370        strh	r0, [r6, r5]
@   0x0800e152: 0300        lsls	r0, r0, #12
@   0x0800e154: 5328        strh	r0, [r5, r4]
@   0x0800e156: 0300        lsls	r0, r0, #12
@   0x0800e158: 3ab6        subs	r2, #182	@ 0xb6
@   0x0800e15a: 080e        lsrs	r6, r1, #32
@   0x0800e15c: 8000        strh	r0, [r0, #0]
@   0x0800e15e: 0600        lsls	r0, r0, #24
@   0x0800e160: 2000        movs	r0, #0
@   0x0800e162: 8000        strh	r0, [r0, #0]
@   0x0800e164: 34b0        adds	r4, #176	@ 0xb0
@   0x0800e166: 0300        lsls	r0, r0, #12
@   0x0800e168: 8fac        ldrh	r4, [r5, #60]	@ 0x3c
@   0x0800e16a: 0830        lsrs	r0, r6, #32
@   0x0800e16c: 0a00        lsrs	r0, r0, #8
@   0x0800e16e: 8000        strh	r0, [r0, #0]
@   0x0800e170: 5330        strh	r0, [r6, r4]
@   0x0800e172: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800E060
sub_0800E060: @ 0x0800e060
        .incbin "frog_us_baserom.gba", 0xe060, 0x114
        thumb_func_end sub_0800E060
