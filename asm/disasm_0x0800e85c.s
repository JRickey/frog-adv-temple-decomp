@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e85c, 0x0800eb1c)  (704 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e85c --end 0x800eb1c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e85c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800e85e: 4657        mov	r7, sl
@   0x0800e860: 464e        mov	r6, r9
@   0x0800e862: 4645        mov	r5, r8
@   0x0800e864: b4e0        push	{r5, r6, r7}
@   0x0800e866: b081        sub	sp, #4
@   0x0800e868: 0600        lsls	r0, r0, #24
@   0x0800e86a: 0e00        lsrs	r0, r0, #24
@   0x0800e86c: 4681        mov	r9, r0
@   0x0800e86e: 4668        mov	r0, sp
@   0x0800e870: 2200        movs	r2, #0
@   0x0800e872: 8002        strh	r2, [r0, #0]
@   0x0800e874: 4b1c        ldr	r3, [pc, #112]	@ (0xe8e8)
@   0x0800e876: 6018        str	r0, [r3, #0]
@   0x0800e878: 2080        movs	r0, #128	@ 0x80
@   0x0800e87a: 0480        lsls	r0, r0, #18
@   0x0800e87c: 6058        str	r0, [r3, #4]
@   0x0800e87e: 491b        ldr	r1, [pc, #108]	@ (0xe8ec)
@   0x0800e880: 6099        str	r1, [r3, #8]
@   0x0800e882: 6898        ldr	r0, [r3, #8]
@   0x0800e884: 4668        mov	r0, sp
@   0x0800e886: 8002        strh	r2, [r0, #0]
@   0x0800e888: 6018        str	r0, [r3, #0]
@   0x0800e88a: 20c0        movs	r0, #192	@ 0xc0
@   0x0800e88c: 04c0        lsls	r0, r0, #19
@   0x0800e88e: 6058        str	r0, [r3, #4]
@   0x0800e890: 6099        str	r1, [r3, #8]
@   0x0800e892: 6898        ldr	r0, [r3, #8]
@   0x0800e894: 4668        mov	r0, sp
@   0x0800e896: 8002        strh	r2, [r0, #0]
@   0x0800e898: 6018        str	r0, [r3, #0]
@   0x0800e89a: 20a0        movs	r0, #160	@ 0xa0
@   0x0800e89c: 04c0        lsls	r0, r0, #19
@   0x0800e89e: 6058        str	r0, [r3, #4]
@   0x0800e8a0: 6099        str	r1, [r3, #8]
@   0x0800e8a2: 6898        ldr	r0, [r3, #8]
@   0x0800e8a4: 2700        movs	r7, #0
@   0x0800e8a6: 454f        cmp	r7, r9
@   0x0800e8a8: d300        bcc.n	0xe8ac
@   0x0800e8aa: e0c1        b.n	0xea30
@   0x0800e8ac: 4810        ldr	r0, [pc, #64]	@ (0xe8f0)
@   0x0800e8ae: 4680        mov	r8, r0
@   0x0800e8b0: 4d10        ldr	r5, [pc, #64]	@ (0xe8f4)
@   0x0800e8b2: 1c1c        adds	r4, r3, #0
@   0x0800e8b4: 4810        ldr	r0, [pc, #64]	@ (0xe8f8)
@   0x0800e8b6: 0179        lsls	r1, r7, #5
@   0x0800e8b8: 1809        adds	r1, r1, r0
@   0x0800e8ba: 7aaa        ldrb	r2, [r5, #10]
@   0x0800e8bc: 0050        lsls	r0, r2, #1
@   0x0800e8be: 1880        adds	r0, r0, r2
@   0x0800e8c0: 19c0        adds	r0, r0, r7
@   0x0800e8c2: 0100        lsls	r0, r0, #4
@   0x0800e8c4: 4440        add	r0, r8
@   0x0800e8c6: 8980        ldrh	r0, [r0, #12]
@   0x0800e8c8: 8308        strh	r0, [r1, #24]
@   0x0800e8ca: 7aaa        ldrb	r2, [r5, #10]
@   0x0800e8cc: 0050        lsls	r0, r2, #1
@   0x0800e8ce: 1880        adds	r0, r0, r2
@   0x0800e8d0: 19c0        adds	r0, r0, r7
@   0x0800e8d2: 0100        lsls	r0, r0, #4
@   0x0800e8d4: 4440        add	r0, r8
@   0x0800e8d6: 89c0        ldrh	r0, [r0, #14]
@   0x0800e8d8: 8348        strh	r0, [r1, #26]
@   0x0800e8da: 2f01        cmp	r7, #1
@   0x0800e8dc: d04e        beq.n	0xe97c
@   0x0800e8de: 2f01        cmp	r7, #1
@   0x0800e8e0: dc0c        bgt.n	0xe8fc
@   0x0800e8e2: 2f00        cmp	r7, #0
@   0x0800e8e4: d00d        beq.n	0xe902
@   0x0800e8e6: e09d        b.n	0xea24
@   0x0800e8e8: 00d4        lsls	r4, r2, #3
@   0x0800e8ea: 0400        lsls	r0, r0, #16
@   0x0800e8ec: 0002        movs	r2, r0
@   0x0800e8ee: 8100        strh	r0, [r0, #8]
@   0x0800e8f0: 3190        adds	r1, #144	@ 0x90
@   0x0800e8f2: 080e        lsrs	r6, r1, #32
@   0x0800e8f4: 5330        strh	r0, [r6, r4]
@   0x0800e8f6: 0300        lsls	r0, r0, #12
@   0x0800e8f8: 60a0        str	r0, [r4, #8]
@   0x0800e8fa: 0300        lsls	r0, r0, #12
@   0x0800e8fc: 2f02        cmp	r7, #2
@   0x0800e8fe: d061        beq.n	0xe9c4
@   0x0800e900: e090        b.n	0xea24
@   0x0800e902: 7aa9        ldrb	r1, [r5, #10]
@   0x0800e904: 0048        lsls	r0, r1, #1
@   0x0800e906: 1840        adds	r0, r0, r1
@   0x0800e908: 0100        lsls	r0, r0, #4
@   0x0800e90a: 4440        add	r0, r8
@   0x0800e90c: 6800        ldr	r0, [r0, #0]
@   0x0800e90e: 2800        cmp	r0, #0
@   0x0800e910: d000        beq.n	0xe914
@   0x0800e912: 4682        mov	sl, r0
@   0x0800e914: 4650        mov	r0, sl
@   0x0800e916: 2180        movs	r1, #128	@ 0x80
@   0x0800e918: 0489        lsls	r1, r1, #18
@   0x0800e91a: f01e        fe25 	bl	0x2d568
@   0x0800e91e: 4913        ldr	r1, [pc, #76]	@ (0xe96c)
@   0x0800e920: 2280        movs	r2, #128	@ 0x80
@   0x0800e922: 0492        lsls	r2, r2, #18
@   0x0800e924: 600a        str	r2, [r1, #0]
@   0x0800e926: 23c0        movs	r3, #192	@ 0xc0
@   0x0800e928: 04db        lsls	r3, r3, #19
@   0x0800e92a: 604b        str	r3, [r1, #4]
@   0x0800e92c: 4a10        ldr	r2, [pc, #64]	@ (0xe970)
@   0x0800e92e: 608a        str	r2, [r1, #8]
@   0x0800e930: 6888        ldr	r0, [r1, #8]
@   0x0800e932: 7aa8        ldrb	r0, [r5, #10]
@   0x0800e934: 280d        cmp	r0, #13
@   0x0800e936: d10a        bne.n	0xe94e
@   0x0800e938: 0040        lsls	r0, r0, #1
@   0x0800e93a: 4684        mov	ip, r0
@   0x0800e93c: 7aa8        ldrb	r0, [r5, #10]
@   0x0800e93e: 4460        add	r0, ip
@   0x0800e940: 0100        lsls	r0, r0, #4
@   0x0800e942: 4440        add	r0, r8
@   0x0800e944: 6800        ldr	r0, [r0, #0]
@   0x0800e946: 6008        str	r0, [r1, #0]
@   0x0800e948: 604b        str	r3, [r1, #4]
@   0x0800e94a: 608a        str	r2, [r1, #8]
@   0x0800e94c: 6888        ldr	r0, [r1, #8]
@   0x0800e94e: 7aa9        ldrb	r1, [r5, #10]
@   0x0800e950: 0048        lsls	r0, r1, #1
@   0x0800e952: 1840        adds	r0, r0, r1
@   0x0800e954: 0100        lsls	r0, r0, #4
@   0x0800e956: 4641        mov	r1, r8
@   0x0800e958: 3108        adds	r1, #8
@   0x0800e95a: 1840        adds	r0, r0, r1
@   0x0800e95c: 6800        ldr	r0, [r0, #0]
@   0x0800e95e: 2180        movs	r1, #128	@ 0x80
@   0x0800e960: 0489        lsls	r1, r1, #18
@   0x0800e962: f01e        fe01 	bl	0x2d568
@   0x0800e966: 4903        ldr	r1, [pc, #12]	@ (0xe974)
@   0x0800e968: 4a03        ldr	r2, [pc, #12]	@ (0xe978)
@   0x0800e96a: e059        b.n	0xea20
@   0x0800e96c: 00d4        lsls	r4, r2, #3
@   0x0800e96e: 0400        lsls	r0, r0, #16
@   0x0800e970: 4000        ands	r0, r0
@   0x0800e972: 8000        strh	r0, [r0, #0]
@   0x0800e974: 0008        movs	r0, r1
@   0x0800e976: 0400        lsls	r0, r0, #16
@   0x0800e978: 1c03        adds	r3, r0, #0
@   0x0800e97a: 0000        movs	r0, r0
@   0x0800e97c: 7aa9        ldrb	r1, [r5, #10]
@   0x0800e97e: 0048        lsls	r0, r1, #1
@   0x0800e980: 1840        adds	r0, r0, r1
@   0x0800e982: 3001        adds	r0, #1
@   0x0800e984: 0101        lsls	r1, r0, #4
@   0x0800e986: 4642        mov	r2, r8
@   0x0800e988: 1888        adds	r0, r1, r2
@   0x0800e98a: 6800        ldr	r0, [r0, #0]
@   0x0800e98c: 2800        cmp	r0, #0
@   0x0800e98e: d005        beq.n	0xe99c
@   0x0800e990: 6020        str	r0, [r4, #0]
@   0x0800e992: 4807        ldr	r0, [pc, #28]	@ (0xe9b0)
@   0x0800e994: 6060        str	r0, [r4, #4]
@   0x0800e996: 4807        ldr	r0, [pc, #28]	@ (0xe9b4)
@   0x0800e998: 60a0        str	r0, [r4, #8]
@   0x0800e99a: 68a0        ldr	r0, [r4, #8]
@   0x0800e99c: 4640        mov	r0, r8
@   0x0800e99e: 3008        adds	r0, #8
@   0x0800e9a0: 1808        adds	r0, r1, r0
@   0x0800e9a2: 6800        ldr	r0, [r0, #0]
@   0x0800e9a4: 4904        ldr	r1, [pc, #16]	@ (0xe9b8)
@   0x0800e9a6: f01e        fddf 	bl	0x2d568
@   0x0800e9aa: 4904        ldr	r1, [pc, #16]	@ (0xe9bc)
@   0x0800e9ac: 4a04        ldr	r2, [pc, #16]	@ (0xe9c0)
@   0x0800e9ae: e037        b.n	0xea20
@   0x0800e9b0: 8000        strh	r0, [r0, #0]
@   0x0800e9b2: 0600        lsls	r0, r0, #24
@   0x0800e9b4: 2000        movs	r0, #0
@   0x0800e9b6: 8000        strh	r0, [r0, #0]
@   0x0800e9b8: 0000        movs	r0, r0
@   0x0800e9ba: 0201        lsls	r1, r0, #8
@   0x0800e9bc: 000a        movs	r2, r1
@   0x0800e9be: 0400        lsls	r0, r0, #16
@   0x0800e9c0: 1d02        adds	r2, r0, #4
@   0x0800e9c2: 0000        movs	r0, r0
@   0x0800e9c4: 7aa9        ldrb	r1, [r5, #10]
@   0x0800e9c6: 0048        lsls	r0, r1, #1
@   0x0800e9c8: 1840        adds	r0, r0, r1
@   0x0800e9ca: 3002        adds	r0, #2
@   0x0800e9cc: 0101        lsls	r1, r0, #4
@   0x0800e9ce: 4642        mov	r2, r8
@   0x0800e9d0: 1888        adds	r0, r1, r2
@   0x0800e9d2: 6800        ldr	r0, [r0, #0]
@   0x0800e9d4: 2800        cmp	r0, #0
@   0x0800e9d6: d005        beq.n	0xe9e4
@   0x0800e9d8: 6020        str	r0, [r4, #0]
@   0x0800e9da: 4809        ldr	r0, [pc, #36]	@ (0xea00)
@   0x0800e9dc: 6060        str	r0, [r4, #4]
@   0x0800e9de: 4809        ldr	r0, [pc, #36]	@ (0xea04)
@   0x0800e9e0: 60a0        str	r0, [r4, #8]
@   0x0800e9e2: 68a0        ldr	r0, [r4, #8]
@   0x0800e9e4: 4640        mov	r0, r8
@   0x0800e9e6: 3008        adds	r0, #8
@   0x0800e9e8: 1808        adds	r0, r1, r0
@   0x0800e9ea: 6801        ldr	r1, [r0, #0]
@   0x0800e9ec: 2900        cmp	r1, #0
@   0x0800e9ee: d10f        bne.n	0xea10
@   0x0800e9f0: 4668        mov	r0, sp
@   0x0800e9f2: 8001        strh	r1, [r0, #0]
@   0x0800e9f4: 6020        str	r0, [r4, #0]
@   0x0800e9f6: 4804        ldr	r0, [pc, #16]	@ (0xea08)
@   0x0800e9f8: 6060        str	r0, [r4, #4]
@   0x0800e9fa: 4804        ldr	r0, [pc, #16]	@ (0xea0c)
@   0x0800e9fc: e00c        b.n	0xea18
@   0x0800e9fe: 0000        movs	r0, r0
@   0x0800ea00: c000        stmia	r0!, {}
@   0x0800ea02: 0600        lsls	r0, r0, #24
@   0x0800ea04: 1000        asrs	r0, r0, #32
@   0x0800ea06: 8000        strh	r0, [r0, #0]
@   0x0800ea08: 0000        movs	r0, r0
@   0x0800ea0a: 0202        lsls	r2, r0, #8
@   0x0800ea0c: 8000        strh	r0, [r0, #0]
@   0x0800ea0e: 8100        strh	r0, [r0, #8]
@   0x0800ea10: 6021        str	r1, [r4, #0]
@   0x0800ea12: 4817        ldr	r0, [pc, #92]	@ (0xea70)
@   0x0800ea14: 6060        str	r0, [r4, #4]
@   0x0800ea16: 4817        ldr	r0, [pc, #92]	@ (0xea74)
@   0x0800ea18: 60a0        str	r0, [r4, #8]
@   0x0800ea1a: 68a0        ldr	r0, [r4, #8]
@   0x0800ea1c: 4916        ldr	r1, [pc, #88]	@ (0xea78)
@   0x0800ea1e: 4a17        ldr	r2, [pc, #92]	@ (0xea7c)
@   0x0800ea20: 1c10        adds	r0, r2, #0
@   0x0800ea22: 8008        strh	r0, [r1, #0]
@   0x0800ea24: 1c78        adds	r0, r7, #1
@   0x0800ea26: 0600        lsls	r0, r0, #24
@   0x0800ea28: 0e07        lsrs	r7, r0, #24
@   0x0800ea2a: 454f        cmp	r7, r9
@   0x0800ea2c: d200        bcs.n	0xea30
@   0x0800ea2e: e741        b.n	0xe8b4
@   0x0800ea30: 4b13        ldr	r3, [pc, #76]	@ (0xea80)
@   0x0800ea32: 4a14        ldr	r2, [pc, #80]	@ (0xea84)
@   0x0800ea34: 4914        ldr	r1, [pc, #80]	@ (0xea88)
@   0x0800ea36: 7a8c        ldrb	r4, [r1, #10]
@   0x0800ea38: 0060        lsls	r0, r4, #1
@   0x0800ea3a: 1900        adds	r0, r0, r4
@   0x0800ea3c: 0100        lsls	r0, r0, #4
@   0x0800ea3e: 3204        adds	r2, #4
@   0x0800ea40: 1880        adds	r0, r0, r2
@   0x0800ea42: 6800        ldr	r0, [r0, #0]
@   0x0800ea44: 6018        str	r0, [r3, #0]
@   0x0800ea46: 20a0        movs	r0, #160	@ 0xa0
@   0x0800ea48: 04c0        lsls	r0, r0, #19
@   0x0800ea4a: 6058        str	r0, [r3, #4]
@   0x0800ea4c: 480f        ldr	r0, [pc, #60]	@ (0xea8c)
@   0x0800ea4e: 6098        str	r0, [r3, #8]
@   0x0800ea50: 6898        ldr	r0, [r3, #8]
@   0x0800ea52: 2180        movs	r1, #128	@ 0x80
@   0x0800ea54: 04c9        lsls	r1, r1, #19
@   0x0800ea56: 2282        movs	r2, #130	@ 0x82
@   0x0800ea58: 0152        lsls	r2, r2, #5
@   0x0800ea5a: 1c10        adds	r0, r2, #0
@   0x0800ea5c: 8008        strh	r0, [r1, #0]
@   0x0800ea5e: 464c        mov	r4, r9
@   0x0800ea60: 2c02        cmp	r4, #2
@   0x0800ea62: d020        beq.n	0xeaa6
@   0x0800ea64: 2c02        cmp	r4, #2
@   0x0800ea66: dc13        bgt.n	0xea90
@   0x0800ea68: 2c01        cmp	r4, #1
@   0x0800ea6a: d015        beq.n	0xea98
@   0x0800ea6c: e034        b.n	0xead8
@   0x0800ea6e: 0000        movs	r0, r0
@   0x0800ea70: 0000        movs	r0, r0
@   0x0800ea72: 0202        lsls	r2, r0, #8
@   0x0800ea74: 8000        strh	r0, [r0, #0]
@   0x0800ea76: 8000        strh	r0, [r0, #0]
@   0x0800ea78: 000c        movs	r4, r1
@   0x0800ea7a: 0400        lsls	r0, r0, #16
@   0x0800ea7c: 1e0d        subs	r5, r1, #0
@   0x0800ea7e: 0000        movs	r0, r0
@   0x0800ea80: 00d4        lsls	r4, r2, #3
@   0x0800ea82: 0400        lsls	r0, r0, #16
@   0x0800ea84: 3190        adds	r1, #144	@ 0x90
@   0x0800ea86: 080e        lsrs	r6, r1, #32
@   0x0800ea88: 5330        strh	r0, [r6, r4]
@   0x0800ea8a: 0300        lsls	r0, r0, #12
@   0x0800ea8c: 0100        lsls	r0, r0, #4
@   0x0800ea8e: 8000        strh	r0, [r0, #0]
@   0x0800ea90: 4648        mov	r0, r9
@   0x0800ea92: 2803        cmp	r0, #3
@   0x0800ea94: d014        beq.n	0xeac0
@   0x0800ea96: e01f        b.n	0xead8
@   0x0800ea98: 2000        movs	r0, #0
@   0x0800ea9a: f000        f9fb 	bl	0xee94
@   0x0800ea9e: 2001        movs	r0, #1
@   0x0800eaa0: f000        f9c8 	bl	0xee34
@   0x0800eaa4: e005        b.n	0xeab2
@   0x0800eaa6: 2000        movs	r0, #0
@   0x0800eaa8: f000        f9f4 	bl	0xee94
@   0x0800eaac: 2001        movs	r0, #1
@   0x0800eaae: f000        f9f1 	bl	0xee94
@   0x0800eab2: 2002        movs	r0, #2
@   0x0800eab4: f000        f9be 	bl	0xee34
@   0x0800eab8: 2003        movs	r0, #3
@   0x0800eaba: f000        f9eb 	bl	0xee94
@   0x0800eabe: e00b        b.n	0xead8
@   0x0800eac0: 2000        movs	r0, #0
@   0x0800eac2: f000        f9e7 	bl	0xee94
@   0x0800eac6: 2001        movs	r0, #1
@   0x0800eac8: f000        f9e4 	bl	0xee94
@   0x0800eacc: 2002        movs	r0, #2
@   0x0800eace: f000        f9e1 	bl	0xee94
@   0x0800ead2: 2003        movs	r0, #3
@   0x0800ead4: f000        f9de 	bl	0xee94
@   0x0800ead8: 4a0b        ldr	r2, [pc, #44]	@ (0xeb08)
@   0x0800eada: 8811        ldrh	r1, [r2, #0]
@   0x0800eadc: 480b        ldr	r0, [pc, #44]	@ (0xeb0c)
@   0x0800eade: 4008        ands	r0, r1
@   0x0800eae0: 8010        strh	r0, [r2, #0]
@   0x0800eae2: 4a0b        ldr	r2, [pc, #44]	@ (0xeb10)
@   0x0800eae4: 8811        ldrh	r1, [r2, #0]
@   0x0800eae6: 480b        ldr	r0, [pc, #44]	@ (0xeb14)
@   0x0800eae8: 4008        ands	r0, r1
@   0x0800eaea: 8010        strh	r0, [r2, #0]
@   0x0800eaec: 490a        ldr	r1, [pc, #40]	@ (0xeb18)
@   0x0800eaee: 2200        movs	r2, #0
@   0x0800eaf0: 2001        movs	r0, #1
@   0x0800eaf2: 7108        strb	r0, [r1, #4]
@   0x0800eaf4: 714a        strb	r2, [r1, #5]
@   0x0800eaf6: b001        add	sp, #4
@   0x0800eaf8: bc38        pop	{r3, r4, r5}
@   0x0800eafa: 4698        mov	r8, r3
@   0x0800eafc: 46a1        mov	r9, r4
@   0x0800eafe: 46aa        mov	sl, r5
@   0x0800eb00: bcf0        pop	{r4, r5, r6, r7}
@   0x0800eb02: bc01        pop	{r0}
@   0x0800eb04: 4700        bx	r0
@   0x0800eb06: 0000        movs	r0, r0
@   0x0800eb08: 0200        lsls	r0, r0, #8
@   0x0800eb0a: 0400        lsls	r0, r0, #16
@   0x0800eb0c: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0800eb10: 0004        movs	r4, r0
@   0x0800eb12: 0400        lsls	r0, r0, #16
@   0x0800eb14: ffef        0000 	vaddl.u32	q8, d15, d0
@   0x0800eb18: 3608        adds	r6, #8
@   0x0800eb1a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800E85C
sub_0800E85C: @ 0x0800e85c
        .incbin "frog_us_baserom.gba", 0xe85c, 0x2c0
        thumb_func_end sub_0800E85C
