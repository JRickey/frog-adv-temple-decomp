@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08010f64, 0x08011288)  (804 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8010f64 --end 0x8011288 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08010f64: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08010f66: 4657        mov	r7, sl
@   0x08010f68: 464e        mov	r6, r9
@   0x08010f6a: 4645        mov	r5, r8
@   0x08010f6c: b4e0        push	{r5, r6, r7}
@   0x08010f6e: b081        sub	sp, #4
@   0x08010f70: 4681        mov	r9, r0
@   0x08010f72: 0609        lsls	r1, r1, #24
@   0x08010f74: 0e09        lsrs	r1, r1, #24
@   0x08010f76: 468c        mov	ip, r1
@   0x08010f78: 4a16        ldr	r2, [pc, #88]	@ (0x10fd4)
@   0x08010f7a: 7890        ldrb	r0, [r2, #2]
@   0x08010f7c: 4108        asrs	r0, r1
@   0x08010f7e: 2101        movs	r1, #1
@   0x08010f80: 4008        ands	r0, r1
@   0x08010f82: 1c16        adds	r6, r2, #0
@   0x08010f84: 2800        cmp	r0, #0
@   0x08010f86: d100        bne.n	0x10f8a
@   0x08010f88: e174        b.n	0x11274
@   0x08010f8a: 4c13        ldr	r4, [pc, #76]	@ (0x10fd8)
@   0x08010f8c: 4d13        ldr	r5, [pc, #76]	@ (0x10fdc)
@   0x08010f8e: 7aa9        ldrb	r1, [r5, #10]
@   0x08010f90: 3901        subs	r1, #1
@   0x08010f92: 0088        lsls	r0, r1, #2
@   0x08010f94: 1840        adds	r0, r0, r1
@   0x08010f96: 0080        lsls	r0, r0, #2
@   0x08010f98: 1c21        adds	r1, r4, #0
@   0x08010f9a: 310c        adds	r1, #12
@   0x08010f9c: 1840        adds	r0, r0, r1
@   0x08010f9e: 6801        ldr	r1, [r0, #0]
@   0x08010fa0: 4660        mov	r0, ip
@   0x08010fa2: 0043        lsls	r3, r0, #1
@   0x08010fa4: 1859        adds	r1, r3, r1
@   0x08010fa6: 4a0e        ldr	r2, [pc, #56]	@ (0x10fe0)
@   0x08010fa8: 1880        adds	r0, r0, r2
@   0x08010faa: 7800        ldrb	r0, [r0, #0]
@   0x08010fac: 7809        ldrb	r1, [r1, #0]
@   0x08010fae: 1841        adds	r1, r0, r1
@   0x08010fb0: 0048        lsls	r0, r1, #1
@   0x08010fb2: 1840        adds	r0, r0, r1
@   0x08010fb4: 00c0        lsls	r0, r0, #3
@   0x08010fb6: 4649        mov	r1, r9
@   0x08010fb8: 180f        adds	r7, r1, r0
@   0x08010fba: 200f        movs	r0, #15
@   0x08010fbc: 7a39        ldrb	r1, [r7, #8]
@   0x08010fbe: 4008        ands	r0, r1
@   0x08010fc0: 4698        mov	r8, r3
@   0x08010fc2: 4692        mov	sl, r2
@   0x08010fc4: 2802        cmp	r0, #2
@   0x08010fc6: d063        beq.n	0x11090
@   0x08010fc8: 2802        cmp	r0, #2
@   0x08010fca: dc0b        bgt.n	0x10fe4
@   0x08010fcc: 2801        cmp	r0, #1
@   0x08010fce: d010        beq.n	0x10ff2
@   0x08010fd0: e116        b.n	0x11200
@   0x08010fd2: 0000        movs	r0, r0
@   0x08010fd4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010fd6: 0300        lsls	r0, r0, #12
@   0x08010fd8: 7eac        ldrb	r4, [r5, #26]
@   0x08010fda: 0830        lsrs	r0, r6, #32
@   0x08010fdc: 5330        strh	r0, [r6, r4]
@   0x08010fde: 0300        lsls	r0, r0, #12
@   0x08010fe0: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x08010fe2: 0300        lsls	r0, r0, #12
@   0x08010fe4: 2803        cmp	r0, #3
@   0x08010fe6: d100        bne.n	0x10fea
@   0x08010fe8: e080        b.n	0x110ec
@   0x08010fea: 2804        cmp	r0, #4
@   0x08010fec: d100        bne.n	0x10ff0
@   0x08010fee: e0b1        b.n	0x11154
@   0x08010ff0: e106        b.n	0x11200
@   0x08010ff2: 6828        ldr	r0, [r5, #0]
@   0x08010ff4: 6871        ldr	r1, [r6, #4]
@   0x08010ff6: 1a40        subs	r0, r0, r1
@   0x08010ff8: 7af2        ldrb	r2, [r6, #11]
@   0x08010ffa: 4290        cmp	r0, r2
@   0x08010ffc: d328        bcc.n	0x11050
@   0x08010ffe: 69b0        ldr	r0, [r6, #24]
@   0x08011000: 6170        str	r0, [r6, #20]
@   0x08011002: 4920        ldr	r1, [pc, #128]	@ (0x11084)
@   0x08011004: 8b49        ldrh	r1, [r1, #26]
@   0x08011006: 0049        lsls	r1, r1, #1
@   0x08011008: 1840        adds	r0, r0, r1
@   0x0801100a: 61b0        str	r0, [r6, #24]
@   0x0801100c: 6930        ldr	r0, [r6, #16]
@   0x0801100e: 60f0        str	r0, [r6, #12]
@   0x08011010: 88bf        ldrh	r7, [r7, #4]
@   0x08011012: 0079        lsls	r1, r7, #1
@   0x08011014: 1840        adds	r0, r0, r1
@   0x08011016: 6130        str	r0, [r6, #16]
@   0x08011018: 232e        movs	r3, #46	@ 0x2e
@   0x0801101a: 5ef0        ldrsh	r0, [r6, r3]
@   0x0801101c: 2800        cmp	r0, #0
@   0x0801101e: d01c        beq.n	0x1105a
@   0x08011020: 2400        movs	r4, #0
@   0x08011022: 8e37        ldrh	r7, [r6, #48]	@ 0x30
@   0x08011024: 42bc        cmp	r4, r7
@   0x08011026: d20e        bcs.n	0x11046
@   0x08011028: 1c33        adds	r3, r6, #0
@   0x0801102a: 695a        ldr	r2, [r3, #20]
@   0x0801102c: 68d9        ldr	r1, [r3, #12]
@   0x0801102e: 8808        ldrh	r0, [r1, #0]
@   0x08011030: 8010        strh	r0, [r2, #0]
@   0x08011032: 3102        adds	r1, #2
@   0x08011034: 60d9        str	r1, [r3, #12]
@   0x08011036: 3202        adds	r2, #2
@   0x08011038: 615a        str	r2, [r3, #20]
@   0x0801103a: 1c60        adds	r0, r4, #1
@   0x0801103c: 0600        lsls	r0, r0, #24
@   0x0801103e: 0e04        lsrs	r4, r0, #24
@   0x08011040: 8e18        ldrh	r0, [r3, #48]	@ 0x30
@   0x08011042: 4284        cmp	r4, r0
@   0x08011044: d3f1        bcc.n	0x1102a
@   0x08011046: 8df0        ldrh	r0, [r6, #46]	@ 0x2e
@   0x08011048: 3801        subs	r0, #1
@   0x0801104a: 85f0        strh	r0, [r6, #46]	@ 0x2e
@   0x0801104c: 6828        ldr	r0, [r5, #0]
@   0x0801104e: 6070        str	r0, [r6, #4]
@   0x08011050: 212e        movs	r1, #46	@ 0x2e
@   0x08011052: 5e70        ldrsh	r0, [r6, r1]
@   0x08011054: 2800        cmp	r0, #0
@   0x08011056: d000        beq.n	0x1105a
@   0x08011058: e0d2        b.n	0x11200
@   0x0801105a: 4662        mov	r2, ip
@   0x0801105c: 4452        add	r2, sl
@   0x0801105e: 7815        ldrb	r5, [r2, #0]
@   0x08011060: 4809        ldr	r0, [pc, #36]	@ (0x11088)
@   0x08011062: 7a81        ldrb	r1, [r0, #10]
@   0x08011064: 3901        subs	r1, #1
@   0x08011066: 0088        lsls	r0, r1, #2
@   0x08011068: 1840        adds	r0, r0, r1
@   0x0801106a: 0080        lsls	r0, r0, #2
@   0x0801106c: 4907        ldr	r1, [pc, #28]	@ (0x1108c)
@   0x0801106e: 310c        adds	r1, #12
@   0x08011070: 1840        adds	r0, r0, r1
@   0x08011072: 6800        ldr	r0, [r0, #0]
@   0x08011074: 4440        add	r0, r8
@   0x08011076: 7840        ldrb	r0, [r0, #1]
@   0x08011078: 3801        subs	r0, #1
@   0x0801107a: 4285        cmp	r5, r0
@   0x0801107c: da00        bge.n	0x11080
@   0x0801107e: e0ad        b.n	0x111dc
@   0x08011080: e0ba        b.n	0x111f8
@   0x08011082: 0000        movs	r0, r0
@   0x08011084: 60a0        str	r0, [r4, #8]
@   0x08011086: 0300        lsls	r0, r0, #12
@   0x08011088: 5330        strh	r0, [r6, r4]
@   0x0801108a: 0300        lsls	r0, r0, #12
@   0x0801108c: 7eac        ldrb	r4, [r5, #26]
@   0x0801108e: 0830        lsrs	r0, r6, #32
@   0x08011090: 6828        ldr	r0, [r5, #0]
@   0x08011092: 6871        ldr	r1, [r6, #4]
@   0x08011094: 1a40        subs	r0, r0, r1
@   0x08011096: 7af2        ldrb	r2, [r6, #11]
@   0x08011098: 4290        cmp	r0, r2
@   0x0801109a: d3d9        bcc.n	0x11050
@   0x0801109c: 69b0        ldr	r0, [r6, #24]
@   0x0801109e: 6170        str	r0, [r6, #20]
@   0x080110a0: 4911        ldr	r1, [pc, #68]	@ (0x110e8)
@   0x080110a2: 8b49        ldrh	r1, [r1, #26]
@   0x080110a4: 0049        lsls	r1, r1, #1
@   0x080110a6: 1a40        subs	r0, r0, r1
@   0x080110a8: 61b0        str	r0, [r6, #24]
@   0x080110aa: 6930        ldr	r0, [r6, #16]
@   0x080110ac: 60f0        str	r0, [r6, #12]
@   0x080110ae: 88bf        ldrh	r7, [r7, #4]
@   0x080110b0: 0079        lsls	r1, r7, #1
@   0x080110b2: 1a40        subs	r0, r0, r1
@   0x080110b4: 6130        str	r0, [r6, #16]
@   0x080110b6: 232e        movs	r3, #46	@ 0x2e
@   0x080110b8: 5ef0        ldrsh	r0, [r6, r3]
@   0x080110ba: 2800        cmp	r0, #0
@   0x080110bc: d0cd        beq.n	0x1105a
@   0x080110be: 2400        movs	r4, #0
@   0x080110c0: 8e37        ldrh	r7, [r6, #48]	@ 0x30
@   0x080110c2: 42bc        cmp	r4, r7
@   0x080110c4: d2bf        bcs.n	0x11046
@   0x080110c6: 1c33        adds	r3, r6, #0
@   0x080110c8: 695a        ldr	r2, [r3, #20]
@   0x080110ca: 68d9        ldr	r1, [r3, #12]
@   0x080110cc: 8808        ldrh	r0, [r1, #0]
@   0x080110ce: 8010        strh	r0, [r2, #0]
@   0x080110d0: 3102        adds	r1, #2
@   0x080110d2: 60d9        str	r1, [r3, #12]
@   0x080110d4: 3202        adds	r2, #2
@   0x080110d6: 615a        str	r2, [r3, #20]
@   0x080110d8: 1c60        adds	r0, r4, #1
@   0x080110da: 0600        lsls	r0, r0, #24
@   0x080110dc: 0e04        lsrs	r4, r0, #24
@   0x080110de: 8e18        ldrh	r0, [r3, #48]	@ 0x30
@   0x080110e0: 4284        cmp	r4, r0
@   0x080110e2: d3f1        bcc.n	0x110c8
@   0x080110e4: e7af        b.n	0x11046
@   0x080110e6: 0000        movs	r0, r0
@   0x080110e8: 60a0        str	r0, [r4, #8]
@   0x080110ea: 0300        lsls	r0, r0, #12
@   0x080110ec: 6828        ldr	r0, [r5, #0]
@   0x080110ee: 6871        ldr	r1, [r6, #4]
@   0x080110f0: 1a40        subs	r0, r0, r1
@   0x080110f2: 7af2        ldrb	r2, [r6, #11]
@   0x080110f4: 4290        cmp	r0, r2
@   0x080110f6: d327        bcc.n	0x11148
@   0x080110f8: 69b2        ldr	r2, [r6, #24]
@   0x080110fa: 6172        str	r2, [r6, #20]
@   0x080110fc: 1c90        adds	r0, r2, #2
@   0x080110fe: 61b0        str	r0, [r6, #24]
@   0x08011100: 6931        ldr	r1, [r6, #16]
@   0x08011102: 60f1        str	r1, [r6, #12]
@   0x08011104: 1c88        adds	r0, r1, #2
@   0x08011106: 6130        str	r0, [r6, #16]
@   0x08011108: 232c        movs	r3, #44	@ 0x2c
@   0x0801110a: 5ef0        ldrsh	r0, [r6, r3]
@   0x0801110c: 2800        cmp	r0, #0
@   0x0801110e: d0a4        beq.n	0x1105a
@   0x08011110: 2300        movs	r3, #0
@   0x08011112: 8e77        ldrh	r7, [r6, #50]	@ 0x32
@   0x08011114: 42bb        cmp	r3, r7
@   0x08011116: d212        bcs.n	0x1113e
@   0x08011118: 1c34        adds	r4, r6, #0
@   0x0801111a: 8808        ldrh	r0, [r1, #0]
@   0x0801111c: 8010        strh	r0, [r2, #0]
@   0x0801111e: 480c        ldr	r0, [pc, #48]	@ (0x11150)
@   0x08011120: 8b40        ldrh	r0, [r0, #26]
@   0x08011122: 0040        lsls	r0, r0, #1
@   0x08011124: 9000        str	r0, [sp, #0]
@   0x08011126: 1812        adds	r2, r2, r0
@   0x08011128: 8e27        ldrh	r7, [r4, #48]	@ 0x30
@   0x0801112a: 0078        lsls	r0, r7, #1
@   0x0801112c: 1809        adds	r1, r1, r0
@   0x0801112e: 1c58        adds	r0, r3, #1
@   0x08011130: 0600        lsls	r0, r0, #24
@   0x08011132: 0e03        lsrs	r3, r0, #24
@   0x08011134: 8e60        ldrh	r0, [r4, #50]	@ 0x32
@   0x08011136: 4283        cmp	r3, r0
@   0x08011138: d3ef        bcc.n	0x1111a
@   0x0801113a: 60e1        str	r1, [r4, #12]
@   0x0801113c: 6162        str	r2, [r4, #20]
@   0x0801113e: 8db0        ldrh	r0, [r6, #44]	@ 0x2c
@   0x08011140: 3801        subs	r0, #1
@   0x08011142: 85b0        strh	r0, [r6, #44]	@ 0x2c
@   0x08011144: 6828        ldr	r0, [r5, #0]
@   0x08011146: 6070        str	r0, [r6, #4]
@   0x08011148: 212c        movs	r1, #44	@ 0x2c
@   0x0801114a: 5e70        ldrsh	r0, [r6, r1]
@   0x0801114c: e782        b.n	0x11054
@   0x0801114e: 0000        movs	r0, r0
@   0x08011150: 60a0        str	r0, [r4, #8]
@   0x08011152: 0300        lsls	r0, r0, #12
@   0x08011154: 6828        ldr	r0, [r5, #0]
@   0x08011156: 6871        ldr	r1, [r6, #4]
@   0x08011158: 1a40        subs	r0, r0, r1
@   0x0801115a: 7af2        ldrb	r2, [r6, #11]
@   0x0801115c: 4290        cmp	r0, r2
@   0x0801115e: d327        bcc.n	0x111b0
@   0x08011160: 69b2        ldr	r2, [r6, #24]
@   0x08011162: 6172        str	r2, [r6, #20]
@   0x08011164: 1e90        subs	r0, r2, #2
@   0x08011166: 61b0        str	r0, [r6, #24]
@   0x08011168: 6931        ldr	r1, [r6, #16]
@   0x0801116a: 60f1        str	r1, [r6, #12]
@   0x0801116c: 1e88        subs	r0, r1, #2
@   0x0801116e: 6130        str	r0, [r6, #16]
@   0x08011170: 232c        movs	r3, #44	@ 0x2c
@   0x08011172: 5ef0        ldrsh	r0, [r6, r3]
@   0x08011174: 2800        cmp	r0, #0
@   0x08011176: d01f        beq.n	0x111b8
@   0x08011178: 2300        movs	r3, #0
@   0x0801117a: 8e77        ldrh	r7, [r6, #50]	@ 0x32
@   0x0801117c: 42bb        cmp	r3, r7
@   0x0801117e: d212        bcs.n	0x111a6
@   0x08011180: 1c34        adds	r4, r6, #0
@   0x08011182: 8808        ldrh	r0, [r1, #0]
@   0x08011184: 8010        strh	r0, [r2, #0]
@   0x08011186: 4819        ldr	r0, [pc, #100]	@ (0x111ec)
@   0x08011188: 8b40        ldrh	r0, [r0, #26]
@   0x0801118a: 0040        lsls	r0, r0, #1
@   0x0801118c: 9000        str	r0, [sp, #0]
@   0x0801118e: 1812        adds	r2, r2, r0
@   0x08011190: 8e27        ldrh	r7, [r4, #48]	@ 0x30
@   0x08011192: 0078        lsls	r0, r7, #1
@   0x08011194: 1809        adds	r1, r1, r0
@   0x08011196: 1c58        adds	r0, r3, #1
@   0x08011198: 0600        lsls	r0, r0, #24
@   0x0801119a: 0e03        lsrs	r3, r0, #24
@   0x0801119c: 8e60        ldrh	r0, [r4, #50]	@ 0x32
@   0x0801119e: 4283        cmp	r3, r0
@   0x080111a0: d3ef        bcc.n	0x11182
@   0x080111a2: 60e1        str	r1, [r4, #12]
@   0x080111a4: 6162        str	r2, [r4, #20]
@   0x080111a6: 8db0        ldrh	r0, [r6, #44]	@ 0x2c
@   0x080111a8: 3801        subs	r0, #1
@   0x080111aa: 85b0        strh	r0, [r6, #44]	@ 0x2c
@   0x080111ac: 6828        ldr	r0, [r5, #0]
@   0x080111ae: 6070        str	r0, [r6, #4]
@   0x080111b0: 212c        movs	r1, #44	@ 0x2c
@   0x080111b2: 5e70        ldrsh	r0, [r6, r1]
@   0x080111b4: 2800        cmp	r0, #0
@   0x080111b6: d123        bne.n	0x11200
@   0x080111b8: 4662        mov	r2, ip
@   0x080111ba: 4452        add	r2, sl
@   0x080111bc: 7815        ldrb	r5, [r2, #0]
@   0x080111be: 480c        ldr	r0, [pc, #48]	@ (0x111f0)
@   0x080111c0: 7a81        ldrb	r1, [r0, #10]
@   0x080111c2: 3901        subs	r1, #1
@   0x080111c4: 0088        lsls	r0, r1, #2
@   0x080111c6: 1840        adds	r0, r0, r1
@   0x080111c8: 0080        lsls	r0, r0, #2
@   0x080111ca: 490a        ldr	r1, [pc, #40]	@ (0x111f4)
@   0x080111cc: 310c        adds	r1, #12
@   0x080111ce: 1840        adds	r0, r0, r1
@   0x080111d0: 6800        ldr	r0, [r0, #0]
@   0x080111d2: 4440        add	r0, r8
@   0x080111d4: 7840        ldrb	r0, [r0, #1]
@   0x080111d6: 3801        subs	r0, #1
@   0x080111d8: 4285        cmp	r5, r0
@   0x080111da: da0d        bge.n	0x111f8
@   0x080111dc: 1c68        adds	r0, r5, #1
@   0x080111de: 7010        strb	r0, [r2, #0]
@   0x080111e0: 4648        mov	r0, r9
@   0x080111e2: 4661        mov	r1, ip
@   0x080111e4: 2200        movs	r2, #0
@   0x080111e6: f7ff        fdf7 	bl	0x10dd8
@   0x080111ea: e009        b.n	0x11200
@   0x080111ec: 60a0        str	r0, [r4, #8]
@   0x080111ee: 0300        lsls	r0, r0, #12
@   0x080111f0: 5330        strh	r0, [r6, r4]
@   0x080111f2: 0300        lsls	r0, r0, #12
@   0x080111f4: 7eac        ldrb	r4, [r5, #26]
@   0x080111f6: 0830        lsrs	r0, r6, #32
@   0x080111f8: 2100        movs	r1, #0
@   0x080111fa: 7011        strb	r1, [r2, #0]
@   0x080111fc: 4812        ldr	r0, [pc, #72]	@ (0x11248)
@   0x080111fe: 7081        strb	r1, [r0, #2]
@   0x08011200: 4d12        ldr	r5, [pc, #72]	@ (0x1124c)
@   0x08011202: 7aaa        ldrb	r2, [r5, #10]
@   0x08011204: 2a0b        cmp	r2, #11
@   0x08011206: d002        beq.n	0x1120e
@   0x08011208: 200b        movs	r0, #11
@   0x0801120a: f00f        fddb 	bl	0x20dc4
@   0x0801120e: 480e        ldr	r0, [pc, #56]	@ (0x11248)
@   0x08011210: 7884        ldrb	r4, [r0, #2]
@   0x08011212: 1c06        adds	r6, r0, #0
@   0x08011214: 2c00        cmp	r4, #0
@   0x08011216: d10f        bne.n	0x11238
@   0x08011218: 7aad        ldrb	r5, [r5, #10]
@   0x0801121a: 2d0b        cmp	r5, #11
@   0x0801121c: d005        beq.n	0x1122a
@   0x0801121e: 200b        movs	r0, #11
@   0x08011220: f00f        fe2c 	bl	0x20e7c
@   0x08011224: 2082        movs	r0, #130	@ 0x82
@   0x08011226: f00f        fd27 	bl	0x20c78
@   0x0801122a: 7034        strb	r4, [r6, #0]
@   0x0801122c: 4908        ldr	r1, [pc, #32]	@ (0x11250)
@   0x0801122e: 4809        ldr	r0, [pc, #36]	@ (0x11254)
@   0x08011230: 8a0b        ldrh	r3, [r1, #16]
@   0x08011232: 4018        ands	r0, r3
@   0x08011234: 8208        strh	r0, [r1, #16]
@   0x08011236: 824c        strh	r4, [r1, #18]
@   0x08011238: 7a30        ldrb	r0, [r6, #8]
@   0x0801123a: 2800        cmp	r0, #0
@   0x0801123c: d010        beq.n	0x11260
@   0x0801123e: 4806        ldr	r0, [pc, #24]	@ (0x11258)
@   0x08011240: 60f0        str	r0, [r6, #12]
@   0x08011242: 4806        ldr	r0, [pc, #24]	@ (0x1125c)
@   0x08011244: e010        b.n	0x11268
@   0x08011246: 0000        movs	r0, r0
@   0x08011248: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801124a: 0300        lsls	r0, r0, #12
@   0x0801124c: 5330        strh	r0, [r6, r4]
@   0x0801124e: 0300        lsls	r0, r0, #12
@   0x08011250: 35e0        adds	r5, #224	@ 0xe0
@   0x08011252: 0300        lsls	r0, r0, #12
@   0x08011254: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08011258: 0000        movs	r0, r0
@   0x0801125a: 0201        lsls	r1, r0, #8
@   0x0801125c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08011260: 2080        movs	r0, #128	@ 0x80
@   0x08011262: 0480        lsls	r0, r0, #18
@   0x08011264: 60f0        str	r0, [r6, #12]
@   0x08011266: 4807        ldr	r0, [pc, #28]	@ (0x11284)
@   0x08011268: 6170        str	r0, [r6, #20]
@   0x0801126a: 7a30        ldrb	r0, [r6, #8]
@   0x0801126c: 68f1        ldr	r1, [r6, #12]
@   0x0801126e: 6972        ldr	r2, [r6, #20]
@   0x08011270: f7fe        ff38 	bl	0x100e4
@   0x08011274: b001        add	sp, #4
@   0x08011276: bc38        pop	{r3, r4, r5}
@   0x08011278: 4698        mov	r8, r3
@   0x0801127a: 46a1        mov	r9, r4
@   0x0801127c: 46aa        mov	sl, r5
@   0x0801127e: bcf0        pop	{r4, r5, r6, r7}
@   0x08011280: bc01        pop	{r0}
@   0x08011282: 4700        bx	r0
@   0x08011284: e000        b.n	0x11288
@   0x08011286: 0600        lsls	r0, r0, #24

        thumb_func_start Scroll_TickBlitDir
Scroll_TickBlitDir: @ 0x08010f64
        .incbin "frog_us_baserom.gba", 0x10f64, 0x324
        thumb_func_end Scroll_TickBlitDir
