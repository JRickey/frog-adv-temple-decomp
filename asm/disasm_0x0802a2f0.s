@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a2f0, 0x0802a394)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a2f0 --end 0x802a394 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a2f0: b530        push	{r4, r5, lr}
@   0x0802a2f2: b089        sub	sp, #36	@ 0x24
@   0x0802a2f4: a903        add	r1, sp, #12
@   0x0802a2f6: 2400        movs	r4, #0
@   0x0802a2f8: 2002        movs	r0, #2
@   0x0802a2fa: 8008        strh	r0, [r1, #0]
@   0x0802a2fc: 1c08        adds	r0, r1, #0
@   0x0802a2fe: 8044        strh	r4, [r0, #2]
@   0x0802a300: 8084        strh	r4, [r0, #4]
@   0x0802a302: 2004        movs	r0, #4
@   0x0802a304: f7d6        fa2e 	bl	0x764
@   0x0802a308: aa03        add	r2, sp, #12
@   0x0802a30a: 3001        adds	r0, #1
@   0x0802a30c: 0041        lsls	r1, r0, #1
@   0x0802a30e: 1809        adds	r1, r1, r0
@   0x0802a310: 00c9        lsls	r1, r1, #3
@   0x0802a312: 310b        adds	r1, #11
@   0x0802a314: 8111        strh	r1, [r2, #8]
@   0x0802a316: 2005        movs	r0, #5
@   0x0802a318: f7d6        fa24 	bl	0x764
@   0x0802a31c: aa03        add	r2, sp, #12
@   0x0802a31e: 3002        adds	r0, #2
@   0x0802a320: 0041        lsls	r1, r0, #1
@   0x0802a322: 1809        adds	r1, r1, r0
@   0x0802a324: 00c9        lsls	r1, r1, #3
@   0x0802a326: 310b        adds	r1, #11
@   0x0802a328: 8151        strh	r1, [r2, #10]
@   0x0802a32a: 1c10        adds	r0, r2, #0
@   0x0802a32c: 4d16        ldr	r5, [pc, #88]	@ (0x2a388)
@   0x0802a32e: 8185        strh	r5, [r0, #12]
@   0x0802a330: 2004        movs	r0, #4
@   0x0802a332: f7d6        fa17 	bl	0x764
@   0x0802a336: aa03        add	r2, sp, #12
@   0x0802a338: 3005        adds	r0, #5
@   0x0802a33a: 0041        lsls	r1, r0, #1
@   0x0802a33c: 1809        adds	r1, r1, r0
@   0x0802a33e: 00c9        lsls	r1, r1, #3
@   0x0802a340: 310b        adds	r1, #11
@   0x0802a342: 8211        strh	r1, [r2, #16]
@   0x0802a344: 2005        movs	r0, #5
@   0x0802a346: f7d6        fa0d 	bl	0x764
@   0x0802a34a: aa03        add	r2, sp, #12
@   0x0802a34c: 3002        adds	r0, #2
@   0x0802a34e: 0041        lsls	r1, r0, #1
@   0x0802a350: 1809        adds	r1, r1, r0
@   0x0802a352: 00c9        lsls	r1, r1, #3
@   0x0802a354: 310b        adds	r1, #11
@   0x0802a356: 8251        strh	r1, [r2, #18]
@   0x0802a358: 1c10        adds	r0, r2, #0
@   0x0802a35a: 8285        strh	r5, [r0, #20]
@   0x0802a35c: 480b        ldr	r0, [pc, #44]	@ (0x2a38c)
@   0x0802a35e: 9000        str	r0, [sp, #0]
@   0x0802a360: 2004        movs	r0, #4
@   0x0802a362: 9001        str	r0, [sp, #4]
@   0x0802a364: 9402        str	r4, [sp, #8]
@   0x0802a366: 200e        movs	r0, #14
@   0x0802a368: 1c11        adds	r1, r2, #0
@   0x0802a36a: 2210        movs	r2, #16
@   0x0802a36c: 2303        movs	r3, #3
@   0x0802a36e: f7f6        fee7 	bl	0x21140
@   0x0802a372: f7d6        fac5 	bl	0x900
@   0x0802a376: 4906        ldr	r1, [pc, #24]	@ (0x2a390)
@   0x0802a378: 22cf        movs	r2, #207	@ 0xcf
@   0x0802a37a: 0092        lsls	r2, r2, #2
@   0x0802a37c: 1889        adds	r1, r1, r2
@   0x0802a37e: 6008        str	r0, [r1, #0]
@   0x0802a380: b009        add	sp, #36	@ 0x24
@   0x0802a382: bc30        pop	{r4, r5}
@   0x0802a384: bc01        pop	{r0}
@   0x0802a386: 4700        bx	r0
@   0x0802a388: 0303        lsls	r3, r0, #12
@   0x0802a38a: 0000        movs	r0, r0
@   0x0802a38c: 0141        lsls	r1, r0, #5
@   0x0802a38e: 0000        movs	r0, r0
@   0x0802a390: 3720        adds	r7, #32
@   0x0802a392: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802A2F0
sub_0802A2F0: @ 0x0802a2f0
        .incbin "frog_us_baserom.gba", 0x2a2f0, 0xa4
        thumb_func_end sub_0802A2F0
