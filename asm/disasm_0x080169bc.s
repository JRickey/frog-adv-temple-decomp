@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080169bc, 0x08016a38)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80169bc --end 0x8016a38 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080169bc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080169be: 4647        mov	r7, r8
@   0x080169c0: b480        push	{r7}
@   0x080169c2: 4a1d        ldr	r2, [pc, #116]	@ (0x16a38)
@   0x080169c4: 2194        movs	r1, #148	@ 0x94
@   0x080169c6: 0049        lsls	r1, r1, #1
@   0x080169c8: 1850        adds	r0, r2, r1
@   0x080169ca: 6804        ldr	r4, [r0, #0]
@   0x080169cc: 2391        movs	r3, #145	@ 0x91
@   0x080169ce: 005b        lsls	r3, r3, #1
@   0x080169d0: 18d0        adds	r0, r2, r3
@   0x080169d2: 8800        ldrh	r0, [r0, #0]
@   0x080169d4: 0140        lsls	r0, r0, #5
@   0x080169d6: 2590        movs	r5, #144	@ 0x90
@   0x080169d8: 006d        lsls	r5, r5, #1
@   0x080169da: 1951        adds	r1, r2, r5
@   0x080169dc: 8809        ldrh	r1, [r1, #0]
@   0x080169de: 1808        adds	r0, r1, r0
@   0x080169e0: 0040        lsls	r0, r0, #1
@   0x080169e2: 4b16        ldr	r3, [pc, #88]	@ (0x16a3c)
@   0x080169e4: 18c1        adds	r1, r0, r3
@   0x080169e6: 2300        movs	r3, #0
@   0x080169e8: 3504        adds	r5, #4
@   0x080169ea: 1950        adds	r0, r2, r5
@   0x080169ec: 8800        ldrh	r0, [r0, #0]
@   0x080169ee: 4283        cmp	r3, r0
@   0x080169f0: d21d        bcs.n	0x16a2e
@   0x080169f2: 3502        adds	r5, #2
@   0x080169f4: 1956        adds	r6, r2, r5
@   0x080169f6: 8832        ldrh	r2, [r6, #0]
@   0x080169f8: 4694        mov	ip, r2
@   0x080169fa: 46b0        mov	r8, r6
@   0x080169fc: 1c07        adds	r7, r0, #0
@   0x080169fe: 2200        movs	r2, #0
@   0x08016a00: 1c5d        adds	r5, r3, #1
@   0x08016a02: 4562        cmp	r2, ip
@   0x08016a04: d20a        bcs.n	0x16a1c
@   0x08016a06: 4640        mov	r0, r8
@   0x08016a08: 8803        ldrh	r3, [r0, #0]
@   0x08016a0a: 8820        ldrh	r0, [r4, #0]
@   0x08016a0c: 8008        strh	r0, [r1, #0]
@   0x08016a0e: 3402        adds	r4, #2
@   0x08016a10: 3102        adds	r1, #2
@   0x08016a12: 1c50        adds	r0, r2, #1
@   0x08016a14: 0400        lsls	r0, r0, #16
@   0x08016a16: 0c02        lsrs	r2, r0, #16
@   0x08016a18: 429a        cmp	r2, r3
@   0x08016a1a: d3f6        bcc.n	0x16a0a
@   0x08016a1c: 2020        movs	r0, #32
@   0x08016a1e: 8832        ldrh	r2, [r6, #0]
@   0x08016a20: 1a80        subs	r0, r0, r2
@   0x08016a22: 0040        lsls	r0, r0, #1
@   0x08016a24: 1809        adds	r1, r1, r0
@   0x08016a26: 0428        lsls	r0, r5, #16
@   0x08016a28: 0c03        lsrs	r3, r0, #16
@   0x08016a2a: 42bb        cmp	r3, r7
@   0x08016a2c: d3e7        bcc.n	0x169fe
@   0x08016a2e: bc08        pop	{r3}
@   0x08016a30: 4698        mov	r8, r3
@   0x08016a32: bcf0        pop	{r4, r5, r6, r7}
@   0x08016a34: bc01        pop	{r0}
@   0x08016a36: 4700        bx	r0

        thumb_func_start sub_080169BC
sub_080169BC: @ 0x080169bc
        .incbin "frog_us_baserom.gba", 0x169bc, 0x7c
        thumb_func_end sub_080169BC
