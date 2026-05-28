@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d33c, 0x0801d438)  (252 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d33c --end 0x801d438 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d33c: b570        push	{r4, r5, r6, lr}
@   0x0801d33e: 0600        lsls	r0, r0, #24
@   0x0801d340: 4d29        ldr	r5, [pc, #164]	@ (0x1d3e8)
@   0x0801d342: 4b2a        ldr	r3, [pc, #168]	@ (0x1d3ec)
@   0x0801d344: 492a        ldr	r1, [pc, #168]	@ (0x1d3f0)
@   0x0801d346: 4a2b        ldr	r2, [pc, #172]	@ (0x1d3f4)
@   0x0801d348: 6812        ldr	r2, [r2, #0]
@   0x0801d34a: 600a        str	r2, [r1, #0]
@   0x0801d34c: 4a2a        ldr	r2, [pc, #168]	@ (0x1d3f8)
@   0x0801d34e: 604a        str	r2, [r1, #4]
@   0x0801d350: 4e2a        ldr	r6, [pc, #168]	@ (0x1d3fc)
@   0x0801d352: 608e        str	r6, [r1, #8]
@   0x0801d354: 688a        ldr	r2, [r1, #8]
@   0x0801d356: 600b        str	r3, [r1, #0]
@   0x0801d358: 4a29        ldr	r2, [pc, #164]	@ (0x1d400)
@   0x0801d35a: 604a        str	r2, [r1, #4]
@   0x0801d35c: 4c29        ldr	r4, [pc, #164]	@ (0x1d404)
@   0x0801d35e: 608c        str	r4, [r1, #8]
@   0x0801d360: 688a        ldr	r2, [r1, #8]
@   0x0801d362: 1c1a        adds	r2, r3, #0
@   0x0801d364: 3208        adds	r2, #8
@   0x0801d366: 600a        str	r2, [r1, #0]
@   0x0801d368: 4a27        ldr	r2, [pc, #156]	@ (0x1d408)
@   0x0801d36a: 604a        str	r2, [r1, #4]
@   0x0801d36c: 608c        str	r4, [r1, #8]
@   0x0801d36e: 688a        ldr	r2, [r1, #8]
@   0x0801d370: 1c1a        adds	r2, r3, #0
@   0x0801d372: 3210        adds	r2, #16
@   0x0801d374: 600a        str	r2, [r1, #0]
@   0x0801d376: 4a25        ldr	r2, [pc, #148]	@ (0x1d40c)
@   0x0801d378: 604a        str	r2, [r1, #4]
@   0x0801d37a: 608c        str	r4, [r1, #8]
@   0x0801d37c: 688a        ldr	r2, [r1, #8]
@   0x0801d37e: 3318        adds	r3, #24
@   0x0801d380: 600b        str	r3, [r1, #0]
@   0x0801d382: 4a23        ldr	r2, [pc, #140]	@ (0x1d410)
@   0x0801d384: 604a        str	r2, [r1, #4]
@   0x0801d386: 608c        str	r4, [r1, #8]
@   0x0801d388: 688a        ldr	r2, [r1, #8]
@   0x0801d38a: 4a22        ldr	r2, [pc, #136]	@ (0x1d414)
@   0x0801d38c: 0d80        lsrs	r0, r0, #22
@   0x0801d38e: 3004        adds	r0, #4
@   0x0801d390: 1882        adds	r2, r0, r2
@   0x0801d392: 6812        ldr	r2, [r2, #0]
@   0x0801d394: 600a        str	r2, [r1, #0]
@   0x0801d396: 4a20        ldr	r2, [pc, #128]	@ (0x1d418)
@   0x0801d398: 604a        str	r2, [r1, #4]
@   0x0801d39a: 4a20        ldr	r2, [pc, #128]	@ (0x1d41c)
@   0x0801d39c: 608a        str	r2, [r1, #8]
@   0x0801d39e: 688a        ldr	r2, [r1, #8]
@   0x0801d3a0: 4a1f        ldr	r2, [pc, #124]	@ (0x1d420)
@   0x0801d3a2: 1880        adds	r0, r0, r2
@   0x0801d3a4: 6800        ldr	r0, [r0, #0]
@   0x0801d3a6: 6008        str	r0, [r1, #0]
@   0x0801d3a8: 481e        ldr	r0, [pc, #120]	@ (0x1d424)
@   0x0801d3aa: 6048        str	r0, [r1, #4]
@   0x0801d3ac: 608e        str	r6, [r1, #8]
@   0x0801d3ae: 6888        ldr	r0, [r1, #8]
@   0x0801d3b0: 600d        str	r5, [r1, #0]
@   0x0801d3b2: 481d        ldr	r0, [pc, #116]	@ (0x1d428)
@   0x0801d3b4: 6048        str	r0, [r1, #4]
@   0x0801d3b6: 608c        str	r4, [r1, #8]
@   0x0801d3b8: 6888        ldr	r0, [r1, #8]
@   0x0801d3ba: 1c28        adds	r0, r5, #0
@   0x0801d3bc: 3008        adds	r0, #8
@   0x0801d3be: 6008        str	r0, [r1, #0]
@   0x0801d3c0: 481a        ldr	r0, [pc, #104]	@ (0x1d42c)
@   0x0801d3c2: 6048        str	r0, [r1, #4]
@   0x0801d3c4: 608c        str	r4, [r1, #8]
@   0x0801d3c6: 6888        ldr	r0, [r1, #8]
@   0x0801d3c8: 1c28        adds	r0, r5, #0
@   0x0801d3ca: 3010        adds	r0, #16
@   0x0801d3cc: 6008        str	r0, [r1, #0]
@   0x0801d3ce: 4818        ldr	r0, [pc, #96]	@ (0x1d430)
@   0x0801d3d0: 6048        str	r0, [r1, #4]
@   0x0801d3d2: 608c        str	r4, [r1, #8]
@   0x0801d3d4: 6888        ldr	r0, [r1, #8]
@   0x0801d3d6: 3518        adds	r5, #24
@   0x0801d3d8: 600d        str	r5, [r1, #0]
@   0x0801d3da: 4816        ldr	r0, [pc, #88]	@ (0x1d434)
@   0x0801d3dc: 6048        str	r0, [r1, #4]
@   0x0801d3de: 608c        str	r4, [r1, #8]
@   0x0801d3e0: 6888        ldr	r0, [r1, #8]
@   0x0801d3e2: bc70        pop	{r4, r5, r6}
@   0x0801d3e4: bc01        pop	{r0}
@   0x0801d3e6: 4700        bx	r0
@   0x0801d3e8: e074        b.n	0x1d4d4
@   0x0801d3ea: 081b        lsrs	r3, r3, #32
@   0x0801d3ec: e054        b.n	0x1d498
@   0x0801d3ee: 081b        lsrs	r3, r3, #32
@   0x0801d3f0: 00d4        lsls	r4, r2, #3
@   0x0801d3f2: 0400        lsls	r0, r0, #16
@   0x0801d3f4: 8f3c        ldrh	r4, [r7, #56]	@ 0x38
@   0x0801d3f6: 0830        lsrs	r0, r6, #32
@   0x0801d3f8: 01c0        lsls	r0, r0, #7
@   0x0801d3fa: 0500        lsls	r0, r0, #20
@   0x0801d3fc: 0010        movs	r0, r2
@   0x0801d3fe: 8000        strh	r0, [r0, #0]
@   0x0801d400: fbf4        0600 			@ <UNDEFINED> instruction: 0xfbf40600
@   0x0801d404: 0004        movs	r4, r0
@   0x0801d406: 8000        strh	r0, [r0, #0]
@   0x0801d408: fc34        0600 			@ <UNDEFINED> instruction: 0xfc340600
@   0x0801d40c: fc74        0600 			@ <UNDEFINED> instruction: 0xfc740600
@   0x0801d410: fcb4        0600 			@ <UNDEFINED> instruction: 0xfcb40600
@   0x0801d414: 87c8        strh	r0, [r1, #62]	@ 0x3e
@   0x0801d416: 0830        lsrs	r0, r6, #32
@   0x0801d418: 8020        strh	r0, [r4, #0]
@   0x0801d41a: 0600        lsls	r0, r0, #24
@   0x0801d41c: 0100        lsls	r0, r0, #4
@   0x0801d41e: 8000        strh	r0, [r0, #0]
@   0x0801d420: 87e8        strh	r0, [r5, #62]	@ 0x3e
@   0x0801d422: 0830        lsrs	r0, r6, #32
@   0x0801d424: 01e0        lsls	r0, r4, #7
@   0x0801d426: 0500        lsls	r0, r0, #20
@   0x0801d428: f841        0600 	str.w	r0, [r1, <undefined>]
@   0x0801d42c: f881        0600 	strb.w	r0, [r1, #1536]	@ 0x600
@   0x0801d430: f8c1        0600 	str.w	r0, [r1, #1536]	@ 0x600
@   0x0801d434: f901        0600 	vst1.8	{d0-d2}, [r1], r0

        thumb_func_start sub_0801D33C
sub_0801D33C: @ 0x0801d33c
        .incbin "frog_us_baserom.gba", 0x1d33c, 0xfc
        thumb_func_end sub_0801D33C
