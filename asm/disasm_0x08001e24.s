@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001e24, 0x08002184)  (864 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001e24 --end 0x8002184 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001e24: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08001e26: 4647        mov	r7, r8
@   0x08001e28: b480        push	{r7}
@   0x08001e2a: b081        sub	sp, #4
@   0x08001e2c: 1c07        adds	r7, r0, #0
@   0x08001e2e: 4688        mov	r8, r1
@   0x08001e30: 4e59        ldr	r6, [pc, #356]	@ (0x1f98)
@   0x08001e32: 1c30        adds	r0, r6, #0
@   0x08001e34: 2108        movs	r1, #8
@   0x08001e36: 2205        movs	r2, #5
@   0x08001e38: f004        fcb0 	bl	0x679c
@   0x08001e3c: 0600        lsls	r0, r0, #24
@   0x08001e3e: 2800        cmp	r0, #0
@   0x08001e40: d010        beq.n	0x1e64
@   0x08001e42: 4956        ldr	r1, [pc, #344]	@ (0x1f9c)
@   0x08001e44: 4856        ldr	r0, [pc, #344]	@ (0x1fa0)
@   0x08001e46: 180a        adds	r2, r1, r0
@   0x08001e48: 2003        movs	r0, #3
@   0x08001e4a: 7010        strb	r0, [r2, #0]
@   0x08001e4c: 22b5        movs	r2, #181	@ 0xb5
@   0x08001e4e: 0092        lsls	r2, r2, #2
@   0x08001e50: 1889        adds	r1, r1, r2
@   0x08001e52: 2002        movs	r0, #2
@   0x08001e54: 880b        ldrh	r3, [r1, #0]
@   0x08001e56: 4318        orrs	r0, r3
@   0x08001e58: 8008        strh	r0, [r1, #0]
@   0x08001e5a: 1c30        adds	r0, r6, #0
@   0x08001e5c: 2108        movs	r1, #8
@   0x08001e5e: 2205        movs	r2, #5
@   0x08001e60: f004        fc30 	bl	0x66c4
@   0x08001e64: 1c30        adds	r0, r6, #0
@   0x08001e66: 2108        movs	r1, #8
@   0x08001e68: 2201        movs	r2, #1
@   0x08001e6a: f004        fc97 	bl	0x679c
@   0x08001e6e: 0600        lsls	r0, r0, #24
@   0x08001e70: 2800        cmp	r0, #0
@   0x08001e72: d042        beq.n	0x1efa
@   0x08001e74: 1c30        adds	r0, r6, #0
@   0x08001e76: 302b        adds	r0, #43	@ 0x2b
@   0x08001e78: 7800        ldrb	r0, [r0, #0]
@   0x08001e7a: 2801        cmp	r0, #1
@   0x08001e7c: d10c        bne.n	0x1e98
@   0x08001e7e: 4947        ldr	r1, [pc, #284]	@ (0x1f9c)
@   0x08001e80: 24fb        movs	r4, #251	@ 0xfb
@   0x08001e82: 00a4        lsls	r4, r4, #2
@   0x08001e84: 190a        adds	r2, r1, r4
@   0x08001e86: 2308        movs	r3, #8
@   0x08001e88: 8810        ldrh	r0, [r2, #0]
@   0x08001e8a: 4318        orrs	r0, r3
@   0x08001e8c: 8010        strh	r0, [r2, #0]
@   0x08001e8e: 4d45        ldr	r5, [pc, #276]	@ (0x1fa4)
@   0x08001e90: 1949        adds	r1, r1, r5
@   0x08001e92: 8808        ldrh	r0, [r1, #0]
@   0x08001e94: 4318        orrs	r0, r3
@   0x08001e96: 8008        strh	r0, [r1, #0]
@   0x08001e98: f010        fbe4 	bl	0x12664
@   0x08001e9c: f010        fc7c 	bl	0x12798
@   0x08001ea0: 2023        movs	r0, #35	@ 0x23
@   0x08001ea2: f01e        fee9 	bl	0x20c78
@   0x08001ea6: 4940        ldr	r1, [pc, #256]	@ (0x1fa8)
@   0x08001ea8: 7e08        ldrb	r0, [r1, #24]
@   0x08001eaa: 7e49        ldrb	r1, [r1, #25]
@   0x08001eac: 4d3b        ldr	r5, [pc, #236]	@ (0x1f9c)
@   0x08001eae: 4b3f        ldr	r3, [pc, #252]	@ (0x1fac)
@   0x08001eb0: 18ea        adds	r2, r5, r3
@   0x08001eb2: 2400        movs	r4, #0
@   0x08001eb4: 5f12        ldrsh	r2, [r2, r4]
@   0x08001eb6: 4c3e        ldr	r4, [pc, #248]	@ (0x1fb0)
@   0x08001eb8: 192b        adds	r3, r5, r4
@   0x08001eba: 2400        movs	r4, #0
@   0x08001ebc: 5f1b        ldrsh	r3, [r3, r4]
@   0x08001ebe: 2414        movs	r4, #20
@   0x08001ec0: 9400        str	r4, [sp, #0]
@   0x08001ec2: f00a        fe5d 	bl	0xcb80
@   0x08001ec6: 4836        ldr	r0, [pc, #216]	@ (0x1fa0)
@   0x08001ec8: 1829        adds	r1, r5, r0
@   0x08001eca: 2001        movs	r0, #1
@   0x08001ecc: 7008        strb	r0, [r1, #0]
@   0x08001ece: 22b5        movs	r2, #181	@ 0xb5
@   0x08001ed0: 0092        lsls	r2, r2, #2
@   0x08001ed2: 18a9        adds	r1, r5, r2
@   0x08001ed4: 2002        movs	r0, #2
@   0x08001ed6: 880b        ldrh	r3, [r1, #0]
@   0x08001ed8: 4318        orrs	r0, r3
@   0x08001eda: 8008        strh	r0, [r1, #0]
@   0x08001edc: 1c30        adds	r0, r6, #0
@   0x08001ede: 2108        movs	r1, #8
@   0x08001ee0: 2203        movs	r2, #3
@   0x08001ee2: f004        fb8d 	bl	0x6600
@   0x08001ee6: 4c33        ldr	r4, [pc, #204]	@ (0x1fb4)
@   0x08001ee8: 192d        adds	r5, r5, r4
@   0x08001eea: 4833        ldr	r0, [pc, #204]	@ (0x1fb8)
@   0x08001eec: 6800        ldr	r0, [r0, #0]
@   0x08001eee: 6028        str	r0, [r5, #0]
@   0x08001ef0: 1c30        adds	r0, r6, #0
@   0x08001ef2: 2108        movs	r1, #8
@   0x08001ef4: 2201        movs	r2, #1
@   0x08001ef6: f004        fbe5 	bl	0x66c4
@   0x08001efa: 4e27        ldr	r6, [pc, #156]	@ (0x1f98)
@   0x08001efc: 1c30        adds	r0, r6, #0
@   0x08001efe: 2108        movs	r1, #8
@   0x08001f00: 2202        movs	r2, #2
@   0x08001f02: f004        fc4b 	bl	0x679c
@   0x08001f06: 0600        lsls	r0, r0, #24
@   0x08001f08: 2800        cmp	r0, #0
@   0x08001f0a: d025        beq.n	0x1f58
@   0x08001f0c: f010        fd36 	bl	0x1297c
@   0x08001f10: 4925        ldr	r1, [pc, #148]	@ (0x1fa8)
@   0x08001f12: 7e08        ldrb	r0, [r1, #24]
@   0x08001f14: 7e49        ldrb	r1, [r1, #25]
@   0x08001f16: 4d21        ldr	r5, [pc, #132]	@ (0x1f9c)
@   0x08001f18: 4b24        ldr	r3, [pc, #144]	@ (0x1fac)
@   0x08001f1a: 18ea        adds	r2, r5, r3
@   0x08001f1c: 2400        movs	r4, #0
@   0x08001f1e: 5f12        ldrsh	r2, [r2, r4]
@   0x08001f20: 4c23        ldr	r4, [pc, #140]	@ (0x1fb0)
@   0x08001f22: 192b        adds	r3, r5, r4
@   0x08001f24: 2400        movs	r4, #0
@   0x08001f26: 5f1b        ldrsh	r3, [r3, r4]
@   0x08001f28: 2404        movs	r4, #4
@   0x08001f2a: 9400        str	r4, [sp, #0]
@   0x08001f2c: f00a        fe28 	bl	0xcb80
@   0x08001f30: 4820        ldr	r0, [pc, #128]	@ (0x1fb4)
@   0x08001f32: 182d        adds	r5, r5, r0
@   0x08001f34: 4820        ldr	r0, [pc, #128]	@ (0x1fb8)
@   0x08001f36: 6800        ldr	r0, [r0, #0]
@   0x08001f38: 6028        str	r0, [r5, #0]
@   0x08001f3a: 1c30        adds	r0, r6, #0
@   0x08001f3c: 2108        movs	r1, #8
@   0x08001f3e: 2206        movs	r2, #6
@   0x08001f40: f004        fb5e 	bl	0x6600
@   0x08001f44: 1c30        adds	r0, r6, #0
@   0x08001f46: 2108        movs	r1, #8
@   0x08001f48: 2202        movs	r2, #2
@   0x08001f4a: f004        fbbb 	bl	0x66c4
@   0x08001f4e: 1c30        adds	r0, r6, #0
@   0x08001f50: 2108        movs	r1, #8
@   0x08001f52: 2203        movs	r2, #3
@   0x08001f54: f004        fbb6 	bl	0x66c4
@   0x08001f58: 1c30        adds	r0, r6, #0
@   0x08001f5a: 2108        movs	r1, #8
@   0x08001f5c: 2203        movs	r2, #3
@   0x08001f5e: f004        fc1d 	bl	0x679c
@   0x08001f62: 0600        lsls	r0, r0, #24
@   0x08001f64: 2800        cmp	r0, #0
@   0x08001f66: d03c        beq.n	0x1fe2
@   0x08001f68: 4913        ldr	r1, [pc, #76]	@ (0x1fb8)
@   0x08001f6a: 480c        ldr	r0, [pc, #48]	@ (0x1f9c)
@   0x08001f6c: 4a11        ldr	r2, [pc, #68]	@ (0x1fb4)
@   0x08001f6e: 1880        adds	r0, r0, r2
@   0x08001f70: 6809        ldr	r1, [r1, #0]
@   0x08001f72: 6800        ldr	r0, [r0, #0]
@   0x08001f74: 1a09        subs	r1, r1, r0
@   0x08001f76: 29f0        cmp	r1, #240	@ 0xf0
@   0x08001f78: d920        bls.n	0x1fbc
@   0x08001f7a: 1c30        adds	r0, r6, #0
@   0x08001f7c: 2108        movs	r1, #8
@   0x08001f7e: 2202        movs	r2, #2
@   0x08001f80: f004        fb3e 	bl	0x6600
@   0x08001f84: 2074        movs	r0, #116	@ 0x74
@   0x08001f86: f01e        fe77 	bl	0x20c78
@   0x08001f8a: 1c30        adds	r0, r6, #0
@   0x08001f8c: 2108        movs	r1, #8
@   0x08001f8e: 2203        movs	r2, #3
@   0x08001f90: f004        fb98 	bl	0x66c4
@   0x08001f94: e025        b.n	0x1fe2
@   0x08001f96: 0000        movs	r0, r0
@   0x08001f98: 6110        str	r0, [r2, #16]
@   0x08001f9a: 0300        lsls	r0, r0, #12
@   0x08001f9c: 3720        adds	r7, #32
@   0x08001f9e: 0300        lsls	r0, r0, #12
@   0x08001fa0: 02ba        lsls	r2, r7, #10
@   0x08001fa2: 0000        movs	r0, r0
@   0x08001fa4: 0424        lsls	r4, r4, #16
@   0x08001fa6: 0000        movs	r0, r0
@   0x08001fa8: 35e0        adds	r5, #224	@ 0xe0
@   0x08001faa: 0300        lsls	r0, r0, #12
@   0x08001fac: 0692        lsls	r2, r2, #26
@   0x08001fae: 0000        movs	r0, r0
@   0x08001fb0: 0694        lsls	r4, r2, #26
@   0x08001fb2: 0000        movs	r0, r0
@   0x08001fb4: 06bc        lsls	r4, r7, #26
@   0x08001fb6: 0000        movs	r0, r0
@   0x08001fb8: 5330        strh	r0, [r6, r4]
@   0x08001fba: 0300        lsls	r0, r0, #12
@   0x08001fbc: 4b67        ldr	r3, [pc, #412]	@ (0x215c)
@   0x08001fbe: 2010        movs	r0, #16
@   0x08001fc0: 8a1c        ldrh	r4, [r3, #16]
@   0x08001fc2: 4020        ands	r0, r4
@   0x08001fc4: 2800        cmp	r0, #0
@   0x08001fc6: d00c        beq.n	0x1fe2
@   0x08001fc8: 7e18        ldrb	r0, [r3, #24]
@   0x08001fca: 7e59        ldrb	r1, [r3, #25]
@   0x08001fcc: 2508        movs	r5, #8
@   0x08001fce: 5f5a        ldrsh	r2, [r3, r5]
@   0x08001fd0: 240a        movs	r4, #10
@   0x08001fd2: 5f1b        ldrsh	r3, [r3, r4]
@   0x08001fd4: f00a        fed8 	bl	0xcd88
@   0x08001fd8: 0600        lsls	r0, r0, #24
@   0x08001fda: 0e03        lsrs	r3, r0, #24
@   0x08001fdc: 1c18        adds	r0, r3, #0
@   0x08001fde: f008        fe31 	bl	0xac44
@   0x08001fe2: 4c5f        ldr	r4, [pc, #380]	@ (0x2160)
@   0x08001fe4: 1c20        adds	r0, r4, #0
@   0x08001fe6: 2108        movs	r1, #8
@   0x08001fe8: 2206        movs	r2, #6
@   0x08001fea: f004        fbd7 	bl	0x679c
@   0x08001fee: 0600        lsls	r0, r0, #24
@   0x08001ff0: 2800        cmp	r0, #0
@   0x08001ff2: d012        beq.n	0x201a
@   0x08001ff4: 495b        ldr	r1, [pc, #364]	@ (0x2164)
@   0x08001ff6: 485c        ldr	r0, [pc, #368]	@ (0x2168)
@   0x08001ff8: 4d5c        ldr	r5, [pc, #368]	@ (0x216c)
@   0x08001ffa: 1940        adds	r0, r0, r5
@   0x08001ffc: 6809        ldr	r1, [r1, #0]
@   0x08001ffe: 6800        ldr	r0, [r0, #0]
@   0x08002000: 1a09        subs	r1, r1, r0
@   0x08002002: 29f0        cmp	r1, #240	@ 0xf0
@   0x08002004: d909        bls.n	0x201a
@   0x08002006: 1c20        adds	r0, r4, #0
@   0x08002008: 2108        movs	r1, #8
@   0x0800200a: 2200        movs	r2, #0
@   0x0800200c: f004        faf8 	bl	0x6600
@   0x08002010: 1c20        adds	r0, r4, #0
@   0x08002012: 2108        movs	r1, #8
@   0x08002014: 2206        movs	r2, #6
@   0x08002016: f004        fb55 	bl	0x66c4
@   0x0800201a: 4e51        ldr	r6, [pc, #324]	@ (0x2160)
@   0x0800201c: 1c30        adds	r0, r6, #0
@   0x0800201e: 2108        movs	r1, #8
@   0x08002020: 2204        movs	r2, #4
@   0x08002022: f004        fbbb 	bl	0x679c
@   0x08002026: 0600        lsls	r0, r0, #24
@   0x08002028: 2800        cmp	r0, #0
@   0x0800202a: d047        beq.n	0x20bc
@   0x0800202c: f010        fc2e 	bl	0x1288c
@   0x08002030: 494a        ldr	r1, [pc, #296]	@ (0x215c)
@   0x08002032: 7e08        ldrb	r0, [r1, #24]
@   0x08002034: 7e49        ldrb	r1, [r1, #25]
@   0x08002036: 4c4c        ldr	r4, [pc, #304]	@ (0x2168)
@   0x08002038: 4b4d        ldr	r3, [pc, #308]	@ (0x2170)
@   0x0800203a: 18e2        adds	r2, r4, r3
@   0x0800203c: 2500        movs	r5, #0
@   0x0800203e: 5f52        ldrsh	r2, [r2, r5]
@   0x08002040: 4d4c        ldr	r5, [pc, #304]	@ (0x2174)
@   0x08002042: 1963        adds	r3, r4, r5
@   0x08002044: 2500        movs	r5, #0
@   0x08002046: 5f5b        ldrsh	r3, [r3, r5]
@   0x08002048: 2504        movs	r5, #4
@   0x0800204a: 9500        str	r5, [sp, #0]
@   0x0800204c: f00a        fd98 	bl	0xcb80
@   0x08002050: 4849        ldr	r0, [pc, #292]	@ (0x2178)
@   0x08002052: 1821        adds	r1, r4, r0
@   0x08002054: 2002        movs	r0, #2
@   0x08002056: 7008        strb	r0, [r1, #0]
@   0x08002058: 22b5        movs	r2, #181	@ 0xb5
@   0x0800205a: 0092        lsls	r2, r2, #2
@   0x0800205c: 18a1        adds	r1, r4, r2
@   0x0800205e: 2202        movs	r2, #2
@   0x08002060: 8808        ldrh	r0, [r1, #0]
@   0x08002062: 4310        orrs	r0, r2
@   0x08002064: 8008        strh	r0, [r1, #0]
@   0x08002066: 4b45        ldr	r3, [pc, #276]	@ (0x217c)
@   0x08002068: 18e1        adds	r1, r4, r3
@   0x0800206a: 2003        movs	r0, #3
@   0x0800206c: 7008        strb	r0, [r1, #0]
@   0x0800206e: 2099        movs	r0, #153	@ 0x99
@   0x08002070: 0080        lsls	r0, r0, #2
@   0x08002072: 1821        adds	r1, r4, r0
@   0x08002074: 8808        ldrh	r0, [r1, #0]
@   0x08002076: 4310        orrs	r0, r2
@   0x08002078: 8008        strh	r0, [r1, #0]
@   0x0800207a: 4941        ldr	r1, [pc, #260]	@ (0x2180)
@   0x0800207c: 1860        adds	r0, r4, r1
@   0x0800207e: 7005        strb	r5, [r0, #0]
@   0x08002080: 3352        adds	r3, #82	@ 0x52
@   0x08002082: 18e1        adds	r1, r4, r3
@   0x08002084: 8808        ldrh	r0, [r1, #0]
@   0x08002086: 4310        orrs	r0, r2
@   0x08002088: 8008        strh	r0, [r1, #0]
@   0x0800208a: 1c31        adds	r1, r6, #0
@   0x0800208c: 312b        adds	r1, #43	@ 0x2b
@   0x0800208e: 7808        ldrb	r0, [r1, #0]
@   0x08002090: 3001        adds	r0, #1
@   0x08002092: 7008        strb	r0, [r1, #0]
@   0x08002094: 4d35        ldr	r5, [pc, #212]	@ (0x216c)
@   0x08002096: 1964        adds	r4, r4, r5
@   0x08002098: 4832        ldr	r0, [pc, #200]	@ (0x2164)
@   0x0800209a: 6800        ldr	r0, [r0, #0]
@   0x0800209c: 6020        str	r0, [r4, #0]
@   0x0800209e: 1c30        adds	r0, r6, #0
@   0x080020a0: 2108        movs	r1, #8
@   0x080020a2: 2206        movs	r2, #6
@   0x080020a4: f004        faac 	bl	0x6600
@   0x080020a8: 1c30        adds	r0, r6, #0
@   0x080020aa: 2108        movs	r1, #8
@   0x080020ac: 2204        movs	r2, #4
@   0x080020ae: f004        fb09 	bl	0x66c4
@   0x080020b2: 1c30        adds	r0, r6, #0
@   0x080020b4: 2108        movs	r1, #8
@   0x080020b6: 2207        movs	r2, #7
@   0x080020b8: f004        fb04 	bl	0x66c4
@   0x080020bc: 1c34        adds	r4, r6, #0
@   0x080020be: 3433        adds	r4, #51	@ 0x33
@   0x080020c0: 7820        ldrb	r0, [r4, #0]
@   0x080020c2: 2802        cmp	r0, #2
@   0x080020c4: d124        bne.n	0x2110
@   0x080020c6: 1c38        adds	r0, r7, #0
@   0x080020c8: 4641        mov	r1, r8
@   0x080020ca: 221c        movs	r2, #28
@   0x080020cc: f009        fc24 	bl	0xb918
@   0x080020d0: 7824        ldrb	r4, [r4, #0]
@   0x080020d2: 2c02        cmp	r4, #2
@   0x080020d4: d11c        bne.n	0x2110
@   0x080020d6: 1c30        adds	r0, r6, #0
@   0x080020d8: 2108        movs	r1, #8
@   0x080020da: 2207        movs	r2, #7
@   0x080020dc: f004        fb5e 	bl	0x679c
@   0x080020e0: 0600        lsls	r0, r0, #24
@   0x080020e2: 2800        cmp	r0, #0
@   0x080020e4: d014        beq.n	0x2110
@   0x080020e6: 4b1d        ldr	r3, [pc, #116]	@ (0x215c)
@   0x080020e8: 2010        movs	r0, #16
@   0x080020ea: 8a19        ldrh	r1, [r3, #16]
@   0x080020ec: 4008        ands	r0, r1
@   0x080020ee: 2800        cmp	r0, #0
@   0x080020f0: d00e        beq.n	0x2110
@   0x080020f2: 7e18        ldrb	r0, [r3, #24]
@   0x080020f4: 7e59        ldrb	r1, [r3, #25]
@   0x080020f6: 2408        movs	r4, #8
@   0x080020f8: 5f1a        ldrsh	r2, [r3, r4]
@   0x080020fa: 250a        movs	r5, #10
@   0x080020fc: 5f5b        ldrsh	r3, [r3, r5]
@   0x080020fe: f00a        fe43 	bl	0xcd88
@   0x08002102: 0600        lsls	r0, r0, #24
@   0x08002104: 0e03        lsrs	r3, r0, #24
@   0x08002106: 1c38        adds	r0, r7, #0
@   0x08002108: 4641        mov	r1, r8
@   0x0800210a: 221c        movs	r2, #28
@   0x0800210c: f009        fbcc 	bl	0xb8a8
@   0x08002110: 4c13        ldr	r4, [pc, #76]	@ (0x2160)
@   0x08002112: 1c20        adds	r0, r4, #0
@   0x08002114: 2108        movs	r1, #8
@   0x08002116: 2200        movs	r2, #0
@   0x08002118: f004        fb40 	bl	0x679c
@   0x0800211c: 0600        lsls	r0, r0, #24
@   0x0800211e: 2800        cmp	r0, #0
@   0x08002120: d015        beq.n	0x214e
@   0x08002122: 1c25        adds	r5, r4, #0
@   0x08002124: 352b        adds	r5, #43	@ 0x2b
@   0x08002126: 7828        ldrb	r0, [r5, #0]
@   0x08002128: 1c21        adds	r1, r4, #0
@   0x0800212a: 3133        adds	r1, #51	@ 0x33
@   0x0800212c: 7008        strb	r0, [r1, #0]
@   0x0800212e: 0600        lsls	r0, r0, #24
@   0x08002130: 0e00        lsrs	r0, r0, #24
@   0x08002132: 2801        cmp	r0, #1
@   0x08002134: d101        bne.n	0x213a
@   0x08002136: f028        fd15 	bl	0x2ab64
@   0x0800213a: 782d        ldrb	r5, [r5, #0]
@   0x0800213c: 2d02        cmp	r5, #2
@   0x0800213e: d106        bne.n	0x214e
@   0x08002140: 1c38        adds	r0, r7, #0
@   0x08002142: 4641        mov	r1, r8
@   0x08002144: 221c        movs	r2, #28
@   0x08002146: f009        fb33 	bl	0xb7b0
@   0x0800214a: f010        fcf5 	bl	0x12b38
@   0x0800214e: b001        add	sp, #4
@   0x08002150: bc08        pop	{r3}
@   0x08002152: 4698        mov	r8, r3
@   0x08002154: bcf0        pop	{r4, r5, r6, r7}
@   0x08002156: bc01        pop	{r0}
@   0x08002158: 4700        bx	r0
@   0x0800215a: 0000        movs	r0, r0
@   0x0800215c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800215e: 0300        lsls	r0, r0, #12
@   0x08002160: 6110        str	r0, [r2, #16]
@   0x08002162: 0300        lsls	r0, r0, #12
@   0x08002164: 5330        strh	r0, [r6, r4]
@   0x08002166: 0300        lsls	r0, r0, #12
@   0x08002168: 3720        adds	r7, #32
@   0x0800216a: 0300        lsls	r0, r0, #12
@   0x0800216c: 06bc        lsls	r4, r7, #26
@   0x0800216e: 0000        movs	r0, r0
@   0x08002170: 0692        lsls	r2, r2, #26
@   0x08002172: 0000        movs	r0, r0
@   0x08002174: 0694        lsls	r4, r2, #26
@   0x08002176: 0000        movs	r0, r0
@   0x08002178: 02ba        lsls	r2, r7, #10
@   0x0800217a: 0000        movs	r0, r0
@   0x0800217c: 024a        lsls	r2, r1, #9
@   0x0800217e: 0000        movs	r0, r0
@   0x08002180: 0282        lsls	r2, r0, #10

        thumb_func_start sub_08001E24
sub_08001E24: @ 0x08001e24
        .incbin "frog_us_baserom.gba", 0x1e24, 0x360
        thumb_func_end sub_08001E24
