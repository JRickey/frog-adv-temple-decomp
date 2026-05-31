@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803030c, 0x0803038c)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803030c --end 0x803038c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803030c: b570        push	{r4, r5, r6, lr}
@   0x0803030e: 1c05        adds	r5, r0, #0
@   0x08030310: 1c0e        adds	r6, r1, #0
@   0x08030312: 2d03        cmp	r5, #3
@   0x08030314: dc0a        bgt.n	0x3032c
@   0x08030316: 4a04        ldr	r2, [pc, #16]	@ (0x30328)
@   0x08030318: 6810        ldr	r0, [r2, #0]
@   0x0803031a: 0069        lsls	r1, r5, #1
@   0x0803031c: 30ac        adds	r0, #172	@ 0xac
@   0x0803031e: 1840        adds	r0, r0, r1
@   0x08030320: 2100        movs	r1, #0
@   0x08030322: 8001        strh	r1, [r0, #0]
@   0x08030324: e00f        b.n	0x30346
@   0x08030326: 0000        movs	r0, r0
@   0x08030328: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803032a: 0300        lsls	r0, r0, #12
@   0x0803032c: 1f2a        subs	r2, r5, #4
@   0x0803032e: 4c0e        ldr	r4, [pc, #56]	@ (0x30368)
@   0x08030330: 6821        ldr	r1, [r4, #0]
@   0x08030332: 31c8        adds	r1, #200	@ 0xc8
@   0x08030334: 6808        ldr	r0, [r1, #0]
@   0x08030336: 0192        lsls	r2, r2, #6
@   0x08030338: 1810        adds	r0, r2, r0
@   0x0803033a: 2300        movs	r3, #0
@   0x0803033c: 8683        strh	r3, [r0, #52]	@ 0x34
@   0x0803033e: 6808        ldr	r0, [r1, #0]
@   0x08030340: 1812        adds	r2, r2, r0
@   0x08030342: 86d3        strh	r3, [r2, #54]	@ 0x36
@   0x08030344: 1c22        adds	r2, r4, #0
@   0x08030346: 2000        movs	r0, #0
@   0x08030348: 6030        str	r0, [r6, #0]
@   0x0803034a: 2d03        cmp	r5, #3
@   0x0803034c: dd10        ble.n	0x30370
@   0x0803034e: 6810        ldr	r0, [r2, #0]
@   0x08030350: 30c8        adds	r0, #200	@ 0xc8
@   0x08030352: 6801        ldr	r1, [r0, #0]
@   0x08030354: 01a8        lsls	r0, r5, #6
@   0x08030356: 1840        adds	r0, r0, r1
@   0x08030358: 4904        ldr	r1, [pc, #16]	@ (0x3036c)
@   0x0803035a: 1842        adds	r2, r0, r1
@   0x0803035c: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0803035e: 2180        movs	r1, #128	@ 0x80
@   0x08030360: 0209        lsls	r1, r1, #8
@   0x08030362: 4308        orrs	r0, r1
@   0x08030364: 6390        str	r0, [r2, #56]	@ 0x38
@   0x08030366: e00c        b.n	0x30382
@   0x08030368: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803036a: 0300        lsls	r0, r0, #12
@   0x0803036c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08030370: 6811        ldr	r1, [r2, #0]
@   0x08030372: 00a8        lsls	r0, r5, #2
@   0x08030374: 3110        adds	r1, #16
@   0x08030376: 1809        adds	r1, r1, r0
@   0x08030378: 6808        ldr	r0, [r1, #0]
@   0x0803037a: 2280        movs	r2, #128	@ 0x80
@   0x0803037c: 0212        lsls	r2, r2, #8
@   0x0803037e: 4310        orrs	r0, r2
@   0x08030380: 6008        str	r0, [r1, #0]
@   0x08030382: 2000        movs	r0, #0
@   0x08030384: bc70        pop	{r4, r5, r6}
@   0x08030386: bc02        pop	{r1}
@   0x08030388: 4708        bx	r1

        thumb_func_start sub_0803030C
sub_0803030C: @ 0x0803030c
        .incbin "frog_us_baserom.gba", 0x3030c, 0x80
        thumb_func_end sub_0803030C
