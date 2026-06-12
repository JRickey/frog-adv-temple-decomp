@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08030e50, 0x08031390)  (1344 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8030e50 --end 0x8031390 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030e50: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030e52: 1c03        adds	r3, r0, #0
@   0x08030e54: 468c        mov	ip, r1
@   0x08030e56: 680f        ldr	r7, [r1, #0]
@   0x08030e58: 2b03        cmp	r3, #3
@   0x08030e5a: d06f        beq.n	0x30f3c
@   0x08030e5c: 2b03        cmp	r3, #3
@   0x08030e5e: dc0d        bgt.n	0x30e7c
@   0x08030e60: 4a05        ldr	r2, [pc, #20]	@ (0x30e78)
@   0x08030e62: 00d8        lsls	r0, r3, #3
@   0x08030e64: 18c0        adds	r0, r0, r3
@   0x08030e66: 0080        lsls	r0, r0, #2
@   0x08030e68: 3020        adds	r0, #32
@   0x08030e6a: 6811        ldr	r1, [r2, #0]
@   0x08030e6c: 180c        adds	r4, r1, r0
@   0x08030e6e: 0098        lsls	r0, r3, #2
@   0x08030e70: 3010        adds	r0, #16
@   0x08030e72: 180d        adds	r5, r1, r0
@   0x08030e74: e00c        b.n	0x30e90
@   0x08030e76: 0000        movs	r0, r0
@   0x08030e78: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030e7a: 0300        lsls	r0, r0, #12
@   0x08030e7c: 4a33        ldr	r2, [pc, #204]	@ (0x30f4c)
@   0x08030e7e: 6811        ldr	r1, [r2, #0]
@   0x08030e80: 31c8        adds	r1, #200	@ 0xc8
@   0x08030e82: 0198        lsls	r0, r3, #6
@   0x08030e84: 4c32        ldr	r4, [pc, #200]	@ (0x30f50)
@   0x08030e86: 1900        adds	r0, r0, r4
@   0x08030e88: 6809        ldr	r1, [r1, #0]
@   0x08030e8a: 180c        adds	r4, r1, r0
@   0x08030e8c: 1c25        adds	r5, r4, #0
@   0x08030e8e: 3538        adds	r5, #56	@ 0x38
@   0x08030e90: 2001        movs	r0, #1
@   0x08030e92: 7879        ldrb	r1, [r7, #1]
@   0x08030e94: 4008        ands	r0, r1
@   0x08030e96: 2800        cmp	r0, #0
@   0x08030e98: d001        beq.n	0x30e9e
@   0x08030e9a: 2000        movs	r0, #0
@   0x08030e9c: 82e0        strh	r0, [r4, #22]
@   0x08030e9e: 2002        movs	r0, #2
@   0x08030ea0: 7879        ldrb	r1, [r7, #1]
@   0x08030ea2: 4008        ands	r0, r1
@   0x08030ea4: 2800        cmp	r0, #0
@   0x08030ea6: d001        beq.n	0x30eac
@   0x08030ea8: 2000        movs	r0, #0
@   0x08030eaa: 83e0        strh	r0, [r4, #30]
@   0x08030eac: 2004        movs	r0, #4
@   0x08030eae: 7879        ldrb	r1, [r7, #1]
@   0x08030eb0: 4008        ands	r0, r1
@   0x08030eb2: 2800        cmp	r0, #0
@   0x08030eb4: d001        beq.n	0x30eba
@   0x08030eb6: 2000        movs	r0, #0
@   0x08030eb8: 80e0        strh	r0, [r4, #6]
@   0x08030eba: 2008        movs	r0, #8
@   0x08030ebc: 7879        ldrb	r1, [r7, #1]
@   0x08030ebe: 4008        ands	r0, r1
@   0x08030ec0: 2800        cmp	r0, #0
@   0x08030ec2: d001        beq.n	0x30ec8
@   0x08030ec4: 2000        movs	r0, #0
@   0x08030ec6: 81e0        strh	r0, [r4, #14]
@   0x08030ec8: 2010        movs	r0, #16
@   0x08030eca: 7879        ldrb	r1, [r7, #1]
@   0x08030ecc: 4008        ands	r0, r1
@   0x08030ece: 2800        cmp	r0, #0
@   0x08030ed0: d01c        beq.n	0x30f0c
@   0x08030ed2: 2b03        cmp	r3, #3
@   0x08030ed4: dd1a        ble.n	0x30f0c
@   0x08030ed6: 3b04        subs	r3, #4
@   0x08030ed8: 6810        ldr	r0, [r2, #0]
@   0x08030eda: 1c06        adds	r6, r0, #0
@   0x08030edc: 36c8        adds	r6, #200	@ 0xc8
@   0x08030ede: 6830        ldr	r0, [r6, #0]
@   0x08030ee0: 019a        lsls	r2, r3, #6
@   0x08030ee2: 1813        adds	r3, r2, r0
@   0x08030ee4: 6b99        ldr	r1, [r3, #56]	@ 0x38
@   0x08030ee6: 2080        movs	r0, #128	@ 0x80
@   0x08030ee8: 00c0        lsls	r0, r0, #3
@   0x08030eea: 4008        ands	r0, r1
@   0x08030eec: 2800        cmp	r0, #0
@   0x08030eee: d00d        beq.n	0x30f0c
@   0x08030ef0: 4818        ldr	r0, [pc, #96]	@ (0x30f54)
@   0x08030ef2: 4001        ands	r1, r0
@   0x08030ef4: 6399        str	r1, [r3, #56]	@ 0x38
@   0x08030ef6: 6830        ldr	r0, [r6, #0]
@   0x08030ef8: 1880        adds	r0, r0, r2
@   0x08030efa: 1c01        adds	r1, r0, #0
@   0x08030efc: 312c        adds	r1, #44	@ 0x2c
@   0x08030efe: 8d80        ldrh	r0, [r0, #44]	@ 0x2c
@   0x08030f00: 0400        lsls	r0, r0, #16
@   0x08030f02: 1600        asrs	r0, r0, #24
@   0x08030f04: 2200        movs	r2, #0
@   0x08030f06: 7148        strb	r0, [r1, #5]
@   0x08030f08: 7108        strb	r0, [r1, #4]
@   0x08030f0a: 804a        strh	r2, [r1, #2]
@   0x08030f0c: 2040        movs	r0, #64	@ 0x40
@   0x08030f0e: 7879        ldrb	r1, [r7, #1]
@   0x08030f10: 4008        ands	r0, r1
@   0x08030f12: 2800        cmp	r0, #0
@   0x08030f14: d005        beq.n	0x30f22
@   0x08030f16: 6828        ldr	r0, [r5, #0]
@   0x08030f18: 490f        ldr	r1, [pc, #60]	@ (0x30f58)
@   0x08030f1a: 4008        ands	r0, r1
@   0x08030f1c: 6028        str	r0, [r5, #0]
@   0x08030f1e: 2000        movs	r0, #0
@   0x08030f20: 8260        strh	r0, [r4, #18]
@   0x08030f22: 2020        movs	r0, #32
@   0x08030f24: 787f        ldrb	r7, [r7, #1]
@   0x08030f26: 4038        ands	r0, r7
@   0x08030f28: 2800        cmp	r0, #0
@   0x08030f2a: d003        beq.n	0x30f34
@   0x08030f2c: 6828        ldr	r0, [r5, #0]
@   0x08030f2e: 490b        ldr	r1, [pc, #44]	@ (0x30f5c)
@   0x08030f30: 4008        ands	r0, r1
@   0x08030f32: 6028        str	r0, [r5, #0]
@   0x08030f34: 6828        ldr	r0, [r5, #0]
@   0x08030f36: 21c0        movs	r1, #192	@ 0xc0
@   0x08030f38: 4308        orrs	r0, r1
@   0x08030f3a: 6028        str	r0, [r5, #0]
@   0x08030f3c: 4664        mov	r4, ip
@   0x08030f3e: 6820        ldr	r0, [r4, #0]
@   0x08030f40: 3002        adds	r0, #2
@   0x08030f42: 6020        str	r0, [r4, #0]
@   0x08030f44: 2001        movs	r0, #1
@   0x08030f46: bcf0        pop	{r4, r5, r6, r7}
@   0x08030f48: bc02        pop	{r1}
@   0x08030f4a: 4708        bx	r1
@   0x08030f4c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030f4e: 0300        lsls	r0, r0, #12
@   0x08030f50: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08030f54: fbff        ffff 			@ <UNDEFINED> instruction: 0xfbffffff
@   0x08030f58: dfff        svc	255	@ 0xff
@   0x08030f5a: ffff        b7ff 	vqshl.u64	<illegal reg q13.5>, <illegal reg q15.5>, #63	@ 0x3f
@   0x08030f5e: ffff        b530 	vsli.32	d27, d16, #31
@   0x08030f62: 1c02        adds	r2, r0, #0
@   0x08030f64: 1c0d        adds	r5, r1, #0
@   0x08030f66: 682c        ldr	r4, [r5, #0]
@   0x08030f68: 2a03        cmp	r2, #3
@   0x08030f6a: d03d        beq.n	0x30fe8
@   0x08030f6c: 2a03        cmp	r2, #3
@   0x08030f6e: dc0d        bgt.n	0x30f8c
@   0x08030f70: 4905        ldr	r1, [pc, #20]	@ (0x30f88)
@   0x08030f72: 00d0        lsls	r0, r2, #3
@   0x08030f74: 1880        adds	r0, r0, r2
@   0x08030f76: 0080        lsls	r0, r0, #2
@   0x08030f78: 3020        adds	r0, #32
@   0x08030f7a: 6809        ldr	r1, [r1, #0]
@   0x08030f7c: 180b        adds	r3, r1, r0
@   0x08030f7e: 0090        lsls	r0, r2, #2
@   0x08030f80: 3010        adds	r0, #16
@   0x08030f82: 180a        adds	r2, r1, r0
@   0x08030f84: e00c        b.n	0x30fa0
@   0x08030f86: 0000        movs	r0, r0
@   0x08030f88: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030f8a: 0300        lsls	r0, r0, #12
@   0x08030f8c: 481a        ldr	r0, [pc, #104]	@ (0x30ff8)
@   0x08030f8e: 6801        ldr	r1, [r0, #0]
@   0x08030f90: 31c8        adds	r1, #200	@ 0xc8
@   0x08030f92: 0190        lsls	r0, r2, #6
@   0x08030f94: 4a19        ldr	r2, [pc, #100]	@ (0x30ffc)
@   0x08030f96: 1880        adds	r0, r0, r2
@   0x08030f98: 6809        ldr	r1, [r1, #0]
@   0x08030f9a: 180b        adds	r3, r1, r0
@   0x08030f9c: 1c1a        adds	r2, r3, #0
@   0x08030f9e: 3238        adds	r2, #56	@ 0x38
@   0x08030fa0: 2001        movs	r0, #1
@   0x08030fa2: 7861        ldrb	r1, [r4, #1]
@   0x08030fa4: 4008        ands	r0, r1
@   0x08030fa6: 2800        cmp	r0, #0
@   0x08030fa8: d002        beq.n	0x30fb0
@   0x08030faa: 2000        movs	r0, #0
@   0x08030fac: 8298        strh	r0, [r3, #20]
@   0x08030fae: 82d8        strh	r0, [r3, #22]
@   0x08030fb0: 2002        movs	r0, #2
@   0x08030fb2: 7861        ldrb	r1, [r4, #1]
@   0x08030fb4: 4008        ands	r0, r1
@   0x08030fb6: 2800        cmp	r0, #0
@   0x08030fb8: d002        beq.n	0x30fc0
@   0x08030fba: 2000        movs	r0, #0
@   0x08030fbc: 8398        strh	r0, [r3, #28]
@   0x08030fbe: 83d8        strh	r0, [r3, #30]
@   0x08030fc0: 2004        movs	r0, #4
@   0x08030fc2: 7861        ldrb	r1, [r4, #1]
@   0x08030fc4: 4008        ands	r0, r1
@   0x08030fc6: 2800        cmp	r0, #0
@   0x08030fc8: d002        beq.n	0x30fd0
@   0x08030fca: 2000        movs	r0, #0
@   0x08030fcc: 8098        strh	r0, [r3, #4]
@   0x08030fce: 80d8        strh	r0, [r3, #6]
@   0x08030fd0: 2008        movs	r0, #8
@   0x08030fd2: 7864        ldrb	r4, [r4, #1]
@   0x08030fd4: 4020        ands	r0, r4
@   0x08030fd6: 2800        cmp	r0, #0
@   0x08030fd8: d002        beq.n	0x30fe0
@   0x08030fda: 2000        movs	r0, #0
@   0x08030fdc: 8198        strh	r0, [r3, #12]
@   0x08030fde: 81d8        strh	r0, [r3, #14]
@   0x08030fe0: 6810        ldr	r0, [r2, #0]
@   0x08030fe2: 2140        movs	r1, #64	@ 0x40
@   0x08030fe4: 4308        orrs	r0, r1
@   0x08030fe6: 6010        str	r0, [r2, #0]
@   0x08030fe8: 6828        ldr	r0, [r5, #0]
@   0x08030fea: 3002        adds	r0, #2
@   0x08030fec: 6028        str	r0, [r5, #0]
@   0x08030fee: 2001        movs	r0, #1
@   0x08030ff0: bc30        pop	{r4, r5}
@   0x08030ff2: bc02        pop	{r1}
@   0x08030ff4: 4708        bx	r1
@   0x08030ff6: 0000        movs	r0, r0
@   0x08030ff8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030ffa: 0300        lsls	r0, r0, #12
@   0x08030ffc: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08031000: b530        push	{r4, r5, lr}
@   0x08031002: 1c02        adds	r2, r0, #0
@   0x08031004: 1c0c        adds	r4, r1, #0
@   0x08031006: 6825        ldr	r5, [r4, #0]
@   0x08031008: 2a03        cmp	r2, #3
@   0x0803100a: d03d        beq.n	0x31088
@   0x0803100c: 4814        ldr	r0, [pc, #80]	@ (0x31060)
@   0x0803100e: 6803        ldr	r3, [r0, #0]
@   0x08031010: 218c        movs	r1, #140	@ 0x8c
@   0x08031012: 0049        lsls	r1, r1, #1
@   0x08031014: 1858        adds	r0, r3, r1
@   0x08031016: 6800        ldr	r0, [r0, #0]
@   0x08031018: 4684        mov	ip, r0
@   0x0803101a: 2088        movs	r0, #136	@ 0x88
@   0x0803101c: 0040        lsls	r0, r0, #1
@   0x0803101e: 4460        add	r0, ip
@   0x08031020: 6801        ldr	r1, [r0, #0]
@   0x08031022: 0050        lsls	r0, r2, #1
@   0x08031024: 1880        adds	r0, r0, r2
@   0x08031026: 0080        lsls	r0, r0, #2
@   0x08031028: 1840        adds	r0, r0, r1
@   0x0803102a: 7941        ldrb	r1, [r0, #5]
@   0x0803102c: 29ff        cmp	r1, #255	@ 0xff
@   0x0803102e: d02b        beq.n	0x31088
@   0x08031030: 209c        movs	r0, #156	@ 0x9c
@   0x08031032: 0040        lsls	r0, r0, #1
@   0x08031034: 4460        add	r0, ip
@   0x08031036: 1840        adds	r0, r0, r1
@   0x08031038: 7800        ldrb	r0, [r0, #0]
@   0x0803103a: 28ff        cmp	r0, #255	@ 0xff
@   0x0803103c: d024        beq.n	0x31088
@   0x0803103e: 0200        lsls	r0, r0, #8
@   0x08031040: 886d        ldrh	r5, [r5, #2]
@   0x08031042: 1828        adds	r0, r5, r0
@   0x08031044: 0400        lsls	r0, r0, #16
@   0x08031046: 0c05        lsrs	r5, r0, #16
@   0x08031048: 2a03        cmp	r2, #3
@   0x0803104a: dc0b        bgt.n	0x31064
@   0x0803104c: 00d0        lsls	r0, r2, #3
@   0x0803104e: 1880        adds	r0, r0, r2
@   0x08031050: 0080        lsls	r0, r0, #2
@   0x08031052: 3020        adds	r0, #32
@   0x08031054: 1819        adds	r1, r3, r0
@   0x08031056: 0090        lsls	r0, r2, #2
@   0x08031058: 3010        adds	r0, #16
@   0x0803105a: 181a        adds	r2, r3, r0
@   0x0803105c: e00b        b.n	0x31076
@   0x0803105e: 0000        movs	r0, r0
@   0x08031060: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031062: 0300        lsls	r0, r0, #12
@   0x08031064: 1c18        adds	r0, r3, #0
@   0x08031066: 30c8        adds	r0, #200	@ 0xc8
@   0x08031068: 0191        lsls	r1, r2, #6
@   0x0803106a: 4a0b        ldr	r2, [pc, #44]	@ (0x31098)
@   0x0803106c: 1889        adds	r1, r1, r2
@   0x0803106e: 6800        ldr	r0, [r0, #0]
@   0x08031070: 1841        adds	r1, r0, r1
@   0x08031072: 1c0a        adds	r2, r1, #0
@   0x08031074: 3238        adds	r2, #56	@ 0x38
@   0x08031076: 0428        lsls	r0, r5, #16
@   0x08031078: 1400        asrs	r0, r0, #16
@   0x0803107a: 880b        ldrh	r3, [r1, #0]
@   0x0803107c: 1ac0        subs	r0, r0, r3
@   0x0803107e: 8048        strh	r0, [r1, #2]
@   0x08031080: 6810        ldr	r0, [r2, #0]
@   0x08031082: 2140        movs	r1, #64	@ 0x40
@   0x08031084: 4308        orrs	r0, r1
@   0x08031086: 6010        str	r0, [r2, #0]
@   0x08031088: 6820        ldr	r0, [r4, #0]
@   0x0803108a: 3004        adds	r0, #4
@   0x0803108c: 6020        str	r0, [r4, #0]
@   0x0803108e: 2001        movs	r0, #1
@   0x08031090: bc30        pop	{r4, r5}
@   0x08031092: bc02        pop	{r1}
@   0x08031094: 4708        bx	r1
@   0x08031096: 0000        movs	r0, r0
@   0x08031098: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0803109c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803109e: 4647        mov	r7, r8
@   0x080310a0: b480        push	{r7}
@   0x080310a2: 1c05        adds	r5, r0, #0
@   0x080310a4: 4688        mov	r8, r1
@   0x080310a6: 680c        ldr	r4, [r1, #0]
@   0x080310a8: 481c        ldr	r0, [pc, #112]	@ (0x3111c)
@   0x080310aa: 6803        ldr	r3, [r0, #0]
@   0x080310ac: 2188        movs	r1, #136	@ 0x88
@   0x080310ae: 0049        lsls	r1, r1, #1
@   0x080310b0: 1858        adds	r0, r3, r1
@   0x080310b2: 6802        ldr	r2, [r0, #0]
@   0x080310b4: 6811        ldr	r1, [r2, #0]
@   0x080310b6: 1851        adds	r1, r2, r1
@   0x080310b8: 8866        ldrh	r6, [r4, #2]
@   0x080310ba: 00b0        lsls	r0, r6, #2
@   0x080310bc: 1840        adds	r0, r0, r1
@   0x080310be: 6800        ldr	r0, [r0, #0]
@   0x080310c0: 1811        adds	r1, r2, r0
@   0x080310c2: 2000        movs	r0, #0
@   0x080310c4: 4684        mov	ip, r0
@   0x080310c6: 7888        ldrb	r0, [r1, #2]
@   0x080310c8: 2800        cmp	r0, #0
@   0x080310ca: d069        beq.n	0x311a0
@   0x080310cc: 888f        ldrh	r7, [r1, #4]
@   0x080310ce: 1d8e        adds	r6, r1, #6
@   0x080310d0: 218c        movs	r1, #140	@ 0x8c
@   0x080310d2: 0049        lsls	r1, r1, #1
@   0x080310d4: 1858        adds	r0, r3, r1
@   0x080310d6: 6800        ldr	r0, [r0, #0]
@   0x080310d8: 2388        movs	r3, #136	@ 0x88
@   0x080310da: 005b        lsls	r3, r3, #1
@   0x080310dc: 18c0        adds	r0, r0, r3
@   0x080310de: 6801        ldr	r1, [r0, #0]
@   0x080310e0: 0068        lsls	r0, r5, #1
@   0x080310e2: 1940        adds	r0, r0, r5
@   0x080310e4: 0080        lsls	r0, r0, #2
@   0x080310e6: 1840        adds	r0, r0, r1
@   0x080310e8: 2304        movs	r3, #4
@   0x080310ea: 5ee1        ldrsh	r1, [r4, r3]
@   0x080310ec: 79c0        ldrb	r0, [r0, #7]
@   0x080310ee: 1844        adds	r4, r0, r1
@   0x080310f0: 2c00        cmp	r4, #0
@   0x080310f2: db21        blt.n	0x31138
@   0x080310f4: 42bc        cmp	r4, r7
@   0x080310f6: da1f        bge.n	0x31138
@   0x080310f8: 2d02        cmp	r5, #2
@   0x080310fa: d111        bne.n	0x31120
@   0x080310fc: 00e0        lsls	r0, r4, #3
@   0x080310fe: 1980        adds	r0, r0, r6
@   0x08031100: 69d1        ldr	r1, [r2, #28]
@   0x08031102: 8800        ldrh	r0, [r0, #0]
@   0x08031104: 0080        lsls	r0, r0, #2
@   0x08031106: 1851        adds	r1, r2, r1
@   0x08031108: 1840        adds	r0, r0, r1
@   0x0803110a: 6800        ldr	r0, [r0, #0]
@   0x0803110c: 1810        adds	r0, r2, r0
@   0x0803110e: 7ac1        ldrb	r1, [r0, #11]
@   0x08031110: 2901        cmp	r1, #1
@   0x08031112: d111        bne.n	0x31138
@   0x08031114: f7fe        fc0c 	bl	0x2f930
@   0x08031118: e011        b.n	0x3113e
@   0x0803111a: 0000        movs	r0, r0
@   0x0803111c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803111e: 0300        lsls	r0, r0, #12
@   0x08031120: 2d03        cmp	r5, #3
@   0x08031122: dd09        ble.n	0x31138
@   0x08031124: 1f28        subs	r0, r5, #4
@   0x08031126: 00e2        lsls	r2, r4, #3
@   0x08031128: 1992        adds	r2, r2, r6
@   0x0803112a: 8811        ldrh	r1, [r2, #0]
@   0x0803112c: 7993        ldrb	r3, [r2, #6]
@   0x0803112e: 2200        movs	r2, #0
@   0x08031130: f7ff        fbbe 	bl	0x308b0
@   0x08031134: 2201        movs	r2, #1
@   0x08031136: 4694        mov	ip, r2
@   0x08031138: 4663        mov	r3, ip
@   0x0803113a: 2b00        cmp	r3, #0
@   0x0803113c: d030        beq.n	0x311a0
@   0x0803113e: 00e0        lsls	r0, r4, #3
@   0x08031140: 1984        adds	r4, r0, r6
@   0x08031142: 2004        movs	r0, #4
@   0x08031144: 5620        ldrsb	r0, [r4, r0]
@   0x08031146: 1c29        adds	r1, r5, #0
@   0x08031148: f7fd        fb94 	bl	0x2e874
@   0x0803114c: 8863        ldrh	r3, [r4, #2]
@   0x0803114e: 2602        movs	r6, #2
@   0x08031150: 5fa0        ldrsh	r0, [r4, r6]
@   0x08031152: 2800        cmp	r0, #0
@   0x08031154: d024        beq.n	0x311a0
@   0x08031156: 2d02        cmp	r5, #2
@   0x08031158: d10e        bne.n	0x31178
@   0x0803115a: 4806        ldr	r0, [pc, #24]	@ (0x31174)
@   0x0803115c: 6802        ldr	r2, [r0, #0]
@   0x0803115e: 1c11        adds	r1, r2, #0
@   0x08031160: 316a        adds	r1, #106	@ 0x6a
@   0x08031162: 880c        ldrh	r4, [r1, #0]
@   0x08031164: 1918        adds	r0, r3, r4
@   0x08031166: 8008        strh	r0, [r1, #0]
@   0x08031168: 6990        ldr	r0, [r2, #24]
@   0x0803116a: 2140        movs	r1, #64	@ 0x40
@   0x0803116c: 4308        orrs	r0, r1
@   0x0803116e: 6190        str	r0, [r2, #24]
@   0x08031170: e016        b.n	0x311a0
@   0x08031172: 0000        movs	r0, r0
@   0x08031174: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031176: 0300        lsls	r0, r0, #12
@   0x08031178: 2d03        cmp	r5, #3
@   0x0803117a: dd11        ble.n	0x311a0
@   0x0803117c: 79a0        ldrb	r0, [r4, #6]
@   0x0803117e: 2800        cmp	r0, #0
@   0x08031180: d10e        bne.n	0x311a0
@   0x08031182: 480c        ldr	r0, [pc, #48]	@ (0x311b4)
@   0x08031184: 6801        ldr	r1, [r0, #0]
@   0x08031186: 31c8        adds	r1, #200	@ 0xc8
@   0x08031188: 01a8        lsls	r0, r5, #6
@   0x0803118a: 4e0b        ldr	r6, [pc, #44]	@ (0x311b8)
@   0x0803118c: 1980        adds	r0, r0, r6
@   0x0803118e: 6809        ldr	r1, [r1, #0]
@   0x08031190: 1809        adds	r1, r1, r0
@   0x08031192: 884a        ldrh	r2, [r1, #2]
@   0x08031194: 1898        adds	r0, r3, r2
@   0x08031196: 8048        strh	r0, [r1, #2]
@   0x08031198: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0803119a: 2240        movs	r2, #64	@ 0x40
@   0x0803119c: 4310        orrs	r0, r2
@   0x0803119e: 6388        str	r0, [r1, #56]	@ 0x38
@   0x080311a0: 4643        mov	r3, r8
@   0x080311a2: 6818        ldr	r0, [r3, #0]
@   0x080311a4: 3006        adds	r0, #6
@   0x080311a6: 6018        str	r0, [r3, #0]
@   0x080311a8: 2001        movs	r0, #1
@   0x080311aa: bc08        pop	{r3}
@   0x080311ac: 4698        mov	r8, r3
@   0x080311ae: bcf0        pop	{r4, r5, r6, r7}
@   0x080311b0: bc02        pop	{r1}
@   0x080311b2: 4708        bx	r1
@   0x080311b4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080311b6: 0300        lsls	r0, r0, #12
@   0x080311b8: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080311bc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080311be: 4657        mov	r7, sl
@   0x080311c0: 464e        mov	r6, r9
@   0x080311c2: 4645        mov	r5, r8
@   0x080311c4: b4e0        push	{r5, r6, r7}
@   0x080311c6: b081        sub	sp, #4
@   0x080311c8: 1c06        adds	r6, r0, #0
@   0x080311ca: 4689        mov	r9, r1
@   0x080311cc: 680d        ldr	r5, [r1, #0]
@   0x080311ce: 796a        ldrb	r2, [r5, #5]
@   0x080311d0: 4807        ldr	r0, [pc, #28]	@ (0x311f0)
@   0x080311d2: 6801        ldr	r1, [r0, #0]
@   0x080311d4: 7808        ldrb	r0, [r1, #0]
@   0x080311d6: 3004        adds	r0, #4
@   0x080311d8: 4282        cmp	r2, r0
@   0x080311da: db02        blt.n	0x311e2
@   0x080311dc: 2aff        cmp	r2, #255	@ 0xff
@   0x080311de: d000        beq.n	0x311e2
@   0x080311e0: e0c7        b.n	0x31372
@   0x080311e2: 2e03        cmp	r6, #3
@   0x080311e4: dc06        bgt.n	0x311f4
@   0x080311e6: 0070        lsls	r0, r6, #1
@   0x080311e8: 30ac        adds	r0, #172	@ 0xac
@   0x080311ea: 180c        adds	r4, r1, r0
@   0x080311ec: e009        b.n	0x31202
@   0x080311ee: 0000        movs	r0, r0
@   0x080311f0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080311f2: 0300        lsls	r0, r0, #12
@   0x080311f4: 1c08        adds	r0, r1, #0
@   0x080311f6: 30c8        adds	r0, #200	@ 0xc8
@   0x080311f8: 01b1        lsls	r1, r6, #6
@   0x080311fa: 6800        ldr	r0, [r0, #0]
@   0x080311fc: 1809        adds	r1, r1, r0
@   0x080311fe: 1c0c        adds	r4, r1, #0
@   0x08031200: 3ccc        subs	r4, #204	@ 0xcc
@   0x08031202: 8820        ldrh	r0, [r4, #0]
@   0x08031204: 4680        mov	r8, r0
@   0x08031206: 4908        ldr	r1, [pc, #32]	@ (0x31228)
@   0x08031208: 1c08        adds	r0, r1, #0
@   0x0803120a: 8020        strh	r0, [r4, #0]
@   0x0803120c: 7968        ldrb	r0, [r5, #5]
@   0x0803120e: 2803        cmp	r0, #3
@   0x08031210: d80c        bhi.n	0x3122c
@   0x08031212: 7929        ldrb	r1, [r5, #4]
@   0x08031214: 796a        ldrb	r2, [r5, #5]
@   0x08031216: 2000        movs	r0, #0
@   0x08031218: f001        fcc2 	bl	0x32ba0
@   0x0803121c: 2701        movs	r7, #1
@   0x0803121e: 427f        negs	r7, r7
@   0x08031220: 2800        cmp	r0, #0
@   0x08031222: d011        beq.n	0x31248
@   0x08031224: 796f        ldrb	r7, [r5, #5]
@   0x08031226: e00f        b.n	0x31248
@   0x08031228: 7fff        ldrb	r7, [r7, #31]
@   0x0803122a: 0000        movs	r0, r0
@   0x0803122c: 796f        ldrb	r7, [r5, #5]
@   0x0803122e: 2fff        cmp	r7, #255	@ 0xff
@   0x08031230: d000        beq.n	0x31234
@   0x08031232: 3f04        subs	r7, #4
@   0x08031234: 7929        ldrb	r1, [r5, #4]
@   0x08031236: 2000        movs	r0, #0
@   0x08031238: 22ff        movs	r2, #255	@ 0xff
@   0x0803123a: 1c3b        adds	r3, r7, #0
@   0x0803123c: f001        fc6c 	bl	0x32b18
@   0x08031240: 1c07        adds	r7, r0, #0
@   0x08031242: 2f00        cmp	r7, #0
@   0x08031244: db00        blt.n	0x31248
@   0x08031246: 3704        adds	r7, #4
@   0x08031248: 4641        mov	r1, r8
@   0x0803124a: 8021        strh	r1, [r4, #0]
@   0x0803124c: 2f00        cmp	r7, #0
@   0x0803124e: da00        bge.n	0x31252
@   0x08031250: e08f        b.n	0x31372
@   0x08031252: 4816        ldr	r0, [pc, #88]	@ (0x312ac)
@   0x08031254: 6804        ldr	r4, [r0, #0]
@   0x08031256: 2388        movs	r3, #136	@ 0x88
@   0x08031258: 005b        lsls	r3, r3, #1
@   0x0803125a: 18e0        adds	r0, r4, r3
@   0x0803125c: 6802        ldr	r2, [r0, #0]
@   0x0803125e: 6810        ldr	r0, [r2, #0]
@   0x08031260: 88e9        ldrh	r1, [r5, #6]
@   0x08031262: 0089        lsls	r1, r1, #2
@   0x08031264: 4688        mov	r8, r1
@   0x08031266: 1810        adds	r0, r2, r0
@   0x08031268: 4440        add	r0, r8
@   0x0803126a: 6800        ldr	r0, [r0, #0]
@   0x0803126c: 1812        adds	r2, r2, r0
@   0x0803126e: 4692        mov	sl, r2
@   0x08031270: 218c        movs	r1, #140	@ 0x8c
@   0x08031272: 0049        lsls	r1, r1, #1
@   0x08031274: 1860        adds	r0, r4, r1
@   0x08031276: 6801        ldr	r1, [r0, #0]
@   0x08031278: 18c9        adds	r1, r1, r3
@   0x0803127a: 0070        lsls	r0, r6, #1
@   0x0803127c: 1980        adds	r0, r0, r6
@   0x0803127e: 0080        lsls	r0, r0, #2
@   0x08031280: 6809        ldr	r1, [r1, #0]
@   0x08031282: 180e        adds	r6, r1, r0
@   0x08031284: 2f03        cmp	r7, #3
@   0x08031286: dc1d        bgt.n	0x312c4
@   0x08031288: 2001        movs	r0, #1
@   0x0803128a: 78ac        ldrb	r4, [r5, #2]
@   0x0803128c: 4020        ands	r0, r4
@   0x0803128e: 2800        cmp	r0, #0
@   0x08031290: d10e        bne.n	0x312b0
@   0x08031292: 2103        movs	r1, #3
@   0x08031294: 5669        ldrsb	r1, [r5, r1]
@   0x08031296: 79f0        ldrb	r0, [r6, #7]
@   0x08031298: 1841        adds	r1, r0, r1
@   0x0803129a: 79b3        ldrb	r3, [r6, #6]
@   0x0803129c: 7928        ldrb	r0, [r5, #4]
@   0x0803129e: 9000        str	r0, [sp, #0]
@   0x080312a0: 1c38        adds	r0, r7, #0
@   0x080312a2: 2240        movs	r2, #64	@ 0x40
@   0x080312a4: f001        fb2e 	bl	0x32904
@   0x080312a8: e03c        b.n	0x31324
@   0x080312aa: 0000        movs	r0, r0
@   0x080312ac: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080312ae: 0300        lsls	r0, r0, #12
@   0x080312b0: 2103        movs	r1, #3
@   0x080312b2: 5669        ldrsb	r1, [r5, r1]
@   0x080312b4: 79f4        ldrb	r4, [r6, #7]
@   0x080312b6: 1861        adds	r1, r4, r1
@   0x080312b8: 79b2        ldrb	r2, [r6, #6]
@   0x080312ba: 792b        ldrb	r3, [r5, #4]
@   0x080312bc: 1c38        adds	r0, r7, #0
@   0x080312be: f001        fb6d 	bl	0x3299c
@   0x080312c2: e02f        b.n	0x31324
@   0x080312c4: 3f04        subs	r7, #4
@   0x080312c6: 1c20        adds	r0, r4, #0
@   0x080312c8: 30c8        adds	r0, #200	@ 0xc8
@   0x080312ca: 01b9        lsls	r1, r7, #6
@   0x080312cc: 6800        ldr	r0, [r0, #0]
@   0x080312ce: 1840        adds	r0, r0, r1
@   0x080312d0: 4680        mov	r8, r0
@   0x080312d2: 2101        movs	r1, #1
@   0x080312d4: 78a8        ldrb	r0, [r5, #2]
@   0x080312d6: 4001        ands	r1, r0
@   0x080312d8: 2900        cmp	r1, #0
@   0x080312da: d111        bne.n	0x31300
@   0x080312dc: 1c20        adds	r0, r4, #0
@   0x080312de: 30c4        adds	r0, #196	@ 0xc4
@   0x080312e0: 6800        ldr	r0, [r0, #0]
@   0x080312e2: 00bc        lsls	r4, r7, #2
@   0x080312e4: 1820        adds	r0, r4, r0
@   0x080312e6: 6001        str	r1, [r0, #0]
@   0x080312e8: 2103        movs	r1, #3
@   0x080312ea: 5669        ldrsb	r1, [r5, r1]
@   0x080312ec: 79f0        ldrb	r0, [r6, #7]
@   0x080312ee: 1841        adds	r1, r0, r1
@   0x080312f0: 79b3        ldrb	r3, [r6, #6]
@   0x080312f2: 7928        ldrb	r0, [r5, #4]
@   0x080312f4: 9000        str	r0, [sp, #0]
@   0x080312f6: 4640        mov	r0, r8
@   0x080312f8: 2240        movs	r2, #64	@ 0x40
@   0x080312fa: f001        facb 	bl	0x32894
@   0x080312fe: e009        b.n	0x31314
@   0x08031300: 2103        movs	r1, #3
@   0x08031302: 5669        ldrsb	r1, [r5, r1]
@   0x08031304: 79f4        ldrb	r4, [r6, #7]
@   0x08031306: 1861        adds	r1, r4, r1
@   0x08031308: 79b2        ldrb	r2, [r6, #6]
@   0x0803130a: 792b        ldrb	r3, [r5, #4]
@   0x0803130c: 4640        mov	r0, r8
@   0x0803130e: f001        fc5b 	bl	0x32bc8
@   0x08031312: 00bc        lsls	r4, r7, #2
@   0x08031314: 481d        ldr	r0, [pc, #116]	@ (0x3138c)
@   0x08031316: 6800        ldr	r0, [r0, #0]
@   0x08031318: 30cc        adds	r0, #204	@ 0xcc
@   0x0803131a: 6800        ldr	r0, [r0, #0]
@   0x0803131c: 1820        adds	r0, r4, r0
@   0x0803131e: 4641        mov	r1, r8
@   0x08031320: 6001        str	r1, [r0, #0]
@   0x08031322: 3704        adds	r7, #4
@   0x08031324: 4b19        ldr	r3, [pc, #100]	@ (0x3138c)
@   0x08031326: 6818        ldr	r0, [r3, #0]
@   0x08031328: 248c        movs	r4, #140	@ 0x8c
@   0x0803132a: 0064        lsls	r4, r4, #1
@   0x0803132c: 1900        adds	r0, r0, r4
@   0x0803132e: 6801        ldr	r1, [r0, #0]
@   0x08031330: 2088        movs	r0, #136	@ 0x88
@   0x08031332: 0040        lsls	r0, r0, #1
@   0x08031334: 1809        adds	r1, r1, r0
@   0x08031336: 0078        lsls	r0, r7, #1
@   0x08031338: 19c0        adds	r0, r0, r7
@   0x0803133a: 0080        lsls	r0, r0, #2
@   0x0803133c: 6809        ldr	r1, [r1, #0]
@   0x0803133e: 1809        adds	r1, r1, r0
@   0x08031340: 2200        movs	r2, #0
@   0x08031342: 710a        strb	r2, [r1, #4]
@   0x08031344: 7970        ldrb	r0, [r6, #5]
@   0x08031346: 7148        strb	r0, [r1, #5]
@   0x08031348: 79b0        ldrb	r0, [r6, #6]
@   0x0803134a: 7188        strb	r0, [r1, #6]
@   0x0803134c: 79f6        ldrb	r6, [r6, #7]
@   0x0803134e: 78ec        ldrb	r4, [r5, #3]
@   0x08031350: 1930        adds	r0, r6, r4
@   0x08031352: 71c8        strb	r0, [r1, #7]
@   0x08031354: 6818        ldr	r0, [r3, #0]
@   0x08031356: 218a        movs	r1, #138	@ 0x8a
@   0x08031358: 0049        lsls	r1, r1, #1
@   0x0803135a: 1840        adds	r0, r0, r1
@   0x0803135c: 0139        lsls	r1, r7, #4
@   0x0803135e: 6800        ldr	r0, [r0, #0]
@   0x08031360: 1840        adds	r0, r0, r1
@   0x08031362: 8102        strh	r2, [r0, #8]
@   0x08031364: 8142        strh	r2, [r0, #10]
@   0x08031366: 6042        str	r2, [r0, #4]
@   0x08031368: 4651        mov	r1, sl
@   0x0803136a: 3104        adds	r1, #4
@   0x0803136c: 6001        str	r1, [r0, #0]
@   0x0803136e: 88e9        ldrh	r1, [r5, #6]
@   0x08031370: 8181        strh	r1, [r0, #12]
@   0x08031372: 464c        mov	r4, r9
@   0x08031374: 6820        ldr	r0, [r4, #0]
@   0x08031376: 3008        adds	r0, #8
@   0x08031378: 6020        str	r0, [r4, #0]
@   0x0803137a: 2001        movs	r0, #1
@   0x0803137c: b001        add	sp, #4
@   0x0803137e: bc38        pop	{r3, r4, r5}
@   0x08031380: 4698        mov	r8, r3
@   0x08031382: 46a1        mov	r9, r4
@   0x08031384: 46aa        mov	sl, r5
@   0x08031386: bcf0        pop	{r4, r5, r6, r7}
@   0x08031388: bc02        pop	{r1}
@   0x0803138a: 4708        bx	r1
@   0x0803138c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803138e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08030E50
sub_08030E50: @ 0x08030e50
        .incbin "baserom.gba", 0x30e50, 0x540
        thumb_func_end sub_08030E50
