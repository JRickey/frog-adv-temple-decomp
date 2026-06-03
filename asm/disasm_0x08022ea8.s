@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022ea8, 0x08022f4c)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022ea8 --end 0x8022f4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022ea8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022eaa: 4647        mov	r7, r8
@   0x08022eac: b480        push	{r7}
@   0x08022eae: b084        sub	sp, #16
@   0x08022eb0: 2500        movs	r5, #0
@   0x08022eb2: 480f        ldr	r0, [pc, #60]	@ (0x22ef0)
@   0x08022eb4: 4680        mov	r8, r0
@   0x08022eb6: 2707        movs	r7, #7
@   0x08022eb8: 2603        movs	r6, #3
@   0x08022eba: 2001        movs	r0, #1
@   0x08022ebc: 4028        ands	r0, r5
@   0x08022ebe: 2800        cmp	r0, #0
@   0x08022ec0: d118        bne.n	0x22ef4
@   0x08022ec2: 1c2c        adds	r4, r5, #0
@   0x08022ec4: 3432        adds	r4, #50	@ 0x32
@   0x08022ec6: 00a8        lsls	r0, r5, #2
@   0x08022ec8: 4440        add	r0, r8
@   0x08022eca: 6801        ldr	r1, [r0, #0]
@   0x08022ecc: 1c28        adds	r0, r5, #0
@   0x08022ece: 4038        ands	r0, r7
@   0x08022ed0: 0500        lsls	r0, r0, #20
@   0x08022ed2: 22c1        movs	r2, #193	@ 0xc1
@   0x08022ed4: 0412        lsls	r2, r2, #16
@   0x08022ed6: 1880        adds	r0, r0, r2
@   0x08022ed8: 0c00        lsrs	r0, r0, #16
@   0x08022eda: 9000        str	r0, [sp, #0]
@   0x08022edc: 9701        str	r7, [sp, #4]
@   0x08022ede: 9602        str	r6, [sp, #8]
@   0x08022ee0: 9603        str	r6, [sp, #12]
@   0x08022ee2: 1c20        adds	r0, r4, #0
@   0x08022ee4: 2210        movs	r2, #16
@   0x08022ee6: 2308        movs	r3, #8
@   0x08022ee8: f7fe        f8da 	bl	0x210a0
@   0x08022eec: e018        b.n	0x22f20
@   0x08022eee: 0000        movs	r0, r0
@   0x08022ef0: 1c80        adds	r0, r0, #2
@   0x08022ef2: 0831        lsrs	r1, r6, #32
@   0x08022ef4: 1c2c        adds	r4, r5, #0
@   0x08022ef6: 3432        adds	r4, #50	@ 0x32
@   0x08022ef8: 00a8        lsls	r0, r5, #2
@   0x08022efa: 4440        add	r0, r8
@   0x08022efc: 6801        ldr	r1, [r0, #0]
@   0x08022efe: 1c28        adds	r0, r5, #0
@   0x08022f00: 4038        ands	r0, r7
@   0x08022f02: 0500        lsls	r0, r0, #20
@   0x08022f04: 22c1        movs	r2, #193	@ 0xc1
@   0x08022f06: 0412        lsls	r2, r2, #16
@   0x08022f08: 1880        adds	r0, r0, r2
@   0x08022f0a: 0c00        lsrs	r0, r0, #16
@   0x08022f0c: 9000        str	r0, [sp, #0]
@   0x08022f0e: 2006        movs	r0, #6
@   0x08022f10: 9001        str	r0, [sp, #4]
@   0x08022f12: 9602        str	r6, [sp, #8]
@   0x08022f14: 9603        str	r6, [sp, #12]
@   0x08022f16: 1c20        adds	r0, r4, #0
@   0x08022f18: 2210        movs	r2, #16
@   0x08022f1a: 2307        movs	r3, #7
@   0x08022f1c: f7fe        f8c0 	bl	0x210a0
@   0x08022f20: 2d02        cmp	r5, #2
@   0x08022f22: d806        bhi.n	0x22f32
@   0x08022f24: 4808        ldr	r0, [pc, #32]	@ (0x22f48)
@   0x08022f26: 00e1        lsls	r1, r4, #3
@   0x08022f28: 1b09        subs	r1, r1, r4
@   0x08022f2a: 00c9        lsls	r1, r1, #3
@   0x08022f2c: 1809        adds	r1, r1, r0
@   0x08022f2e: 2002        movs	r0, #2
@   0x08022f30: 7188        strb	r0, [r1, #6]
@   0x08022f32: 1c68        adds	r0, r5, #1
@   0x08022f34: 0600        lsls	r0, r0, #24
@   0x08022f36: 0e05        lsrs	r5, r0, #24
@   0x08022f38: 2d0b        cmp	r5, #11
@   0x08022f3a: d9be        bls.n	0x22eba
@   0x08022f3c: b004        add	sp, #16
@   0x08022f3e: bc08        pop	{r3}
@   0x08022f40: 4698        mov	r8, r3
@   0x08022f42: bcf0        pop	{r4, r5, r6, r7}
@   0x08022f44: bc01        pop	{r0}
@   0x08022f46: 4700        bx	r0
@   0x08022f48: 3720        adds	r7, #32
@   0x08022f4a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022EA8
sub_08022EA8: @ 0x08022ea8
        .incbin "frog_us_baserom.gba", 0x22ea8, 0xa4
        thumb_func_end sub_08022EA8
