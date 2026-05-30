@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017db8, 0x08017f00)  (328 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017db8 --end 0x8017f00 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017db8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08017dba: 4d0e        ldr	r5, [pc, #56]	@ (0x17df4)
@   0x08017dbc: 2700        movs	r7, #0
@   0x08017dbe: 71af        strb	r7, [r5, #6]
@   0x08017dc0: 4e0d        ldr	r6, [pc, #52]	@ (0x17df8)
@   0x08017dc2: 7830        ldrb	r0, [r6, #0]
@   0x08017dc4: f001        fb2c 	bl	0x19420
@   0x08017dc8: 8834        ldrh	r4, [r6, #0]
@   0x08017dca: 2c40        cmp	r4, #64	@ 0x40
@   0x08017dcc: d11a        bne.n	0x17e04
@   0x08017dce: f001        fdd9 	bl	0x19984
@   0x08017dd2: 490a        ldr	r1, [pc, #40]	@ (0x17dfc)
@   0x08017dd4: 2001        movs	r0, #1
@   0x08017dd6: 6088        str	r0, [r1, #8]
@   0x08017dd8: 4909        ldr	r1, [pc, #36]	@ (0x17e00)
@   0x08017dda: 201b        movs	r0, #27
@   0x08017ddc: 7248        strb	r0, [r1, #9]
@   0x08017dde: 7828        ldrb	r0, [r5, #0]
@   0x08017de0: 3002        adds	r0, #2
@   0x08017de2: 7028        strb	r0, [r5, #0]
@   0x08017de4: 752f        strb	r7, [r5, #20]
@   0x08017de6: 20bf        movs	r0, #191	@ 0xbf
@   0x08017de8: f7f8        fc54 	bl	0x10694
@   0x08017dec: 2000        movs	r0, #0
@   0x08017dee: 8037        strh	r7, [r6, #0]
@   0x08017df0: 7168        strb	r0, [r5, #5]
@   0x08017df2: e068        b.n	0x17ec6
@   0x08017df4: 3480        adds	r4, #128	@ 0x80
@   0x08017df6: 0300        lsls	r0, r0, #12
@   0x08017df8: 5398        strh	r0, [r3, r6]
@   0x08017dfa: 0300        lsls	r0, r0, #12
@   0x08017dfc: 34a0        adds	r4, #160	@ 0xa0
@   0x08017dfe: 0300        lsls	r0, r0, #12
@   0x08017e00: 5330        strh	r0, [r6, r4]
@   0x08017e02: 0300        lsls	r0, r0, #12
@   0x08017e04: 2c00        cmp	r4, #0
@   0x08017e06: d15b        bne.n	0x17ec0
@   0x08017e08: f7e8        fd7a 	bl	0x900
@   0x08017e0c: 6929        ldr	r1, [r5, #16]
@   0x08017e0e: 1a40        subs	r0, r0, r1
@   0x08017e10: 280f        cmp	r0, #15
@   0x08017e12: d917        bls.n	0x17e44
@   0x08017e14: 7a28        ldrb	r0, [r5, #8]
@   0x08017e16: 2800        cmp	r0, #0
@   0x08017e18: d10c        bne.n	0x17e34
@   0x08017e1a: 2280        movs	r2, #128	@ 0x80
@   0x08017e1c: 04d2        lsls	r2, r2, #19
@   0x08017e1e: 8811        ldrh	r1, [r2, #0]
@   0x08017e20: 2010        movs	r0, #16
@   0x08017e22: 4008        ands	r0, r1
@   0x08017e24: 2800        cmp	r0, #0
@   0x08017e26: d003        beq.n	0x17e30
@   0x08017e28: 8810        ldrh	r0, [r2, #0]
@   0x08017e2a: 2110        movs	r1, #16
@   0x08017e2c: 4048        eors	r0, r1
@   0x08017e2e: 8010        strh	r0, [r2, #0]
@   0x08017e30: 2001        movs	r0, #1
@   0x08017e32: 7228        strb	r0, [r5, #8]
@   0x08017e34: f7e8        fd64 	bl	0x900
@   0x08017e38: 4901        ldr	r1, [pc, #4]	@ (0x17e40)
@   0x08017e3a: 6108        str	r0, [r1, #16]
@   0x08017e3c: e015        b.n	0x17e6a
@   0x08017e3e: 0000        movs	r0, r0
@   0x08017e40: 3480        adds	r4, #128	@ 0x80
@   0x08017e42: 0300        lsls	r0, r0, #12
@   0x08017e44: 79e8        ldrb	r0, [r5, #7]
@   0x08017e46: 2832        cmp	r0, #50	@ 0x32
@   0x08017e48: d10f        bne.n	0x17e6a
@   0x08017e4a: 7a28        ldrb	r0, [r5, #8]
@   0x08017e4c: 2800        cmp	r0, #0
@   0x08017e4e: d013        beq.n	0x17e78
@   0x08017e50: 2280        movs	r2, #128	@ 0x80
@   0x08017e52: 04d2        lsls	r2, r2, #19
@   0x08017e54: 8811        ldrh	r1, [r2, #0]
@   0x08017e56: 2010        movs	r0, #16
@   0x08017e58: 4008        ands	r0, r1
@   0x08017e5a: 2800        cmp	r0, #0
@   0x08017e5c: d103        bne.n	0x17e66
@   0x08017e5e: 8810        ldrh	r0, [r2, #0]
@   0x08017e60: 2110        movs	r1, #16
@   0x08017e62: 4048        eors	r0, r1
@   0x08017e64: 8010        strh	r0, [r2, #0]
@   0x08017e66: 722c        strb	r4, [r5, #8]
@   0x08017e68: 71ec        strb	r4, [r5, #7]
@   0x08017e6a: 4911        ldr	r1, [pc, #68]	@ (0x17eb0)
@   0x08017e6c: 7a08        ldrb	r0, [r1, #8]
@   0x08017e6e: 2800        cmp	r0, #0
@   0x08017e70: d002        beq.n	0x17e78
@   0x08017e72: 79c8        ldrb	r0, [r1, #7]
@   0x08017e74: 3001        adds	r0, #1
@   0x08017e76: 71c8        strb	r0, [r1, #7]
@   0x08017e78: f7e8        fd42 	bl	0x900
@   0x08017e7c: 4c0c        ldr	r4, [pc, #48]	@ (0x17eb0)
@   0x08017e7e: 68e1        ldr	r1, [r4, #12]
@   0x08017e80: 1a40        subs	r0, r0, r1
@   0x08017e82: 490c        ldr	r1, [pc, #48]	@ (0x17eb4)
@   0x08017e84: 4288        cmp	r0, r1
@   0x08017e86: d91e        bls.n	0x17ec6
@   0x08017e88: 4a0b        ldr	r2, [pc, #44]	@ (0x17eb8)
@   0x08017e8a: 2100        movs	r1, #0
@   0x08017e8c: 2001        movs	r0, #1
@   0x08017e8e: 7290        strb	r0, [r2, #10]
@   0x08017e90: 480a        ldr	r0, [pc, #40]	@ (0x17ebc)
@   0x08017e92: 60c1        str	r1, [r0, #12]
@   0x08017e94: 7001        strb	r1, [r0, #0]
@   0x08017e96: 6041        str	r1, [r0, #4]
@   0x08017e98: 6081        str	r1, [r0, #8]
@   0x08017e9a: 7041        strb	r1, [r0, #1]
@   0x08017e9c: 2004        movs	r0, #4
@   0x08017e9e: 7160        strb	r0, [r4, #5]
@   0x08017ea0: 7021        strb	r1, [r4, #0]
@   0x08017ea2: f7e8        fd2d 	bl	0x900
@   0x08017ea6: 60e0        str	r0, [r4, #12]
@   0x08017ea8: f015        fd26 	bl	0x2d8f8
@   0x08017eac: e00b        b.n	0x17ec6
@   0x08017eae: 0000        movs	r0, r0
@   0x08017eb0: 3480        adds	r4, #128	@ 0x80
@   0x08017eb2: 0300        lsls	r0, r0, #12
@   0x08017eb4: 0257        lsls	r7, r2, #9
@   0x08017eb6: 0000        movs	r0, r0
@   0x08017eb8: 5330        strh	r0, [r6, r4]
@   0x08017eba: 0300        lsls	r0, r0, #12
@   0x08017ebc: 34c0        adds	r4, #192	@ 0xc0
@   0x08017ebe: 0300        lsls	r0, r0, #12
@   0x08017ec0: f7e8        fd1e 	bl	0x900
@   0x08017ec4: 60e8        str	r0, [r5, #12]
@   0x08017ec6: bcf0        pop	{r4, r5, r6, r7}
@   0x08017ec8: bc01        pop	{r0}
@   0x08017eca: 4700        bx	r0
@   0x08017ecc: 4809        ldr	r0, [pc, #36]	@ (0x17ef4)
@   0x08017ece: 7801        ldrb	r1, [r0, #0]
@   0x08017ed0: 3101        adds	r1, #1
@   0x08017ed2: 2200        movs	r2, #0
@   0x08017ed4: 7001        strb	r1, [r0, #0]
@   0x08017ed6: 4908        ldr	r1, [pc, #32]	@ (0x17ef8)
@   0x08017ed8: 700a        strb	r2, [r1, #0]
@   0x08017eda: 704a        strb	r2, [r1, #1]
@   0x08017edc: 20f0        movs	r0, #240	@ 0xf0
@   0x08017ede: 7088        strb	r0, [r1, #2]
@   0x08017ee0: 20a0        movs	r0, #160	@ 0xa0
@   0x08017ee2: 70c8        strb	r0, [r1, #3]
@   0x08017ee4: 4905        ldr	r1, [pc, #20]	@ (0x17efc)
@   0x08017ee6: 700a        strb	r2, [r1, #0]
@   0x08017ee8: 704a        strb	r2, [r1, #1]
@   0x08017eea: 2050        movs	r0, #80	@ 0x50
@   0x08017eec: 7088        strb	r0, [r1, #2]
@   0x08017eee: 2018        movs	r0, #24
@   0x08017ef0: 70c8        strb	r0, [r1, #3]
@   0x08017ef2: 4770        bx	lr
@   0x08017ef4: 3480        adds	r4, #128	@ 0x80
@   0x08017ef6: 0300        lsls	r0, r0, #12
@   0x08017ef8: 3470        adds	r4, #112	@ 0x70
@   0x08017efa: 0300        lsls	r0, r0, #12
@   0x08017efc: 34b8        adds	r4, #184	@ 0xb8
@   0x08017efe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08017DB8
sub_08017DB8: @ 0x08017db8
        .incbin "frog_us_baserom.gba", 0x17db8, 0x148
        thumb_func_end sub_08017DB8
