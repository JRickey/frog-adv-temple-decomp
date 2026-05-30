@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017f00, 0x080181d0)  (720 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017f00 --end 0x80181d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017f00: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08017f02: 4647        mov	r7, r8
@   0x08017f04: b480        push	{r7}
@   0x08017f06: b088        sub	sp, #32
@   0x08017f08: 2200        movs	r2, #0
@   0x08017f0a: 9204        str	r2, [sp, #16]
@   0x08017f0c: 4824        ldr	r0, [pc, #144]	@ (0x17fa0)
@   0x08017f0e: 4680        mov	r8, r0
@   0x08017f10: 9005        str	r0, [sp, #20]
@   0x08017f12: 4924        ldr	r1, [pc, #144]	@ (0x17fa4)
@   0x08017f14: 4824        ldr	r0, [pc, #144]	@ (0x17fa8)
@   0x08017f16: 6800        ldr	r0, [r0, #0]
@   0x08017f18: 0080        lsls	r0, r0, #2
@   0x08017f1a: 1840        adds	r0, r0, r1
@   0x08017f1c: 6800        ldr	r0, [r0, #0]
@   0x08017f1e: 9006        str	r0, [sp, #24]
@   0x08017f20: 9207        str	r2, [sp, #28]
@   0x08017f22: 2580        movs	r5, #128	@ 0x80
@   0x08017f24: 04ed        lsls	r5, r5, #19
@   0x08017f26: 8829        ldrh	r1, [r5, #0]
@   0x08017f28: 4820        ldr	r0, [pc, #128]	@ (0x17fac)
@   0x08017f2a: 4008        ands	r0, r1
@   0x08017f2c: 8028        strh	r0, [r5, #0]
@   0x08017f2e: 4920        ldr	r1, [pc, #128]	@ (0x17fb0)
@   0x08017f30: 200a        movs	r0, #10
@   0x08017f32: 7008        strb	r0, [r1, #0]
@   0x08017f34: 4c1f        ldr	r4, [pc, #124]	@ (0x17fb4)
@   0x08017f36: 68a0        ldr	r0, [r4, #8]
@   0x08017f38: 2800        cmp	r0, #0
@   0x08017f3a: d000        beq.n	0x17f3e
@   0x08017f3c: 750a        strb	r2, [r1, #20]
@   0x08017f3e: 200e        movs	r0, #14
@   0x08017f40: f000        fe64 	bl	0x18c0c
@   0x08017f44: 68a0        ldr	r0, [r4, #8]
@   0x08017f46: 2419        movs	r4, #25
@   0x08017f48: 2800        cmp	r0, #0
@   0x08017f4a: d000        beq.n	0x17f4e
@   0x08017f4c: 2417        movs	r4, #23
@   0x08017f4e: 2200        movs	r2, #0
@   0x08017f50: 2800        cmp	r0, #0
@   0x08017f52: d100        bne.n	0x17f56
@   0x08017f54: 2201        movs	r2, #1
@   0x08017f56: 2002        movs	r0, #2
@   0x08017f58: 9003        str	r0, [sp, #12]
@   0x08017f5a: 4669        mov	r1, sp
@   0x08017f5c: a805        add	r0, sp, #20
@   0x08017f5e: c8c8        ldmia	r0!, {r3, r6, r7}
@   0x08017f60: c1c8        stmia	r1!, {r3, r6, r7}
@   0x08017f62: 9b04        ldr	r3, [sp, #16]
@   0x08017f64: 1c10        adds	r0, r2, #0
@   0x08017f66: 1c21        adds	r1, r4, #0
@   0x08017f68: 2206        movs	r2, #6
@   0x08017f6a: f000        fc95 	bl	0x18898
@   0x08017f6e: 4912        ldr	r1, [pc, #72]	@ (0x17fb8)
@   0x08017f70: 4640        mov	r0, r8
@   0x08017f72: 6008        str	r0, [r1, #0]
@   0x08017f74: 4811        ldr	r0, [pc, #68]	@ (0x17fbc)
@   0x08017f76: 6048        str	r0, [r1, #4]
@   0x08017f78: 4811        ldr	r0, [pc, #68]	@ (0x17fc0)
@   0x08017f7a: 6088        str	r0, [r1, #8]
@   0x08017f7c: 6888        ldr	r0, [r1, #8]
@   0x08017f7e: f000        fe93 	bl	0x18ca8
@   0x08017f82: 8828        ldrh	r0, [r5, #0]
@   0x08017f84: 2280        movs	r2, #128	@ 0x80
@   0x08017f86: 0112        lsls	r2, r2, #4
@   0x08017f88: 1c11        adds	r1, r2, #0
@   0x08017f8a: 4308        orrs	r0, r1
@   0x08017f8c: 8028        strh	r0, [r5, #0]
@   0x08017f8e: f000        f91f 	bl	0x181d0
@   0x08017f92: b008        add	sp, #32
@   0x08017f94: bc08        pop	{r3}
@   0x08017f96: 4698        mov	r8, r3
@   0x08017f98: bcf0        pop	{r4, r5, r6, r7}
@   0x08017f9a: bc01        pop	{r0}
@   0x08017f9c: 4700        bx	r0
@   0x08017f9e: 0000        movs	r0, r0
@   0x08017fa0: 6c18        ldr	r0, [r3, #64]	@ 0x40
@   0x08017fa2: 081e        lsrs	r6, r3, #32
@   0x08017fa4: 8f70        ldrh	r0, [r6, #58]	@ 0x3a
@   0x08017fa6: 0830        lsrs	r0, r6, #32
@   0x08017fa8: 34b0        adds	r4, #176	@ 0xb0
@   0x08017faa: 0300        lsls	r0, r0, #12
@   0x08017fac: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08017fb0: 3480        adds	r4, #128	@ 0x80
@   0x08017fb2: 0300        lsls	r0, r0, #12
@   0x08017fb4: 34a0        adds	r4, #160	@ 0xa0
@   0x08017fb6: 0300        lsls	r0, r0, #12
@   0x08017fb8: 00d4        lsls	r4, r2, #3
@   0x08017fba: 0400        lsls	r0, r0, #16
@   0x08017fbc: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08017fc0: 0400        lsls	r0, r0, #16
@   0x08017fc2: 8000        strh	r0, [r0, #0]
@   0x08017fc4: b530        push	{r4, r5, lr}
@   0x08017fc6: b082        sub	sp, #8
@   0x08017fc8: 4804        ldr	r0, [pc, #16]	@ (0x17fdc)
@   0x08017fca: 8804        ldrh	r4, [r0, #0]
@   0x08017fcc: 2c02        cmp	r4, #2
@   0x08017fce: d021        beq.n	0x18014
@   0x08017fd0: 2c02        cmp	r4, #2
@   0x08017fd2: dc05        bgt.n	0x17fe0
@   0x08017fd4: 2c01        cmp	r4, #1
@   0x08017fd6: d008        beq.n	0x17fea
@   0x08017fd8: e088        b.n	0x180ec
@   0x08017fda: 0000        movs	r0, r0
@   0x08017fdc: 5398        strh	r0, [r3, r6]
@   0x08017fde: 0300        lsls	r0, r0, #12
@   0x08017fe0: 2c10        cmp	r4, #16
@   0x08017fe2: d02d        beq.n	0x18040
@   0x08017fe4: 2c40        cmp	r4, #64	@ 0x40
@   0x08017fe6: d02b        beq.n	0x18040
@   0x08017fe8: e080        b.n	0x180ec
@   0x08017fea: 2002        movs	r0, #2
@   0x08017fec: f008        fe44 	bl	0x20c78
@   0x08017ff0: 4906        ldr	r1, [pc, #24]	@ (0x1800c)
@   0x08017ff2: 7d08        ldrb	r0, [r1, #20]
@   0x08017ff4: 2800        cmp	r0, #0
@   0x08017ff6: d079        beq.n	0x180ec
@   0x08017ff8: 3801        subs	r0, #1
@   0x08017ffa: 7508        strb	r0, [r1, #20]
@   0x08017ffc: 4804        ldr	r0, [pc, #16]	@ (0x18010)
@   0x08017ffe: 6104        str	r4, [r0, #16]
@   0x08018000: 6084        str	r4, [r0, #8]
@   0x08018002: 2001        movs	r0, #1
@   0x08018004: f001        f806 	bl	0x19014
@   0x08018008: e070        b.n	0x180ec
@   0x0801800a: 0000        movs	r0, r0
@   0x0801800c: 3480        adds	r4, #128	@ 0x80
@   0x0801800e: 0300        lsls	r0, r0, #12
@   0x08018010: 34d0        adds	r4, #208	@ 0xd0
@   0x08018012: 0300        lsls	r0, r0, #12
@   0x08018014: 2002        movs	r0, #2
@   0x08018016: f008        fe2f 	bl	0x20c78
@   0x0801801a: 4907        ldr	r1, [pc, #28]	@ (0x18038)
@   0x0801801c: 7d08        ldrb	r0, [r1, #20]
@   0x0801801e: 2801        cmp	r0, #1
@   0x08018020: d864        bhi.n	0x180ec
@   0x08018022: 3001        adds	r0, #1
@   0x08018024: 2200        movs	r2, #0
@   0x08018026: 7508        strb	r0, [r1, #20]
@   0x08018028: 4904        ldr	r1, [pc, #16]	@ (0x1803c)
@   0x0801802a: 2001        movs	r0, #1
@   0x0801802c: 6108        str	r0, [r1, #16]
@   0x0801802e: 608a        str	r2, [r1, #8]
@   0x08018030: 2000        movs	r0, #0
@   0x08018032: f000        ffef 	bl	0x19014
@   0x08018036: e059        b.n	0x180ec
@   0x08018038: 3480        adds	r4, #128	@ 0x80
@   0x0801803a: 0300        lsls	r0, r0, #12
@   0x0801803c: 34d0        adds	r4, #208	@ 0xd0
@   0x0801803e: 0300        lsls	r0, r0, #12
@   0x08018040: 2001        movs	r0, #1
@   0x08018042: f008        fe19 	bl	0x20c78
@   0x08018046: 480f        ldr	r0, [pc, #60]	@ (0x18084)
@   0x08018048: 9901        ldr	r1, [sp, #4]
@   0x0801804a: 4001        ands	r1, r0
@   0x0801804c: 2009        movs	r0, #9
@   0x0801804e: 4301        orrs	r1, r0
@   0x08018050: 4a0d        ldr	r2, [pc, #52]	@ (0x18088)
@   0x08018052: 4011        ands	r1, r2
@   0x08018054: 20c0        movs	r0, #192	@ 0xc0
@   0x08018056: 00c0        lsls	r0, r0, #3
@   0x08018058: 4301        orrs	r1, r0
@   0x0801805a: 480c        ldr	r0, [pc, #48]	@ (0x1808c)
@   0x0801805c: 4001        ands	r1, r0
@   0x0801805e: 20c0        movs	r0, #192	@ 0xc0
@   0x08018060: 0480        lsls	r0, r0, #18
@   0x08018062: 4301        orrs	r1, r0
@   0x08018064: 480a        ldr	r0, [pc, #40]	@ (0x18090)
@   0x08018066: 4001        ands	r1, r0
@   0x08018068: 20e0        movs	r0, #224	@ 0xe0
@   0x0801806a: 0300        lsls	r0, r0, #12
@   0x0801806c: 4301        orrs	r1, r0
@   0x0801806e: 9101        str	r1, [sp, #4]
@   0x08018070: 4808        ldr	r0, [pc, #32]	@ (0x18094)
@   0x08018072: 7d00        ldrb	r0, [r0, #20]
@   0x08018074: 2801        cmp	r0, #1
@   0x08018076: d016        beq.n	0x180a6
@   0x08018078: 2801        cmp	r0, #1
@   0x0801807a: dc0d        bgt.n	0x18098
@   0x0801807c: 2800        cmp	r0, #0
@   0x0801807e: d00e        beq.n	0x1809e
@   0x08018080: e01a        b.n	0x180b8
@   0x08018082: 0000        movs	r0, r0
@   0x08018084: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08018088: 00ff        lsls	r7, r7, #3
@   0x0801808a: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801808e: 00ff        lsls	r7, r7, #3
@   0x08018090: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08018094: 3480        adds	r4, #128	@ 0x80
@   0x08018096: 0300        lsls	r0, r0, #12
@   0x08018098: 2802        cmp	r0, #2
@   0x0801809a: d008        beq.n	0x180ae
@   0x0801809c: e00c        b.n	0x180b8
@   0x0801809e: 4011        ands	r1, r2
@   0x080180a0: 20a0        movs	r0, #160	@ 0xa0
@   0x080180a2: 00c0        lsls	r0, r0, #3
@   0x080180a4: e006        b.n	0x180b4
@   0x080180a6: 4011        ands	r1, r2
@   0x080180a8: 2090        movs	r0, #144	@ 0x90
@   0x080180aa: 0100        lsls	r0, r0, #4
@   0x080180ac: e002        b.n	0x180b4
@   0x080180ae: 4011        ands	r1, r2
@   0x080180b0: 20d0        movs	r0, #208	@ 0xd0
@   0x080180b2: 0100        lsls	r0, r0, #4
@   0x080180b4: 4301        orrs	r1, r0
@   0x080180b6: 9101        str	r1, [sp, #4]
@   0x080180b8: 200a        movs	r0, #10
@   0x080180ba: 9000        str	r0, [sp, #0]
@   0x080180bc: a801        add	r0, sp, #4
@   0x080180be: 2104        movs	r1, #4
@   0x080180c0: 2205        movs	r2, #5
@   0x080180c2: 2302        movs	r3, #2
@   0x080180c4: f001        fbb6 	bl	0x19834
@   0x080180c8: 2280        movs	r2, #128	@ 0x80
@   0x080180ca: 04d2        lsls	r2, r2, #19
@   0x080180cc: 8811        ldrh	r1, [r2, #0]
@   0x080180ce: 4819        ldr	r0, [pc, #100]	@ (0x18134)
@   0x080180d0: 4008        ands	r0, r1
@   0x080180d2: 8010        strh	r0, [r2, #0]
@   0x080180d4: 4918        ldr	r1, [pc, #96]	@ (0x18138)
@   0x080180d6: 2001        movs	r0, #1
@   0x080180d8: 6088        str	r0, [r1, #8]
@   0x080180da: 2117        movs	r1, #23
@   0x080180dc: 2206        movs	r2, #6
@   0x080180de: 2302        movs	r3, #2
@   0x080180e0: f000        fab2 	bl	0x18648
@   0x080180e4: 4915        ldr	r1, [pc, #84]	@ (0x1813c)
@   0x080180e6: 7808        ldrb	r0, [r1, #0]
@   0x080180e8: 3001        adds	r0, #1
@   0x080180ea: 7008        strb	r0, [r1, #0]
@   0x080180ec: 4d14        ldr	r5, [pc, #80]	@ (0x18140)
@   0x080180ee: 8828        ldrh	r0, [r5, #0]
@   0x080180f0: 2820        cmp	r0, #32
@   0x080180f2: d129        bne.n	0x18148
@   0x080180f4: 2000        movs	r0, #0
@   0x080180f6: f008        fdbf 	bl	0x20c78
@   0x080180fa: 2280        movs	r2, #128	@ 0x80
@   0x080180fc: 04d2        lsls	r2, r2, #19
@   0x080180fe: 8811        ldrh	r1, [r2, #0]
@   0x08018100: 480c        ldr	r0, [pc, #48]	@ (0x18134)
@   0x08018102: 4008        ands	r0, r1
@   0x08018104: 8010        strh	r0, [r2, #0]
@   0x08018106: 480c        ldr	r0, [pc, #48]	@ (0x18138)
@   0x08018108: 2400        movs	r4, #0
@   0x0801810a: 6084        str	r4, [r0, #8]
@   0x0801810c: 2000        movs	r0, #0
@   0x0801810e: 2119        movs	r1, #25
@   0x08018110: 2206        movs	r2, #6
@   0x08018112: 2302        movs	r3, #2
@   0x08018114: f000        fa98 	bl	0x18648
@   0x08018118: 490a        ldr	r1, [pc, #40]	@ (0x18144)
@   0x0801811a: 201b        movs	r0, #27
@   0x0801811c: 7248        strb	r0, [r1, #9]
@   0x0801811e: 4907        ldr	r1, [pc, #28]	@ (0x1813c)
@   0x08018120: 700c        strb	r4, [r1, #0]
@   0x08018122: 708c        strb	r4, [r1, #2]
@   0x08018124: 704c        strb	r4, [r1, #1]
@   0x08018126: 2200        movs	r2, #0
@   0x08018128: 802c        strh	r4, [r5, #0]
@   0x0801812a: 2001        movs	r0, #1
@   0x0801812c: 7188        strb	r0, [r1, #6]
@   0x0801812e: 71ca        strb	r2, [r1, #7]
@   0x08018130: e01e        b.n	0x18170
@   0x08018132: 0000        movs	r0, r0
@   0x08018134: efff        0000 	vext.8	d16, d15, d0, #0
@   0x08018138: 34a0        adds	r4, #160	@ 0xa0
@   0x0801813a: 0300        lsls	r0, r0, #12
@   0x0801813c: 3480        adds	r4, #128	@ 0x80
@   0x0801813e: 0300        lsls	r0, r0, #12
@   0x08018140: 5398        strh	r0, [r3, r6]
@   0x08018142: 0300        lsls	r0, r0, #12
@   0x08018144: 5330        strh	r0, [r6, r4]
@   0x08018146: 0300        lsls	r0, r0, #12
@   0x08018148: 2800        cmp	r0, #0
@   0x0801814a: d008        beq.n	0x1815e
@   0x0801814c: 2810        cmp	r0, #16
@   0x0801814e: d006        beq.n	0x1815e
@   0x08018150: 2840        cmp	r0, #64	@ 0x40
@   0x08018152: d004        beq.n	0x1815e
@   0x08018154: f000        f83c 	bl	0x181d0
@   0x08018158: f001        f866 	bl	0x19228
@   0x0801815c: e008        b.n	0x18170
@   0x0801815e: 4b08        ldr	r3, [pc, #32]	@ (0x18180)
@   0x08018160: 6818        ldr	r0, [r3, #0]
@   0x08018162: 6859        ldr	r1, [r3, #4]
@   0x08018164: 689a        ldr	r2, [r3, #8]
@   0x08018166: 68db        ldr	r3, [r3, #12]
@   0x08018168: f000        fa2a 	bl	0x185c0
@   0x0801816c: f000        fec0 	bl	0x18ef0
@   0x08018170: 4904        ldr	r1, [pc, #16]	@ (0x18184)
@   0x08018172: 2000        movs	r0, #0
@   0x08018174: 8008        strh	r0, [r1, #0]
@   0x08018176: b002        add	sp, #8
@   0x08018178: bc30        pop	{r4, r5}
@   0x0801817a: bc01        pop	{r0}
@   0x0801817c: 4700        bx	r0
@   0x0801817e: 0000        movs	r0, r0
@   0x08018180: 8100        strh	r0, [r0, #8]
@   0x08018182: 0830        lsrs	r0, r6, #32
@   0x08018184: 5398        strh	r0, [r3, r6]
@   0x08018186: 0300        lsls	r0, r0, #12
@   0x08018188: 4a04        ldr	r2, [pc, #16]	@ (0x1819c)
@   0x0801818a: 7d11        ldrb	r1, [r2, #20]
@   0x0801818c: 2901        cmp	r1, #1
@   0x0801818e: d013        beq.n	0x181b8
@   0x08018190: 2901        cmp	r1, #1
@   0x08018192: dc05        bgt.n	0x181a0
@   0x08018194: 2900        cmp	r1, #0
@   0x08018196: d006        beq.n	0x181a6
@   0x08018198: e017        b.n	0x181ca
@   0x0801819a: 0000        movs	r0, r0
@   0x0801819c: 3480        adds	r4, #128	@ 0x80
@   0x0801819e: 0300        lsls	r0, r0, #12
@   0x080181a0: 2902        cmp	r1, #2
@   0x080181a2: d00c        beq.n	0x181be
@   0x080181a4: e011        b.n	0x181ca
@   0x080181a6: 2001        movs	r0, #1
@   0x080181a8: 7150        strb	r0, [r2, #5]
@   0x080181aa: 4802        ldr	r0, [pc, #8]	@ (0x181b4)
@   0x080181ac: 7001        strb	r1, [r0, #0]
@   0x080181ae: 7041        strb	r1, [r0, #1]
@   0x080181b0: e00b        b.n	0x181ca
@   0x080181b2: 0000        movs	r0, r0
@   0x080181b4: 34a0        adds	r4, #160	@ 0xa0
@   0x080181b6: 0300        lsls	r0, r0, #12
@   0x080181b8: 2000        movs	r0, #0
@   0x080181ba: 2102        movs	r1, #2
@   0x080181bc: e001        b.n	0x181c2
@   0x080181be: 2000        movs	r0, #0
@   0x080181c0: 2103        movs	r1, #3
@   0x080181c2: 7151        strb	r1, [r2, #5]
@   0x080181c4: 4901        ldr	r1, [pc, #4]	@ (0x181cc)
@   0x080181c6: 7008        strb	r0, [r1, #0]
@   0x080181c8: 7048        strb	r0, [r1, #1]
@   0x080181ca: 4770        bx	lr
@   0x080181cc: 34a0        adds	r4, #160	@ 0xa0
@   0x080181ce: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08017F00
sub_08017F00: @ 0x08017f00
        .incbin "frog_us_baserom.gba", 0x17f00, 0x2d0
        thumb_func_end sub_08017F00
