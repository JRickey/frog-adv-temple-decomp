@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080340d4, 0x08034150)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80340d4 --end 0x8034150 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080340d4: b510        push	{r4, lr}
@   0x080340d6: 1c0b        adds	r3, r1, #0
@   0x080340d8: 6800        ldr	r0, [r0, #0]
@   0x080340da: 0241        lsls	r1, r0, #9
@   0x080340dc: 0a4a        lsrs	r2, r1, #9
@   0x080340de: 0041        lsls	r1, r0, #1
@   0x080340e0: 0e09        lsrs	r1, r1, #24
@   0x080340e2: 0fc0        lsrs	r0, r0, #31
@   0x080340e4: 6058        str	r0, [r3, #4]
@   0x080340e6: 2900        cmp	r1, #0
@   0x080340e8: d116        bne.n	0x34118
@   0x080340ea: 2a00        cmp	r2, #0
@   0x080340ec: d102        bne.n	0x340f4
@   0x080340ee: 2002        movs	r0, #2
@   0x080340f0: 6018        str	r0, [r3, #0]
@   0x080340f2: e02b        b.n	0x3414c
@   0x080340f4: 1c0c        adds	r4, r1, #0
@   0x080340f6: 3c7e        subs	r4, #126	@ 0x7e
@   0x080340f8: 609c        str	r4, [r3, #8]
@   0x080340fa: 01d2        lsls	r2, r2, #7
@   0x080340fc: 2003        movs	r0, #3
@   0x080340fe: 6018        str	r0, [r3, #0]
@   0x08034100: 4904        ldr	r1, [pc, #16]	@ (0x34114)
@   0x08034102: 428a        cmp	r2, r1
@   0x08034104: d816        bhi.n	0x34134
@   0x08034106: 1c20        adds	r0, r4, #0
@   0x08034108: 0052        lsls	r2, r2, #1
@   0x0803410a: 3801        subs	r0, #1
@   0x0803410c: 428a        cmp	r2, r1
@   0x0803410e: d9fb        bls.n	0x34108
@   0x08034110: 6098        str	r0, [r3, #8]
@   0x08034112: e00f        b.n	0x34134
@   0x08034114: ffff        3fff 			@ <UNDEFINED> instruction: 0xffff3fff
@   0x08034118: 29ff        cmp	r1, #255	@ 0xff
@   0x0803411a: d10d        bne.n	0x34138
@   0x0803411c: 2a00        cmp	r2, #0
@   0x0803411e: d102        bne.n	0x34126
@   0x08034120: 2004        movs	r0, #4
@   0x08034122: 6018        str	r0, [r3, #0]
@   0x08034124: e012        b.n	0x3414c
@   0x08034126: 2080        movs	r0, #128	@ 0x80
@   0x08034128: 0340        lsls	r0, r0, #13
@   0x0803412a: 4010        ands	r0, r2
@   0x0803412c: 2800        cmp	r0, #0
@   0x0803412e: d000        beq.n	0x34132
@   0x08034130: 2001        movs	r0, #1
@   0x08034132: 6018        str	r0, [r3, #0]
@   0x08034134: 60da        str	r2, [r3, #12]
@   0x08034136: e009        b.n	0x3414c
@   0x08034138: 1c08        adds	r0, r1, #0
@   0x0803413a: 387f        subs	r0, #127	@ 0x7f
@   0x0803413c: 6098        str	r0, [r3, #8]
@   0x0803413e: 2003        movs	r0, #3
@   0x08034140: 6018        str	r0, [r3, #0]
@   0x08034142: 01d0        lsls	r0, r2, #7
@   0x08034144: 2180        movs	r1, #128	@ 0x80
@   0x08034146: 05c9        lsls	r1, r1, #23
@   0x08034148: 4308        orrs	r0, r1
@   0x0803414a: 60d8        str	r0, [r3, #12]
@   0x0803414c: bd10        pop	{r4, pc}

        thumb_func_start sub_080340D4
sub_080340D4: @ 0x080340d4
        .incbin "frog_us_baserom.gba", 0x340d4, 0x7c
        thumb_func_end sub_080340D4
