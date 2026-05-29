@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d0f8, 0x0800d1f8)  (256 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d0f8 --end 0x800d1f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d0f8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d0fa: 4647        mov	r7, r8
@   0x0800d0fc: b480        push	{r7}
@   0x0800d0fe: b082        sub	sp, #8
@   0x0800d100: 2600        movs	r6, #0
@   0x0800d102: 2700        movs	r7, #0
@   0x0800d104: 2100        movs	r1, #0
@   0x0800d106: 480e        ldr	r0, [pc, #56]	@ (0xd140)
@   0x0800d108: 4680        mov	r8, r0
@   0x0800d10a: 4a0d        ldr	r2, [pc, #52]	@ (0xd140)
@   0x0800d10c: 0609        lsls	r1, r1, #24
@   0x0800d10e: 1608        asrs	r0, r1, #24
@   0x0800d110: 1880        adds	r0, r0, r2
@   0x0800d112: 1c0d        adds	r5, r1, #0
@   0x0800d114: 7800        ldrb	r0, [r0, #0]
@   0x0800d116: 2801        cmp	r0, #1
@   0x0800d118: d114        bne.n	0xd144
@   0x0800d11a: 0630        lsls	r0, r6, #24
@   0x0800d11c: 1604        asrs	r4, r0, #24
@   0x0800d11e: 2c13        cmp	r4, #19
@   0x0800d120: dc10        bgt.n	0xd144
@   0x0800d122: 0e29        lsrs	r1, r5, #24
@   0x0800d124: 4668        mov	r0, sp
@   0x0800d126: f000        fced 	bl	0xdb04
@   0x0800d12a: 9a00        ldr	r2, [sp, #0]
@   0x0800d12c: 0411        lsls	r1, r2, #16
@   0x0800d12e: 1409        asrs	r1, r1, #16
@   0x0800d130: 1412        asrs	r2, r2, #16
@   0x0800d132: 1c20        adds	r0, r4, #0
@   0x0800d134: f01e        fce0 	bl	0x2baf8
@   0x0800d138: 1c60        adds	r0, r4, #1
@   0x0800d13a: 0600        lsls	r0, r0, #24
@   0x0800d13c: 0e06        lsrs	r6, r0, #24
@   0x0800d13e: e018        b.n	0xd172
@   0x0800d140: 53a0        strh	r0, [r4, r6]
@   0x0800d142: 0300        lsls	r0, r0, #12
@   0x0800d144: 1628        asrs	r0, r5, #24
@   0x0800d146: 4440        add	r0, r8
@   0x0800d148: 7800        ldrb	r0, [r0, #0]
@   0x0800d14a: 2802        cmp	r0, #2
@   0x0800d14c: d111        bne.n	0xd172
@   0x0800d14e: 0638        lsls	r0, r7, #24
@   0x0800d150: 1604        asrs	r4, r0, #24
@   0x0800d152: 2c09        cmp	r4, #9
@   0x0800d154: dc0d        bgt.n	0xd172
@   0x0800d156: 0e29        lsrs	r1, r5, #24
@   0x0800d158: a801        add	r0, sp, #4
@   0x0800d15a: f000        fcd3 	bl	0xdb04
@   0x0800d15e: 9a01        ldr	r2, [sp, #4]
@   0x0800d160: 0411        lsls	r1, r2, #16
@   0x0800d162: 1409        asrs	r1, r1, #16
@   0x0800d164: 1412        asrs	r2, r2, #16
@   0x0800d166: 1c20        adds	r0, r4, #0
@   0x0800d168: f01e        fcf8 	bl	0x2bb5c
@   0x0800d16c: 1c60        adds	r0, r4, #1
@   0x0800d16e: 0600        lsls	r0, r0, #24
@   0x0800d170: 0e07        lsrs	r7, r0, #24
@   0x0800d172: 2180        movs	r1, #128	@ 0x80
@   0x0800d174: 0449        lsls	r1, r1, #17
@   0x0800d176: 1868        adds	r0, r5, r1
@   0x0800d178: 0e01        lsrs	r1, r0, #24
@   0x0800d17a: 1600        asrs	r0, r0, #24
@   0x0800d17c: 283f        cmp	r0, #63	@ 0x3f
@   0x0800d17e: ddc4        ble.n	0xd10a
@   0x0800d180: 0631        lsls	r1, r6, #24
@   0x0800d182: 1c0b        adds	r3, r1, #0
@   0x0800d184: 1618        asrs	r0, r3, #24
@   0x0800d186: 063f        lsls	r7, r7, #24
@   0x0800d188: 2813        cmp	r0, #19
@   0x0800d18a: dc14        bgt.n	0xd1b6
@   0x0800d18c: 4a19        ldr	r2, [pc, #100]	@ (0xd1f4)
@   0x0800d18e: 1609        asrs	r1, r1, #24
@   0x0800d190: 3103        adds	r1, #3
@   0x0800d192: 00c8        lsls	r0, r1, #3
@   0x0800d194: 1a40        subs	r0, r0, r1
@   0x0800d196: 00c0        lsls	r0, r0, #3
@   0x0800d198: 1881        adds	r1, r0, r2
@   0x0800d19a: 8e8c        ldrh	r4, [r1, #52]	@ 0x34
@   0x0800d19c: 2608        movs	r6, #8
@   0x0800d19e: 2500        movs	r5, #0
@   0x0800d1a0: 1c22        adds	r2, r4, #0
@   0x0800d1a2: 4332        orrs	r2, r6
@   0x0800d1a4: 432a        orrs	r2, r5
@   0x0800d1a6: 1c14        adds	r4, r2, #0
@   0x0800d1a8: 2080        movs	r0, #128	@ 0x80
@   0x0800d1aa: 0440        lsls	r0, r0, #17
@   0x0800d1ac: 181b        adds	r3, r3, r0
@   0x0800d1ae: 1618        asrs	r0, r3, #24
@   0x0800d1b0: 2813        cmp	r0, #19
@   0x0800d1b2: ddf5        ble.n	0xd1a0
@   0x0800d1b4: 868a        strh	r2, [r1, #52]	@ 0x34
@   0x0800d1b6: 1c3b        adds	r3, r7, #0
@   0x0800d1b8: 1618        asrs	r0, r3, #24
@   0x0800d1ba: 2809        cmp	r0, #9
@   0x0800d1bc: dc14        bgt.n	0xd1e8
@   0x0800d1be: 4a0d        ldr	r2, [pc, #52]	@ (0xd1f4)
@   0x0800d1c0: 1639        asrs	r1, r7, #24
@   0x0800d1c2: 3117        adds	r1, #23
@   0x0800d1c4: 00c8        lsls	r0, r1, #3
@   0x0800d1c6: 1a40        subs	r0, r0, r1
@   0x0800d1c8: 00c0        lsls	r0, r0, #3
@   0x0800d1ca: 1881        adds	r1, r0, r2
@   0x0800d1cc: 8e8c        ldrh	r4, [r1, #52]	@ 0x34
@   0x0800d1ce: 2608        movs	r6, #8
@   0x0800d1d0: 2500        movs	r5, #0
@   0x0800d1d2: 1c22        adds	r2, r4, #0
@   0x0800d1d4: 4332        orrs	r2, r6
@   0x0800d1d6: 432a        orrs	r2, r5
@   0x0800d1d8: 1c14        adds	r4, r2, #0
@   0x0800d1da: 2080        movs	r0, #128	@ 0x80
@   0x0800d1dc: 0440        lsls	r0, r0, #17
@   0x0800d1de: 181b        adds	r3, r3, r0
@   0x0800d1e0: 1618        asrs	r0, r3, #24
@   0x0800d1e2: 2809        cmp	r0, #9
@   0x0800d1e4: ddf5        ble.n	0xd1d2
@   0x0800d1e6: 868a        strh	r2, [r1, #52]	@ 0x34
@   0x0800d1e8: b002        add	sp, #8
@   0x0800d1ea: bc08        pop	{r3}
@   0x0800d1ec: 4698        mov	r8, r3
@   0x0800d1ee: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d1f0: bc01        pop	{r0}
@   0x0800d1f2: 4700        bx	r0
@   0x0800d1f4: 3720        adds	r7, #32
@   0x0800d1f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800D0F8
sub_0800D0F8: @ 0x0800d0f8
        .incbin "frog_us_baserom.gba", 0xd0f8, 0x100
        thumb_func_end sub_0800D0F8
