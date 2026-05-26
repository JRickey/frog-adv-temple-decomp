@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a4d0, 0x0800a520)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a4d0 --end 0x800a520 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a4d0: b530        push	{r4, r5, lr}
@   0x0800a4d2: 4b11        ldr	r3, [pc, #68]	@ (0xa518)
@   0x0800a4d4: 1c1a        adds	r2, r3, #0
@   0x0800a4d6: 326c        adds	r2, #108	@ 0x6c
@   0x0800a4d8: 8811        ldrh	r1, [r2, #0]
@   0x0800a4da: 2408        movs	r4, #8
@   0x0800a4dc: 2008        movs	r0, #8
@   0x0800a4de: 4008        ands	r0, r1
@   0x0800a4e0: 2800        cmp	r0, #0
@   0x0800a4e2: d115        bne.n	0xa510
@   0x0800a4e4: 2004        movs	r0, #4
@   0x0800a4e6: 8e9d        ldrh	r5, [r3, #52]	@ 0x34
@   0x0800a4e8: 4028        ands	r0, r5
@   0x0800a4ea: 2800        cmp	r0, #0
@   0x0800a4ec: d002        beq.n	0xa4f4
@   0x0800a4ee: 1c20        adds	r0, r4, #0
@   0x0800a4f0: 4308        orrs	r0, r1
@   0x0800a4f2: 8010        strh	r0, [r2, #0]
@   0x0800a4f4: 8811        ldrh	r1, [r2, #0]
@   0x0800a4f6: 2080        movs	r0, #128	@ 0x80
@   0x0800a4f8: 0200        lsls	r0, r0, #8
@   0x0800a4fa: 4008        ands	r0, r1
@   0x0800a4fc: 2800        cmp	r0, #0
@   0x0800a4fe: d003        beq.n	0xa508
@   0x0800a500: 4806        ldr	r0, [pc, #24]	@ (0xa51c)
@   0x0800a502: 4008        ands	r0, r1
@   0x0800a504: 4320        orrs	r0, r4
@   0x0800a506: 8010        strh	r0, [r2, #0]
@   0x0800a508: 1c18        adds	r0, r3, #0
@   0x0800a50a: 3038        adds	r0, #56	@ 0x38
@   0x0800a50c: f7fb        fa5a 	bl	0x59c4
@   0x0800a510: bc30        pop	{r4, r5}
@   0x0800a512: bc01        pop	{r0}
@   0x0800a514: 4700        bx	r0
@   0x0800a516: 0000        movs	r0, r0
@   0x0800a518: 3720        adds	r7, #32
@   0x0800a51a: 0300        lsls	r0, r0, #12
@   0x0800a51c: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_0800A4D0
sub_0800A4D0: @ 0x0800a4d0
        .incbin "frog_us_baserom.gba", 0xa4d0, 0x50
        thumb_func_end sub_0800A4D0
