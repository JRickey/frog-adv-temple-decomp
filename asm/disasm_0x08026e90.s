@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026e90, 0x08026edc)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026e90 --end 0x8026edc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026e90: b530        push	{r4, r5, lr}
@   0x08026e92: b084        sub	sp, #16
@   0x08026e94: 2400        movs	r4, #0
@   0x08026e96: 1c20        adds	r0, r4, #0
@   0x08026e98: 3074        adds	r0, #116	@ 0x74
@   0x08026e9a: 4a0e        ldr	r2, [pc, #56]	@ (0x26ed4)
@   0x08026e9c: 00a1        lsls	r1, r4, #2
@   0x08026e9e: 1889        adds	r1, r1, r2
@   0x08026ea0: 6809        ldr	r1, [r1, #0]
@   0x08026ea2: 2201        movs	r2, #1
@   0x08026ea4: 4022        ands	r2, r4
@   0x08026ea6: 0192        lsls	r2, r2, #6
@   0x08026ea8: 4d0b        ldr	r5, [pc, #44]	@ (0x26ed8)
@   0x08026eaa: 1c2b        adds	r3, r5, #0
@   0x08026eac: 431a        orrs	r2, r3
@   0x08026eae: 9200        str	r2, [sp, #0]
@   0x08026eb0: 220d        movs	r2, #13
@   0x08026eb2: 9201        str	r2, [sp, #4]
@   0x08026eb4: 2203        movs	r2, #3
@   0x08026eb6: 9202        str	r2, [sp, #8]
@   0x08026eb8: 9203        str	r2, [sp, #12]
@   0x08026eba: 2210        movs	r2, #16
@   0x08026ebc: 2339        movs	r3, #57	@ 0x39
@   0x08026ebe: f7fa        f8ef 	bl	0x210a0
@   0x08026ec2: 1c60        adds	r0, r4, #1
@   0x08026ec4: 0600        lsls	r0, r0, #24
@   0x08026ec6: 0e04        lsrs	r4, r0, #24
@   0x08026ec8: 2c02        cmp	r4, #2
@   0x08026eca: d9e4        bls.n	0x26e96
@   0x08026ecc: b004        add	sp, #16
@   0x08026ece: bc30        pop	{r4, r5}
@   0x08026ed0: bc01        pop	{r0}
@   0x08026ed2: 4700        bx	r0
@   0x08026ed4: 5274        strh	r4, [r6, r1]
@   0x08026ed6: 0831        lsrs	r1, r6, #32
@   0x08026ed8: 0211        lsls	r1, r2, #8

        thumb_func_start sub_08026E90
sub_08026E90: @ 0x08026e90
        .incbin "baserom.gba", 0x26e90, 0x4c
        thumb_func_end sub_08026E90
