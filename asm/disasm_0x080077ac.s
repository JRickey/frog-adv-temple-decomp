@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080077ac, 0x08007874)  (200 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80077ac --end 0x8007874 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080077ac: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080077ae: 4657        mov	r7, sl
@   0x080077b0: 464e        mov	r6, r9
@   0x080077b2: 4645        mov	r5, r8
@   0x080077b4: b4e0        push	{r5, r6, r7}
@   0x080077b6: b086        sub	sp, #24
@   0x080077b8: 1c06        adds	r6, r0, #0
@   0x080077ba: 4688        mov	r8, r1
@   0x080077bc: 1c13        adds	r3, r2, #0
@   0x080077be: 482a        ldr	r0, [pc, #168]	@ (0x7868)
@   0x080077c0: 1c02        adds	r2, r0, #0
@   0x080077c2: 3232        adds	r2, #50	@ 0x32
@   0x080077c4: 6b41        ldr	r1, [r0, #52]	@ 0x34
@   0x080077c6: 7812        ldrb	r2, [r2, #0]
@   0x080077c8: 0090        lsls	r0, r2, #2
@   0x080077ca: 1840        adds	r0, r0, r1
@   0x080077cc: 3804        subs	r0, #4
@   0x080077ce: 6802        ldr	r2, [r0, #0]
@   0x080077d0: 2100        movs	r1, #0
@   0x080077d2: 5e50        ldrsh	r0, [r2, r1]
@   0x080077d4: 0045        lsls	r5, r0, #1
@   0x080077d6: 182d        adds	r5, r5, r0
@   0x080077d8: 04ed        lsls	r5, r5, #19
@   0x080077da: 20b0        movs	r0, #176	@ 0xb0
@   0x080077dc: 0300        lsls	r0, r0, #12
@   0x080077de: 182d        adds	r5, r5, r0
@   0x080077e0: 0c2d        lsrs	r5, r5, #16
@   0x080077e2: 2102        movs	r1, #2
@   0x080077e4: 5e50        ldrsh	r0, [r2, r1]
@   0x080077e6: 0044        lsls	r4, r0, #1
@   0x080077e8: 1824        adds	r4, r4, r0
@   0x080077ea: 04e4        lsls	r4, r4, #19
@   0x080077ec: 20b0        movs	r0, #176	@ 0xb0
@   0x080077ee: 0300        lsls	r0, r0, #12
@   0x080077f0: 1824        adds	r4, r4, r0
@   0x080077f2: 0c24        lsrs	r4, r4, #16
@   0x080077f4: 481d        ldr	r0, [pc, #116]	@ (0x786c)
@   0x080077f6: 8811        ldrh	r1, [r2, #0]
@   0x080077f8: 8101        strh	r1, [r0, #8]
@   0x080077fa: 8851        ldrh	r1, [r2, #2]
@   0x080077fc: 8141        strh	r1, [r0, #10]
@   0x080077fe: 7951        ldrb	r1, [r2, #5]
@   0x08007800: 468a        mov	sl, r1
@   0x08007802: 7997        ldrb	r7, [r2, #6]
@   0x08007804: 7911        ldrb	r1, [r2, #4]
@   0x08007806: 4689        mov	r9, r1
@   0x08007808: 79d1        ldrb	r1, [r2, #7]
@   0x0800780a: 7601        strb	r1, [r0, #24]
@   0x0800780c: 7a11        ldrb	r1, [r2, #8]
@   0x0800780e: 7641        strb	r1, [r0, #25]
@   0x08007810: 0636        lsls	r6, r6, #24
@   0x08007812: 1636        asrs	r6, r6, #24
@   0x08007814: 4641        mov	r1, r8
@   0x08007816: 0409        lsls	r1, r1, #16
@   0x08007818: 1409        asrs	r1, r1, #16
@   0x0800781a: 4688        mov	r8, r1
@   0x0800781c: 061b        lsls	r3, r3, #24
@   0x0800781e: 161b        asrs	r3, r3, #24
@   0x08007820: 2100        movs	r1, #0
@   0x08007822: 9100        str	r1, [sp, #0]
@   0x08007824: 1c31        adds	r1, r6, #0
@   0x08007826: 4642        mov	r2, r8
@   0x08007828: f7ff        f924 	bl	0x6a74
@   0x0800782c: 4810        ldr	r0, [pc, #64]	@ (0x7870)
@   0x0800782e: 042d        lsls	r5, r5, #16
@   0x08007830: 142d        asrs	r5, r5, #16
@   0x08007832: 0424        lsls	r4, r4, #16
@   0x08007834: 1424        asrs	r4, r4, #16
@   0x08007836: 4651        mov	r1, sl
@   0x08007838: 9100        str	r1, [sp, #0]
@   0x0800783a: 2101        movs	r1, #1
@   0x0800783c: 9101        str	r1, [sp, #4]
@   0x0800783e: 2100        movs	r1, #0
@   0x08007840: 9102        str	r1, [sp, #8]
@   0x08007842: 9703        str	r7, [sp, #12]
@   0x08007844: 4649        mov	r1, r9
@   0x08007846: 9104        str	r1, [sp, #16]
@   0x08007848: 2110        movs	r1, #16
@   0x0800784a: 9105        str	r1, [sp, #20]
@   0x0800784c: 2100        movs	r1, #0
@   0x0800784e: 1c2a        adds	r2, r5, #0
@   0x08007850: 1c23        adds	r3, r4, #0
@   0x08007852: f002        ff5d 	bl	0xa710
@   0x08007856: b006        add	sp, #24
@   0x08007858: bc38        pop	{r3, r4, r5}
@   0x0800785a: 4698        mov	r8, r3
@   0x0800785c: 46a1        mov	r9, r4
@   0x0800785e: 46aa        mov	sl, r5
@   0x08007860: bcf0        pop	{r4, r5, r6, r7}
@   0x08007862: bc01        pop	{r0}
@   0x08007864: 4700        bx	r0
@   0x08007866: 0000        movs	r0, r0
@   0x08007868: 6110        str	r0, [r2, #16]
@   0x0800786a: 0300        lsls	r0, r0, #12
@   0x0800786c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800786e: 0300        lsls	r0, r0, #12
@   0x08007870: 3720        adds	r7, #32
@   0x08007872: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080077AC
sub_080077AC: @ 0x080077ac
        .incbin "frog_us_baserom.gba", 0x77ac, 0xc8
        thumb_func_end sub_080077AC
