@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080179b8, 0x08017a88)  (208 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80179b8 --end 0x8017a88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080179b8: b570        push	{r4, r5, r6, lr}
@   0x080179ba: 4811        ldr	r0, [pc, #68]	@ (0x17a00)
@   0x080179bc: 7841        ldrb	r1, [r0, #1]
@   0x080179be: 1c06        adds	r6, r0, #0
@   0x080179c0: 2900        cmp	r1, #0
@   0x080179c2: d009        beq.n	0x179d8
@   0x080179c4: f7e8        ff9c 	bl	0x900
@   0x080179c8: 6871        ldr	r1, [r6, #4]
@   0x080179ca: 1a40        subs	r0, r0, r1
@   0x080179cc: 213c        movs	r1, #60	@ 0x3c
@   0x080179ce: f01c        fa89 	bl	0x33ee4
@   0x080179d2: 7871        ldrb	r1, [r6, #1]
@   0x080179d4: 4288        cmp	r0, r1
@   0x080179d6: d351        bcc.n	0x17a7c
@   0x080179d8: 2300        movs	r3, #0
@   0x080179da: 7073        strb	r3, [r6, #1]
@   0x080179dc: 6073        str	r3, [r6, #4]
@   0x080179de: 4909        ldr	r1, [pc, #36]	@ (0x17a04)
@   0x080179e0: 4a09        ldr	r2, [pc, #36]	@ (0x17a08)
@   0x080179e2: 7a90        ldrb	r0, [r2, #10]
@   0x080179e4: 3801        subs	r0, #1
@   0x080179e6: 0080        lsls	r0, r0, #2
@   0x080179e8: 1840        adds	r0, r0, r1
@   0x080179ea: 6805        ldr	r5, [r0, #0]
@   0x080179ec: 7831        ldrb	r1, [r6, #0]
@   0x080179ee: 0048        lsls	r0, r1, #1
@   0x080179f0: 1940        adds	r0, r0, r5
@   0x080179f2: 8804        ldrh	r4, [r0, #0]
@   0x080179f4: 2cfe        cmp	r4, #254	@ 0xfe
@   0x080179f6: d109        bne.n	0x17a0c
@   0x080179f8: 2001        movs	r0, #1
@   0x080179fa: 60f0        str	r0, [r6, #12]
@   0x080179fc: e009        b.n	0x17a12
@   0x080179fe: 0000        movs	r0, r0
@   0x08017a00: 34c0        adds	r4, #192	@ 0xc0
@   0x08017a02: 0300        lsls	r0, r0, #12
@   0x08017a04: 7fec        ldrb	r4, [r5, #31]
@   0x08017a06: 0830        lsrs	r0, r6, #32
@   0x08017a08: 5330        strh	r0, [r6, r4]
@   0x08017a0a: 0300        lsls	r0, r0, #12
@   0x08017a0c: 2cfd        cmp	r4, #253	@ 0xfd
@   0x08017a0e: d100        bne.n	0x17a12
@   0x08017a10: 60f3        str	r3, [r6, #12]
@   0x08017a12: 490f        ldr	r1, [pc, #60]	@ (0x17a50)
@   0x08017a14: 2001        movs	r0, #1
@   0x08017a16: 8a09        ldrh	r1, [r1, #16]
@   0x08017a18: 4008        ands	r0, r1
@   0x08017a1a: 4e0e        ldr	r6, [pc, #56]	@ (0x17a54)
@   0x08017a1c: 2800        cmp	r0, #0
@   0x08017a1e: d002        beq.n	0x17a26
@   0x08017a20: 68f0        ldr	r0, [r6, #12]
@   0x08017a22: 2800        cmp	r0, #0
@   0x08017a24: d028        beq.n	0x17a78
@   0x08017a26: 7830        ldrb	r0, [r6, #0]
@   0x08017a28: 1c41        adds	r1, r0, #1
@   0x08017a2a: 7031        strb	r1, [r6, #0]
@   0x08017a2c: 0600        lsls	r0, r0, #24
@   0x08017a2e: 0dc0        lsrs	r0, r0, #23
@   0x08017a30: 1940        adds	r0, r0, r5
@   0x08017a32: 8804        ldrh	r4, [r0, #0]
@   0x08017a34: 2c00        cmp	r4, #0
@   0x08017a36: d10f        bne.n	0x17a58
@   0x08017a38: 1c48        adds	r0, r1, #1
@   0x08017a3a: 7030        strb	r0, [r6, #0]
@   0x08017a3c: 0608        lsls	r0, r1, #24
@   0x08017a3e: 0dc0        lsrs	r0, r0, #23
@   0x08017a40: 1940        adds	r0, r0, r5
@   0x08017a42: 8800        ldrh	r0, [r0, #0]
@   0x08017a44: 7070        strb	r0, [r6, #1]
@   0x08017a46: f7e8        ff5b 	bl	0x900
@   0x08017a4a: 6070        str	r0, [r6, #4]
@   0x08017a4c: e017        b.n	0x17a7e
@   0x08017a4e: 0000        movs	r0, r0
@   0x08017a50: 35e0        adds	r5, #224	@ 0xe0
@   0x08017a52: 0300        lsls	r0, r0, #12
@   0x08017a54: 34c0        adds	r4, #192	@ 0xc0
@   0x08017a56: 0300        lsls	r0, r0, #12
@   0x08017a58: 1c20        adds	r0, r4, #0
@   0x08017a5a: 38fd        subs	r0, #253	@ 0xfd
@   0x08017a5c: 0400        lsls	r0, r0, #16
@   0x08017a5e: 0c00        lsrs	r0, r0, #16
@   0x08017a60: 2801        cmp	r0, #1
@   0x08017a62: d90b        bls.n	0x17a7c
@   0x08017a64: 2cff        cmp	r4, #255	@ 0xff
@   0x08017a66: d10a        bne.n	0x17a7e
@   0x08017a68: 2104        movs	r1, #4
@   0x08017a6a: 7251        strb	r1, [r2, #9]
@   0x08017a6c: 4801        ldr	r0, [pc, #4]	@ (0x17a74)
@   0x08017a6e: 7001        strb	r1, [r0, #0]
@   0x08017a70: e004        b.n	0x17a7c
@   0x08017a72: 0000        movs	r0, r0
@   0x08017a74: 3480        adds	r4, #128	@ 0x80
@   0x08017a76: 0300        lsls	r0, r0, #12
@   0x08017a78: 2000        movs	r0, #0
@   0x08017a7a: e001        b.n	0x17a80
@   0x08017a7c: 2400        movs	r4, #0
@   0x08017a7e: 1c20        adds	r0, r4, #0
@   0x08017a80: bc70        pop	{r4, r5, r6}
@   0x08017a82: bc02        pop	{r1}
@   0x08017a84: 4708        bx	r1

        thumb_func_start sub_080179B8
sub_080179B8: @ 0x080179b8
        .incbin "frog_us_baserom.gba", 0x179b8, 0xd0
        thumb_func_end sub_080179B8
