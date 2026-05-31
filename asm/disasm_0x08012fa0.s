@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012fa0, 0x08013040)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012fa0 --end 0x8013040 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012fa0: b510        push	{r4, lr}
@   0x08012fa2: 2300        movs	r3, #0
@   0x08012fa4: 4a07        ldr	r2, [pc, #28]	@ (0x12fc4)
@   0x08012fa6: 1c10        adds	r0, r2, #0
@   0x08012fa8: 30d3        adds	r0, #211	@ 0xd3
@   0x08012faa: 7800        ldrb	r0, [r0, #0]
@   0x08012fac: 4118        asrs	r0, r3
@   0x08012fae: 2101        movs	r1, #1
@   0x08012fb0: 4008        ands	r0, r1
@   0x08012fb2: 2800        cmp	r0, #0
@   0x08012fb4: d03c        beq.n	0x13030
@   0x08012fb6: 2b07        cmp	r3, #7
@   0x08012fb8: d83a        bhi.n	0x13030
@   0x08012fba: 0098        lsls	r0, r3, #2
@   0x08012fbc: 4902        ldr	r1, [pc, #8]	@ (0x12fc8)
@   0x08012fbe: 1840        adds	r0, r0, r1
@   0x08012fc0: 6800        ldr	r0, [r0, #0]
@   0x08012fc2: 4687        mov	pc, r0
@   0x08012fc4: 3610        adds	r6, #16
@   0x08012fc6: 0300        lsls	r0, r0, #12
@   0x08012fc8: 2fcc        cmp	r7, #204	@ 0xcc
@   0x08012fca: 0801        lsrs	r1, r0, #32
@   0x08012fcc: 2fec        cmp	r7, #236	@ 0xec
@   0x08012fce: 0801        lsrs	r1, r0, #32
@   0x08012fd0: 2ff4        cmp	r7, #244	@ 0xf4
@   0x08012fd2: 0801        lsrs	r1, r0, #32
@   0x08012fd4: 2ffc        cmp	r7, #252	@ 0xfc
@   0x08012fd6: 0801        lsrs	r1, r0, #32
@   0x08012fd8: 3004        adds	r0, #4
@   0x08012fda: 0801        lsrs	r1, r0, #32
@   0x08012fdc: 300c        adds	r0, #12
@   0x08012fde: 0801        lsrs	r1, r0, #32
@   0x08012fe0: 3014        adds	r0, #20
@   0x08012fe2: 0801        lsrs	r1, r0, #32
@   0x08012fe4: 301c        adds	r0, #28
@   0x08012fe6: 0801        lsrs	r1, r0, #32
@   0x08012fe8: 3024        adds	r0, #36	@ 0x24
@   0x08012fea: 0801        lsrs	r1, r0, #32
@   0x08012fec: 1c11        adds	r1, r2, #0
@   0x08012fee: 31d4        adds	r1, #212	@ 0xd4
@   0x08012ff0: 20df        movs	r0, #223	@ 0xdf
@   0x08012ff2: e01a        b.n	0x1302a
@   0x08012ff4: 1c11        adds	r1, r2, #0
@   0x08012ff6: 31d4        adds	r1, #212	@ 0xd4
@   0x08012ff8: 20ef        movs	r0, #239	@ 0xef
@   0x08012ffa: e016        b.n	0x1302a
@   0x08012ffc: 1c11        adds	r1, r2, #0
@   0x08012ffe: 31d4        adds	r1, #212	@ 0xd4
@   0x08013000: 207f        movs	r0, #127	@ 0x7f
@   0x08013002: e012        b.n	0x1302a
@   0x08013004: 1c11        adds	r1, r2, #0
@   0x08013006: 31d4        adds	r1, #212	@ 0xd4
@   0x08013008: 20bf        movs	r0, #191	@ 0xbf
@   0x0801300a: e00e        b.n	0x1302a
@   0x0801300c: 1c11        adds	r1, r2, #0
@   0x0801300e: 31d4        adds	r1, #212	@ 0xd4
@   0x08013010: 20fd        movs	r0, #253	@ 0xfd
@   0x08013012: e00a        b.n	0x1302a
@   0x08013014: 1c11        adds	r1, r2, #0
@   0x08013016: 31d4        adds	r1, #212	@ 0xd4
@   0x08013018: 20fe        movs	r0, #254	@ 0xfe
@   0x0801301a: e006        b.n	0x1302a
@   0x0801301c: 1c11        adds	r1, r2, #0
@   0x0801301e: 31d4        adds	r1, #212	@ 0xd4
@   0x08013020: 20f7        movs	r0, #247	@ 0xf7
@   0x08013022: e002        b.n	0x1302a
@   0x08013024: 1c11        adds	r1, r2, #0
@   0x08013026: 31d4        adds	r1, #212	@ 0xd4
@   0x08013028: 20fb        movs	r0, #251	@ 0xfb
@   0x0801302a: 780c        ldrb	r4, [r1, #0]
@   0x0801302c: 4020        ands	r0, r4
@   0x0801302e: 7008        strb	r0, [r1, #0]
@   0x08013030: 1c58        adds	r0, r3, #1
@   0x08013032: 0600        lsls	r0, r0, #24
@   0x08013034: 0e03        lsrs	r3, r0, #24
@   0x08013036: 2b07        cmp	r3, #7
@   0x08013038: d9b5        bls.n	0x12fa6
@   0x0801303a: bc10        pop	{r4}
@   0x0801303c: bc01        pop	{r0}
@   0x0801303e: 4700        bx	r0

        thumb_func_start sub_08012FA0
sub_08012FA0: @ 0x08012fa0
        .incbin "frog_us_baserom.gba", 0x12fa0, 0xa0
        thumb_func_end sub_08012FA0
