@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000eb8, 0x08001128)  (624 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000eb8 --end 0x8001128 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000eb8: b530        push	{r4, r5, lr}
@   0x08000eba: b0d3        sub	sp, #332	@ 0x14c
@   0x08000ebc: 4802        ldr	r0, [pc, #8]	@ (0xec8)
@   0x08000ebe: 4468        add	r0, sp
@   0x08000ec0: 2100        movs	r1, #0
@   0x08000ec2: 7001        strb	r1, [r0, #0]
@   0x08000ec4: e122        b.n	0x110c
@   0x08000ec6: 0000        movs	r0, r0
@   0x08000ec8: 0141        lsls	r1, r0, #5
@   0x08000eca: 0000        movs	r0, r0
@   0x08000ecc: f01f        fe78 	bl	0x20bc0
@   0x08000ed0: 4805        ldr	r0, [pc, #20]	@ (0xee8)
@   0x08000ed2: 4468        add	r0, sp
@   0x08000ed4: 7800        ldrb	r0, [r0, #0]
@   0x08000ed6: 2808        cmp	r0, #8
@   0x08000ed8: d900        bls.n	0xedc
@   0x08000eda: e117        b.n	0x110c
@   0x08000edc: 0080        lsls	r0, r0, #2
@   0x08000ede: 4903        ldr	r1, [pc, #12]	@ (0xeec)
@   0x08000ee0: 1840        adds	r0, r0, r1
@   0x08000ee2: 6800        ldr	r0, [r0, #0]
@   0x08000ee4: 4687        mov	pc, r0
@   0x08000ee6: 0000        movs	r0, r0
@   0x08000ee8: 0141        lsls	r1, r0, #5
@   0x08000eea: 0000        movs	r0, r0
@   0x08000eec: 0ef0        lsrs	r0, r6, #27
@   0x08000eee: 0800        lsrs	r0, r0, #32
@   0x08000ef0: 0f14        lsrs	r4, r2, #28
@   0x08000ef2: 0800        lsrs	r0, r0, #32
@   0x08000ef4: 0f3c        lsrs	r4, r7, #28
@   0x08000ef6: 0800        lsrs	r0, r0, #32
@   0x08000ef8: 0f6c        lsrs	r4, r5, #29
@   0x08000efa: 0800        lsrs	r0, r0, #32
@   0x08000efc: 0f90        lsrs	r0, r2, #30
@   0x08000efe: 0800        lsrs	r0, r0, #32
@   0x08000f00: 1024        asrs	r4, r4, #32
@   0x08000f02: 0800        lsrs	r0, r0, #32
@   0x08000f04: 1050        asrs	r0, r2, #1
@   0x08000f06: 0800        lsrs	r0, r0, #32
@   0x08000f08: 1090        asrs	r0, r2, #2
@   0x08000f0a: 0800        lsrs	r0, r0, #32
@   0x08000f0c: 10d0        asrs	r0, r2, #3
@   0x08000f0e: 0800        lsrs	r0, r0, #32
@   0x08000f10: 1108        asrs	r0, r1, #4
@   0x08000f12: 0800        lsrs	r0, r0, #32
@   0x08000f14: a951        add	r1, sp, #324	@ 0x144
@   0x08000f16: 4a07        ldr	r2, [pc, #28]	@ (0xf34)
@   0x08000f18: 2400        movs	r4, #0
@   0x08000f1a: 2002        movs	r0, #2
@   0x08000f1c: 7290        strb	r0, [r2, #10]
@   0x08000f1e: 4668        mov	r0, sp
@   0x08000f20: 2203        movs	r2, #3
@   0x08000f22: f00a        fc45 	bl	0xb7b0
@   0x08000f26: 4904        ldr	r1, [pc, #16]	@ (0xf38)
@   0x08000f28: 4469        add	r1, sp
@   0x08000f2a: 2001        movs	r0, #1
@   0x08000f2c: 7008        strb	r0, [r1, #0]
@   0x08000f2e: a850        add	r0, sp, #320	@ 0x140
@   0x08000f30: 7004        strb	r4, [r0, #0]
@   0x08000f32: e0eb        b.n	0x110c
@   0x08000f34: 5330        strh	r0, [r6, r4]
@   0x08000f36: 0300        lsls	r0, r0, #12
@   0x08000f38: 0141        lsls	r1, r0, #5
@   0x08000f3a: 0000        movs	r0, r0
@   0x08000f3c: ac50        add	r4, sp, #320	@ 0x140
@   0x08000f3e: 4908        ldr	r1, [pc, #32]	@ (0xf60)
@   0x08000f40: 1c20        adds	r0, r4, #0
@   0x08000f42: f009        f8df 	bl	0xa104
@   0x08000f46: 0600        lsls	r0, r0, #24
@   0x08000f48: 2800        cmp	r0, #0
@   0x08000f4a: d100        bne.n	0xf4e
@   0x08000f4c: e0d2        b.n	0x10f4
@   0x08000f4e: 4905        ldr	r1, [pc, #20]	@ (0xf64)
@   0x08000f50: 4469        add	r1, sp
@   0x08000f52: 2002        movs	r0, #2
@   0x08000f54: 7008        strb	r0, [r1, #0]
@   0x08000f56: 4904        ldr	r1, [pc, #16]	@ (0xf68)
@   0x08000f58: 2000        movs	r0, #0
@   0x08000f5a: 6148        str	r0, [r1, #20]
@   0x08000f5c: 7020        strb	r0, [r4, #0]
@   0x08000f5e: e0c9        b.n	0x10f4
@   0x08000f60: 0d5d        lsrs	r5, r3, #21
@   0x08000f62: 0800        lsrs	r0, r0, #32
@   0x08000f64: 0141        lsls	r1, r0, #5
@   0x08000f66: 0000        movs	r0, r0
@   0x08000f68: 5330        strh	r0, [r6, r4]
@   0x08000f6a: 0300        lsls	r0, r0, #12
@   0x08000f6c: a850        add	r0, sp, #320	@ 0x140
@   0x08000f6e: f008        ff15 	bl	0x9d9c
@   0x08000f72: 2800        cmp	r0, #0
@   0x08000f74: d100        bne.n	0xf78
@   0x08000f76: e0c9        b.n	0x110c
@   0x08000f78: 4903        ldr	r1, [pc, #12]	@ (0xf88)
@   0x08000f7a: 4469        add	r1, sp
@   0x08000f7c: 2003        movs	r0, #3
@   0x08000f7e: 7008        strb	r0, [r1, #0]
@   0x08000f80: 4902        ldr	r1, [pc, #8]	@ (0xf8c)
@   0x08000f82: 2000        movs	r0, #0
@   0x08000f84: 6148        str	r0, [r1, #20]
@   0x08000f86: e0c1        b.n	0x110c
@   0x08000f88: 0141        lsls	r1, r0, #5
@   0x08000f8a: 0000        movs	r0, r0
@   0x08000f8c: 5330        strh	r0, [r6, r4]
@   0x08000f8e: 0300        lsls	r0, r0, #12
@   0x08000f90: f7ff        fa98 	bl	0x4c4
@   0x08000f94: 4906        ldr	r1, [pc, #24]	@ (0xfb0)
@   0x08000f96: 8008        strh	r0, [r1, #0]
@   0x08000f98: 0400        lsls	r0, r0, #16
@   0x08000f9a: 0c00        lsrs	r0, r0, #16
@   0x08000f9c: 2840        cmp	r0, #64	@ 0x40
@   0x08000f9e: d10b        bne.n	0xfb8
@   0x08000fa0: 4904        ldr	r1, [pc, #16]	@ (0xfb4)
@   0x08000fa2: 4469        add	r1, sp
@   0x08000fa4: 2005        movs	r0, #5
@   0x08000fa6: 7008        strb	r0, [r1, #0]
@   0x08000fa8: f00d        f85a 	bl	0xe060
@   0x08000fac: e0ae        b.n	0x110c
@   0x08000fae: 0000        movs	r0, r0
@   0x08000fb0: 5398        strh	r0, [r3, r6]
@   0x08000fb2: 0300        lsls	r0, r0, #12
@   0x08000fb4: 0141        lsls	r1, r0, #5
@   0x08000fb6: 0000        movs	r0, r0
@   0x08000fb8: 4906        ldr	r1, [pc, #24]	@ (0xfd4)
@   0x08000fba: 2308        movs	r3, #8
@   0x08000fbc: 2208        movs	r2, #8
@   0x08000fbe: 1c10        adds	r0, r2, #0
@   0x08000fc0: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08000fc2: 4008        ands	r0, r1
@   0x08000fc4: 2800        cmp	r0, #0
@   0x08000fc6: d009        beq.n	0xfdc
@   0x08000fc8: 4903        ldr	r1, [pc, #12]	@ (0xfd8)
@   0x08000fca: 4469        add	r1, sp
@   0x08000fcc: 2004        movs	r0, #4
@   0x08000fce: 7008        strb	r0, [r1, #0]
@   0x08000fd0: e09c        b.n	0x110c
@   0x08000fd2: 0000        movs	r0, r0
@   0x08000fd4: 3720        adds	r7, #32
@   0x08000fd6: 0300        lsls	r0, r0, #12
@   0x08000fd8: 0141        lsls	r1, r0, #5
@   0x08000fda: 0000        movs	r0, r0
@   0x08000fdc: 4904        ldr	r1, [pc, #16]	@ (0xff0)
@   0x08000fde: 1c10        adds	r0, r2, #0
@   0x08000fe0: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08000fe2: 4008        ands	r0, r1
@   0x08000fe4: 2800        cmp	r0, #0
@   0x08000fe6: d007        beq.n	0xff8
@   0x08000fe8: 4802        ldr	r0, [pc, #8]	@ (0xff4)
@   0x08000fea: 4468        add	r0, sp
@   0x08000fec: 7003        strb	r3, [r0, #0]
@   0x08000fee: e08d        b.n	0x110c
@   0x08000ff0: 6110        str	r0, [r2, #16]
@   0x08000ff2: 0300        lsls	r0, r0, #12
@   0x08000ff4: 0141        lsls	r1, r0, #5
@   0x08000ff6: 0000        movs	r0, r0
@   0x08000ff8: ac51        add	r4, sp, #324	@ 0x144
@   0x08000ffa: f009        f96d 	bl	0xa2d8
@   0x08000ffe: f7ff        fc6d 	bl	0x8dc
@   0x08001002: f009        f991 	bl	0xa328
@   0x08001006: f008        fa77 	bl	0x94f8
@   0x0800100a: f008        fcbb 	bl	0x9984
@   0x0800100e: 4668        mov	r0, sp
@   0x08001010: 1c21        adds	r1, r4, #0
@   0x08001012: f7ff        fefb 	bl	0xe0c
@   0x08001016: 4902        ldr	r1, [pc, #8]	@ (0x1020)
@   0x08001018: 6948        ldr	r0, [r1, #20]
@   0x0800101a: 3001        adds	r0, #1
@   0x0800101c: 6148        str	r0, [r1, #20]
@   0x0800101e: e075        b.n	0x110c
@   0x08001020: 5330        strh	r0, [r6, r4]
@   0x08001022: 0300        lsls	r0, r0, #12
@   0x08001024: 4c09        ldr	r4, [pc, #36]	@ (0x104c)
@   0x08001026: 446c        add	r4, sp
@   0x08001028: ad51        add	r5, sp, #324	@ 0x144
@   0x0800102a: 4808        ldr	r0, [pc, #32]	@ (0x104c)
@   0x0800102c: 4468        add	r0, sp
@   0x0800102e: f008        fdf1 	bl	0x9c14
@   0x08001032: 2800        cmp	r0, #0
@   0x08001034: d101        bne.n	0x103a
@   0x08001036: 2007        movs	r0, #7
@   0x08001038: 7020        strb	r0, [r4, #0]
@   0x0800103a: 4668        mov	r0, sp
@   0x0800103c: 1c29        adds	r1, r5, #0
@   0x0800103e: 2203        movs	r2, #3
@   0x08001040: f00a        fbb6 	bl	0xb7b0
@   0x08001044: a950        add	r1, sp, #320	@ 0x140
@   0x08001046: 2000        movs	r0, #0
@   0x08001048: 7008        strb	r0, [r1, #0]
@   0x0800104a: e05f        b.n	0x110c
@   0x0800104c: 0141        lsls	r1, r0, #5
@   0x0800104e: 0000        movs	r0, r0
@   0x08001050: f7ff        fa38 	bl	0x4c4
@   0x08001054: 490b        ldr	r1, [pc, #44]	@ (0x1084)
@   0x08001056: 8008        strh	r0, [r1, #0]
@   0x08001058: f00d        fb26 	bl	0xe6a8
@   0x0800105c: 0600        lsls	r0, r0, #24
@   0x0800105e: 0e02        lsrs	r2, r0, #24
@   0x08001060: 2a00        cmp	r2, #0
@   0x08001062: d105        bne.n	0x1070
@   0x08001064: 4808        ldr	r0, [pc, #32]	@ (0x1088)
@   0x08001066: 4468        add	r0, sp
@   0x08001068: 2106        movs	r1, #6
@   0x0800106a: 7001        strb	r1, [r0, #0]
@   0x0800106c: a850        add	r0, sp, #320	@ 0x140
@   0x0800106e: 7002        strb	r2, [r0, #0]
@   0x08001070: 4806        ldr	r0, [pc, #24]	@ (0x108c)
@   0x08001072: 7800        ldrb	r0, [r0, #0]
@   0x08001074: 2800        cmp	r0, #0
@   0x08001076: d149        bne.n	0x110c
@   0x08001078: 4903        ldr	r1, [pc, #12]	@ (0x1088)
@   0x0800107a: 4469        add	r1, sp
@   0x0800107c: 2003        movs	r0, #3
@   0x0800107e: 7008        strb	r0, [r1, #0]
@   0x08001080: e044        b.n	0x110c
@   0x08001082: 0000        movs	r0, r0
@   0x08001084: 5398        strh	r0, [r3, r6]
@   0x08001086: 0300        lsls	r0, r0, #12
@   0x08001088: 0141        lsls	r1, r0, #5
@   0x0800108a: 0000        movs	r0, r0
@   0x0800108c: 5328        strh	r0, [r5, r4]
@   0x0800108e: 0300        lsls	r0, r0, #12
@   0x08001090: ac50        add	r4, sp, #320	@ 0x140
@   0x08001092: 2000        movs	r0, #0
@   0x08001094: 5620        ldrsb	r0, [r4, r0]
@   0x08001096: 2800        cmp	r0, #0
@   0x08001098: d105        bne.n	0x10a6
@   0x0800109a: 20bf        movs	r0, #191	@ 0xbf
@   0x0800109c: f00f        fafa 	bl	0x10694
@   0x080010a0: 7820        ldrb	r0, [r4, #0]
@   0x080010a2: 3001        adds	r0, #1
@   0x080010a4: 7020        strb	r0, [r4, #0]
@   0x080010a6: 7824        ldrb	r4, [r4, #0]
@   0x080010a8: 0624        lsls	r4, r4, #24
@   0x080010aa: 1624        asrs	r4, r4, #24
@   0x080010ac: 2c01        cmp	r4, #1
@   0x080010ae: d12d        bne.n	0x110c
@   0x080010b0: f00f        fb02 	bl	0x106b8
@   0x080010b4: 0600        lsls	r0, r0, #24
@   0x080010b6: 2800        cmp	r0, #0
@   0x080010b8: d128        bne.n	0x110c
@   0x080010ba: 4803        ldr	r0, [pc, #12]	@ (0x10c8)
@   0x080010bc: 2104        movs	r1, #4
@   0x080010be: 7001        strb	r1, [r0, #0]
@   0x080010c0: 7184        strb	r4, [r0, #6]
@   0x080010c2: 4802        ldr	r0, [pc, #8]	@ (0x10cc)
@   0x080010c4: 7241        strb	r1, [r0, #9]
@   0x080010c6: e021        b.n	0x110c
@   0x080010c8: 3480        adds	r4, #128	@ 0x80
@   0x080010ca: 0300        lsls	r0, r0, #12
@   0x080010cc: 5330        strh	r0, [r6, r4]
@   0x080010ce: 0300        lsls	r0, r0, #12
@   0x080010d0: ac50        add	r4, sp, #320	@ 0x140
@   0x080010d2: 490a        ldr	r1, [pc, #40]	@ (0x10fc)
@   0x080010d4: 1c20        adds	r0, r4, #0
@   0x080010d6: f009        f815 	bl	0xa104
@   0x080010da: 0600        lsls	r0, r0, #24
@   0x080010dc: 2800        cmp	r0, #0
@   0x080010de: d009        beq.n	0x10f4
@   0x080010e0: 4907        ldr	r1, [pc, #28]	@ (0x1100)
@   0x080010e2: 4469        add	r1, sp
@   0x080010e4: 2002        movs	r0, #2
@   0x080010e6: 7008        strb	r0, [r1, #0]
@   0x080010e8: 4906        ldr	r1, [pc, #24]	@ (0x1104)
@   0x080010ea: 2000        movs	r0, #0
@   0x080010ec: 6148        str	r0, [r1, #20]
@   0x080010ee: 7020        strb	r0, [r4, #0]
@   0x080010f0: f009        f86a 	bl	0xa1c8
@   0x080010f4: f7ff        fbf2 	bl	0x8dc
@   0x080010f8: e008        b.n	0x110c
@   0x080010fa: 0000        movs	r0, r0
@   0x080010fc: a26d        add	r2, pc, #436	@ (adr r2, 0x12b4)
@   0x080010fe: 0800        lsrs	r0, r0, #32
@   0x08001100: 0141        lsls	r1, r0, #5
@   0x08001102: 0000        movs	r0, r0
@   0x08001104: 5330        strh	r0, [r6, r4]
@   0x08001106: 0300        lsls	r0, r0, #12
@   0x08001108: f00c        feba 	bl	0xde80
@   0x0800110c: 4805        ldr	r0, [pc, #20]	@ (0x1124)
@   0x0800110e: 7a40        ldrb	r0, [r0, #9]
@   0x08001110: 2809        cmp	r0, #9
@   0x08001112: d100        bne.n	0x1116
@   0x08001114: e6da        b.n	0xecc
@   0x08001116: 2818        cmp	r0, #24
@   0x08001118: d100        bne.n	0x111c
@   0x0800111a: e6d7        b.n	0xecc
@   0x0800111c: b053        add	sp, #332	@ 0x14c
@   0x0800111e: bc30        pop	{r4, r5}
@   0x08001120: bc01        pop	{r0}
@   0x08001122: 4700        bx	r0
@   0x08001124: 5330        strh	r0, [r6, r4]
@   0x08001126: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000EB8
sub_08000EB8: @ 0x08000eb8
        .incbin "frog_us_baserom.gba", 0xeb8, 0x270
        thumb_func_end sub_08000EB8
