@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080089a4, 0x08008a5c)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80089a4 --end 0x8008a5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080089a4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080089a6: 0600        lsls	r0, r0, #24
@   0x080089a8: 0e00        lsrs	r0, r0, #24
@   0x080089aa: 1c06        adds	r6, r0, #0
@   0x080089ac: 0609        lsls	r1, r1, #24
@   0x080089ae: 0e0c        lsrs	r4, r1, #24
@   0x080089b0: 0612        lsls	r2, r2, #24
@   0x080089b2: 0e12        lsrs	r2, r2, #24
@   0x080089b4: 4694        mov	ip, r2
@   0x080089b6: 061b        lsls	r3, r3, #24
@   0x080089b8: 0e1b        lsrs	r3, r3, #24
@   0x080089ba: 2801        cmp	r0, #1
@   0x080089bc: d012        beq.n	0x89e4
@   0x080089be: 2801        cmp	r0, #1
@   0x080089c0: dc02        bgt.n	0x89c8
@   0x080089c2: 2800        cmp	r0, #0
@   0x080089c4: d005        beq.n	0x89d2
@   0x080089c6: e029        b.n	0x8a1c
@   0x080089c8: 2e02        cmp	r6, #2
@   0x080089ca: d017        beq.n	0x89fc
@   0x080089cc: 2e03        cmp	r6, #3
@   0x080089ce: d01d        beq.n	0x8a0c
@   0x080089d0: e024        b.n	0x8a1c
@   0x080089d2: 4903        ldr	r1, [pc, #12]	@ (0x89e0)
@   0x080089d4: 884f        ldrh	r7, [r1, #2]
@   0x080089d6: 0620        lsls	r0, r4, #24
@   0x080089d8: 1600        asrs	r0, r0, #24
@   0x080089da: 8889        ldrh	r1, [r1, #4]
@   0x080089dc: 1a08        subs	r0, r1, r0
@   0x080089de: e007        b.n	0x89f0
@   0x080089e0: 3720        adds	r7, #32
@   0x080089e2: 0300        lsls	r0, r0, #12
@   0x080089e4: 4904        ldr	r1, [pc, #16]	@ (0x89f8)
@   0x080089e6: 884f        ldrh	r7, [r1, #2]
@   0x080089e8: 0620        lsls	r0, r4, #24
@   0x080089ea: 1600        asrs	r0, r0, #24
@   0x080089ec: 8889        ldrh	r1, [r1, #4]
@   0x080089ee: 1808        adds	r0, r1, r0
@   0x080089f0: 0400        lsls	r0, r0, #16
@   0x080089f2: 0c05        lsrs	r5, r0, #16
@   0x080089f4: e012        b.n	0x8a1c
@   0x080089f6: 0000        movs	r0, r0
@   0x080089f8: 3720        adds	r7, #32
@   0x080089fa: 0300        lsls	r0, r0, #12
@   0x080089fc: 4902        ldr	r1, [pc, #8]	@ (0x8a08)
@   0x080089fe: 0620        lsls	r0, r4, #24
@   0x08008a00: 1600        asrs	r0, r0, #24
@   0x08008a02: 884a        ldrh	r2, [r1, #2]
@   0x08008a04: 1a10        subs	r0, r2, r0
@   0x08008a06: e006        b.n	0x8a16
@   0x08008a08: 3720        adds	r7, #32
@   0x08008a0a: 0300        lsls	r0, r0, #12
@   0x08008a0c: 4912        ldr	r1, [pc, #72]	@ (0x8a58)
@   0x08008a0e: 0620        lsls	r0, r4, #24
@   0x08008a10: 1600        asrs	r0, r0, #24
@   0x08008a12: 884a        ldrh	r2, [r1, #2]
@   0x08008a14: 1810        adds	r0, r2, r0
@   0x08008a16: 0400        lsls	r0, r0, #16
@   0x08008a18: 0c07        lsrs	r7, r0, #16
@   0x08008a1a: 888d        ldrh	r5, [r1, #4]
@   0x08008a1c: 0618        lsls	r0, r3, #24
@   0x08008a1e: 1602        asrs	r2, r0, #24
@   0x08008a20: 0fc0        lsrs	r0, r0, #31
@   0x08008a22: 1812        adds	r2, r2, r0
@   0x08008a24: 1052        asrs	r2, r2, #1
@   0x08008a26: 0428        lsls	r0, r5, #16
@   0x08008a28: 1400        asrs	r0, r0, #16
@   0x08008a2a: 1a83        subs	r3, r0, r2
@   0x08008a2c: 9905        ldr	r1, [sp, #20]
@   0x08008a2e: 800b        strh	r3, [r1, #0]
@   0x08008a30: 1880        adds	r0, r0, r2
@   0x08008a32: 9906        ldr	r1, [sp, #24]
@   0x08008a34: 8008        strh	r0, [r1, #0]
@   0x08008a36: 4661        mov	r1, ip
@   0x08008a38: 0608        lsls	r0, r1, #24
@   0x08008a3a: 1602        asrs	r2, r0, #24
@   0x08008a3c: 0fc0        lsrs	r0, r0, #31
@   0x08008a3e: 1812        adds	r2, r2, r0
@   0x08008a40: 1052        asrs	r2, r2, #1
@   0x08008a42: 0438        lsls	r0, r7, #16
@   0x08008a44: 1400        asrs	r0, r0, #16
@   0x08008a46: 1a83        subs	r3, r0, r2
@   0x08008a48: 9907        ldr	r1, [sp, #28]
@   0x08008a4a: 800b        strh	r3, [r1, #0]
@   0x08008a4c: 1880        adds	r0, r0, r2
@   0x08008a4e: 9908        ldr	r1, [sp, #32]
@   0x08008a50: 8008        strh	r0, [r1, #0]
@   0x08008a52: bcf0        pop	{r4, r5, r6, r7}
@   0x08008a54: bc01        pop	{r0}
@   0x08008a56: 4700        bx	r0
@   0x08008a58: 3720        adds	r7, #32
@   0x08008a5a: 0300        lsls	r0, r0, #12

        thumb_func_start Entity_GetDirHitbox
Entity_GetDirHitbox: @ 0x080089a4
        .incbin "frog_us_baserom.gba", 0x89a4, 0xb8
        thumb_func_end Entity_GetDirHitbox
