@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801fe68, 0x080200b4)  (588 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801fe68 --end 0x80200b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801fe68: b570        push	{r4, r5, r6, lr}
@   0x0801fe6a: b082        sub	sp, #8
@   0x0801fe6c: 4910        ldr	r1, [pc, #64]	@ (0x1feb0)
@   0x0801fe6e: 9801        ldr	r0, [sp, #4]
@   0x0801fe70: 4008        ands	r0, r1
@   0x0801fe72: 2108        movs	r1, #8
@   0x0801fe74: 4308        orrs	r0, r1
@   0x0801fe76: 490f        ldr	r1, [pc, #60]	@ (0x1feb4)
@   0x0801fe78: 4008        ands	r0, r1
@   0x0801fe7a: 21c0        movs	r1, #192	@ 0xc0
@   0x0801fe7c: 0089        lsls	r1, r1, #2
@   0x0801fe7e: 4308        orrs	r0, r1
@   0x0801fe80: 490d        ldr	r1, [pc, #52]	@ (0x1feb8)
@   0x0801fe82: 4008        ands	r0, r1
@   0x0801fe84: 21c0        movs	r1, #192	@ 0xc0
@   0x0801fe86: 0489        lsls	r1, r1, #18
@   0x0801fe88: 4308        orrs	r0, r1
@   0x0801fe8a: 490c        ldr	r1, [pc, #48]	@ (0x1febc)
@   0x0801fe8c: 4008        ands	r0, r1
@   0x0801fe8e: 21e0        movs	r1, #224	@ 0xe0
@   0x0801fe90: 0309        lsls	r1, r1, #12
@   0x0801fe92: 4308        orrs	r0, r1
@   0x0801fe94: 9001        str	r0, [sp, #4]
@   0x0801fe96: f7e0        fb15 	bl	0x4c4
@   0x0801fe9a: 4909        ldr	r1, [pc, #36]	@ (0x1fec0)
@   0x0801fe9c: 8008        strh	r0, [r1, #0]
@   0x0801fe9e: 880c        ldrh	r4, [r1, #0]
@   0x0801fea0: 2c02        cmp	r4, #2
@   0x0801fea2: d029        beq.n	0x1fef8
@   0x0801fea4: 2c02        cmp	r4, #2
@   0x0801fea6: dc0d        bgt.n	0x1fec4
@   0x0801fea8: 2c01        cmp	r4, #1
@   0x0801feaa: d010        beq.n	0x1fece
@   0x0801feac: e0c2        b.n	0x20034
@   0x0801feae: 0000        movs	r0, r0
@   0x0801feb0: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801feb4: 00ff        lsls	r7, r7, #3
@   0x0801feb6: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801feba: 00ff        lsls	r7, r7, #3
@   0x0801febc: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801fec0: 5398        strh	r0, [r3, r6]
@   0x0801fec2: 0300        lsls	r0, r0, #12
@   0x0801fec4: 2c10        cmp	r4, #16
@   0x0801fec6: d02d        beq.n	0x1ff24
@   0x0801fec8: 2c40        cmp	r4, #64	@ 0x40
@   0x0801feca: d02b        beq.n	0x1ff24
@   0x0801fecc: e0b2        b.n	0x20034
@   0x0801fece: 2002        movs	r0, #2
@   0x0801fed0: f000        fed2 	bl	0x20c78
@   0x0801fed4: 4906        ldr	r1, [pc, #24]	@ (0x1fef0)
@   0x0801fed6: 7d08        ldrb	r0, [r1, #20]
@   0x0801fed8: 2800        cmp	r0, #0
@   0x0801feda: d100        bne.n	0x1fede
@   0x0801fedc: e0aa        b.n	0x20034
@   0x0801fede: 3801        subs	r0, #1
@   0x0801fee0: 7508        strb	r0, [r1, #20]
@   0x0801fee2: 4804        ldr	r0, [pc, #16]	@ (0x1fef4)
@   0x0801fee4: 6104        str	r4, [r0, #16]
@   0x0801fee6: 6084        str	r4, [r0, #8]
@   0x0801fee8: 2001        movs	r0, #1
@   0x0801feea: f7f9        f893 	bl	0x19014
@   0x0801feee: e0a1        b.n	0x20034
@   0x0801fef0: 3480        adds	r4, #128	@ 0x80
@   0x0801fef2: 0300        lsls	r0, r0, #12
@   0x0801fef4: 34d0        adds	r4, #208	@ 0xd0
@   0x0801fef6: 0300        lsls	r0, r0, #12
@   0x0801fef8: 2002        movs	r0, #2
@   0x0801fefa: f000        febd 	bl	0x20c78
@   0x0801fefe: 4907        ldr	r1, [pc, #28]	@ (0x1ff1c)
@   0x0801ff00: 7d08        ldrb	r0, [r1, #20]
@   0x0801ff02: 2804        cmp	r0, #4
@   0x0801ff04: d100        bne.n	0x1ff08
@   0x0801ff06: e095        b.n	0x20034
@   0x0801ff08: 3001        adds	r0, #1
@   0x0801ff0a: 7508        strb	r0, [r1, #20]
@   0x0801ff0c: 4904        ldr	r1, [pc, #16]	@ (0x1ff20)
@   0x0801ff0e: 2001        movs	r0, #1
@   0x0801ff10: 6108        str	r0, [r1, #16]
@   0x0801ff12: 6088        str	r0, [r1, #8]
@   0x0801ff14: 2000        movs	r0, #0
@   0x0801ff16: f7f9        f87d 	bl	0x19014
@   0x0801ff1a: e08b        b.n	0x20034
@   0x0801ff1c: 3480        adds	r4, #128	@ 0x80
@   0x0801ff1e: 0300        lsls	r0, r0, #12
@   0x0801ff20: 34d0        adds	r4, #208	@ 0xd0
@   0x0801ff22: 0300        lsls	r0, r0, #12
@   0x0801ff24: 2001        movs	r0, #1
@   0x0801ff26: f000        fea7 	bl	0x20c78
@   0x0801ff2a: 4c06        ldr	r4, [pc, #24]	@ (0x1ff44)
@   0x0801ff2c: 7d20        ldrb	r0, [r4, #20]
@   0x0801ff2e: f7f9        fd13 	bl	0x19958
@   0x0801ff32: 7d20        ldrb	r0, [r4, #20]
@   0x0801ff34: 2804        cmp	r0, #4
@   0x0801ff36: d83a        bhi.n	0x1ffae
@   0x0801ff38: 0080        lsls	r0, r0, #2
@   0x0801ff3a: 4903        ldr	r1, [pc, #12]	@ (0x1ff48)
@   0x0801ff3c: 1840        adds	r0, r0, r1
@   0x0801ff3e: 6800        ldr	r0, [r0, #0]
@   0x0801ff40: 4687        mov	pc, r0
@   0x0801ff42: 0000        movs	r0, r0
@   0x0801ff44: 3480        adds	r4, #128	@ 0x80
@   0x0801ff46: 0300        lsls	r0, r0, #12
@   0x0801ff48: ff4c        0801 	vsub.i8	d16, d12, d1
@   0x0801ff4c: ff60        0801 	vsub.i32	d16, d0, d1
@   0x0801ff50: ff70        0801 	vsub.i64	d16, d0, d1
@   0x0801ff54: ff80        0801 	vmlal.u8	q0, d0, d1
@   0x0801ff58: ff90        0801 	vmlal.u16	q0, d0, d1
@   0x0801ff5c: ffa0        0801 	vmlal.u32	q0, d0, d1
@   0x0801ff60: 4802        ldr	r0, [pc, #8]	@ (0x1ff6c)
@   0x0801ff62: 9901        ldr	r1, [sp, #4]
@   0x0801ff64: 4001        ands	r1, r0
@   0x0801ff66: 20c0        movs	r0, #192	@ 0xc0
@   0x0801ff68: 0080        lsls	r0, r0, #2
@   0x0801ff6a: e01e        b.n	0x1ffaa
@   0x0801ff6c: 00ff        lsls	r7, r7, #3
@   0x0801ff6e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x0801ff72: 9901        ldr	r1, [sp, #4]
@   0x0801ff74: 4001        ands	r1, r0
@   0x0801ff76: 20c0        movs	r0, #192	@ 0xc0
@   0x0801ff78: 00c0        lsls	r0, r0, #3
@   0x0801ff7a: e016        b.n	0x1ffaa
@   0x0801ff7c: 00ff        lsls	r7, r7, #3
@   0x0801ff7e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x0801ff82: 9901        ldr	r1, [sp, #4]
@   0x0801ff84: 4001        ands	r1, r0
@   0x0801ff86: 2090        movs	r0, #144	@ 0x90
@   0x0801ff88: 0100        lsls	r0, r0, #4
@   0x0801ff8a: e00e        b.n	0x1ffaa
@   0x0801ff8c: 00ff        lsls	r7, r7, #3
@   0x0801ff8e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x0801ff92: 9901        ldr	r1, [sp, #4]
@   0x0801ff94: 4001        ands	r1, r0
@   0x0801ff96: 20c0        movs	r0, #192	@ 0xc0
@   0x0801ff98: 0100        lsls	r0, r0, #4
@   0x0801ff9a: e006        b.n	0x1ffaa
@   0x0801ff9c: 00ff        lsls	r7, r7, #3
@   0x0801ff9e: ffff        4809 	vtbl.8	d20, {d15}, d9
@   0x0801ffa2: 9901        ldr	r1, [sp, #4]
@   0x0801ffa4: 4001        ands	r1, r0
@   0x0801ffa6: 20f0        movs	r0, #240	@ 0xf0
@   0x0801ffa8: 0100        lsls	r0, r0, #4
@   0x0801ffaa: 4301        orrs	r1, r0
@   0x0801ffac: 9101        str	r1, [sp, #4]
@   0x0801ffae: 4807        ldr	r0, [pc, #28]	@ (0x1ffcc)
@   0x0801ffb0: 7d00        ldrb	r0, [r0, #20]
@   0x0801ffb2: 2803        cmp	r0, #3
@   0x0801ffb4: d00c        beq.n	0x1ffd0
@   0x0801ffb6: 200a        movs	r0, #10
@   0x0801ffb8: 9000        str	r0, [sp, #0]
@   0x0801ffba: a801        add	r0, sp, #4
@   0x0801ffbc: 2100        movs	r1, #0
@   0x0801ffbe: 2201        movs	r2, #1
@   0x0801ffc0: 2302        movs	r3, #2
@   0x0801ffc2: f7f9        fc37 	bl	0x19834
@   0x0801ffc6: e00b        b.n	0x1ffe0
@   0x0801ffc8: 00ff        lsls	r7, r7, #3
@   0x0801ffca: ffff        3480 	vraddhn.i<illegal width 128>	d19, <illegal reg q15.5>, q0
@   0x0801ffce: 0300        lsls	r0, r0, #12
@   0x0801ffd0: 200a        movs	r0, #10
@   0x0801ffd2: 9000        str	r0, [sp, #0]
@   0x0801ffd4: a801        add	r0, sp, #4
@   0x0801ffd6: 2102        movs	r1, #2
@   0x0801ffd8: 2203        movs	r2, #3
@   0x0801ffda: 2302        movs	r3, #2
@   0x0801ffdc: f7f9        fc2a 	bl	0x19834
@   0x0801ffe0: 2300        movs	r3, #0
@   0x0801ffe2: 4e1d        ldr	r6, [pc, #116]	@ (0x20058)
@   0x0801ffe4: 4d1d        ldr	r5, [pc, #116]	@ (0x2005c)
@   0x0801ffe6: 4c1e        ldr	r4, [pc, #120]	@ (0x20060)
@   0x0801ffe8: 6828        ldr	r0, [r5, #0]
@   0x0801ffea: 6869        ldr	r1, [r5, #4]
@   0x0801ffec: 00da        lsls	r2, r3, #3
@   0x0801ffee: 1912        adds	r2, r2, r4
@   0x0801fff0: 6010        str	r0, [r2, #0]
@   0x0801fff2: 6051        str	r1, [r2, #4]
@   0x0801fff4: 1c58        adds	r0, r3, #1
@   0x0801fff6: 0600        lsls	r0, r0, #24
@   0x0801fff8: 0e03        lsrs	r3, r0, #24
@   0x0801fffa: 2b06        cmp	r3, #6
@   0x0801fffc: d9f4        bls.n	0x1ffe8
@   0x0801fffe: 2280        movs	r2, #128	@ 0x80
@   0x08020000: 04d2        lsls	r2, r2, #19
@   0x08020002: 8811        ldrh	r1, [r2, #0]
@   0x08020004: 4817        ldr	r0, [pc, #92]	@ (0x20064)
@   0x08020006: 4008        ands	r0, r1
@   0x08020008: 8010        strh	r0, [r2, #0]
@   0x0802000a: 2001        movs	r0, #1
@   0x0802000c: 60b0        str	r0, [r6, #8]
@   0x0802000e: 2117        movs	r1, #23
@   0x08020010: 2206        movs	r2, #6
@   0x08020012: 2302        movs	r3, #2
@   0x08020014: f7f8        fb18 	bl	0x18648
@   0x08020018: 4913        ldr	r1, [pc, #76]	@ (0x20068)
@   0x0802001a: 2300        movs	r3, #0
@   0x0802001c: 2004        movs	r0, #4
@   0x0802001e: 7248        strb	r0, [r1, #9]
@   0x08020020: 4912        ldr	r1, [pc, #72]	@ (0x2006c)
@   0x08020022: 2008        movs	r0, #8
@   0x08020024: 7008        strb	r0, [r1, #0]
@   0x08020026: 714b        strb	r3, [r1, #5]
@   0x08020028: 708b        strb	r3, [r1, #2]
@   0x0802002a: 704b        strb	r3, [r1, #1]
@   0x0802002c: 4810        ldr	r0, [pc, #64]	@ (0x20070)
@   0x0802002e: 2200        movs	r2, #0
@   0x08020030: 8003        strh	r3, [r0, #0]
@   0x08020032: 71ca        strb	r2, [r1, #7]
@   0x08020034: 480e        ldr	r0, [pc, #56]	@ (0x20070)
@   0x08020036: 8800        ldrh	r0, [r0, #0]
@   0x08020038: 2820        cmp	r0, #32
@   0x0802003a: d11b        bne.n	0x20074
@   0x0802003c: 2000        movs	r0, #0
@   0x0802003e: f000        fe1b 	bl	0x20c78
@   0x08020042: 2280        movs	r2, #128	@ 0x80
@   0x08020044: 04d2        lsls	r2, r2, #19
@   0x08020046: 8811        ldrh	r1, [r2, #0]
@   0x08020048: 4806        ldr	r0, [pc, #24]	@ (0x20064)
@   0x0802004a: 4008        ands	r0, r1
@   0x0802004c: 8010        strh	r0, [r2, #0]
@   0x0802004e: 4907        ldr	r1, [pc, #28]	@ (0x2006c)
@   0x08020050: 7888        ldrb	r0, [r1, #2]
@   0x08020052: 3001        adds	r0, #1
@   0x08020054: 7088        strb	r0, [r1, #2]
@   0x08020056: e021        b.n	0x2009c
@   0x08020058: 34a0        adds	r4, #160	@ 0xa0
@   0x0802005a: 0300        lsls	r0, r0, #12
@   0x0802005c: d910        bls.n	0x20080
@   0x0802005e: 081b        lsrs	r3, r3, #32
@   0x08020060: 54a0        strb	r0, [r4, r2]
@   0x08020062: 0300        lsls	r0, r0, #12
@   0x08020064: efff        0000 	vext.8	d16, d15, d0, #0
@   0x08020068: 5330        strh	r0, [r6, r4]
@   0x0802006a: 0300        lsls	r0, r0, #12
@   0x0802006c: 3480        adds	r4, #128	@ 0x80
@   0x0802006e: 0300        lsls	r0, r0, #12
@   0x08020070: 5398        strh	r0, [r3, r6]
@   0x08020072: 0300        lsls	r0, r0, #12
@   0x08020074: 2800        cmp	r0, #0
@   0x08020076: d008        beq.n	0x2008a
@   0x08020078: 2810        cmp	r0, #16
@   0x0802007a: d006        beq.n	0x2008a
@   0x0802007c: 2840        cmp	r0, #64	@ 0x40
@   0x0802007e: d004        beq.n	0x2008a
@   0x08020080: f000        f818 	bl	0x200b4
@   0x08020084: f7f9        f8d0 	bl	0x19228
@   0x08020088: e008        b.n	0x2009c
@   0x0802008a: 4b08        ldr	r3, [pc, #32]	@ (0x200ac)
@   0x0802008c: 6818        ldr	r0, [r3, #0]
@   0x0802008e: 6859        ldr	r1, [r3, #4]
@   0x08020090: 689a        ldr	r2, [r3, #8]
@   0x08020092: 68db        ldr	r3, [r3, #12]
@   0x08020094: f7f8        fa94 	bl	0x185c0
@   0x08020098: f7f8        ff2a 	bl	0x18ef0
@   0x0802009c: 4904        ldr	r1, [pc, #16]	@ (0x200b0)
@   0x0802009e: 2000        movs	r0, #0
@   0x080200a0: 8008        strh	r0, [r1, #0]
@   0x080200a2: b002        add	sp, #8
@   0x080200a4: bc70        pop	{r4, r5, r6}
@   0x080200a6: bc01        pop	{r0}
@   0x080200a8: 4700        bx	r0
@   0x080200aa: 0000        movs	r0, r0
@   0x080200ac: 8100        strh	r0, [r0, #8]
@   0x080200ae: 0830        lsrs	r0, r6, #32
@   0x080200b0: 5398        strh	r0, [r3, r6]
@   0x080200b2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801FE68
sub_0801FE68: @ 0x0801fe68
        .incbin "frog_us_baserom.gba", 0x1fe68, 0x24c
        thumb_func_end sub_0801FE68
