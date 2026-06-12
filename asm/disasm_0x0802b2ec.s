@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802b2ec, 0x0802b3b0)  (196 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802b2ec --end 0x802b3b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802b2ec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802b2ee: 4647        mov	r7, r8
@   0x0802b2f0: b480        push	{r7}
@   0x0802b2f2: b086        sub	sp, #24
@   0x0802b2f4: 1c07        adds	r7, r0, #0
@   0x0802b2f6: 1c08        adds	r0, r1, #0
@   0x0802b2f8: 1c11        adds	r1, r2, #0
@   0x0802b2fa: 1c1c        adds	r4, r3, #0
@   0x0802b2fc: 9e0c        ldr	r6, [sp, #48]	@ 0x30
@   0x0802b2fe: 9a0d        ldr	r2, [sp, #52]	@ 0x34
@   0x0802b300: 0424        lsls	r4, r4, #16
@   0x0802b302: 0c24        lsrs	r4, r4, #16
@   0x0802b304: 0436        lsls	r6, r6, #16
@   0x0802b306: 0c36        lsrs	r6, r6, #16
@   0x0802b308: 0612        lsls	r2, r2, #24
@   0x0802b30a: 0e12        lsrs	r2, r2, #24
@   0x0802b30c: 4690        mov	r8, r2
@   0x0802b30e: 0400        lsls	r0, r0, #16
@   0x0802b310: 1400        asrs	r0, r0, #16
@   0x0802b312: 0409        lsls	r1, r1, #16
@   0x0802b314: 1409        asrs	r1, r1, #16
@   0x0802b316: ad05        add	r5, sp, #20
@   0x0802b318: 220a        movs	r2, #10
@   0x0802b31a: 1c2b        adds	r3, r5, #0
@   0x0802b31c: f7ff        fe74 	bl	0x2b008
@   0x0802b320: 4668        mov	r0, sp
@   0x0802b322: 8004        strh	r4, [r0, #0]
@   0x0802b324: 8046        strh	r6, [r0, #2]
@   0x0802b326: 4669        mov	r1, sp
@   0x0802b328: 8828        ldrh	r0, [r5, #0]
@   0x0802b32a: 8108        strh	r0, [r1, #8]
@   0x0802b32c: 8868        ldrh	r0, [r5, #2]
@   0x0802b32e: 8148        strh	r0, [r1, #10]
@   0x0802b330: 490d        ldr	r1, [pc, #52]	@ (0x2b368)
@   0x0802b332: 882a        ldrh	r2, [r5, #0]
@   0x0802b334: 4b0d        ldr	r3, [pc, #52]	@ (0x2b36c)
@   0x0802b336: 18c8        adds	r0, r1, r3
@   0x0802b338: 8002        strh	r2, [r0, #0]
@   0x0802b33a: 8868        ldrh	r0, [r5, #2]
@   0x0802b33c: 4a0c        ldr	r2, [pc, #48]	@ (0x2b370)
@   0x0802b33e: 1889        adds	r1, r1, r2
@   0x0802b340: 8008        strh	r0, [r1, #0]
@   0x0802b342: 4668        mov	r0, sp
@   0x0802b344: 2100        movs	r1, #0
@   0x0802b346: 2201        movs	r2, #1
@   0x0802b348: f7f6        fa44 	bl	0x217d4
@   0x0802b34c: 0600        lsls	r0, r0, #24
@   0x0802b34e: 0e00        lsrs	r0, r0, #24
@   0x0802b350: 2800        cmp	r0, #0
@   0x0802b352: d10f        bne.n	0x2b374
@   0x0802b354: 7eb8        ldrb	r0, [r7, #26]
@   0x0802b356: 3004        adds	r0, #4
@   0x0802b358: 76b8        strb	r0, [r7, #26]
@   0x0802b35a: 1c38        adds	r0, r7, #0
@   0x0802b35c: 2100        movs	r1, #0
@   0x0802b35e: 2200        movs	r2, #0
@   0x0802b360: 2300        movs	r3, #0
@   0x0802b362: f7df        f90d 	bl	0xa580
@   0x0802b366: e018        b.n	0x2b39a
@   0x0802b368: 3720        adds	r7, #32
@   0x0802b36a: 0300        lsls	r0, r0, #12
@   0x0802b36c: 0af2        lsrs	r2, r6, #11
@   0x0802b36e: 0000        movs	r0, r0
@   0x0802b370: 0af4        lsrs	r4, r6, #11
@   0x0802b372: 0000        movs	r0, r0
@   0x0802b374: 76b8        strb	r0, [r7, #26]
@   0x0802b376: 7eb8        ldrb	r0, [r7, #26]
@   0x0802b378: ac04        add	r4, sp, #16
@   0x0802b37a: 466d        mov	r5, sp
@   0x0802b37c: 3511        adds	r5, #17
@   0x0802b37e: 1c21        adds	r1, r4, #0
@   0x0802b380: 1c2a        adds	r2, r5, #0
@   0x0802b382: f7f6        fdcb 	bl	0x21f1c
@   0x0802b386: 4643        mov	r3, r8
@   0x0802b388: 0619        lsls	r1, r3, #24
@   0x0802b38a: 1609        asrs	r1, r1, #24
@   0x0802b38c: 2200        movs	r2, #0
@   0x0802b38e: 56a2        ldrsb	r2, [r4, r2]
@   0x0802b390: 2300        movs	r3, #0
@   0x0802b392: 56eb        ldrsb	r3, [r5, r3]
@   0x0802b394: 1c38        adds	r0, r7, #0
@   0x0802b396: f7df        f8f3 	bl	0xa580
@   0x0802b39a: 2002        movs	r0, #2
@   0x0802b39c: 8eb9        ldrh	r1, [r7, #52]	@ 0x34
@   0x0802b39e: 4308        orrs	r0, r1
@   0x0802b3a0: 86b8        strh	r0, [r7, #52]	@ 0x34
@   0x0802b3a2: b006        add	sp, #24
@   0x0802b3a4: bc08        pop	{r3}
@   0x0802b3a6: 4698        mov	r8, r3
@   0x0802b3a8: bcf0        pop	{r4, r5, r6, r7}
@   0x0802b3aa: bc01        pop	{r0}
@   0x0802b3ac: 4700        bx	r0

        thumb_func_start sub_0802B2EC
sub_0802B2EC: @ 0x0802b2ec
        .incbin "baserom.gba", 0x2b2ec, 0xc4
        thumb_func_end sub_0802B2EC
