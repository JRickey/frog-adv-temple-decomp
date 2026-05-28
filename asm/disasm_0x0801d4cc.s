@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d4cc, 0x0801d570)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d4cc --end 0x801d570 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d4cc: b530        push	{r4, r5, lr}
@   0x0801d4ce: b081        sub	sp, #4
@   0x0801d4d0: 1c05        adds	r5, r0, #0
@   0x0801d4d2: 062d        lsls	r5, r5, #24
@   0x0801d4d4: 0e2d        lsrs	r5, r5, #24
@   0x0801d4d6: 4a1d        ldr	r2, [pc, #116]	@ (0x1d54c)
@   0x0801d4d8: 481d        ldr	r0, [pc, #116]	@ (0x1d550)
@   0x0801d4da: 6150        str	r0, [r2, #20]
@   0x0801d4dc: 3080        adds	r0, #128	@ 0x80
@   0x0801d4de: 6250        str	r0, [r2, #36]	@ 0x24
@   0x0801d4e0: 4b1c        ldr	r3, [pc, #112]	@ (0x1d554)
@   0x0801d4e2: 481d        ldr	r0, [pc, #116]	@ (0x1d558)
@   0x0801d4e4: 6801        ldr	r1, [r0, #0]
@   0x0801d4e6: 0048        lsls	r0, r1, #1
@   0x0801d4e8: 1840        adds	r0, r0, r1
@   0x0801d4ea: 00c0        lsls	r0, r0, #3
@   0x0801d4ec: 18c0        adds	r0, r0, r3
@   0x0801d4ee: 6801        ldr	r1, [r0, #0]
@   0x0801d4f0: 00a8        lsls	r0, r5, #2
@   0x0801d4f2: 1840        adds	r0, r0, r1
@   0x0801d4f4: 309c        adds	r0, #156	@ 0x9c
@   0x0801d4f6: 6800        ldr	r0, [r0, #0]
@   0x0801d4f8: 60d0        str	r0, [r2, #12]
@   0x0801d4fa: 2000        movs	r0, #0
@   0x0801d4fc: 2400        movs	r4, #0
@   0x0801d4fe: 7210        strb	r0, [r2, #8]
@   0x0801d500: 8594        strh	r4, [r2, #44]	@ 0x2c
@   0x0801d502: 8614        strh	r4, [r2, #48]	@ 0x30
@   0x0801d504: 8654        strh	r4, [r2, #50]	@ 0x32
@   0x0801d506: 2008        movs	r0, #8
@   0x0801d508: 72d0        strb	r0, [r2, #11]
@   0x0801d50a: f010        fe17 	bl	0x2e13c
@   0x0801d50e: 4913        ldr	r1, [pc, #76]	@ (0x1d55c)
@   0x0801d510: 1c68        adds	r0, r5, #1
@   0x0801d512: 0080        lsls	r0, r0, #2
@   0x0801d514: 1840        adds	r0, r0, r1
@   0x0801d516: 6800        ldr	r0, [r0, #0]
@   0x0801d518: f003        fbae 	bl	0x20c78
@   0x0801d51c: 4668        mov	r0, sp
@   0x0801d51e: 8004        strh	r4, [r0, #0]
@   0x0801d520: 480f        ldr	r0, [pc, #60]	@ (0x1d560)
@   0x0801d522: 4669        mov	r1, sp
@   0x0801d524: 6001        str	r1, [r0, #0]
@   0x0801d526: 490f        ldr	r1, [pc, #60]	@ (0x1d564)
@   0x0801d528: 6041        str	r1, [r0, #4]
@   0x0801d52a: 4a0f        ldr	r2, [pc, #60]	@ (0x1d568)
@   0x0801d52c: 6082        str	r2, [r0, #8]
@   0x0801d52e: 6881        ldr	r1, [r0, #8]
@   0x0801d530: 4669        mov	r1, sp
@   0x0801d532: 800c        strh	r4, [r1, #0]
@   0x0801d534: 6001        str	r1, [r0, #0]
@   0x0801d536: 490d        ldr	r1, [pc, #52]	@ (0x1d56c)
@   0x0801d538: 6041        str	r1, [r0, #4]
@   0x0801d53a: 6082        str	r2, [r0, #8]
@   0x0801d53c: 6880        ldr	r0, [r0, #8]
@   0x0801d53e: 1c28        adds	r0, r5, #0
@   0x0801d540: f7ff        fefc 	bl	0x1d33c
@   0x0801d544: b001        add	sp, #4
@   0x0801d546: bc30        pop	{r4, r5}
@   0x0801d548: bc01        pop	{r0}
@   0x0801d54a: 4700        bx	r0
@   0x0801d54c: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d54e: 0300        lsls	r0, r0, #12
@   0x0801d550: f84c        0600 	str.w	r0, [ip, <undefined>]
@   0x0801d554: 1254        asrs	r4, r2, #9
@   0x0801d556: 080c        lsrs	r4, r1, #32
@   0x0801d558: 34b0        adds	r4, #176	@ 0xb0
@   0x0801d55a: 0300        lsls	r0, r0, #12
@   0x0801d55c: e094        b.n	0x1d688
@   0x0801d55e: 081b        lsrs	r3, r3, #32
@   0x0801d560: 00d4        lsls	r4, r2, #3
@   0x0801d562: 0400        lsls	r0, r0, #16
@   0x0801d564: fbc0        0600 	smlal	r0, r6, r0, r0
@   0x0801d568: 00c0        lsls	r0, r0, #3
@   0x0801d56a: 8100        strh	r0, [r0, #8]
@   0x0801d56c: f800        0600 	strb.w	r0, [r0, <undefined>]

        thumb_func_start sub_0801D4CC
sub_0801D4CC: @ 0x0801d4cc
        .incbin "frog_us_baserom.gba", 0x1d4cc, 0xa4
        thumb_func_end sub_0801D4CC
