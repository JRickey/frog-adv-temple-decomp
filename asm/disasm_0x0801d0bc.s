@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d0bc, 0x0801d150)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d0bc --end 0x801d150 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d0bc: b570        push	{r4, r5, r6, lr}
@   0x0801d0be: b081        sub	sp, #4
@   0x0801d0c0: 1c02        adds	r2, r0, #0
@   0x0801d0c2: 0609        lsls	r1, r1, #24
@   0x0801d0c4: 0e09        lsrs	r1, r1, #24
@   0x0801d0c6: 1c08        adds	r0, r1, #0
@   0x0801d0c8: 2901        cmp	r1, #1
@   0x0801d0ca: d00d        beq.n	0x1d0e8
@   0x0801d0cc: 2901        cmp	r1, #1
@   0x0801d0ce: dc02        bgt.n	0x1d0d6
@   0x0801d0d0: 2900        cmp	r1, #0
@   0x0801d0d2: d005        beq.n	0x1d0e0
@   0x0801d0d4: e011        b.n	0x1d0fa
@   0x0801d0d6: 2802        cmp	r0, #2
@   0x0801d0d8: d00a        beq.n	0x1d0f0
@   0x0801d0da: 2803        cmp	r0, #3
@   0x0801d0dc: d00c        beq.n	0x1d0f8
@   0x0801d0de: e00c        b.n	0x1d0fa
@   0x0801d0e0: 4d00        ldr	r5, [pc, #0]	@ (0x1d0e4)
@   0x0801d0e2: e00a        b.n	0x1d0fa
@   0x0801d0e4: e000        b.n	0x1d0e8
@   0x0801d0e6: 0600        lsls	r0, r0, #24
@   0x0801d0e8: 4d00        ldr	r5, [pc, #0]	@ (0x1d0ec)
@   0x0801d0ea: e006        b.n	0x1d0fa
@   0x0801d0ec: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801d0f0: 4d00        ldr	r5, [pc, #0]	@ (0x1d0f4)
@   0x0801d0f2: e002        b.n	0x1d0fa
@   0x0801d0f4: f000        0600 	and.w	r6, r0, #0
@   0x0801d0f8: 4d13        ldr	r5, [pc, #76]	@ (0x1d148)
@   0x0801d0fa: 2400        movs	r4, #0
@   0x0801d0fc: 0e10        lsrs	r0, r2, #24
@   0x0801d0fe: 4284        cmp	r4, r0
@   0x0801d100: d21d        bcs.n	0x1d13e
@   0x0801d102: 466e        mov	r6, sp
@   0x0801d104: 4b11        ldr	r3, [pc, #68]	@ (0x1d14c)
@   0x0801d106: 0610        lsls	r0, r2, #24
@   0x0801d108: 0dc0        lsrs	r0, r0, #23
@   0x0801d10a: 182d        adds	r5, r5, r0
@   0x0801d10c: 2000        movs	r0, #0
@   0x0801d10e: 8030        strh	r0, [r6, #0]
@   0x0801d110: 4668        mov	r0, sp
@   0x0801d112: 6018        str	r0, [r3, #0]
@   0x0801d114: 0a10        lsrs	r0, r2, #8
@   0x0801d116: 0600        lsls	r0, r0, #24
@   0x0801d118: 0e00        lsrs	r0, r0, #24
@   0x0801d11a: 1900        adds	r0, r0, r4
@   0x0801d11c: 0180        lsls	r0, r0, #6
@   0x0801d11e: 1828        adds	r0, r5, r0
@   0x0801d120: 6058        str	r0, [r3, #4]
@   0x0801d122: 0c10        lsrs	r0, r2, #16
@   0x0801d124: 0600        lsls	r0, r0, #24
@   0x0801d126: 0e00        lsrs	r0, r0, #24
@   0x0801d128: 2181        movs	r1, #129	@ 0x81
@   0x0801d12a: 0609        lsls	r1, r1, #24
@   0x0801d12c: 4308        orrs	r0, r1
@   0x0801d12e: 6098        str	r0, [r3, #8]
@   0x0801d130: 6898        ldr	r0, [r3, #8]
@   0x0801d132: 1c60        adds	r0, r4, #1
@   0x0801d134: 0600        lsls	r0, r0, #24
@   0x0801d136: 0e04        lsrs	r4, r0, #24
@   0x0801d138: 0e10        lsrs	r0, r2, #24
@   0x0801d13a: 4284        cmp	r4, r0
@   0x0801d13c: d3e6        bcc.n	0x1d10c
@   0x0801d13e: b001        add	sp, #4
@   0x0801d140: bc70        pop	{r4, r5, r6}
@   0x0801d142: bc01        pop	{r0}
@   0x0801d144: 4700        bx	r0
@   0x0801d146: 0000        movs	r0, r0
@   0x0801d148: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801d14c: 00d4        lsls	r4, r2, #3
@   0x0801d14e: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801D0BC
sub_0801D0BC: @ 0x0801d0bc
        .incbin "frog_us_baserom.gba", 0x1d0bc, 0x94
        thumb_func_end sub_0801D0BC
