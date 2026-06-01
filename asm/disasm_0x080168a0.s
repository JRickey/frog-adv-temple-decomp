@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080168a0, 0x08016928)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80168a0 --end 0x8016928 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080168a0: b510        push	{r4, lr}
@   0x080168a2: 210f        movs	r1, #15
@   0x080168a4: 4803        ldr	r0, [pc, #12]	@ (0x168b4)
@   0x080168a6: 7880        ldrb	r0, [r0, #2]
@   0x080168a8: 2803        cmp	r0, #3
@   0x080168aa: d005        beq.n	0x168b8
@   0x080168ac: 2805        cmp	r0, #5
@   0x080168ae: d005        beq.n	0x168bc
@   0x080168b0: e005        b.n	0x168be
@   0x080168b2: 0000        movs	r0, r0
@   0x080168b4: 6110        str	r0, [r2, #16]
@   0x080168b6: 0300        lsls	r0, r0, #12
@   0x080168b8: 2100        movs	r1, #0
@   0x080168ba: e000        b.n	0x168be
@   0x080168bc: 2101        movs	r1, #1
@   0x080168be: 1c0c        adds	r4, r1, #0
@   0x080168c0: 2c0f        cmp	r4, #15
@   0x080168c2: d021        beq.n	0x16908
@   0x080168c4: 4912        ldr	r1, [pc, #72]	@ (0x16910)
@   0x080168c6: 2000        movs	r0, #0
@   0x080168c8: 7008        strb	r0, [r1, #0]
@   0x080168ca: 4b12        ldr	r3, [pc, #72]	@ (0x16914)
@   0x080168cc: 0121        lsls	r1, r4, #4
@   0x080168ce: 1d18        adds	r0, r3, #4
@   0x080168d0: 1808        adds	r0, r1, r0
@   0x080168d2: 6800        ldr	r0, [r0, #0]
@   0x080168d4: 4a10        ldr	r2, [pc, #64]	@ (0x16918)
@   0x080168d6: 6800        ldr	r0, [r0, #0]
@   0x080168d8: 6010        str	r0, [r2, #0]
@   0x080168da: 1c18        adds	r0, r3, #0
@   0x080168dc: 3008        adds	r0, #8
@   0x080168de: 1808        adds	r0, r1, r0
@   0x080168e0: 6800        ldr	r0, [r0, #0]
@   0x080168e2: 6050        str	r0, [r2, #4]
@   0x080168e4: 18c9        adds	r1, r1, r3
@   0x080168e6: 8989        ldrh	r1, [r1, #12]
@   0x080168e8: 0848        lsrs	r0, r1, #1
@   0x080168ea: 2180        movs	r1, #128	@ 0x80
@   0x080168ec: 0609        lsls	r1, r1, #24
@   0x080168ee: 4308        orrs	r0, r1
@   0x080168f0: 6090        str	r0, [r2, #8]
@   0x080168f2: 6890        ldr	r0, [r2, #8]
@   0x080168f4: 4809        ldr	r0, [pc, #36]	@ (0x1691c)
@   0x080168f6: 6010        str	r0, [r2, #0]
@   0x080168f8: 4809        ldr	r0, [pc, #36]	@ (0x16920)
@   0x080168fa: 6050        str	r0, [r2, #4]
@   0x080168fc: 4809        ldr	r0, [pc, #36]	@ (0x16924)
@   0x080168fe: 6090        str	r0, [r2, #8]
@   0x08016900: 6890        ldr	r0, [r2, #8]
@   0x08016902: 1c20        adds	r0, r4, #0
@   0x08016904: f7ff        ff8e 	bl	0x16824
@   0x08016908: bc10        pop	{r4}
@   0x0801690a: bc01        pop	{r0}
@   0x0801690c: 4700        bx	r0
@   0x0801690e: 0000        movs	r0, r0
@   0x08016910: 5320        strh	r0, [r4, r4]
@   0x08016912: 0300        lsls	r0, r0, #12
@   0x08016914: 6888        ldr	r0, [r1, #8]
@   0x08016916: 0830        lsrs	r0, r6, #32
@   0x08016918: 00d4        lsls	r4, r2, #3
@   0x0801691a: 0400        lsls	r0, r0, #16
@   0x0801691c: 3038        adds	r0, #56	@ 0x38
@   0x0801691e: 0817        lsrs	r7, r2, #32
@   0x08016920: 0180        lsls	r0, r0, #6
@   0x08016922: 0500        lsls	r0, r0, #20
@   0x08016924: 0010        movs	r0, r2
@   0x08016926: 8000        strh	r0, [r0, #0]

        thumb_func_start sub_080168A0
sub_080168A0: @ 0x080168a0
        .incbin "frog_us_baserom.gba", 0x168a0, 0x88
        thumb_func_end sub_080168A0
