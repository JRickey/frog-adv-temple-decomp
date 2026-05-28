@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002ee8, 0x080031d4)  (748 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002ee8 --end 0x80031d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002ee8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08002eea: 4657        mov	r7, sl
@   0x08002eec: 464e        mov	r6, r9
@   0x08002eee: 4645        mov	r5, r8
@   0x08002ef0: b4e0        push	{r5, r6, r7}
@   0x08002ef2: 4688        mov	r8, r1
@   0x08002ef4: 0600        lsls	r0, r0, #24
@   0x08002ef6: 0e00        lsrs	r0, r0, #24
@   0x08002ef8: 4681        mov	r9, r0
@   0x08002efa: 4d0b        ldr	r5, [pc, #44]	@ (0x2f28)
@   0x08002efc: 6928        ldr	r0, [r5, #16]
@   0x08002efe: 2801        cmp	r0, #1
@   0x08002f00: d144        bne.n	0x2f8c
@   0x08002f02: 4c0a        ldr	r4, [pc, #40]	@ (0x2f2c)
@   0x08002f04: 4a0a        ldr	r2, [pc, #40]	@ (0x2f30)
@   0x08002f06: 2104        movs	r1, #4
@   0x08002f08: 5e50        ldrsh	r0, [r2, r1]
@   0x08002f0a: 4643        mov	r3, r8
@   0x08002f0c: 2600        movs	r6, #0
@   0x08002f0e: 5f99        ldrsh	r1, [r3, r6]
@   0x08002f10: 1a40        subs	r0, r0, r1
@   0x08002f12: 6921        ldr	r1, [r4, #16]
@   0x08002f14: 1c13        adds	r3, r2, #0
@   0x08002f16: 4281        cmp	r1, r0
@   0x08002f18: d10c        bne.n	0x2f34
@   0x08002f1a: 68e0        ldr	r0, [r4, #12]
@   0x08002f1c: 2800        cmp	r0, #0
@   0x08002f1e: d109        bne.n	0x2f34
@   0x08002f20: 2002        movs	r0, #2
@   0x08002f22: 6128        str	r0, [r5, #16]
@   0x08002f24: e032        b.n	0x2f8c
@   0x08002f26: 0000        movs	r0, r0
@   0x08002f28: 6110        str	r0, [r2, #16]
@   0x08002f2a: 0300        lsls	r0, r0, #12
@   0x08002f2c: 60a0        str	r0, [r4, #8]
@   0x08002f2e: 0300        lsls	r0, r0, #12
@   0x08002f30: 3720        adds	r7, #32
@   0x08002f32: 0300        lsls	r0, r0, #12
@   0x08002f34: 2200        movs	r2, #0
@   0x08002f36: 464f        mov	r7, r9
@   0x08002f38: 0638        lsls	r0, r7, #24
@   0x08002f3a: 1600        asrs	r0, r0, #24
@   0x08002f3c: 492e        ldr	r1, [pc, #184]	@ (0x2ff8)
@   0x08002f3e: 468a        mov	sl, r1
@   0x08002f40: 4282        cmp	r2, r0
@   0x08002f42: da1f        bge.n	0x2f84
@   0x08002f44: 4d2d        ldr	r5, [pc, #180]	@ (0x2ffc)
@   0x08002f46: 4684        mov	ip, r0
@   0x08002f48: 0610        lsls	r0, r2, #24
@   0x08002f4a: 1604        asrs	r4, r0, #24
@   0x08002f4c: 0162        lsls	r2, r4, #5
@   0x08002f4e: 1c28        adds	r0, r5, #0
@   0x08002f50: 300c        adds	r0, #12
@   0x08002f52: 1811        adds	r1, r2, r0
@   0x08002f54: 6808        ldr	r0, [r1, #0]
@   0x08002f56: 2800        cmp	r0, #0
@   0x08002f58: dd01        ble.n	0x2f5e
@   0x08002f5a: 3801        subs	r0, #1
@   0x08002f5c: 6008        str	r0, [r1, #0]
@   0x08002f5e: 4e28        ldr	r6, [pc, #160]	@ (0x3000)
@   0x08002f60: 1992        adds	r2, r2, r6
@   0x08002f62: 2704        movs	r7, #4
@   0x08002f64: 5fd9        ldrsh	r1, [r3, r7]
@   0x08002f66: 4646        mov	r6, r8
@   0x08002f68: 2700        movs	r7, #0
@   0x08002f6a: 5ff0        ldrsh	r0, [r6, r7]
@   0x08002f6c: 1a09        subs	r1, r1, r0
@   0x08002f6e: 6810        ldr	r0, [r2, #0]
@   0x08002f70: 4288        cmp	r0, r1
@   0x08002f72: d001        beq.n	0x2f78
@   0x08002f74: 3801        subs	r0, #1
@   0x08002f76: 6010        str	r0, [r2, #0]
@   0x08002f78: 1c60        adds	r0, r4, #1
@   0x08002f7a: 0600        lsls	r0, r0, #24
@   0x08002f7c: 0e02        lsrs	r2, r0, #24
@   0x08002f7e: 1600        asrs	r0, r0, #24
@   0x08002f80: 4560        cmp	r0, ip
@   0x08002f82: dbe1        blt.n	0x2f48
@   0x08002f84: 4650        mov	r0, sl
@   0x08002f86: 2101        movs	r1, #1
@   0x08002f88: f003        fdfe 	bl	0x6b88
@   0x08002f8c: 481d        ldr	r0, [pc, #116]	@ (0x3004)
@   0x08002f8e: 6901        ldr	r1, [r0, #16]
@   0x08002f90: 4682        mov	sl, r0
@   0x08002f92: 2902        cmp	r1, #2
@   0x08002f94: d11b        bne.n	0x2fce
@   0x08002f96: 4648        mov	r0, r9
@   0x08002f98: 0603        lsls	r3, r0, #24
@   0x08002f9a: 2200        movs	r2, #0
@   0x08002f9c: 2b00        cmp	r3, #0
@   0x08002f9e: dd16        ble.n	0x2fce
@   0x08002fa0: 4c19        ldr	r4, [pc, #100]	@ (0x3008)
@   0x08002fa2: 1d21        adds	r1, r4, #4
@   0x08002fa4: 468c        mov	ip, r1
@   0x08002fa6: 4e19        ldr	r6, [pc, #100]	@ (0x300c)
@   0x08002fa8: 4647        mov	r7, r8
@   0x08002faa: 2000        movs	r0, #0
@   0x08002fac: 5e3d        ldrsh	r5, [r7, r0]
@   0x08002fae: 0611        lsls	r1, r2, #24
@   0x08002fb0: 1609        asrs	r1, r1, #24
@   0x08002fb2: 014a        lsls	r2, r1, #5
@   0x08002fb4: 1910        adds	r0, r2, r4
@   0x08002fb6: 2700        movs	r7, #0
@   0x08002fb8: 6007        str	r7, [r0, #0]
@   0x08002fba: 4462        add	r2, ip
@   0x08002fbc: 2704        movs	r7, #4
@   0x08002fbe: 5ff0        ldrsh	r0, [r6, r7]
@   0x08002fc0: 1b40        subs	r0, r0, r5
@   0x08002fc2: 6010        str	r0, [r2, #0]
@   0x08002fc4: 3101        adds	r1, #1
@   0x08002fc6: 0609        lsls	r1, r1, #24
@   0x08002fc8: 0e0a        lsrs	r2, r1, #24
@   0x08002fca: 4299        cmp	r1, r3
@   0x08002fcc: dbef        blt.n	0x2fae
@   0x08002fce: 4651        mov	r1, sl
@   0x08002fd0: 6908        ldr	r0, [r1, #16]
@   0x08002fd2: 2804        cmp	r0, #4
@   0x08002fd4: d000        beq.n	0x2fd8
@   0x08002fd6: e096        b.n	0x3106
@   0x08002fd8: 4807        ldr	r0, [pc, #28]	@ (0x2ff8)
@   0x08002fda: 7b80        ldrb	r0, [r0, #14]
@   0x08002fdc: 2802        cmp	r0, #2
@   0x08002fde: d13f        bne.n	0x3060
@   0x08002fe0: 480a        ldr	r0, [pc, #40]	@ (0x300c)
@   0x08002fe2: 1c03        adds	r3, r0, #0
@   0x08002fe4: 885a        ldrh	r2, [r3, #2]
@   0x08002fe6: 2a83        cmp	r2, #131	@ 0x83
@   0x08002fe8: d114        bne.n	0x3014
@   0x08002fea: 4809        ldr	r0, [pc, #36]	@ (0x3010)
@   0x08002fec: 889e        ldrh	r6, [r3, #4]
@   0x08002fee: 4286        cmp	r6, r0
@   0x08002ff0: d110        bne.n	0x3014
@   0x08002ff2: 2005        movs	r0, #5
@   0x08002ff4: 6108        str	r0, [r1, #16]
@   0x08002ff6: e06a        b.n	0x30ce
@   0x08002ff8: 35e0        adds	r5, #224	@ 0xe0
@   0x08002ffa: 0300        lsls	r0, r0, #12
@   0x08002ffc: 60a0        str	r0, [r4, #8]
@   0x08002ffe: 0300        lsls	r0, r0, #12
@   0x08003000: 60b0        str	r0, [r6, #8]
@   0x08003002: 0300        lsls	r0, r0, #12
@   0x08003004: 6110        str	r0, [r2, #16]
@   0x08003006: 0300        lsls	r0, r0, #12
@   0x08003008: 60ac        str	r4, [r5, #8]
@   0x0800300a: 0300        lsls	r0, r0, #12
@   0x0800300c: 3720        adds	r7, #32
@   0x0800300e: 0300        lsls	r0, r0, #12
@   0x08003010: 090b        lsrs	r3, r1, #4
@   0x08003012: 0000        movs	r0, r0
@   0x08003014: 8859        ldrh	r1, [r3, #2]
@   0x08003016: 2702        movs	r7, #2
@   0x08003018: 5fd8        ldrsh	r0, [r3, r7]
@   0x0800301a: 2883        cmp	r0, #131	@ 0x83
@   0x0800301c: dd06        ble.n	0x302c
@   0x0800301e: 1e48        subs	r0, r1, #1
@   0x08003020: 8058        strh	r0, [r3, #2]
@   0x08003022: 1c19        adds	r1, r3, #0
@   0x08003024: 3172        adds	r1, #114	@ 0x72
@   0x08003026: 8808        ldrh	r0, [r1, #0]
@   0x08003028: 3801        subs	r0, #1
@   0x0800302a: 8008        strh	r0, [r1, #0]
@   0x0800302c: 8859        ldrh	r1, [r3, #2]
@   0x0800302e: 2202        movs	r2, #2
@   0x08003030: 5e98        ldrsh	r0, [r3, r2]
@   0x08003032: 2882        cmp	r0, #130	@ 0x82
@   0x08003034: dc06        bgt.n	0x3044
@   0x08003036: 1c48        adds	r0, r1, #1
@   0x08003038: 8058        strh	r0, [r3, #2]
@   0x0800303a: 1c19        adds	r1, r3, #0
@   0x0800303c: 3172        adds	r1, #114	@ 0x72
@   0x0800303e: 8808        ldrh	r0, [r1, #0]
@   0x08003040: 3001        adds	r0, #1
@   0x08003042: 8008        strh	r0, [r1, #0]
@   0x08003044: 889a        ldrh	r2, [r3, #4]
@   0x08003046: 2604        movs	r6, #4
@   0x08003048: 5f99        ldrsh	r1, [r3, r6]
@   0x0800304a: 4804        ldr	r0, [pc, #16]	@ (0x305c)
@   0x0800304c: 4281        cmp	r1, r0
@   0x0800304e: dd3e        ble.n	0x30ce
@   0x08003050: 1e50        subs	r0, r2, #1
@   0x08003052: 8098        strh	r0, [r3, #4]
@   0x08003054: 1c19        adds	r1, r3, #0
@   0x08003056: 3174        adds	r1, #116	@ 0x74
@   0x08003058: e036        b.n	0x30c8
@   0x0800305a: 0000        movs	r0, r0
@   0x0800305c: 090b        lsrs	r3, r1, #4
@   0x0800305e: 0000        movs	r0, r0
@   0x08003060: 4806        ldr	r0, [pc, #24]	@ (0x307c)
@   0x08003062: 1c03        adds	r3, r0, #0
@   0x08003064: 885f        ldrh	r7, [r3, #2]
@   0x08003066: 2f83        cmp	r7, #131	@ 0x83
@   0x08003068: d10c        bne.n	0x3084
@   0x0800306a: 4805        ldr	r0, [pc, #20]	@ (0x3080)
@   0x0800306c: 8899        ldrh	r1, [r3, #4]
@   0x0800306e: 4281        cmp	r1, r0
@   0x08003070: d108        bne.n	0x3084
@   0x08003072: 2005        movs	r0, #5
@   0x08003074: 4652        mov	r2, sl
@   0x08003076: 6110        str	r0, [r2, #16]
@   0x08003078: e029        b.n	0x30ce
@   0x0800307a: 0000        movs	r0, r0
@   0x0800307c: 3720        adds	r7, #32
@   0x0800307e: 0300        lsls	r0, r0, #12
@   0x08003080: 0143        lsls	r3, r0, #5
@   0x08003082: 0000        movs	r0, r0
@   0x08003084: 8859        ldrh	r1, [r3, #2]
@   0x08003086: 2602        movs	r6, #2
@   0x08003088: 5f98        ldrsh	r0, [r3, r6]
@   0x0800308a: 2883        cmp	r0, #131	@ 0x83
@   0x0800308c: dd06        ble.n	0x309c
@   0x0800308e: 1e48        subs	r0, r1, #1
@   0x08003090: 8058        strh	r0, [r3, #2]
@   0x08003092: 1c19        adds	r1, r3, #0
@   0x08003094: 31aa        adds	r1, #170	@ 0xaa
@   0x08003096: 8808        ldrh	r0, [r1, #0]
@   0x08003098: 3801        subs	r0, #1
@   0x0800309a: 8008        strh	r0, [r1, #0]
@   0x0800309c: 8859        ldrh	r1, [r3, #2]
@   0x0800309e: 2702        movs	r7, #2
@   0x080030a0: 5fd8        ldrsh	r0, [r3, r7]
@   0x080030a2: 2882        cmp	r0, #130	@ 0x82
@   0x080030a4: dc06        bgt.n	0x30b4
@   0x080030a6: 1c48        adds	r0, r1, #1
@   0x080030a8: 8058        strh	r0, [r3, #2]
@   0x080030aa: 1c19        adds	r1, r3, #0
@   0x080030ac: 31aa        adds	r1, #170	@ 0xaa
@   0x080030ae: 8808        ldrh	r0, [r1, #0]
@   0x080030b0: 3001        adds	r0, #1
@   0x080030b2: 8008        strh	r0, [r1, #0]
@   0x080030b4: 889a        ldrh	r2, [r3, #4]
@   0x080030b6: 2004        movs	r0, #4
@   0x080030b8: 5e19        ldrsh	r1, [r3, r0]
@   0x080030ba: 4822        ldr	r0, [pc, #136]	@ (0x3144)
@   0x080030bc: 4281        cmp	r1, r0
@   0x080030be: dd06        ble.n	0x30ce
@   0x080030c0: 1e50        subs	r0, r2, #1
@   0x080030c2: 8098        strh	r0, [r3, #4]
@   0x080030c4: 1c19        adds	r1, r3, #0
@   0x080030c6: 31ac        adds	r1, #172	@ 0xac
@   0x080030c8: 8808        ldrh	r0, [r1, #0]
@   0x080030ca: 3801        subs	r0, #1
@   0x080030cc: 8008        strh	r0, [r1, #0]
@   0x080030ce: 4649        mov	r1, r9
@   0x080030d0: 060b        lsls	r3, r1, #24
@   0x080030d2: 2200        movs	r2, #0
@   0x080030d4: 2b00        cmp	r3, #0
@   0x080030d6: dd16        ble.n	0x3106
@   0x080030d8: 4c1b        ldr	r4, [pc, #108]	@ (0x3148)
@   0x080030da: 1d26        adds	r6, r4, #4
@   0x080030dc: 46b4        mov	ip, r6
@   0x080030de: 4e1b        ldr	r6, [pc, #108]	@ (0x314c)
@   0x080030e0: 4647        mov	r7, r8
@   0x080030e2: 2000        movs	r0, #0
@   0x080030e4: 5e3d        ldrsh	r5, [r7, r0]
@   0x080030e6: 0611        lsls	r1, r2, #24
@   0x080030e8: 1609        asrs	r1, r1, #24
@   0x080030ea: 014a        lsls	r2, r1, #5
@   0x080030ec: 1910        adds	r0, r2, r4
@   0x080030ee: 2700        movs	r7, #0
@   0x080030f0: 6007        str	r7, [r0, #0]
@   0x080030f2: 4462        add	r2, ip
@   0x080030f4: 2704        movs	r7, #4
@   0x080030f6: 5ff0        ldrsh	r0, [r6, r7]
@   0x080030f8: 1b40        subs	r0, r0, r5
@   0x080030fa: 6010        str	r0, [r2, #0]
@   0x080030fc: 3101        adds	r1, #1
@   0x080030fe: 0609        lsls	r1, r1, #24
@   0x08003100: 0e0a        lsrs	r2, r1, #24
@   0x08003102: 4299        cmp	r1, r3
@   0x08003104: dbef        blt.n	0x30e6
@   0x08003106: 4651        mov	r1, sl
@   0x08003108: 6908        ldr	r0, [r1, #16]
@   0x0800310a: 2805        cmp	r0, #5
@   0x0800310c: d156        bne.n	0x31bc
@   0x0800310e: 4b10        ldr	r3, [pc, #64]	@ (0x3150)
@   0x08003110: 4a0e        ldr	r2, [pc, #56]	@ (0x314c)
@   0x08003112: 2604        movs	r6, #4
@   0x08003114: 5f90        ldrsh	r0, [r2, r6]
@   0x08003116: 3850        subs	r0, #80	@ 0x50
@   0x08003118: 6919        ldr	r1, [r3, #16]
@   0x0800311a: 4281        cmp	r1, r0
@   0x0800311c: d11c        bne.n	0x3158
@   0x0800311e: 2702        movs	r7, #2
@   0x08003120: 5fd0        ldrsh	r0, [r2, r7]
@   0x08003122: 3878        subs	r0, #120	@ 0x78
@   0x08003124: 68d9        ldr	r1, [r3, #12]
@   0x08003126: 4281        cmp	r1, r0
@   0x08003128: d116        bne.n	0x3158
@   0x0800312a: 2062        movs	r0, #98	@ 0x62
@   0x0800312c: f01d        fda4 	bl	0x20c78
@   0x08003130: 2500        movs	r5, #0
@   0x08003132: 4650        mov	r0, sl
@   0x08003134: 6105        str	r5, [r0, #16]
@   0x08003136: 4c07        ldr	r4, [pc, #28]	@ (0x3154)
@   0x08003138: 1c20        adds	r0, r4, #0
@   0x0800313a: 2101        movs	r1, #1
@   0x0800313c: f003        fd2a 	bl	0x6b94
@   0x08003140: 8265        strh	r5, [r4, #18]
@   0x08003142: e03b        b.n	0x31bc
@   0x08003144: 0143        lsls	r3, r0, #5
@   0x08003146: 0000        movs	r0, r0
@   0x08003148: 60ac        str	r4, [r5, #8]
@   0x0800314a: 0300        lsls	r0, r0, #12
@   0x0800314c: 3720        adds	r7, #32
@   0x0800314e: 0300        lsls	r0, r0, #12
@   0x08003150: 60a0        str	r0, [r4, #8]
@   0x08003152: 0300        lsls	r0, r0, #12
@   0x08003154: 35e0        adds	r5, #224	@ 0xe0
@   0x08003156: 0300        lsls	r0, r0, #12
@   0x08003158: 2200        movs	r2, #0
@   0x0800315a: 4649        mov	r1, r9
@   0x0800315c: 0608        lsls	r0, r1, #24
@   0x0800315e: 1600        asrs	r0, r0, #24
@   0x08003160: 4282        cmp	r2, r0
@   0x08003162: da2b        bge.n	0x31bc
@   0x08003164: 4d19        ldr	r5, [pc, #100]	@ (0x31cc)
@   0x08003166: 4e1a        ldr	r6, [pc, #104]	@ (0x31d0)
@   0x08003168: 2310        movs	r3, #16
@   0x0800316a: 195b        adds	r3, r3, r5
@   0x0800316c: 4698        mov	r8, r3
@   0x0800316e: 1c07        adds	r7, r0, #0
@   0x08003170: 0610        lsls	r0, r2, #24
@   0x08003172: 1601        asrs	r1, r0, #24
@   0x08003174: 014c        lsls	r4, r1, #5
@   0x08003176: 1c28        adds	r0, r5, #0
@   0x08003178: 300c        adds	r0, #12
@   0x0800317a: 1823        adds	r3, r4, r0
@   0x0800317c: 2202        movs	r2, #2
@   0x0800317e: 5eb0        ldrsh	r0, [r6, r2]
@   0x08003180: 3878        subs	r0, #120	@ 0x78
@   0x08003182: 681a        ldr	r2, [r3, #0]
@   0x08003184: 4282        cmp	r2, r0
@   0x08003186: da01        bge.n	0x318c
@   0x08003188: 1c50        adds	r0, r2, #1
@   0x0800318a: 6018        str	r0, [r3, #0]
@   0x0800318c: 2202        movs	r2, #2
@   0x0800318e: 5eb0        ldrsh	r0, [r6, r2]
@   0x08003190: 3878        subs	r0, #120	@ 0x78
@   0x08003192: 681a        ldr	r2, [r3, #0]
@   0x08003194: 4282        cmp	r2, r0
@   0x08003196: dd01        ble.n	0x319c
@   0x08003198: 1e50        subs	r0, r2, #1
@   0x0800319a: 6018        str	r0, [r3, #0]
@   0x0800319c: 4640        mov	r0, r8
@   0x0800319e: 1823        adds	r3, r4, r0
@   0x080031a0: 2204        movs	r2, #4
@   0x080031a2: 5eb0        ldrsh	r0, [r6, r2]
@   0x080031a4: 3850        subs	r0, #80	@ 0x50
@   0x080031a6: 681a        ldr	r2, [r3, #0]
@   0x080031a8: 4282        cmp	r2, r0
@   0x080031aa: d001        beq.n	0x31b0
@   0x080031ac: 1c50        adds	r0, r2, #1
@   0x080031ae: 6018        str	r0, [r3, #0]
@   0x080031b0: 1c48        adds	r0, r1, #1
@   0x080031b2: 0600        lsls	r0, r0, #24
@   0x080031b4: 0e02        lsrs	r2, r0, #24
@   0x080031b6: 1600        asrs	r0, r0, #24
@   0x080031b8: 42b8        cmp	r0, r7
@   0x080031ba: dbd9        blt.n	0x3170
@   0x080031bc: bc38        pop	{r3, r4, r5}
@   0x080031be: 4698        mov	r8, r3
@   0x080031c0: 46a1        mov	r9, r4
@   0x080031c2: 46aa        mov	sl, r5
@   0x080031c4: bcf0        pop	{r4, r5, r6, r7}
@   0x080031c6: bc01        pop	{r0}
@   0x080031c8: 4700        bx	r0
@   0x080031ca: 0000        movs	r0, r0
@   0x080031cc: 60a0        str	r0, [r4, #8]
@   0x080031ce: 0300        lsls	r0, r0, #12
@   0x080031d0: 3720        adds	r7, #32
@   0x080031d2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002EE8
sub_08002EE8: @ 0x08002ee8
        .incbin "frog_us_baserom.gba", 0x2ee8, 0x2ec
        thumb_func_end sub_08002EE8
