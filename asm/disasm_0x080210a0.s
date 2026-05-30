@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080210a0, 0x08021140)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80210a0 --end 0x8021140 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080210a0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080210a2: 4657        mov	r7, sl
@   0x080210a4: 464e        mov	r6, r9
@   0x080210a6: 4645        mov	r5, r8
@   0x080210a8: b4e0        push	{r5, r6, r7}
@   0x080210aa: b081        sub	sp, #4
@   0x080210ac: 468a        mov	sl, r1
@   0x080210ae: 9e09        ldr	r6, [sp, #36]	@ 0x24
@   0x080210b0: 990a        ldr	r1, [sp, #40]	@ 0x28
@   0x080210b2: 4688        mov	r8, r1
@   0x080210b4: 990b        ldr	r1, [sp, #44]	@ 0x2c
@   0x080210b6: 4689        mov	r9, r1
@   0x080210b8: 9d0c        ldr	r5, [sp, #48]	@ 0x30
@   0x080210ba: 0400        lsls	r0, r0, #16
@   0x080210bc: 0c00        lsrs	r0, r0, #16
@   0x080210be: 4651        mov	r1, sl
@   0x080210c0: 7889        ldrb	r1, [r1, #2]
@   0x080210c2: 468c        mov	ip, r1
@   0x080210c4: 4c1d        ldr	r4, [pc, #116]	@ (0x2113c)
@   0x080210c6: 00c1        lsls	r1, r0, #3
@   0x080210c8: 1a09        subs	r1, r1, r0
@   0x080210ca: 00c9        lsls	r1, r1, #3
@   0x080210cc: 190f        adds	r7, r1, r4
@   0x080210ce: 86ba        strh	r2, [r7, #52]	@ 0x34
@   0x080210d0: 4652        mov	r2, sl
@   0x080210d2: 8910        ldrh	r0, [r2, #8]
@   0x080210d4: 8078        strh	r0, [r7, #2]
@   0x080210d6: 8950        ldrh	r0, [r2, #10]
@   0x080210d8: 80b8        strh	r0, [r7, #4]
@   0x080210da: 703b        strb	r3, [r7, #0]
@   0x080210dc: 82be        strh	r6, [r7, #20]
@   0x080210de: 4640        mov	r0, r8
@   0x080210e0: 75b8        strb	r0, [r7, #22]
@   0x080210e2: 75fd        strb	r5, [r7, #23]
@   0x080210e4: 4649        mov	r1, r9
@   0x080210e6: 71b9        strb	r1, [r7, #6]
@   0x080210e8: 8812        ldrh	r2, [r2, #0]
@   0x080210ea: 0410        lsls	r0, r2, #16
@   0x080210ec: 1600        asrs	r0, r0, #24
@   0x080210ee: 2102        movs	r1, #2
@   0x080210f0: 2800        cmp	r0, #0
@   0x080210f2: d000        beq.n	0x210f6
@   0x080210f4: 1c01        adds	r1, r0, #0
@   0x080210f6: 1c38        adds	r0, r7, #0
@   0x080210f8: 3033        adds	r0, #51	@ 0x33
@   0x080210fa: 7001        strb	r1, [r0, #0]
@   0x080210fc: 4660        mov	r0, ip
@   0x080210fe: 76b8        strb	r0, [r7, #26]
@   0x08021100: 2002        movs	r0, #2
@   0x08021102: 8eb9        ldrh	r1, [r7, #52]	@ 0x34
@   0x08021104: 4308        orrs	r0, r1
@   0x08021106: 86b8        strh	r0, [r7, #52]	@ 0x34
@   0x08021108: 466c        mov	r4, sp
@   0x0802110a: 3401        adds	r4, #1
@   0x0802110c: 4660        mov	r0, ip
@   0x0802110e: 4669        mov	r1, sp
@   0x08021110: 1c22        adds	r2, r4, #0
@   0x08021112: f000        ff03 	bl	0x21f1c
@   0x08021116: 4652        mov	r2, sl
@   0x08021118: 210c        movs	r1, #12
@   0x0802111a: 5651        ldrsb	r1, [r2, r1]
@   0x0802111c: 4668        mov	r0, sp
@   0x0802111e: 2200        movs	r2, #0
@   0x08021120: 5682        ldrsb	r2, [r0, r2]
@   0x08021122: 2300        movs	r3, #0
@   0x08021124: 56e3        ldrsb	r3, [r4, r3]
@   0x08021126: 1c38        adds	r0, r7, #0
@   0x08021128: f7e9        fa2a 	bl	0xa580
@   0x0802112c: b001        add	sp, #4
@   0x0802112e: bc38        pop	{r3, r4, r5}
@   0x08021130: 4698        mov	r8, r3
@   0x08021132: 46a1        mov	r9, r4
@   0x08021134: 46aa        mov	sl, r5
@   0x08021136: bcf0        pop	{r4, r5, r6, r7}
@   0x08021138: bc01        pop	{r0}
@   0x0802113a: 4700        bx	r0
@   0x0802113c: 3720        adds	r7, #32
@   0x0802113e: 0300        lsls	r0, r0, #12
