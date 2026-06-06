@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014ee8, 0x08015044)  (348 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014ee8 --end 0x8015044 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014ee8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08014eea: 4647        mov	r7, r8
@   0x08014eec: b480        push	{r7}
@   0x08014eee: b084        sub	sp, #16
@   0x08014ef0: 1c06        adds	r6, r0, #0
@   0x08014ef2: 0609        lsls	r1, r1, #24
@   0x08014ef4: 0e09        lsrs	r1, r1, #24
@   0x08014ef6: 061b        lsls	r3, r3, #24
@   0x08014ef8: 0e1b        lsrs	r3, r3, #24
@   0x08014efa: 2700        movs	r7, #0
@   0x08014efc: 4d04        ldr	r5, [pc, #16]	@ (0x14f10)
@   0x08014efe: 7828        ldrb	r0, [r5, #0]
@   0x08014f00: 2801        cmp	r0, #1
@   0x08014f02: d04d        beq.n	0x14fa0
@   0x08014f04: 2801        cmp	r0, #1
@   0x08014f06: dc05        bgt.n	0x14f14
@   0x08014f08: 2800        cmp	r0, #0
@   0x08014f0a: d007        beq.n	0x14f1c
@   0x08014f0c: e08f        b.n	0x1502e
@   0x08014f0e: 0000        movs	r0, r0
@   0x08014f10: 3610        adds	r6, #16
@   0x08014f12: 0300        lsls	r0, r0, #12
@   0x08014f14: 2802        cmp	r0, #2
@   0x08014f16: d100        bne.n	0x14f1a
@   0x08014f18: e080        b.n	0x1501c
@   0x08014f1a: e088        b.n	0x1502e
@   0x08014f1c: 78a8        ldrb	r0, [r5, #2]
@   0x08014f1e: 4288        cmp	r0, r1
@   0x08014f20: d306        bcc.n	0x14f30
@   0x08014f22: 4802        ldr	r0, [pc, #8]	@ (0x14f2c)
@   0x08014f24: 86c7        strh	r7, [r0, #54]	@ 0x36
@   0x08014f26: 2001        movs	r0, #1
@   0x08014f28: e082        b.n	0x15030
@   0x08014f2a: 0000        movs	r0, r0
@   0x08014f2c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08014f2e: 0300        lsls	r0, r0, #12
@   0x08014f30: 78aa        ldrb	r2, [r5, #2]
@   0x08014f32: 0053        lsls	r3, r2, #1
@   0x08014f34: 189b        adds	r3, r3, r2
@   0x08014f36: 00db        lsls	r3, r3, #3
@   0x08014f38: 199b        adds	r3, r3, r6
@   0x08014f3a: 4c15        ldr	r4, [pc, #84]	@ (0x14f90)
@   0x08014f3c: 46a0        mov	r8, r4
@   0x08014f3e: 9402        str	r4, [sp, #8]
@   0x08014f40: 2003        movs	r0, #3
@   0x08014f42: 9003        str	r0, [sp, #12]
@   0x08014f44: 4669        mov	r1, sp
@   0x08014f46: 1c18        adds	r0, r3, #0
@   0x08014f48: 3010        adds	r0, #16
@   0x08014f4a: c814        ldmia	r0!, {r2, r4}
@   0x08014f4c: c114        stmia	r1!, {r2, r4}
@   0x08014f4e: 6818        ldr	r0, [r3, #0]
@   0x08014f50: 6859        ldr	r1, [r3, #4]
@   0x08014f52: 689a        ldr	r2, [r3, #8]
@   0x08014f54: 68db        ldr	r3, [r3, #12]
@   0x08014f56: f7ff        f8a3 	bl	0x140a0
@   0x08014f5a: 4640        mov	r0, r8
@   0x08014f5c: 2103        movs	r1, #3
@   0x08014f5e: f7ff        f8ef 	bl	0x14140
@   0x08014f62: 2180        movs	r1, #128	@ 0x80
@   0x08014f64: 0489        lsls	r1, r1, #18
@   0x08014f66: 4a0b        ldr	r2, [pc, #44]	@ (0x14f94)
@   0x08014f68: 2000        movs	r0, #0
@   0x08014f6a: f7fb        f8bb 	bl	0x100e4
@   0x08014f6e: 480a        ldr	r0, [pc, #40]	@ (0x14f98)
@   0x08014f70: 7287        strb	r7, [r0, #10]
@   0x08014f72: 490a        ldr	r1, [pc, #40]	@ (0x14f9c)
@   0x08014f74: 78aa        ldrb	r2, [r5, #2]
@   0x08014f76: 0050        lsls	r0, r2, #1
@   0x08014f78: 1880        adds	r0, r0, r2
@   0x08014f7a: 00c0        lsls	r0, r0, #3
@   0x08014f7c: 1980        adds	r0, r0, r6
@   0x08014f7e: 8840        ldrh	r0, [r0, #2]
@   0x08014f80: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08014f82: 2003        movs	r0, #3
@   0x08014f84: f00b        ff1e 	bl	0x20dc4
@   0x08014f88: 2001        movs	r0, #1
@   0x08014f8a: 7028        strb	r0, [r5, #0]
@   0x08014f8c: e04f        b.n	0x1502e
@   0x08014f8e: 0000        movs	r0, r0
@   0x08014f90: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08014f92: 0300        lsls	r0, r0, #12
@   0x08014f94: e000        b.n	0x14f98
@   0x08014f96: 0600        lsls	r0, r0, #24
@   0x08014f98: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08014f9a: 0300        lsls	r0, r0, #12
@   0x08014f9c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08014f9e: 0300        lsls	r0, r0, #12
@   0x08014fa0: 011b        lsls	r3, r3, #4
@   0x08014fa2: 189b        adds	r3, r3, r2
@   0x08014fa4: 7898        ldrb	r0, [r3, #2]
@   0x08014fa6: 9000        str	r0, [sp, #0]
@   0x08014fa8: 4c19        ldr	r4, [pc, #100]	@ (0x15010)
@   0x08014faa: 9401        str	r4, [sp, #4]
@   0x08014fac: 6818        ldr	r0, [r3, #0]
@   0x08014fae: 6859        ldr	r1, [r3, #4]
@   0x08014fb0: 689a        ldr	r2, [r3, #8]
@   0x08014fb2: 68db        ldr	r3, [r3, #12]
@   0x08014fb4: f7fe        fe54 	bl	0x13c60
@   0x08014fb8: 7020        strb	r0, [r4, #0]
@   0x08014fba: 0600        lsls	r0, r0, #24
@   0x08014fbc: 0e00        lsrs	r0, r0, #24
@   0x08014fbe: 2801        cmp	r0, #1
@   0x08014fc0: d135        bne.n	0x1502e
@   0x08014fc2: 4c14        ldr	r4, [pc, #80]	@ (0x15014)
@   0x08014fc4: 7220        strb	r0, [r4, #8]
@   0x08014fc6: 78a8        ldrb	r0, [r5, #2]
@   0x08014fc8: 0043        lsls	r3, r0, #1
@   0x08014fca: 181b        adds	r3, r3, r0
@   0x08014fcc: 00db        lsls	r3, r3, #3
@   0x08014fce: 199b        adds	r3, r3, r6
@   0x08014fd0: 9402        str	r4, [sp, #8]
@   0x08014fd2: 2003        movs	r0, #3
@   0x08014fd4: 9003        str	r0, [sp, #12]
@   0x08014fd6: 4669        mov	r1, sp
@   0x08014fd8: 1c18        adds	r0, r3, #0
@   0x08014fda: 3010        adds	r0, #16
@   0x08014fdc: c844        ldmia	r0!, {r2, r6}
@   0x08014fde: c144        stmia	r1!, {r2, r6}
@   0x08014fe0: 6818        ldr	r0, [r3, #0]
@   0x08014fe2: 6859        ldr	r1, [r3, #4]
@   0x08014fe4: 689a        ldr	r2, [r3, #8]
@   0x08014fe6: 68db        ldr	r3, [r3, #12]
@   0x08014fe8: f7ff        f85a 	bl	0x140a0
@   0x08014fec: 1c20        adds	r0, r4, #0
@   0x08014fee: 2103        movs	r1, #3
@   0x08014ff0: f7ff        f8a6 	bl	0x14140
@   0x08014ff4: 78a8        ldrb	r0, [r5, #2]
@   0x08014ff6: 3001        adds	r0, #1
@   0x08014ff8: 70a8        strb	r0, [r5, #2]
@   0x08014ffa: 7227        strb	r7, [r4, #8]
@   0x08014ffc: 2002        movs	r0, #2
@   0x08014ffe: 7028        strb	r0, [r5, #0]
@   0x08015000: 2180        movs	r1, #128	@ 0x80
@   0x08015002: 0489        lsls	r1, r1, #18
@   0x08015004: 4a04        ldr	r2, [pc, #16]	@ (0x15018)
@   0x08015006: 2000        movs	r0, #0
@   0x08015008: f7fb        f86c 	bl	0x100e4
@   0x0801500c: e00f        b.n	0x1502e
@   0x0801500e: 0000        movs	r0, r0
@   0x08015010: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015012: 0300        lsls	r0, r0, #12
@   0x08015014: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08015016: 0300        lsls	r0, r0, #12
@   0x08015018: e000        b.n	0x1501c
@   0x0801501a: 0600        lsls	r0, r0, #24
@   0x0801501c: 4807        ldr	r0, [pc, #28]	@ (0x1503c)
@   0x0801501e: 7800        ldrb	r0, [r0, #0]
@   0x08015020: 2801        cmp	r0, #1
@   0x08015022: d104        bne.n	0x1502e
@   0x08015024: 4806        ldr	r0, [pc, #24]	@ (0x15040)
@   0x08015026: 7800        ldrb	r0, [r0, #0]
@   0x08015028: 2801        cmp	r0, #1
@   0x0801502a: d100        bne.n	0x1502e
@   0x0801502c: 702f        strb	r7, [r5, #0]
@   0x0801502e: 2000        movs	r0, #0
@   0x08015030: b004        add	sp, #16
@   0x08015032: bc08        pop	{r3}
@   0x08015034: 4698        mov	r8, r3
@   0x08015036: bcf0        pop	{r4, r5, r6, r7}
@   0x08015038: bc02        pop	{r1}
@   0x0801503a: 4708        bx	r1
@   0x0801503c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801503e: 0300        lsls	r0, r0, #12
@   0x08015040: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015042: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08014EE8
sub_08014EE8: @ 0x08014ee8
        .incbin "frog_us_baserom.gba", 0x14ee8, 0x15c
        thumb_func_end sub_08014EE8
