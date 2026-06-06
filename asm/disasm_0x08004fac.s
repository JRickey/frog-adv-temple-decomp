@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004fac, 0x080052c0)  (788 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004fac --end 0x80052c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004fac: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08004fae: 4647        mov	r7, r8
@   0x08004fb0: b480        push	{r7}
@   0x08004fb2: 4c03        ldr	r4, [pc, #12]	@ (0x4fc0)
@   0x08004fb4: 44a5        add	sp, r4
@   0x08004fb6: 4803        ldr	r0, [pc, #12]	@ (0x4fc4)
@   0x08004fb8: 4468        add	r0, sp
@   0x08004fba: 2100        movs	r1, #0
@   0x08004fbc: 7001        strb	r1, [r0, #0]
@   0x08004fbe: e16c        b.n	0x529a
@   0x08004fc0: fcec        ffff 			@ <UNDEFINED> instruction: 0xfcecffff
@   0x08004fc4: 0301        lsls	r1, r0, #12
@   0x08004fc6: 0000        movs	r0, r0
@   0x08004fc8: f01b        fdfa 	bl	0x20bc0
@   0x08004fcc: 4805        ldr	r0, [pc, #20]	@ (0x4fe4)
@   0x08004fce: 4468        add	r0, sp
@   0x08004fd0: 7800        ldrb	r0, [r0, #0]
@   0x08004fd2: 2809        cmp	r0, #9
@   0x08004fd4: d900        bls.n	0x4fd8
@   0x08004fd6: e160        b.n	0x529a
@   0x08004fd8: 0080        lsls	r0, r0, #2
@   0x08004fda: 4903        ldr	r1, [pc, #12]	@ (0x4fe8)
@   0x08004fdc: 1840        adds	r0, r0, r1
@   0x08004fde: 6800        ldr	r0, [r0, #0]
@   0x08004fe0: 4687        mov	pc, r0
@   0x08004fe2: 0000        movs	r0, r0
@   0x08004fe4: 0301        lsls	r1, r0, #12
@   0x08004fe6: 0000        movs	r0, r0
@   0x08004fe8: 4fec        ldr	r7, [pc, #944]	@ (0x539c)
@   0x08004fea: 0800        lsrs	r0, r0, #32
@   0x08004fec: 5014        str	r4, [r2, r0]
@   0x08004fee: 0800        lsrs	r0, r0, #32
@   0x08004ff0: 5038        str	r0, [r7, r0]
@   0x08004ff2: 0800        lsrs	r0, r0, #32
@   0x08004ff4: 5068        str	r0, [r5, r1]
@   0x08004ff6: 0800        lsrs	r0, r0, #32
@   0x08004ff8: 5084        str	r4, [r0, r2]
@   0x08004ffa: 0800        lsrs	r0, r0, #32
@   0x08004ffc: 50b8        str	r0, [r7, r2]
@   0x08004ffe: 0800        lsrs	r0, r0, #32
@   0x08005000: 5154        str	r4, [r2, r5]
@   0x08005002: 0800        lsrs	r0, r0, #32
@   0x08005004: 51cc        str	r4, [r1, r7]
@   0x08005006: 0800        lsrs	r0, r0, #32
@   0x08005008: 520c        strh	r4, [r1, r0]
@   0x0800500a: 0800        lsrs	r0, r0, #32
@   0x0800500c: 524c        strh	r4, [r1, r1]
@   0x0800500e: 0800        lsrs	r0, r0, #32
@   0x08005010: 5284        strh	r4, [r0, r2]
@   0x08005012: 0800        lsrs	r0, r0, #32
@   0x08005014: 4906        ldr	r1, [pc, #24]	@ (0x5030)
@   0x08005016: 2400        movs	r4, #0
@   0x08005018: 200f        movs	r0, #15
@   0x0800501a: 7288        strb	r0, [r1, #10]
@   0x0800501c: f005        f8fa 	bl	0xa214
@   0x08005020: 4680        mov	r8, r0
@   0x08005022: 4904        ldr	r1, [pc, #16]	@ (0x5034)
@   0x08005024: 4469        add	r1, sp
@   0x08005026: 2001        movs	r0, #1
@   0x08005028: 7008        strb	r0, [r1, #0]
@   0x0800502a: a8c0        add	r0, sp, #768	@ 0x300
@   0x0800502c: 7004        strb	r4, [r0, #0]
@   0x0800502e: e134        b.n	0x529a
@   0x08005030: 5330        strh	r0, [r6, r4]
@   0x08005032: 0300        lsls	r0, r0, #12
@   0x08005034: 0301        lsls	r1, r0, #12
@   0x08005036: 0000        movs	r0, r0
@   0x08005038: acc0        add	r4, sp, #768	@ 0x300
@   0x0800503a: 4908        ldr	r1, [pc, #32]	@ (0x505c)
@   0x0800503c: 1c20        adds	r0, r4, #0
@   0x0800503e: f005        f861 	bl	0xa104
@   0x08005042: 0600        lsls	r0, r0, #24
@   0x08005044: 2800        cmp	r0, #0
@   0x08005046: d100        bne.n	0x504a
@   0x08005048: e113        b.n	0x5272
@   0x0800504a: 4905        ldr	r1, [pc, #20]	@ (0x5060)
@   0x0800504c: 4469        add	r1, sp
@   0x0800504e: 2002        movs	r0, #2
@   0x08005050: 7008        strb	r0, [r1, #0]
@   0x08005052: 4904        ldr	r1, [pc, #16]	@ (0x5064)
@   0x08005054: 2000        movs	r0, #0
@   0x08005056: 6148        str	r0, [r1, #20]
@   0x08005058: 7020        strb	r0, [r4, #0]
@   0x0800505a: e10a        b.n	0x5272
@   0x0800505c: 52cd        strh	r5, [r1, r3]
@   0x0800505e: 0800        lsrs	r0, r0, #32
@   0x08005060: 0301        lsls	r1, r0, #12
@   0x08005062: 0000        movs	r0, r0
@   0x08005064: 5330        strh	r0, [r6, r4]
@   0x08005066: 0300        lsls	r0, r0, #12
@   0x08005068: 200f        movs	r0, #15
@   0x0800506a: f016        fa53 	bl	0x1b514
@   0x0800506e: 4640        mov	r0, r8
@   0x08005070: f005        f8f2 	bl	0xa258
@   0x08005074: 4902        ldr	r1, [pc, #8]	@ (0x5080)
@   0x08005076: 4469        add	r1, sp
@   0x08005078: 2003        movs	r0, #3
@   0x0800507a: 7008        strb	r0, [r1, #0]
@   0x0800507c: e10d        b.n	0x529a
@   0x0800507e: 0000        movs	r0, r0
@   0x08005080: 0301        lsls	r1, r0, #12
@   0x08005082: 0000        movs	r0, r0
@   0x08005084: a8c0        add	r0, sp, #768	@ 0x300
@   0x08005086: f004        fe89 	bl	0x9d9c
@   0x0800508a: 2800        cmp	r0, #0
@   0x0800508c: d100        bne.n	0x5090
@   0x0800508e: e104        b.n	0x529a
@   0x08005090: 4906        ldr	r1, [pc, #24]	@ (0x50ac)
@   0x08005092: 4469        add	r1, sp
@   0x08005094: 2004        movs	r0, #4
@   0x08005096: 7008        strb	r0, [r1, #0]
@   0x08005098: 4905        ldr	r1, [pc, #20]	@ (0x50b0)
@   0x0800509a: 2000        movs	r0, #0
@   0x0800509c: 6148        str	r0, [r1, #20]
@   0x0800509e: 4805        ldr	r0, [pc, #20]	@ (0x50b4)
@   0x080050a0: 2103        movs	r1, #3
@   0x080050a2: 2204        movs	r2, #4
@   0x080050a4: f001        faac 	bl	0x6600
@   0x080050a8: e0f7        b.n	0x529a
@   0x080050aa: 0000        movs	r0, r0
@   0x080050ac: 0301        lsls	r1, r0, #12
@   0x080050ae: 0000        movs	r0, r0
@   0x080050b0: 5330        strh	r0, [r6, r4]
@   0x080050b2: 0300        lsls	r0, r0, #12
@   0x080050b4: 6110        str	r0, [r2, #16]
@   0x080050b6: 0300        lsls	r0, r0, #12
@   0x080050b8: f7fb        fa04 	bl	0x4c4
@   0x080050bc: 4906        ldr	r1, [pc, #24]	@ (0x50d8)
@   0x080050be: 8008        strh	r0, [r1, #0]
@   0x080050c0: 0400        lsls	r0, r0, #16
@   0x080050c2: 0c00        lsrs	r0, r0, #16
@   0x080050c4: 2840        cmp	r0, #64	@ 0x40
@   0x080050c6: d10b        bne.n	0x50e0
@   0x080050c8: 4904        ldr	r1, [pc, #16]	@ (0x50dc)
@   0x080050ca: 4469        add	r1, sp
@   0x080050cc: 2006        movs	r0, #6
@   0x080050ce: 7008        strb	r0, [r1, #0]
@   0x080050d0: f008        ffc6 	bl	0xe060
@   0x080050d4: e0e1        b.n	0x529a
@   0x080050d6: 0000        movs	r0, r0
@   0x080050d8: 5398        strh	r0, [r3, r6]
@   0x080050da: 0300        lsls	r0, r0, #12
@   0x080050dc: 0301        lsls	r1, r0, #12
@   0x080050de: 0000        movs	r0, r0
@   0x080050e0: 4905        ldr	r1, [pc, #20]	@ (0x50f8)
@   0x080050e2: 2208        movs	r2, #8
@   0x080050e4: 1c10        adds	r0, r2, #0
@   0x080050e6: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080050e8: 4008        ands	r0, r1
@   0x080050ea: 2800        cmp	r0, #0
@   0x080050ec: d008        beq.n	0x5100
@   0x080050ee: 4903        ldr	r1, [pc, #12]	@ (0x50fc)
@   0x080050f0: 4469        add	r1, sp
@   0x080050f2: 2005        movs	r0, #5
@   0x080050f4: 7008        strb	r0, [r1, #0]
@   0x080050f6: e0d0        b.n	0x529a
@   0x080050f8: 3720        adds	r7, #32
@   0x080050fa: 0300        lsls	r0, r0, #12
@   0x080050fc: 0301        lsls	r1, r0, #12
@   0x080050fe: 0000        movs	r0, r0
@   0x08005100: 4905        ldr	r1, [pc, #20]	@ (0x5118)
@   0x08005102: 1c10        adds	r0, r2, #0
@   0x08005104: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08005106: 4008        ands	r0, r1
@   0x08005108: 2800        cmp	r0, #0
@   0x0800510a: d009        beq.n	0x5120
@   0x0800510c: 4903        ldr	r1, [pc, #12]	@ (0x511c)
@   0x0800510e: 4469        add	r1, sp
@   0x08005110: 2009        movs	r0, #9
@   0x08005112: 7008        strb	r0, [r1, #0]
@   0x08005114: e0c1        b.n	0x529a
@   0x08005116: 0000        movs	r0, r0
@   0x08005118: 6110        str	r0, [r2, #16]
@   0x0800511a: 0300        lsls	r0, r0, #12
@   0x0800511c: 0301        lsls	r1, r0, #12
@   0x0800511e: 0000        movs	r0, r0
@   0x08005120: acc1        add	r4, sp, #772	@ 0x304
@   0x08005122: adc3        add	r5, sp, #780	@ 0x30c
@   0x08005124: f005        f8d8 	bl	0xa2d8
@   0x08005128: f7fb        fbd8 	bl	0x8dc
@   0x0800512c: f005        f8fc 	bl	0xa328
@   0x08005130: f004        f9e2 	bl	0x94f8
@   0x08005134: f004        fc26 	bl	0x9984
@   0x08005138: 4668        mov	r0, sp
@   0x0800513a: 1c21        adds	r1, r4, #0
@   0x0800513c: aa60        add	r2, sp, #384	@ 0x180
@   0x0800513e: 1c2b        adds	r3, r5, #0
@   0x08005140: f7ff        fde6 	bl	0x4d10
@   0x08005144: 4902        ldr	r1, [pc, #8]	@ (0x5150)
@   0x08005146: 6948        ldr	r0, [r1, #20]
@   0x08005148: 3001        adds	r0, #1
@   0x0800514a: 6148        str	r0, [r1, #20]
@   0x0800514c: e0a5        b.n	0x529a
@   0x0800514e: 0000        movs	r0, r0
@   0x08005150: 5330        strh	r0, [r6, r4]
@   0x08005152: 0300        lsls	r0, r0, #12
@   0x08005154: 4c1b        ldr	r4, [pc, #108]	@ (0x51c4)
@   0x08005156: 446c        add	r4, sp
@   0x08005158: adc1        add	r5, sp, #772	@ 0x304
@   0x0800515a: 27c0        movs	r7, #192	@ 0xc0
@   0x0800515c: 007f        lsls	r7, r7, #1
@   0x0800515e: aec3        add	r6, sp, #780	@ 0x30c
@   0x08005160: 4818        ldr	r0, [pc, #96]	@ (0x51c4)
@   0x08005162: 4468        add	r0, sp
@   0x08005164: f004        fd56 	bl	0x9c14
@   0x08005168: 2800        cmp	r0, #0
@   0x0800516a: d101        bne.n	0x5170
@   0x0800516c: 2008        movs	r0, #8
@   0x0800516e: 7020        strb	r0, [r4, #0]
@   0x08005170: 4915        ldr	r1, [pc, #84]	@ (0x51c8)
@   0x08005172: 2000        movs	r0, #0
@   0x08005174: 6108        str	r0, [r1, #16]
@   0x08005176: 1c0a        adds	r2, r1, #0
@   0x08005178: 322a        adds	r2, #42	@ 0x2a
@   0x0800517a: 7010        strb	r0, [r2, #0]
@   0x0800517c: 3201        adds	r2, #1
@   0x0800517e: 7010        strb	r0, [r2, #0]
@   0x08005180: 1c0c        adds	r4, r1, #0
@   0x08005182: 3433        adds	r4, #51	@ 0x33
@   0x08005184: 7820        ldrb	r0, [r4, #0]
@   0x08005186: 2801        cmp	r0, #1
@   0x08005188: d117        bne.n	0x51ba
@   0x0800518a: 4668        mov	r0, sp
@   0x0800518c: 1c29        adds	r1, r5, #0
@   0x0800518e: 221d        movs	r2, #29
@   0x08005190: f006        fe42 	bl	0xbe18
@   0x08005194: a860        add	r0, sp, #384	@ 0x180
@   0x08005196: 1c31        adds	r1, r6, #0
@   0x08005198: 221e        movs	r2, #30
@   0x0800519a: f006        fe3d 	bl	0xbe18
@   0x0800519e: 7824        ldrb	r4, [r4, #0]
@   0x080051a0: 2c01        cmp	r4, #1
@   0x080051a2: d10a        bne.n	0x51ba
@   0x080051a4: 4668        mov	r0, sp
@   0x080051a6: 1c29        adds	r1, r5, #0
@   0x080051a8: 221d        movs	r2, #29
@   0x080051aa: f006        fe35 	bl	0xbe18
@   0x080051ae: 4669        mov	r1, sp
@   0x080051b0: 19c8        adds	r0, r1, r7
@   0x080051b2: 1c31        adds	r1, r6, #0
@   0x080051b4: 221e        movs	r2, #30
@   0x080051b6: f006        fe2f 	bl	0xbe18
@   0x080051ba: a9c0        add	r1, sp, #768	@ 0x300
@   0x080051bc: 2000        movs	r0, #0
@   0x080051be: 7008        strb	r0, [r1, #0]
@   0x080051c0: e06b        b.n	0x529a
@   0x080051c2: 0000        movs	r0, r0
@   0x080051c4: 0301        lsls	r1, r0, #12
@   0x080051c6: 0000        movs	r0, r0
@   0x080051c8: 6110        str	r0, [r2, #16]
@   0x080051ca: 0300        lsls	r0, r0, #12
@   0x080051cc: f7fb        f97a 	bl	0x4c4
@   0x080051d0: 490b        ldr	r1, [pc, #44]	@ (0x5200)
@   0x080051d2: 8008        strh	r0, [r1, #0]
@   0x080051d4: f009        fa68 	bl	0xe6a8
@   0x080051d8: 0600        lsls	r0, r0, #24
@   0x080051da: 0e02        lsrs	r2, r0, #24
@   0x080051dc: 2a00        cmp	r2, #0
@   0x080051de: d105        bne.n	0x51ec
@   0x080051e0: 4808        ldr	r0, [pc, #32]	@ (0x5204)
@   0x080051e2: 4468        add	r0, sp
@   0x080051e4: 2107        movs	r1, #7
@   0x080051e6: 7001        strb	r1, [r0, #0]
@   0x080051e8: a8c0        add	r0, sp, #768	@ 0x300
@   0x080051ea: 7002        strb	r2, [r0, #0]
@   0x080051ec: 4806        ldr	r0, [pc, #24]	@ (0x5208)
@   0x080051ee: 7800        ldrb	r0, [r0, #0]
@   0x080051f0: 2800        cmp	r0, #0
@   0x080051f2: d152        bne.n	0x529a
@   0x080051f4: 4903        ldr	r1, [pc, #12]	@ (0x5204)
@   0x080051f6: 4469        add	r1, sp
@   0x080051f8: 2004        movs	r0, #4
@   0x080051fa: 7008        strb	r0, [r1, #0]
@   0x080051fc: e04d        b.n	0x529a
@   0x080051fe: 0000        movs	r0, r0
@   0x08005200: 5398        strh	r0, [r3, r6]
@   0x08005202: 0300        lsls	r0, r0, #12
@   0x08005204: 0301        lsls	r1, r0, #12
@   0x08005206: 0000        movs	r0, r0
@   0x08005208: 5328        strh	r0, [r5, r4]
@   0x0800520a: 0300        lsls	r0, r0, #12
@   0x0800520c: acc0        add	r4, sp, #768	@ 0x300
@   0x0800520e: 2000        movs	r0, #0
@   0x08005210: 5620        ldrsb	r0, [r4, r0]
@   0x08005212: 2800        cmp	r0, #0
@   0x08005214: d105        bne.n	0x5222
@   0x08005216: 20bf        movs	r0, #191	@ 0xbf
@   0x08005218: f00b        fa3c 	bl	0x10694
@   0x0800521c: 7820        ldrb	r0, [r4, #0]
@   0x0800521e: 3001        adds	r0, #1
@   0x08005220: 7020        strb	r0, [r4, #0]
@   0x08005222: 7824        ldrb	r4, [r4, #0]
@   0x08005224: 0624        lsls	r4, r4, #24
@   0x08005226: 1624        asrs	r4, r4, #24
@   0x08005228: 2c01        cmp	r4, #1
@   0x0800522a: d136        bne.n	0x529a
@   0x0800522c: f00b        fa44 	bl	0x106b8
@   0x08005230: 0600        lsls	r0, r0, #24
@   0x08005232: 2800        cmp	r0, #0
@   0x08005234: d131        bne.n	0x529a
@   0x08005236: 4803        ldr	r0, [pc, #12]	@ (0x5244)
@   0x08005238: 2104        movs	r1, #4
@   0x0800523a: 7001        strb	r1, [r0, #0]
@   0x0800523c: 7184        strb	r4, [r0, #6]
@   0x0800523e: 4802        ldr	r0, [pc, #8]	@ (0x5248)
@   0x08005240: 7241        strb	r1, [r0, #9]
@   0x08005242: e02a        b.n	0x529a
@   0x08005244: 3480        adds	r4, #128	@ 0x80
@   0x08005246: 0300        lsls	r0, r0, #12
@   0x08005248: 5330        strh	r0, [r6, r4]
@   0x0800524a: 0300        lsls	r0, r0, #12
@   0x0800524c: acc0        add	r4, sp, #768	@ 0x300
@   0x0800524e: 490a        ldr	r1, [pc, #40]	@ (0x5278)
@   0x08005250: 1c20        adds	r0, r4, #0
@   0x08005252: f004        ff57 	bl	0xa104
@   0x08005256: 0600        lsls	r0, r0, #24
@   0x08005258: 2800        cmp	r0, #0
@   0x0800525a: d00a        beq.n	0x5272
@   0x0800525c: 4907        ldr	r1, [pc, #28]	@ (0x527c)
@   0x0800525e: 4469        add	r1, sp
@   0x08005260: 2003        movs	r0, #3
@   0x08005262: 7008        strb	r0, [r1, #0]
@   0x08005264: 4906        ldr	r1, [pc, #24]	@ (0x5280)
@   0x08005266: 2000        movs	r0, #0
@   0x08005268: 6148        str	r0, [r1, #20]
@   0x0800526a: 7020        strb	r0, [r4, #0]
@   0x0800526c: 4640        mov	r0, r8
@   0x0800526e: f004        fff3 	bl	0xa258
@   0x08005272: f7fb        fb33 	bl	0x8dc
@   0x08005276: e010        b.n	0x529a
@   0x08005278: a26d        add	r2, pc, #436	@ (adr r2, 0x5430)
@   0x0800527a: 0800        lsrs	r0, r0, #32
@   0x0800527c: 0301        lsls	r1, r0, #12
@   0x0800527e: 0000        movs	r0, r0
@   0x08005280: 5330        strh	r0, [r6, r4]
@   0x08005282: 0300        lsls	r0, r0, #12
@   0x08005284: 480b        ldr	r0, [pc, #44]	@ (0x52b4)
@   0x08005286: 4a0c        ldr	r2, [pc, #48]	@ (0x52b8)
@   0x08005288: 1880        adds	r0, r0, r2
@   0x0800528a: 2108        movs	r1, #8
@   0x0800528c: 8802        ldrh	r2, [r0, #0]
@   0x0800528e: 4311        orrs	r1, r2
@   0x08005290: 8001        strh	r1, [r0, #0]
@   0x08005292: f010        fbb5 	bl	0x15a00
@   0x08005296: f008        fdf3 	bl	0xde80
@   0x0800529a: 4808        ldr	r0, [pc, #32]	@ (0x52bc)
@   0x0800529c: 7a40        ldrb	r0, [r0, #9]
@   0x0800529e: 2816        cmp	r0, #22
@   0x080052a0: d100        bne.n	0x52a4
@   0x080052a2: e691        b.n	0x4fc8
@   0x080052a4: 23c5        movs	r3, #197	@ 0xc5
@   0x080052a6: 009b        lsls	r3, r3, #2
@   0x080052a8: 449d        add	sp, r3
@   0x080052aa: bc08        pop	{r3}
@   0x080052ac: 4698        mov	r8, r3
@   0x080052ae: bcf0        pop	{r4, r5, r6, r7}
@   0x080052b0: bc01        pop	{r0}
@   0x080052b2: 4700        bx	r0
@   0x080052b4: 3720        adds	r7, #32
@   0x080052b6: 0300        lsls	r0, r0, #12
@   0x080052b8: 0504        lsls	r4, r0, #20
@   0x080052ba: 0000        movs	r0, r0
@   0x080052bc: 5330        strh	r0, [r6, r4]
@   0x080052be: 0300        lsls	r0, r0, #12

        thumb_func_start SceneLoop_22
SceneLoop_22: @ 0x08004fac
        .incbin "frog_us_baserom.gba", 0x4fac, 0x314
        thumb_func_end SceneLoop_22
