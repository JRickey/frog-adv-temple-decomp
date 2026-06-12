@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024b68, 0x08024cd0)  (360 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024b68 --end 0x8024cd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024b68: b570        push	{r4, r5, r6, lr}
@   0x08024b6a: 464e        mov	r6, r9
@   0x08024b6c: 4645        mov	r5, r8
@   0x08024b6e: b460        push	{r5, r6}
@   0x08024b70: b084        sub	sp, #16
@   0x08024b72: 4d4f        ldr	r5, [pc, #316]	@ (0x24cb0)
@   0x08024b74: 6829        ldr	r1, [r5, #0]
@   0x08024b76: 484f        ldr	r0, [pc, #316]	@ (0x24cb4)
@   0x08024b78: 4681        mov	r9, r0
@   0x08024b7a: 9000        str	r0, [sp, #0]
@   0x08024b7c: 2608        movs	r6, #8
@   0x08024b7e: 9601        str	r6, [sp, #4]
@   0x08024b80: 2403        movs	r4, #3
@   0x08024b82: 9402        str	r4, [sp, #8]
@   0x08024b84: 9403        str	r4, [sp, #12]
@   0x08024b86: 2041        movs	r0, #65	@ 0x41
@   0x08024b88: 2210        movs	r2, #16
@   0x08024b8a: 2325        movs	r3, #37	@ 0x25
@   0x08024b8c: f7fc        fa88 	bl	0x210a0
@   0x08024b90: 6869        ldr	r1, [r5, #4]
@   0x08024b92: 4849        ldr	r0, [pc, #292]	@ (0x24cb8)
@   0x08024b94: 4680        mov	r8, r0
@   0x08024b96: 9000        str	r0, [sp, #0]
@   0x08024b98: 9601        str	r6, [sp, #4]
@   0x08024b9a: 9402        str	r4, [sp, #8]
@   0x08024b9c: 9403        str	r4, [sp, #12]
@   0x08024b9e: 2042        movs	r0, #66	@ 0x42
@   0x08024ba0: 2210        movs	r2, #16
@   0x08024ba2: 2325        movs	r3, #37	@ 0x25
@   0x08024ba4: f7fc        fa7c 	bl	0x210a0
@   0x08024ba8: 68a9        ldr	r1, [r5, #8]
@   0x08024baa: 4648        mov	r0, r9
@   0x08024bac: 9000        str	r0, [sp, #0]
@   0x08024bae: 9601        str	r6, [sp, #4]
@   0x08024bb0: 9402        str	r4, [sp, #8]
@   0x08024bb2: 9403        str	r4, [sp, #12]
@   0x08024bb4: 2043        movs	r0, #67	@ 0x43
@   0x08024bb6: 2210        movs	r2, #16
@   0x08024bb8: 2325        movs	r3, #37	@ 0x25
@   0x08024bba: f7fc        fa71 	bl	0x210a0
@   0x08024bbe: 68e9        ldr	r1, [r5, #12]
@   0x08024bc0: 4640        mov	r0, r8
@   0x08024bc2: 9000        str	r0, [sp, #0]
@   0x08024bc4: 9601        str	r6, [sp, #4]
@   0x08024bc6: 9402        str	r4, [sp, #8]
@   0x08024bc8: 9403        str	r4, [sp, #12]
@   0x08024bca: 2044        movs	r0, #68	@ 0x44
@   0x08024bcc: 2210        movs	r2, #16
@   0x08024bce: 2325        movs	r3, #37	@ 0x25
@   0x08024bd0: f7fc        fa66 	bl	0x210a0
@   0x08024bd4: 6929        ldr	r1, [r5, #16]
@   0x08024bd6: 4648        mov	r0, r9
@   0x08024bd8: 9000        str	r0, [sp, #0]
@   0x08024bda: 9601        str	r6, [sp, #4]
@   0x08024bdc: 9402        str	r4, [sp, #8]
@   0x08024bde: 9403        str	r4, [sp, #12]
@   0x08024be0: 2045        movs	r0, #69	@ 0x45
@   0x08024be2: 2210        movs	r2, #16
@   0x08024be4: 2325        movs	r3, #37	@ 0x25
@   0x08024be6: f7fc        fa5b 	bl	0x210a0
@   0x08024bea: 6969        ldr	r1, [r5, #20]
@   0x08024bec: 4640        mov	r0, r8
@   0x08024bee: 9000        str	r0, [sp, #0]
@   0x08024bf0: 9601        str	r6, [sp, #4]
@   0x08024bf2: 9402        str	r4, [sp, #8]
@   0x08024bf4: 9403        str	r4, [sp, #12]
@   0x08024bf6: 2046        movs	r0, #70	@ 0x46
@   0x08024bf8: 2210        movs	r2, #16
@   0x08024bfa: 2325        movs	r3, #37	@ 0x25
@   0x08024bfc: f7fc        fa50 	bl	0x210a0
@   0x08024c00: 69a9        ldr	r1, [r5, #24]
@   0x08024c02: 4648        mov	r0, r9
@   0x08024c04: 9000        str	r0, [sp, #0]
@   0x08024c06: 9601        str	r6, [sp, #4]
@   0x08024c08: 9402        str	r4, [sp, #8]
@   0x08024c0a: 9403        str	r4, [sp, #12]
@   0x08024c0c: 2047        movs	r0, #71	@ 0x47
@   0x08024c0e: 2210        movs	r2, #16
@   0x08024c10: 2325        movs	r3, #37	@ 0x25
@   0x08024c12: f7fc        fa45 	bl	0x210a0
@   0x08024c16: 69e9        ldr	r1, [r5, #28]
@   0x08024c18: 4640        mov	r0, r8
@   0x08024c1a: 9000        str	r0, [sp, #0]
@   0x08024c1c: 9601        str	r6, [sp, #4]
@   0x08024c1e: 9402        str	r4, [sp, #8]
@   0x08024c20: 9403        str	r4, [sp, #12]
@   0x08024c22: 2048        movs	r0, #72	@ 0x48
@   0x08024c24: 2210        movs	r2, #16
@   0x08024c26: 2325        movs	r3, #37	@ 0x25
@   0x08024c28: f7fc        fa3a 	bl	0x210a0
@   0x08024c2c: 4d23        ldr	r5, [pc, #140]	@ (0x24cbc)
@   0x08024c2e: 6829        ldr	r1, [r5, #0]
@   0x08024c30: 4823        ldr	r0, [pc, #140]	@ (0x24cc0)
@   0x08024c32: 4681        mov	r9, r0
@   0x08024c34: 9000        str	r0, [sp, #0]
@   0x08024c36: 9601        str	r6, [sp, #4]
@   0x08024c38: 9402        str	r4, [sp, #8]
@   0x08024c3a: 9403        str	r4, [sp, #12]
@   0x08024c3c: 2049        movs	r0, #73	@ 0x49
@   0x08024c3e: 2210        movs	r2, #16
@   0x08024c40: 2325        movs	r3, #37	@ 0x25
@   0x08024c42: f7fc        fa2d 	bl	0x210a0
@   0x08024c46: 6869        ldr	r1, [r5, #4]
@   0x08024c48: 481e        ldr	r0, [pc, #120]	@ (0x24cc4)
@   0x08024c4a: 4680        mov	r8, r0
@   0x08024c4c: 9000        str	r0, [sp, #0]
@   0x08024c4e: 9601        str	r6, [sp, #4]
@   0x08024c50: 9402        str	r4, [sp, #8]
@   0x08024c52: 9403        str	r4, [sp, #12]
@   0x08024c54: 204a        movs	r0, #74	@ 0x4a
@   0x08024c56: 2210        movs	r2, #16
@   0x08024c58: 2325        movs	r3, #37	@ 0x25
@   0x08024c5a: f7fc        fa21 	bl	0x210a0
@   0x08024c5e: 68a9        ldr	r1, [r5, #8]
@   0x08024c60: 4648        mov	r0, r9
@   0x08024c62: 9000        str	r0, [sp, #0]
@   0x08024c64: 9601        str	r6, [sp, #4]
@   0x08024c66: 9402        str	r4, [sp, #8]
@   0x08024c68: 9403        str	r4, [sp, #12]
@   0x08024c6a: 204b        movs	r0, #75	@ 0x4b
@   0x08024c6c: 2210        movs	r2, #16
@   0x08024c6e: 2325        movs	r3, #37	@ 0x25
@   0x08024c70: f7fc        fa16 	bl	0x210a0
@   0x08024c74: 68e9        ldr	r1, [r5, #12]
@   0x08024c76: 4640        mov	r0, r8
@   0x08024c78: 9000        str	r0, [sp, #0]
@   0x08024c7a: 9601        str	r6, [sp, #4]
@   0x08024c7c: 9402        str	r4, [sp, #8]
@   0x08024c7e: 9403        str	r4, [sp, #12]
@   0x08024c80: 204c        movs	r0, #76	@ 0x4c
@   0x08024c82: 2210        movs	r2, #16
@   0x08024c84: 2325        movs	r3, #37	@ 0x25
@   0x08024c86: f7fc        fa0b 	bl	0x210a0
@   0x08024c8a: 480f        ldr	r0, [pc, #60]	@ (0x24cc8)
@   0x08024c8c: 6801        ldr	r1, [r0, #0]
@   0x08024c8e: 480f        ldr	r0, [pc, #60]	@ (0x24ccc)
@   0x08024c90: 9000        str	r0, [sp, #0]
@   0x08024c92: 9601        str	r6, [sp, #4]
@   0x08024c94: 9402        str	r4, [sp, #8]
@   0x08024c96: 9403        str	r4, [sp, #12]
@   0x08024c98: 204d        movs	r0, #77	@ 0x4d
@   0x08024c9a: 2210        movs	r2, #16
@   0x08024c9c: 2324        movs	r3, #36	@ 0x24
@   0x08024c9e: f7fc        f9ff 	bl	0x210a0
@   0x08024ca2: b004        add	sp, #16
@   0x08024ca4: bc18        pop	{r3, r4}
@   0x08024ca6: 4698        mov	r8, r3
@   0x08024ca8: 46a1        mov	r9, r4
@   0x08024caa: bc70        pop	{r4, r5, r6}
@   0x08024cac: bc01        pop	{r0}
@   0x08024cae: 4700        bx	r0
@   0x08024cb0: 4014        ands	r4, r2
@   0x08024cb2: 0831        lsrs	r1, r6, #32
@   0x08024cb4: 0171        lsls	r1, r6, #5
@   0x08024cb6: 0000        movs	r0, r0
@   0x08024cb8: 0191        lsls	r1, r2, #6
@   0x08024cba: 0000        movs	r0, r0
@   0x08024cbc: 4034        ands	r4, r6
@   0x08024cbe: 0831        lsrs	r1, r6, #32
@   0x08024cc0: 01b1        lsls	r1, r6, #6
@   0x08024cc2: 0000        movs	r0, r0
@   0x08024cc4: 01d1        lsls	r1, r2, #7
@   0x08024cc6: 0000        movs	r0, r0
@   0x08024cc8: 4044        eors	r4, r0
@   0x08024cca: 0831        lsrs	r1, r6, #32
@   0x08024ccc: 01f1        lsls	r1, r6, #7

        thumb_func_start sub_08024B68
sub_08024B68: @ 0x08024b68
        .incbin "baserom.gba", 0x24b68, 0x168
        thumb_func_end sub_08024B68
