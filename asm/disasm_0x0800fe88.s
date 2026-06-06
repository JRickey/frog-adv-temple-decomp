@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800fe88, 0x080100e4)  (604 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800fe88 --end 0x80100e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800fe88: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800fe8a: 464f        mov	r7, r9
@   0x0800fe8c: 4646        mov	r6, r8
@   0x0800fe8e: b4c0        push	{r6, r7}
@   0x0800fe90: b081        sub	sp, #4
@   0x0800fe92: 4813        ldr	r0, [pc, #76]	@ (0xfee0)
@   0x0800fe94: 68c2        ldr	r2, [r0, #12]
@   0x0800fe96: 4913        ldr	r1, [pc, #76]	@ (0xfee4)
@   0x0800fe98: 1c07        adds	r7, r0, #0
@   0x0800fe9a: 4813        ldr	r0, [pc, #76]	@ (0xfee8)
@   0x0800fe9c: 4681        mov	r9, r0
@   0x0800fe9e: 8812        ldrh	r2, [r2, #0]
@   0x0800fea0: 428a        cmp	r2, r1
@   0x0800fea2: d076        beq.n	0xff92
@   0x0800fea4: 1c3e        adds	r6, r7, #0
@   0x0800fea6: 4911        ldr	r1, [pc, #68]	@ (0xfeec)
@   0x0800fea8: 4688        mov	r8, r1
@   0x0800feaa: 68f5        ldr	r5, [r6, #12]
@   0x0800feac: 8829        ldrh	r1, [r5, #0]
@   0x0800feae: 4810        ldr	r0, [pc, #64]	@ (0xfef0)
@   0x0800feb0: 4281        cmp	r1, r0
@   0x0800feb2: d137        bne.n	0xff24
@   0x0800feb4: 2400        movs	r4, #0
@   0x0800feb6: 2600        movs	r6, #0
@   0x0800feb8: 480b        ldr	r0, [pc, #44]	@ (0xfee8)
@   0x0800feba: 8004        strh	r4, [r0, #0]
@   0x0800febc: 4a0d        ldr	r2, [pc, #52]	@ (0xfef4)
@   0x0800febe: 4690        mov	r8, r2
@   0x0800fec0: 4f07        ldr	r7, [pc, #28]	@ (0xfee0)
@   0x0800fec2: 4681        mov	r9, r0
@   0x0800fec4: 464d        mov	r5, r9
@   0x0800fec6: 480b        ldr	r0, [pc, #44]	@ (0xfef4)
@   0x0800fec8: 6800        ldr	r0, [r0, #0]
@   0x0800feca: 1b00        subs	r0, r0, r4
@   0x0800fecc: 2803        cmp	r0, #3
@   0x0800fece: d922        bls.n	0xff16
@   0x0800fed0: 2e00        cmp	r6, #0
@   0x0800fed2: d013        beq.n	0xfefc
@   0x0800fed4: 6978        ldr	r0, [r7, #20]
@   0x0800fed6: 3076        adds	r0, #118	@ 0x76
@   0x0800fed8: 4a07        ldr	r2, [pc, #28]	@ (0xfef8)
@   0x0800feda: 1c11        adds	r1, r2, #0
@   0x0800fedc: 8001        strh	r1, [r0, #0]
@   0x0800fede: e010        b.n	0xff02
@   0x0800fee0: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0800fee2: 0300        lsls	r0, r0, #12
@   0x0800fee4: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800fee8: 5398        strh	r0, [r3, r6]
@   0x0800feea: 0300        lsls	r0, r0, #12
@   0x0800feec: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0800fef0: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x0800fef4: 5330        strh	r0, [r6, r4]
@   0x0800fef6: 0300        lsls	r0, r0, #12
@   0x0800fef8: e0e4        b.n	0x100c4
@   0x0800fefa: 0000        movs	r0, r0
@   0x0800fefc: 6978        ldr	r0, [r7, #20]
@   0x0800fefe: 3076        adds	r0, #118	@ 0x76
@   0x0800ff00: 8006        strh	r6, [r0, #0]
@   0x0800ff02: 2000        movs	r0, #0
@   0x0800ff04: 2e00        cmp	r6, #0
@   0x0800ff06: d100        bne.n	0xff0a
@   0x0800ff08: 2001        movs	r0, #1
@   0x0800ff0a: 1c06        adds	r6, r0, #0
@   0x0800ff0c: 4640        mov	r0, r8
@   0x0800ff0e: 6804        ldr	r4, [r0, #0]
@   0x0800ff10: f7f0        fad8 	bl	0x4c4
@   0x0800ff14: 8028        strh	r0, [r5, #0]
@   0x0800ff16: 8828        ldrh	r0, [r5, #0]
@   0x0800ff18: 2810        cmp	r0, #16
@   0x0800ff1a: d100        bne.n	0xff1e
@   0x0800ff1c: e0b6        b.n	0x1008c
@   0x0800ff1e: 2820        cmp	r0, #32
@   0x0800ff20: d1d1        bne.n	0xfec6
@   0x0800ff22: e0b3        b.n	0x1008c
@   0x0800ff24: 4808        ldr	r0, [pc, #32]	@ (0xff48)
@   0x0800ff26: 4281        cmp	r1, r0
@   0x0800ff28: d010        beq.n	0xff4c
@   0x0800ff2a: 6972        ldr	r2, [r6, #20]
@   0x0800ff2c: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x0800ff2e: 0048        lsls	r0, r1, #1
@   0x0800ff30: 1880        adds	r0, r0, r2
@   0x0800ff32: 2100        movs	r1, #0
@   0x0800ff34: 8001        strh	r1, [r0, #0]
@   0x0800ff36: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x0800ff38: 0048        lsls	r0, r1, #1
@   0x0800ff3a: 1880        adds	r0, r0, r2
@   0x0800ff3c: 3040        adds	r0, #64	@ 0x40
@   0x0800ff3e: 8829        ldrh	r1, [r5, #0]
@   0x0800ff40: 8001        strh	r1, [r0, #0]
@   0x0800ff42: 1ca8        adds	r0, r5, #2
@   0x0800ff44: 60f0        str	r0, [r6, #12]
@   0x0800ff46: e01c        b.n	0xff82
@   0x0800ff48: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0800ff4c: 1cab        adds	r3, r5, #2
@   0x0800ff4e: 60f3        str	r3, [r6, #12]
@   0x0800ff50: 6974        ldr	r4, [r6, #20]
@   0x0800ff52: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0800ff54: 0042        lsls	r2, r0, #1
@   0x0800ff56: 1912        adds	r2, r2, r4
@   0x0800ff58: 886d        ldrh	r5, [r5, #2]
@   0x0800ff5a: 4916        ldr	r1, [pc, #88]	@ (0xffb4)
@   0x0800ff5c: 1868        adds	r0, r5, r1
@   0x0800ff5e: 0041        lsls	r1, r0, #1
@   0x0800ff60: 1809        adds	r1, r1, r0
@   0x0800ff62: 1c48        adds	r0, r1, #1
@   0x0800ff64: 0040        lsls	r0, r0, #1
@   0x0800ff66: 4440        add	r0, r8
@   0x0800ff68: 8800        ldrh	r0, [r0, #0]
@   0x0800ff6a: 8010        strh	r0, [r2, #0]
@   0x0800ff6c: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0800ff6e: 0042        lsls	r2, r0, #1
@   0x0800ff70: 1912        adds	r2, r2, r4
@   0x0800ff72: 3240        adds	r2, #64	@ 0x40
@   0x0800ff74: 3102        adds	r1, #2
@   0x0800ff76: 0049        lsls	r1, r1, #1
@   0x0800ff78: 4441        add	r1, r8
@   0x0800ff7a: 8808        ldrh	r0, [r1, #0]
@   0x0800ff7c: 8010        strh	r0, [r2, #0]
@   0x0800ff7e: 3302        adds	r3, #2
@   0x0800ff80: 60f3        str	r3, [r6, #12]
@   0x0800ff82: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0800ff84: 3001        adds	r0, #1
@   0x0800ff86: 8630        strh	r0, [r6, #48]	@ 0x30
@   0x0800ff88: 68f1        ldr	r1, [r6, #12]
@   0x0800ff8a: 480b        ldr	r0, [pc, #44]	@ (0xffb8)
@   0x0800ff8c: 8809        ldrh	r1, [r1, #0]
@   0x0800ff8e: 4281        cmp	r1, r0
@   0x0800ff90: d18b        bne.n	0xfeaa
@   0x0800ff92: 68f9        ldr	r1, [r7, #12]
@   0x0800ff94: 4808        ldr	r0, [pc, #32]	@ (0xffb8)
@   0x0800ff96: 8809        ldrh	r1, [r1, #0]
@   0x0800ff98: 4281        cmp	r1, r0
@   0x0800ff9a: d16a        bne.n	0x10072
@   0x0800ff9c: 2000        movs	r0, #0
@   0x0800ff9e: 8638        strh	r0, [r7, #48]	@ 0x30
@   0x0800ffa0: 8e78        ldrh	r0, [r7, #50]	@ 0x32
@   0x0800ffa2: 2800        cmp	r0, #0
@   0x0800ffa4: d10a        bne.n	0xffbc
@   0x0800ffa6: 2001        movs	r0, #1
@   0x0800ffa8: 8678        strh	r0, [r7, #50]	@ 0x32
@   0x0800ffaa: 6a7e        ldr	r6, [r7, #36]	@ 0x24
@   0x0800ffac: 6978        ldr	r0, [r7, #20]
@   0x0800ffae: 6278        str	r0, [r7, #36]	@ 0x24
@   0x0800ffb0: 617e        str	r6, [r7, #20]
@   0x0800ffb2: e05b        b.n	0x1006c
@   0x0800ffb4: 1f19        subs	r1, r3, #4
@   0x0800ffb6: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0800ffba: 0000        movs	r0, r0
@   0x0800ffbc: 2400        movs	r4, #0
@   0x0800ffbe: 2600        movs	r6, #0
@   0x0800ffc0: 4809        ldr	r0, [pc, #36]	@ (0xffe8)
@   0x0800ffc2: 8004        strh	r4, [r0, #0]
@   0x0800ffc4: 4909        ldr	r1, [pc, #36]	@ (0xffec)
@   0x0800ffc6: 4688        mov	r8, r1
@   0x0800ffc8: 1c3d        adds	r5, r7, #0
@   0x0800ffca: 1c07        adds	r7, r0, #0
@   0x0800ffcc: 4807        ldr	r0, [pc, #28]	@ (0xffec)
@   0x0800ffce: 6800        ldr	r0, [r0, #0]
@   0x0800ffd0: 1b00        subs	r0, r0, r4
@   0x0800ffd2: 2803        cmp	r0, #3
@   0x0800ffd4: d91b        bls.n	0x1000e
@   0x0800ffd6: 2e00        cmp	r6, #0
@   0x0800ffd8: d00c        beq.n	0xfff4
@   0x0800ffda: 6968        ldr	r0, [r5, #20]
@   0x0800ffdc: 3076        adds	r0, #118	@ 0x76
@   0x0800ffde: 4a04        ldr	r2, [pc, #16]	@ (0xfff0)
@   0x0800ffe0: 1c11        adds	r1, r2, #0
@   0x0800ffe2: 8001        strh	r1, [r0, #0]
@   0x0800ffe4: e009        b.n	0xfffa
@   0x0800ffe6: 0000        movs	r0, r0
@   0x0800ffe8: 5398        strh	r0, [r3, r6]
@   0x0800ffea: 0300        lsls	r0, r0, #12
@   0x0800ffec: 5330        strh	r0, [r6, r4]
@   0x0800ffee: 0300        lsls	r0, r0, #12
@   0x0800fff0: e0e4        b.n	0x101bc
@   0x0800fff2: 0000        movs	r0, r0
@   0x0800fff4: 6968        ldr	r0, [r5, #20]
@   0x0800fff6: 3076        adds	r0, #118	@ 0x76
@   0x0800fff8: 8006        strh	r6, [r0, #0]
@   0x0800fffa: 2000        movs	r0, #0
@   0x0800fffc: 2e00        cmp	r6, #0
@   0x0800fffe: d100        bne.n	0x10002
@   0x08010000: 2001        movs	r0, #1
@   0x08010002: 1c06        adds	r6, r0, #0
@   0x08010004: 4640        mov	r0, r8
@   0x08010006: 6804        ldr	r4, [r0, #0]
@   0x08010008: f7f0        fa5c 	bl	0x4c4
@   0x0801000c: 8038        strh	r0, [r7, #0]
@   0x0801000e: 8838        ldrh	r0, [r7, #0]
@   0x08010010: 491a        ldr	r1, [pc, #104]	@ (0x1007c)
@   0x08010012: 4689        mov	r9, r1
@   0x08010014: 2820        cmp	r0, #32
@   0x08010016: d03c        beq.n	0x10092
@   0x08010018: 2810        cmp	r0, #16
@   0x0801001a: d001        beq.n	0x10020
@   0x0801001c: 2820        cmp	r0, #32
@   0x0801001e: d1d5        bne.n	0xffcc
@   0x08010020: 4d17        ldr	r5, [pc, #92]	@ (0x10080)
@   0x08010022: 2400        movs	r4, #0
@   0x08010024: 866c        strh	r4, [r5, #50]	@ 0x32
@   0x08010026: 6a6e        ldr	r6, [r5, #36]	@ 0x24
@   0x08010028: 696a        ldr	r2, [r5, #20]
@   0x0801002a: 626a        str	r2, [r5, #36]	@ 0x24
@   0x0801002c: 616e        str	r6, [r5, #20]
@   0x0801002e: 4668        mov	r0, sp
@   0x08010030: 8004        strh	r4, [r0, #0]
@   0x08010032: 4814        ldr	r0, [pc, #80]	@ (0x10084)
@   0x08010034: 4669        mov	r1, sp
@   0x08010036: 6001        str	r1, [r0, #0]
@   0x08010038: 6042        str	r2, [r0, #4]
@   0x0801003a: 4b13        ldr	r3, [pc, #76]	@ (0x10088)
@   0x0801003c: 6083        str	r3, [r0, #8]
@   0x0801003e: 6881        ldr	r1, [r0, #8]
@   0x08010040: 4669        mov	r1, sp
@   0x08010042: 800c        strh	r4, [r1, #0]
@   0x08010044: 6001        str	r1, [r0, #0]
@   0x08010046: 3240        adds	r2, #64	@ 0x40
@   0x08010048: 6042        str	r2, [r0, #4]
@   0x0801004a: 6083        str	r3, [r0, #8]
@   0x0801004c: 6881        ldr	r1, [r0, #8]
@   0x0801004e: 4669        mov	r1, sp
@   0x08010050: 800c        strh	r4, [r1, #0]
@   0x08010052: 6001        str	r1, [r0, #0]
@   0x08010054: 6046        str	r6, [r0, #4]
@   0x08010056: 6083        str	r3, [r0, #8]
@   0x08010058: 6881        ldr	r1, [r0, #8]
@   0x0801005a: 4669        mov	r1, sp
@   0x0801005c: 800c        strh	r4, [r1, #0]
@   0x0801005e: 6001        str	r1, [r0, #0]
@   0x08010060: 1c31        adds	r1, r6, #0
@   0x08010062: 3140        adds	r1, #64	@ 0x40
@   0x08010064: 6041        str	r1, [r0, #4]
@   0x08010066: 6083        str	r3, [r0, #8]
@   0x08010068: 6880        ldr	r0, [r0, #8]
@   0x0801006a: 1c2f        adds	r7, r5, #0
@   0x0801006c: 68f8        ldr	r0, [r7, #12]
@   0x0801006e: 3002        adds	r0, #2
@   0x08010070: 60f8        str	r0, [r7, #12]
@   0x08010072: 2000        movs	r0, #0
@   0x08010074: 464a        mov	r2, r9
@   0x08010076: 8010        strh	r0, [r2, #0]
@   0x08010078: 2000        movs	r0, #0
@   0x0801007a: e00b        b.n	0x10094
@   0x0801007c: 5398        strh	r0, [r3, r6]
@   0x0801007e: 0300        lsls	r0, r0, #12
@   0x08010080: 6440        str	r0, [r0, #68]	@ 0x44
@   0x08010082: 0300        lsls	r0, r0, #12
@   0x08010084: 00d4        lsls	r4, r2, #3
@   0x08010086: 0400        lsls	r0, r0, #16
@   0x08010088: 001c        movs	r4, r3
@   0x0801008a: 8100        strh	r0, [r0, #8]
@   0x0801008c: 2000        movs	r0, #0
@   0x0801008e: 4649        mov	r1, r9
@   0x08010090: 8008        strh	r0, [r1, #0]
@   0x08010092: 20fe        movs	r0, #254	@ 0xfe
@   0x08010094: b001        add	sp, #4
@   0x08010096: bc18        pop	{r3, r4}
@   0x08010098: 4698        mov	r8, r3
@   0x0801009a: 46a1        mov	r9, r4
@   0x0801009c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801009e: bc02        pop	{r1}
@   0x080100a0: 4708        bx	r1
@   0x080100a2: 0000        movs	r0, r0
@   0x080100a4: b081        sub	sp, #4
@   0x080100a6: 4669        mov	r1, sp
@   0x080100a8: 2000        movs	r0, #0
@   0x080100aa: 8008        strh	r0, [r1, #0]
@   0x080100ac: 4909        ldr	r1, [pc, #36]	@ (0x100d4)
@   0x080100ae: 4668        mov	r0, sp
@   0x080100b0: 6008        str	r0, [r1, #0]
@   0x080100b2: 4809        ldr	r0, [pc, #36]	@ (0x100d8)
@   0x080100b4: 6048        str	r0, [r1, #4]
@   0x080100b6: 4809        ldr	r0, [pc, #36]	@ (0x100dc)
@   0x080100b8: 6088        str	r0, [r1, #8]
@   0x080100ba: 6888        ldr	r0, [r1, #8]
@   0x080100bc: 39c6        subs	r1, #198	@ 0xc6
@   0x080100be: 4a08        ldr	r2, [pc, #32]	@ (0x100e0)
@   0x080100c0: 1c10        adds	r0, r2, #0
@   0x080100c2: 8008        strh	r0, [r1, #0]
@   0x080100c4: 390e        subs	r1, #14
@   0x080100c6: 2284        movs	r2, #132	@ 0x84
@   0x080100c8: 0112        lsls	r2, r2, #4
@   0x080100ca: 1c10        adds	r0, r2, #0
@   0x080100cc: 8008        strh	r0, [r1, #0]
@   0x080100ce: b001        add	sp, #4
@   0x080100d0: 4770        bx	lr
@   0x080100d2: 0000        movs	r0, r0
@   0x080100d4: 00d4        lsls	r4, r2, #3
@   0x080100d6: 0400        lsls	r0, r0, #16
@   0x080100d8: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x080100dc: 0400        lsls	r0, r0, #16
@   0x080100de: 8100        strh	r0, [r0, #8]
@   0x080100e0: 1f08        subs	r0, r1, #4

        thumb_func_start Credits_RenderStep
Credits_RenderStep: @ 0x0800fe88
        .incbin "frog_us_baserom.gba", 0xfe88, 0x25c
        thumb_func_end Credits_RenderStep
