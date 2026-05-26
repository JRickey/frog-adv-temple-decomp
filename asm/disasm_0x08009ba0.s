@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009ba0, 0x08009c14)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009ba0 --end 0x8009c14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009ba0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009ba2: 2600        movs	r6, #0
@   0x08009ba4: 4813        ldr	r0, [pc, #76]	@ (0x9bf4)
@   0x08009ba6: 7a80        ldrb	r0, [r0, #10]
@   0x08009ba8: 2801        cmp	r0, #1
@   0x08009baa: d11e        bne.n	0x9bea
@   0x08009bac: 4812        ldr	r0, [pc, #72]	@ (0x9bf8)
@   0x08009bae: 3032        adds	r0, #50	@ 0x32
@   0x08009bb0: 7800        ldrb	r0, [r0, #0]
@   0x08009bb2: 2801        cmp	r0, #1
@   0x08009bb4: d119        bne.n	0x9bea
@   0x08009bb6: 2200        movs	r2, #0
@   0x08009bb8: 4c10        ldr	r4, [pc, #64]	@ (0x9bfc)
@   0x08009bba: 4b11        ldr	r3, [pc, #68]	@ (0x9c00)
@   0x08009bbc: 469c        mov	ip, r3
@   0x08009bbe: 2008        movs	r0, #8
@   0x08009bc0: 5e25        ldrsh	r5, [r4, r0]
@   0x08009bc2: 0091        lsls	r1, r2, #2
@   0x08009bc4: 4667        mov	r7, ip
@   0x08009bc6: 19c8        adds	r0, r1, r7
@   0x08009bc8: 2700        movs	r7, #0
@   0x08009bca: 5fc0        ldrsh	r0, [r0, r7]
@   0x08009bcc: 3201        adds	r2, #1
@   0x08009bce: 4285        cmp	r5, r0
@   0x08009bd0: d107        bne.n	0x9be2
@   0x08009bd2: 1c98        adds	r0, r3, #2
@   0x08009bd4: 1808        adds	r0, r1, r0
@   0x08009bd6: 8961        ldrh	r1, [r4, #10]
@   0x08009bd8: 8800        ldrh	r0, [r0, #0]
@   0x08009bda: 4281        cmp	r1, r0
@   0x08009bdc: d101        bne.n	0x9be2
@   0x08009bde: 0610        lsls	r0, r2, #24
@   0x08009be0: 0e06        lsrs	r6, r0, #24
@   0x08009be2: 0610        lsls	r0, r2, #24
@   0x08009be4: 0e02        lsrs	r2, r0, #24
@   0x08009be6: 2a04        cmp	r2, #4
@   0x08009be8: d9eb        bls.n	0x9bc2
@   0x08009bea: 0634        lsls	r4, r6, #24
@   0x08009bec: 2c00        cmp	r4, #0
@   0x08009bee: d109        bne.n	0x9c04
@   0x08009bf0: 2000        movs	r0, #0
@   0x08009bf2: e00b        b.n	0x9c0c
@   0x08009bf4: 5330        strh	r0, [r6, r4]
@   0x08009bf6: 0300        lsls	r0, r0, #12
@   0x08009bf8: 6110        str	r0, [r2, #16]
@   0x08009bfa: 0300        lsls	r0, r0, #12
@   0x08009bfc: 35e0        adds	r5, #224	@ 0xe0
@   0x08009bfe: 0300        lsls	r0, r0, #12
@   0x08009c00: 9cf4        ldr	r4, [sp, #976]	@ 0x3d0
@   0x08009c02: 082f        lsrs	r7, r5, #32
@   0x08009c04: 2008        movs	r0, #8
@   0x08009c06: f017        f837 	bl	0x20c78
@   0x08009c0a: 0e20        lsrs	r0, r4, #24
@   0x08009c0c: bcf0        pop	{r4, r5, r6, r7}
@   0x08009c0e: bc02        pop	{r1}
@   0x08009c10: 4708        bx	r1

        thumb_func_start sub_08009BA0
sub_08009BA0: @ 0x08009ba0
        .incbin "frog_us_baserom.gba", 0x9ba0, 0x74
        thumb_func_end sub_08009BA0
