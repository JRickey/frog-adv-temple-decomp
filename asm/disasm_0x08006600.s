@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006600, 0x080066c4)  (196 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006600 --end 0x80066c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006600: b510        push	{r4, lr}
@   0x08006602: 1c04        adds	r4, r0, #0
@   0x08006604: 0609        lsls	r1, r1, #24
@   0x08006606: 0e08        lsrs	r0, r1, #24
@   0x08006608: 0612        lsls	r2, r2, #24
@   0x0800660a: 0e13        lsrs	r3, r2, #24
@   0x0800660c: 2809        cmp	r0, #9
@   0x0800660e: d856        bhi.n	0x66be
@   0x08006610: 0080        lsls	r0, r0, #2
@   0x08006612: 4902        ldr	r1, [pc, #8]	@ (0x661c)
@   0x08006614: 1840        adds	r0, r0, r1
@   0x08006616: 6800        ldr	r0, [r0, #0]
@   0x08006618: 4687        mov	pc, r0
@   0x0800661a: 0000        movs	r0, r0
@   0x0800661c: 6620        str	r0, [r4, #96]	@ 0x60
@   0x0800661e: 0800        lsrs	r0, r0, #32
@   0x08006620: 6648        str	r0, [r1, #100]	@ 0x64
@   0x08006622: 0800        lsrs	r0, r0, #32
@   0x08006624: 6654        str	r4, [r2, #100]	@ 0x64
@   0x08006626: 0800        lsrs	r0, r0, #32
@   0x08006628: 6668        str	r0, [r5, #100]	@ 0x64
@   0x0800662a: 0800        lsrs	r0, r0, #32
@   0x0800662c: 6674        str	r4, [r6, #100]	@ 0x64
@   0x0800662e: 0800        lsrs	r0, r0, #32
@   0x08006630: 6680        str	r0, [r0, #104]	@ 0x68
@   0x08006632: 0800        lsrs	r0, r0, #32
@   0x08006634: 668c        str	r4, [r1, #104]	@ 0x68
@   0x08006636: 0800        lsrs	r0, r0, #32
@   0x08006638: 6698        str	r0, [r3, #104]	@ 0x68
@   0x0800663a: 0800        lsrs	r0, r0, #32
@   0x0800663c: 66a4        str	r4, [r4, #104]	@ 0x68
@   0x0800663e: 0800        lsrs	r0, r0, #32
@   0x08006640: 66aa        str	r2, [r5, #104]	@ 0x68
@   0x08006642: 0800        lsrs	r0, r0, #32
@   0x08006644: 66b0        str	r0, [r6, #104]	@ 0x68
@   0x08006646: 0800        lsrs	r0, r0, #32
@   0x08006648: 2001        movs	r0, #1
@   0x0800664a: 4098        lsls	r0, r3
@   0x0800664c: 8821        ldrh	r1, [r4, #0]
@   0x0800664e: 4308        orrs	r0, r1
@   0x08006650: 8020        strh	r0, [r4, #0]
@   0x08006652: e034        b.n	0x66be
@   0x08006654: 2201        movs	r2, #1
@   0x08006656: 409a        lsls	r2, r3
@   0x08006658: 17d3        asrs	r3, r2, #31
@   0x0800665a: 6860        ldr	r0, [r4, #4]
@   0x0800665c: 68a1        ldr	r1, [r4, #8]
@   0x0800665e: 4310        orrs	r0, r2
@   0x08006660: 4319        orrs	r1, r3
@   0x08006662: 6060        str	r0, [r4, #4]
@   0x08006664: 60a1        str	r1, [r4, #8]
@   0x08006666: e02a        b.n	0x66be
@   0x08006668: 2001        movs	r0, #1
@   0x0800666a: 4098        lsls	r0, r3
@   0x0800666c: 89a2        ldrh	r2, [r4, #12]
@   0x0800666e: 4310        orrs	r0, r2
@   0x08006670: 81a0        strh	r0, [r4, #12]
@   0x08006672: e024        b.n	0x66be
@   0x08006674: 2101        movs	r1, #1
@   0x08006676: 4099        lsls	r1, r3
@   0x08006678: 6920        ldr	r0, [r4, #16]
@   0x0800667a: 4308        orrs	r0, r1
@   0x0800667c: 6120        str	r0, [r4, #16]
@   0x0800667e: e01e        b.n	0x66be
@   0x08006680: 2001        movs	r0, #1
@   0x08006682: 4098        lsls	r0, r3
@   0x08006684: 8ca1        ldrh	r1, [r4, #36]	@ 0x24
@   0x08006686: 4308        orrs	r0, r1
@   0x08006688: 84a0        strh	r0, [r4, #36]	@ 0x24
@   0x0800668a: e018        b.n	0x66be
@   0x0800668c: 2001        movs	r0, #1
@   0x0800668e: 4098        lsls	r0, r3
@   0x08006690: 8ce2        ldrh	r2, [r4, #38]	@ 0x26
@   0x08006692: 4310        orrs	r0, r2
@   0x08006694: 84e0        strh	r0, [r4, #38]	@ 0x26
@   0x08006696: e012        b.n	0x66be
@   0x08006698: 2001        movs	r0, #1
@   0x0800669a: 4098        lsls	r0, r3
@   0x0800669c: 8d21        ldrh	r1, [r4, #40]	@ 0x28
@   0x0800669e: 4308        orrs	r0, r1
@   0x080066a0: 8520        strh	r0, [r4, #40]	@ 0x28
@   0x080066a2: e00c        b.n	0x66be
@   0x080066a4: 1c21        adds	r1, r4, #0
@   0x080066a6: 312c        adds	r1, #44	@ 0x2c
@   0x080066a8: e004        b.n	0x66b4
@   0x080066aa: 1c21        adds	r1, r4, #0
@   0x080066ac: 312a        adds	r1, #42	@ 0x2a
@   0x080066ae: e001        b.n	0x66b4
@   0x080066b0: 1c21        adds	r1, r4, #0
@   0x080066b2: 312b        adds	r1, #43	@ 0x2b
@   0x080066b4: 2001        movs	r0, #1
@   0x080066b6: 4098        lsls	r0, r3
@   0x080066b8: 780a        ldrb	r2, [r1, #0]
@   0x080066ba: 4310        orrs	r0, r2
@   0x080066bc: 7008        strb	r0, [r1, #0]
@   0x080066be: bc10        pop	{r4}
@   0x080066c0: bc01        pop	{r0}
@   0x080066c2: 4700        bx	r0

        thumb_func_start sub_08006600
sub_08006600: @ 0x08006600
        .incbin "frog_us_baserom.gba", 0x6600, 0xc4
        thumb_func_end sub_08006600
