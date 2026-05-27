@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f9f0, 0x0802fa60)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f9f0 --end 0x802fa60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f9f0: b510        push	{r4, lr}
@   0x0802f9f2: 1c02        adds	r2, r0, #0
@   0x0802f9f4: 4806        ldr	r0, [pc, #24]	@ (0x2fa10)
@   0x0802f9f6: 6803        ldr	r3, [r0, #0]
@   0x0802f9f8: 218a        movs	r1, #138	@ 0x8a
@   0x0802f9fa: 0049        lsls	r1, r1, #1
@   0x0802f9fc: 1858        adds	r0, r3, r1
@   0x0802f9fe: 0111        lsls	r1, r2, #4
@   0x0802fa00: 6800        ldr	r0, [r0, #0]
@   0x0802fa02: 1844        adds	r4, r0, r1
@   0x0802fa04: 2a03        cmp	r2, #3
@   0x0802fa06: dc05        bgt.n	0x2fa14
@   0x0802fa08: 0090        lsls	r0, r2, #2
@   0x0802fa0a: 3010        adds	r0, #16
@   0x0802fa0c: 1819        adds	r1, r3, r0
@   0x0802fa0e: e007        b.n	0x2fa20
@   0x0802fa10: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802fa12: 0300        lsls	r0, r0, #12
@   0x0802fa14: 1c18        adds	r0, r3, #0
@   0x0802fa16: 30c8        adds	r0, #200	@ 0xc8
@   0x0802fa18: 0191        lsls	r1, r2, #6
@   0x0802fa1a: 6800        ldr	r0, [r0, #0]
@   0x0802fa1c: 1809        adds	r1, r1, r0
@   0x0802fa1e: 39c8        subs	r1, #200	@ 0xc8
@   0x0802fa20: 680a        ldr	r2, [r1, #0]
@   0x0802fa22: 2080        movs	r0, #128	@ 0x80
@   0x0802fa24: 0040        lsls	r0, r0, #1
@   0x0802fa26: 4302        orrs	r2, r0
@   0x0802fa28: 600a        str	r2, [r1, #0]
@   0x0802fa2a: 2009        movs	r0, #9
@   0x0802fa2c: 4010        ands	r0, r2
@   0x0802fa2e: 2801        cmp	r0, #1
@   0x0802fa30: d10c        bne.n	0x2fa4c
@   0x0802fa32: 2310        movs	r3, #16
@   0x0802fa34: 4313        orrs	r3, r2
@   0x0802fa36: 600b        str	r3, [r1, #0]
@   0x0802fa38: 2206        movs	r2, #6
@   0x0802fa3a: 1c18        adds	r0, r3, #0
@   0x0802fa3c: 4010        ands	r0, r2
@   0x0802fa3e: 2802        cmp	r0, #2
@   0x0802fa40: d804        bhi.n	0x2fa4c
@   0x0802fa42: 2007        movs	r0, #7
@   0x0802fa44: 4240        negs	r0, r0
@   0x0802fa46: 4003        ands	r3, r0
@   0x0802fa48: 4313        orrs	r3, r2
@   0x0802fa4a: 600b        str	r3, [r1, #0]
@   0x0802fa4c: 6861        ldr	r1, [r4, #4]
@   0x0802fa4e: 2900        cmp	r1, #0
@   0x0802fa50: d002        beq.n	0x2fa58
@   0x0802fa52: 2000        movs	r0, #0
@   0x0802fa54: 8160        strh	r0, [r4, #10]
@   0x0802fa56: 6021        str	r1, [r4, #0]
@   0x0802fa58: bc10        pop	{r4}
@   0x0802fa5a: bc01        pop	{r0}
@   0x0802fa5c: 4700        bx	r0

        thumb_func_start sub_0802F9F0
sub_0802F9F0: @ 0x0802f9f0
        .incbin "frog_us_baserom.gba", 0x2f9f0, 0x70
        thumb_func_end sub_0802F9F0
