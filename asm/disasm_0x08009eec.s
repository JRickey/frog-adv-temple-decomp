@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009eec, 0x0800a05c)  (368 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009eec --end 0x800a05c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009eec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009eee: 4647        mov	r7, r8
@   0x08009ef0: b480        push	{r7}
@   0x08009ef2: 1c07        adds	r7, r0, #0
@   0x08009ef4: 0609        lsls	r1, r1, #24
@   0x08009ef6: 0e0c        lsrs	r4, r1, #24
@   0x08009ef8: f7f6        fae4 	bl	0x4c4
@   0x08009efc: 490b        ldr	r1, [pc, #44]	@ (0x9f2c)
@   0x08009efe: 8008        strh	r0, [r1, #0]
@   0x08009f00: 783b        ldrb	r3, [r7, #0]
@   0x08009f02: 2000        movs	r0, #0
@   0x08009f04: 5638        ldrsb	r0, [r7, r0]
@   0x08009f06: 2800        cmp	r0, #0
@   0x08009f08: d116        bne.n	0x9f38
@   0x08009f0a: 4909        ldr	r1, [pc, #36]	@ (0x9f30)
@   0x08009f0c: 6808        ldr	r0, [r1, #0]
@   0x08009f0e: 6148        str	r0, [r1, #20]
@   0x08009f10: 2001        movs	r0, #1
@   0x08009f12: 7038        strb	r0, [r7, #0]
@   0x08009f14: 1c20        adds	r0, r4, #0
@   0x08009f16: f013        f897 	bl	0x1d048
@   0x08009f1a: 4806        ldr	r0, [pc, #24]	@ (0x9f34)
@   0x08009f1c: 7e81        ldrb	r1, [r0, #26]
@   0x08009f1e: 311d        adds	r1, #29
@   0x08009f20: 7681        strb	r1, [r0, #26]
@   0x08009f22: 2102        movs	r1, #2
@   0x08009f24: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x08009f26: 4311        orrs	r1, r2
@   0x08009f28: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08009f2a: e013        b.n	0x9f54
@   0x08009f2c: 5398        strh	r0, [r3, r6]
@   0x08009f2e: 0300        lsls	r0, r0, #12
@   0x08009f30: 5330        strh	r0, [r6, r4]
@   0x08009f32: 0300        lsls	r0, r0, #12
@   0x08009f34: 3720        adds	r7, #32
@   0x08009f36: 0300        lsls	r0, r0, #12
@   0x08009f38: 4a38        ldr	r2, [pc, #224]	@ (0xa01c)
@   0x08009f3a: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08009f3c: 2080        movs	r0, #128	@ 0x80
@   0x08009f3e: 0200        lsls	r0, r0, #8
@   0x08009f40: 4008        ands	r0, r1
@   0x08009f42: 2800        cmp	r0, #0
@   0x08009f44: d006        beq.n	0x9f54
@   0x08009f46: 2002        movs	r0, #2
@   0x08009f48: 4308        orrs	r0, r1
@   0x08009f4a: 4935        ldr	r1, [pc, #212]	@ (0xa020)
@   0x08009f4c: 4008        ands	r0, r1
@   0x08009f4e: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08009f50: 1c58        adds	r0, r3, #1
@   0x08009f52: 7038        strb	r0, [r7, #0]
@   0x08009f54: 4831        ldr	r0, [pc, #196]	@ (0xa01c)
@   0x08009f56: 4680        mov	r8, r0
@   0x08009f58: f7fb        fd34 	bl	0x59c4
@   0x08009f5c: 4931        ldr	r1, [pc, #196]	@ (0xa024)
@   0x08009f5e: 4d32        ldr	r5, [pc, #200]	@ (0xa028)
@   0x08009f60: 7aaa        ldrb	r2, [r5, #10]
@   0x08009f62: 0090        lsls	r0, r2, #2
@   0x08009f64: 1840        adds	r0, r0, r1
@   0x08009f66: 6800        ldr	r0, [r0, #0]
@   0x08009f68: f029        feb6 	bl	0x33cd8
@   0x08009f6c: 492f        ldr	r1, [pc, #188]	@ (0xa02c)
@   0x08009f6e: 7aaa        ldrb	r2, [r5, #10]
@   0x08009f70: 0090        lsls	r0, r2, #2
@   0x08009f72: 1840        adds	r0, r0, r1
@   0x08009f74: 6800        ldr	r0, [r0, #0]
@   0x08009f76: f029        feaf 	bl	0x33cd8
@   0x08009f7a: 4c2d        ldr	r4, [pc, #180]	@ (0xa030)
@   0x08009f7c: 7aa9        ldrb	r1, [r5, #10]
@   0x08009f7e: 1908        adds	r0, r1, r4
@   0x08009f80: 7800        ldrb	r0, [r0, #0]
@   0x08009f82: f005        f963 	bl	0xf24c
@   0x08009f86: f7ff        fd67 	bl	0x9a58
@   0x08009f8a: f7ff        f8fd 	bl	0x9188
@   0x08009f8e: f7f6        fca5 	bl	0x8dc
@   0x08009f92: 4e28        ldr	r6, [pc, #160]	@ (0xa034)
@   0x08009f94: 8831        ldrh	r1, [r6, #0]
@   0x08009f96: 4828        ldr	r0, [pc, #160]	@ (0xa038)
@   0x08009f98: 4008        ands	r0, r1
@   0x08009f9a: 8030        strh	r0, [r6, #0]
@   0x08009f9c: 7aad        ldrb	r5, [r5, #10]
@   0x08009f9e: 192c        adds	r4, r5, r4
@   0x08009fa0: 7820        ldrb	r0, [r4, #0]
@   0x08009fa2: f005        fe91 	bl	0xfcc8
@   0x08009fa6: f7fc        f80f 	bl	0x5fc8
@   0x08009faa: 4824        ldr	r0, [pc, #144]	@ (0xa03c)
@   0x08009fac: 21e0        movs	r1, #224	@ 0xe0
@   0x08009fae: 04c9        lsls	r1, r1, #19
@   0x08009fb0: 2280        movs	r2, #128	@ 0x80
@   0x08009fb2: 0052        lsls	r2, r2, #1
@   0x08009fb4: f023        fad0 	bl	0x2d558
@   0x08009fb8: 4921        ldr	r1, [pc, #132]	@ (0xa040)
@   0x08009fba: 4a22        ldr	r2, [pc, #136]	@ (0xa044)
@   0x08009fbc: 8810        ldrh	r0, [r2, #0]
@   0x08009fbe: 8008        strh	r0, [r1, #0]
@   0x08009fc0: 3102        adds	r1, #2
@   0x08009fc2: 8850        ldrh	r0, [r2, #2]
@   0x08009fc4: 8008        strh	r0, [r1, #0]
@   0x08009fc6: 3102        adds	r1, #2
@   0x08009fc8: 8890        ldrh	r0, [r2, #4]
@   0x08009fca: 8008        strh	r0, [r1, #0]
@   0x08009fcc: 3102        adds	r1, #2
@   0x08009fce: 88d0        ldrh	r0, [r2, #6]
@   0x08009fd0: 8008        strh	r0, [r1, #0]
@   0x08009fd2: 3102        adds	r1, #2
@   0x08009fd4: 8910        ldrh	r0, [r2, #8]
@   0x08009fd6: 8008        strh	r0, [r1, #0]
@   0x08009fd8: 3102        adds	r1, #2
@   0x08009fda: 8950        ldrh	r0, [r2, #10]
@   0x08009fdc: 8008        strh	r0, [r1, #0]
@   0x08009fde: 8830        ldrh	r0, [r6, #0]
@   0x08009fe0: 2101        movs	r1, #1
@   0x08009fe2: 4308        orrs	r0, r1
@   0x08009fe4: 8030        strh	r0, [r6, #0]
@   0x08009fe6: 783f        ldrb	r7, [r7, #0]
@   0x08009fe8: 2f08        cmp	r7, #8
@   0x08009fea: d003        beq.n	0x9ff4
@   0x08009fec: 4816        ldr	r0, [pc, #88]	@ (0xa048)
@   0x08009fee: 8800        ldrh	r0, [r0, #0]
@   0x08009ff0: 2800        cmp	r0, #0
@   0x08009ff2: d02d        beq.n	0xa050
@   0x08009ff4: 4642        mov	r2, r8
@   0x08009ff6: 7e90        ldrb	r0, [r2, #26]
@   0x08009ff8: 281c        cmp	r0, #28
@   0x08009ffa: d905        bls.n	0xa008
@   0x08009ffc: 381d        subs	r0, #29
@   0x08009ffe: 7690        strb	r0, [r2, #26]
@   0x0800a000: 2002        movs	r0, #2
@   0x0800a002: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0800a004: 4308        orrs	r0, r1
@   0x0800a006: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0800a008: 480f        ldr	r0, [pc, #60]	@ (0xa048)
@   0x0800a00a: 8801        ldrh	r1, [r0, #0]
@   0x0800a00c: 2900        cmp	r1, #0
@   0x0800a00e: d001        beq.n	0xa014
@   0x0800a010: 480e        ldr	r0, [pc, #56]	@ (0xa04c)
@   0x0800a012: 8241        strh	r1, [r0, #18]
@   0x0800a014: f013        f83e 	bl	0x1d094
@   0x0800a018: 2001        movs	r0, #1
@   0x0800a01a: e01a        b.n	0xa052
@   0x0800a01c: 3720        adds	r7, #32
@   0x0800a01e: 0300        lsls	r0, r0, #12
@   0x0800a020: 7fff        ldrb	r7, [r7, #31]
@   0x0800a022: 0000        movs	r0, r0
@   0x0800a024: 0cb8        lsrs	r0, r7, #18
@   0x0800a026: 080c        lsrs	r4, r1, #32
@   0x0800a028: 5330        strh	r0, [r6, r4]
@   0x0800a02a: 0300        lsls	r0, r0, #12
@   0x0800a02c: 0d40        lsrs	r0, r0, #21
@   0x0800a02e: 080c        lsrs	r4, r1, #32
@   0x0800a030: 0d84        lsrs	r4, r0, #22
@   0x0800a032: 080c        lsrs	r4, r1, #32
@   0x0800a034: 0200        lsls	r0, r0, #8
@   0x0800a036: 0400        lsls	r0, r0, #16
@   0x0800a038: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x0800a03c: 54a0        strb	r0, [r4, r2]
@   0x0800a03e: 0300        lsls	r0, r0, #12
@   0x0800a040: 0010        movs	r0, r2
@   0x0800a042: 0400        lsls	r0, r0, #16
@   0x0800a044: 3550        adds	r5, #80	@ 0x50
@   0x0800a046: 0300        lsls	r0, r0, #12
@   0x0800a048: 5398        strh	r0, [r3, r6]
@   0x0800a04a: 0300        lsls	r0, r0, #12
@   0x0800a04c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a04e: 0300        lsls	r0, r0, #12
@   0x0800a050: 2000        movs	r0, #0
@   0x0800a052: bc08        pop	{r3}
@   0x0800a054: 4698        mov	r8, r3
@   0x0800a056: bcf0        pop	{r4, r5, r6, r7}
@   0x0800a058: bc02        pop	{r1}
@   0x0800a05a: 4708        bx	r1

        thumb_func_start sub_08009EEC
sub_08009EEC: @ 0x08009eec
        .incbin "frog_us_baserom.gba", 0x9eec, 0x170
        thumb_func_end sub_08009EEC
