@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800fd50, 0x0800fdf4)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800fd50 --end 0x800fdf4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800fd50: b570        push	{r4, r5, r6, lr}
@   0x0800fd52: b081        sub	sp, #4
@   0x0800fd54: 2601        movs	r6, #1
@   0x0800fd56: 4c24        ldr	r4, [pc, #144]	@ (0xfde8)
@   0x0800fd58: 8e20        ldrh	r0, [r4, #48]	@ 0x30
@   0x0800fd5a: 2800        cmp	r0, #0
@   0x0800fd5c: d101        bne.n	0xfd62
@   0x0800fd5e: 2008        movs	r0, #8
@   0x0800fd60: 72e0        strb	r0, [r4, #11]
@   0x0800fd62: 4d22        ldr	r5, [pc, #136]	@ (0xfdec)
@   0x0800fd64: 6828        ldr	r0, [r5, #0]
@   0x0800fd66: 6861        ldr	r1, [r4, #4]
@   0x0800fd68: 1a40        subs	r0, r0, r1
@   0x0800fd6a: 7ae1        ldrb	r1, [r4, #11]
@   0x0800fd6c: 4288        cmp	r0, r1
@   0x0800fd6e: d305        bcc.n	0xfd7c
@   0x0800fd70: f000        f88a 	bl	0xfe88
@   0x0800fd74: 0600        lsls	r0, r0, #24
@   0x0800fd76: 0e02        lsrs	r2, r0, #24
@   0x0800fd78: 6828        ldr	r0, [r5, #0]
@   0x0800fd7a: 6060        str	r0, [r4, #4]
@   0x0800fd7c: 6828        ldr	r0, [r5, #0]
@   0x0800fd7e: 6861        ldr	r1, [r4, #4]
@   0x0800fd80: 1a40        subs	r0, r0, r1
@   0x0800fd82: 28ff        cmp	r0, #255	@ 0xff
@   0x0800fd84: d805        bhi.n	0xfd92
@   0x0800fd86: 481a        ldr	r0, [pc, #104]	@ (0xfdf0)
@   0x0800fd88: 8800        ldrh	r0, [r0, #0]
@   0x0800fd8a: 2820        cmp	r0, #32
@   0x0800fd8c: d001        beq.n	0xfd92
@   0x0800fd8e: 2afe        cmp	r2, #254	@ 0xfe
@   0x0800fd90: d125        bne.n	0xfdde
@   0x0800fd92: 2180        movs	r1, #128	@ 0x80
@   0x0800fd94: 04c9        lsls	r1, r1, #19
@   0x0800fd96: 880a        ldrh	r2, [r1, #0]
@   0x0800fd98: 4816        ldr	r0, [pc, #88]	@ (0xfdf4)
@   0x0800fd9a: 4010        ands	r0, r2
@   0x0800fd9c: 8008        strh	r0, [r1, #0]
@   0x0800fd9e: 880a        ldrh	r2, [r1, #0]
@   0x0800fda0: 4815        ldr	r0, [pc, #84]	@ (0xfdf8)
@   0x0800fda2: 4010        ands	r0, r2
@   0x0800fda4: 8008        strh	r0, [r1, #0]
@   0x0800fda6: 4815        ldr	r0, [pc, #84]	@ (0xfdfc)
@   0x0800fda8: 2400        movs	r4, #0
@   0x0800fdaa: 8004        strh	r4, [r0, #0]
@   0x0800fdac: 3004        adds	r0, #4
@   0x0800fdae: 8004        strh	r4, [r0, #0]
@   0x0800fdb0: 3004        adds	r0, #4
@   0x0800fdb2: 8004        strh	r4, [r0, #0]
@   0x0800fdb4: 3002        adds	r0, #2
@   0x0800fdb6: 8004        strh	r4, [r0, #0]
@   0x0800fdb8: 2003        movs	r0, #3
@   0x0800fdba: f7ff        f86b 	bl	0xee94
@   0x0800fdbe: 4668        mov	r0, sp
@   0x0800fdc0: 8004        strh	r4, [r0, #0]
@   0x0800fdc2: 490f        ldr	r1, [pc, #60]	@ (0xfe00)
@   0x0800fdc4: 6008        str	r0, [r1, #0]
@   0x0800fdc6: 480f        ldr	r0, [pc, #60]	@ (0xfe04)
@   0x0800fdc8: 6048        str	r0, [r1, #4]
@   0x0800fdca: 480f        ldr	r0, [pc, #60]	@ (0xfe08)
@   0x0800fdcc: 6088        str	r0, [r1, #8]
@   0x0800fdce: 6888        ldr	r0, [r1, #8]
@   0x0800fdd0: f006        fe36 	bl	0x16a40
@   0x0800fdd4: 2600        movs	r6, #0
@   0x0800fdd6: 480d        ldr	r0, [pc, #52]	@ (0xfe0c)
@   0x0800fdd8: 2102        movs	r1, #2
@   0x0800fdda: f7f6        fdb5 	bl	0x6948
@   0x0800fdde: 1c30        adds	r0, r6, #0
@   0x0800fde0: b001        add	sp, #4
@   0x0800fde2: bc70        pop	{r4, r5, r6}
@   0x0800fde4: bc02        pop	{r1}
@   0x0800fde6: 4708        bx	r1
@   0x0800fde8: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0800fdea: 0300        lsls	r0, r0, #12
@   0x0800fdec: 5330        strh	r0, [r6, r4]
@   0x0800fdee: 0300        lsls	r0, r0, #12
@   0x0800fdf0: 5398        strh	r0, [r3, r6]
@   0x0800fdf2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800FD50
sub_0800FD50: @ 0x0800fd50
        .incbin "frog_us_baserom.gba", 0xfd50, 0xa4
        thumb_func_end sub_0800FD50
