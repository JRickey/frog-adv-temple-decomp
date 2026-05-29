@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020f3c, 0x08020fe4)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020f3c --end 0x8020fe4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020f3c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08020f3e: 4647        mov	r7, r8
@   0x08020f40: b480        push	{r7}
@   0x08020f42: 0600        lsls	r0, r0, #24
@   0x08020f44: 0e06        lsrs	r6, r0, #24
@   0x08020f46: 4823        ldr	r0, [pc, #140]	@ (0x20fd4)
@   0x08020f48: 1c31        adds	r1, r6, #0
@   0x08020f4a: 1c32        adds	r2, r6, #0
@   0x08020f4c: f7e5        fc70 	bl	0x6830
@   0x08020f50: 4308        orrs	r0, r1
@   0x08020f52: 2800        cmp	r0, #0
@   0x08020f54: d039        beq.n	0x20fca
@   0x08020f56: 4c20        ldr	r4, [pc, #128]	@ (0x20fd8)
@   0x08020f58: 4b20        ldr	r3, [pc, #128]	@ (0x20fdc)
@   0x08020f5a: 00f5        lsls	r5, r6, #3
@   0x08020f5c: 1ba9        subs	r1, r5, r6
@   0x08020f5e: 00c9        lsls	r1, r1, #3
@   0x08020f60: 1c18        adds	r0, r3, #0
@   0x08020f62: 302c        adds	r0, #44	@ 0x2c
@   0x08020f64: 1808        adds	r0, r1, r0
@   0x08020f66: 6822        ldr	r2, [r4, #0]
@   0x08020f68: 6800        ldr	r0, [r0, #0]
@   0x08020f6a: 1a12        subs	r2, r2, r0
@   0x08020f6c: 18c9        adds	r1, r1, r3
@   0x08020f6e: 468c        mov	ip, r1
@   0x08020f70: 4660        mov	r0, ip
@   0x08020f72: 3032        adds	r0, #50	@ 0x32
@   0x08020f74: 46a0        mov	r8, r4
@   0x08020f76: 7800        ldrb	r0, [r0, #0]
@   0x08020f78: 4282        cmp	r2, r0
@   0x08020f7a: d326        bcc.n	0x20fca
@   0x08020f7c: 4660        mov	r0, ip
@   0x08020f7e: 3030        adds	r0, #48	@ 0x30
@   0x08020f80: 3131        adds	r1, #49	@ 0x31
@   0x08020f82: 7809        ldrb	r1, [r1, #0]
@   0x08020f84: 2400        movs	r4, #0
@   0x08020f86: 5704        ldrsb	r4, [r0, r4]
@   0x08020f88: 4662        mov	r2, ip
@   0x08020f8a: 8852        ldrh	r2, [r2, #2]
@   0x08020f8c: 1910        adds	r0, r2, r4
@   0x08020f8e: 4667        mov	r7, ip
@   0x08020f90: 8078        strh	r0, [r7, #2]
@   0x08020f92: 0609        lsls	r1, r1, #24
@   0x08020f94: 1609        asrs	r1, r1, #24
@   0x08020f96: 88ba        ldrh	r2, [r7, #4]
@   0x08020f98: 1850        adds	r0, r2, r1
@   0x08020f9a: 80b8        strh	r0, [r7, #4]
@   0x08020f9c: 4a10        ldr	r2, [pc, #64]	@ (0x20fe0)
@   0x08020f9e: 2002        movs	r0, #2
@   0x08020fa0: 8a17        ldrh	r7, [r2, #16]
@   0x08020fa2: 4038        ands	r0, r7
@   0x08020fa4: 2800        cmp	r0, #0
@   0x08020fa6: d008        beq.n	0x20fba
@   0x08020fa8: 7b52        ldrb	r2, [r2, #13]
@   0x08020faa: 4296        cmp	r6, r2
@   0x08020fac: d105        bne.n	0x20fba
@   0x08020fae: 885a        ldrh	r2, [r3, #2]
@   0x08020fb0: 1910        adds	r0, r2, r4
@   0x08020fb2: 8058        strh	r0, [r3, #2]
@   0x08020fb4: 889f        ldrh	r7, [r3, #4]
@   0x08020fb6: 1878        adds	r0, r7, r1
@   0x08020fb8: 8098        strh	r0, [r3, #4]
@   0x08020fba: 1ba8        subs	r0, r5, r6
@   0x08020fbc: 00c0        lsls	r0, r0, #3
@   0x08020fbe: 1c19        adds	r1, r3, #0
@   0x08020fc0: 312c        adds	r1, #44	@ 0x2c
@   0x08020fc2: 1840        adds	r0, r0, r1
@   0x08020fc4: 4642        mov	r2, r8
@   0x08020fc6: 6811        ldr	r1, [r2, #0]
@   0x08020fc8: 6001        str	r1, [r0, #0]
@   0x08020fca: bc08        pop	{r3}
@   0x08020fcc: 4698        mov	r8, r3
@   0x08020fce: bcf0        pop	{r4, r5, r6, r7}
@   0x08020fd0: bc01        pop	{r0}
@   0x08020fd2: 4700        bx	r0
@   0x08020fd4: 6110        str	r0, [r2, #16]
@   0x08020fd6: 0300        lsls	r0, r0, #12
@   0x08020fd8: 5330        strh	r0, [r6, r4]
@   0x08020fda: 0300        lsls	r0, r0, #12
@   0x08020fdc: 3720        adds	r7, #32
@   0x08020fde: 0300        lsls	r0, r0, #12
@   0x08020fe0: 35e0        adds	r5, #224	@ 0xe0
@   0x08020fe2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020F3C
sub_08020F3C: @ 0x08020f3c
        .incbin "frog_us_baserom.gba", 0x20f3c, 0xa8
        thumb_func_end sub_08020F3C
