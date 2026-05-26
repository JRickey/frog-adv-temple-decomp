@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080066c4, 0x0800679c)  (216 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80066c4 --end 0x800679c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080066c4: b510        push	{r4, lr}
@   0x080066c6: 1c04        adds	r4, r0, #0
@   0x080066c8: 0609        lsls	r1, r1, #24
@   0x080066ca: 0e08        lsrs	r0, r1, #24
@   0x080066cc: 0612        lsls	r2, r2, #24
@   0x080066ce: 0e12        lsrs	r2, r2, #24
@   0x080066d0: 2809        cmp	r0, #9
@   0x080066d2: d85f        bhi.n	0x6794
@   0x080066d4: 0080        lsls	r0, r0, #2
@   0x080066d6: 4902        ldr	r1, [pc, #8]	@ (0x66e0)
@   0x080066d8: 1840        adds	r0, r0, r1
@   0x080066da: 6800        ldr	r0, [r0, #0]
@   0x080066dc: 4687        mov	pc, r0
@   0x080066de: 0000        movs	r0, r0
@   0x080066e0: 66e4        str	r4, [r4, #108]	@ 0x6c
@   0x080066e2: 0800        lsrs	r0, r0, #32
@   0x080066e4: 670c        str	r4, [r1, #112]	@ 0x70
@   0x080066e6: 0800        lsrs	r0, r0, #32
@   0x080066e8: 671a        str	r2, [r3, #112]	@ 0x70
@   0x080066ea: 0800        lsrs	r0, r0, #32
@   0x080066ec: 6734        str	r4, [r6, #112]	@ 0x70
@   0x080066ee: 0800        lsrs	r0, r0, #32
@   0x080066f0: 6742        str	r2, [r0, #116]	@ 0x74
@   0x080066f2: 0800        lsrs	r0, r0, #32
@   0x080066f4: 674e        str	r6, [r1, #116]	@ 0x74
@   0x080066f6: 0800        lsrs	r0, r0, #32
@   0x080066f8: 675c        str	r4, [r3, #116]	@ 0x74
@   0x080066fa: 0800        lsrs	r0, r0, #32
@   0x080066fc: 676a        str	r2, [r5, #116]	@ 0x74
@   0x080066fe: 0800        lsrs	r0, r0, #32
@   0x08006700: 6778        str	r0, [r7, #116]	@ 0x74
@   0x08006702: 0800        lsrs	r0, r0, #32
@   0x08006704: 677e        str	r6, [r7, #116]	@ 0x74
@   0x08006706: 0800        lsrs	r0, r0, #32
@   0x08006708: 6784        str	r4, [r0, #120]	@ 0x78
@   0x0800670a: 0800        lsrs	r0, r0, #32
@   0x0800670c: 2001        movs	r0, #1
@   0x0800670e: 4090        lsls	r0, r2
@   0x08006710: 8821        ldrh	r1, [r4, #0]
@   0x08006712: 4381        bics	r1, r0
@   0x08006714: 1c08        adds	r0, r1, #0
@   0x08006716: 8020        strh	r0, [r4, #0]
@   0x08006718: e03c        b.n	0x6794
@   0x0800671a: 2001        movs	r0, #1
@   0x0800671c: 2100        movs	r1, #0
@   0x0800671e: f02d        fac1 	bl	0x33ca4
@   0x08006722: 43c0        mvns	r0, r0
@   0x08006724: 43c9        mvns	r1, r1
@   0x08006726: 6862        ldr	r2, [r4, #4]
@   0x08006728: 68a3        ldr	r3, [r4, #8]
@   0x0800672a: 4002        ands	r2, r0
@   0x0800672c: 400b        ands	r3, r1
@   0x0800672e: 6062        str	r2, [r4, #4]
@   0x08006730: 60a3        str	r3, [r4, #8]
@   0x08006732: e02f        b.n	0x6794
@   0x08006734: 2001        movs	r0, #1
@   0x08006736: 4090        lsls	r0, r2
@   0x08006738: 89a2        ldrh	r2, [r4, #12]
@   0x0800673a: 4382        bics	r2, r0
@   0x0800673c: 1c10        adds	r0, r2, #0
@   0x0800673e: 81a0        strh	r0, [r4, #12]
@   0x08006740: e028        b.n	0x6794
@   0x08006742: 2101        movs	r1, #1
@   0x08006744: 4091        lsls	r1, r2
@   0x08006746: 6920        ldr	r0, [r4, #16]
@   0x08006748: 4388        bics	r0, r1
@   0x0800674a: 6120        str	r0, [r4, #16]
@   0x0800674c: e022        b.n	0x6794
@   0x0800674e: 2001        movs	r0, #1
@   0x08006750: 4090        lsls	r0, r2
@   0x08006752: 8ca1        ldrh	r1, [r4, #36]	@ 0x24
@   0x08006754: 4381        bics	r1, r0
@   0x08006756: 1c08        adds	r0, r1, #0
@   0x08006758: 84a0        strh	r0, [r4, #36]	@ 0x24
@   0x0800675a: e01b        b.n	0x6794
@   0x0800675c: 2001        movs	r0, #1
@   0x0800675e: 4090        lsls	r0, r2
@   0x08006760: 8ce2        ldrh	r2, [r4, #38]	@ 0x26
@   0x08006762: 4382        bics	r2, r0
@   0x08006764: 1c10        adds	r0, r2, #0
@   0x08006766: 84e0        strh	r0, [r4, #38]	@ 0x26
@   0x08006768: e014        b.n	0x6794
@   0x0800676a: 2001        movs	r0, #1
@   0x0800676c: 4090        lsls	r0, r2
@   0x0800676e: 8d21        ldrh	r1, [r4, #40]	@ 0x28
@   0x08006770: 4381        bics	r1, r0
@   0x08006772: 1c08        adds	r0, r1, #0
@   0x08006774: 8520        strh	r0, [r4, #40]	@ 0x28
@   0x08006776: e00d        b.n	0x6794
@   0x08006778: 1c20        adds	r0, r4, #0
@   0x0800677a: 302c        adds	r0, #44	@ 0x2c
@   0x0800677c: e004        b.n	0x6788
@   0x0800677e: 1c20        adds	r0, r4, #0
@   0x08006780: 302a        adds	r0, #42	@ 0x2a
@   0x08006782: e001        b.n	0x6788
@   0x08006784: 1c20        adds	r0, r4, #0
@   0x08006786: 302b        adds	r0, #43	@ 0x2b
@   0x08006788: 2101        movs	r1, #1
@   0x0800678a: 4091        lsls	r1, r2
@   0x0800678c: 7802        ldrb	r2, [r0, #0]
@   0x0800678e: 438a        bics	r2, r1
@   0x08006790: 1c11        adds	r1, r2, #0
@   0x08006792: 7001        strb	r1, [r0, #0]
@   0x08006794: bc10        pop	{r4}
@   0x08006796: bc01        pop	{r0}
@   0x08006798: 4700        bx	r0

        thumb_func_start sub_080066C4
sub_080066C4: @ 0x080066c4
        .incbin "frog_us_baserom.gba", 0x66c4, 0xd8
        thumb_func_end sub_080066C4
