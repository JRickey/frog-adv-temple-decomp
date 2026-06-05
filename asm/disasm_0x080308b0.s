@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080308b0, 0x080309a0)  (240 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80308b0 --end 0x80309a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080308b0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080308b2: 4657        mov	r7, sl
@   0x080308b4: 464e        mov	r6, r9
@   0x080308b6: 4645        mov	r5, r8
@   0x080308b8: b4e0        push	{r5, r6, r7}
@   0x080308ba: 1c06        adds	r6, r0, #0
@   0x080308bc: 4691        mov	r9, r2
@   0x080308be: 469a        mov	sl, r3
@   0x080308c0: 4b19        ldr	r3, [pc, #100]	@ (0x30928)
@   0x080308c2: 6818        ldr	r0, [r3, #0]
@   0x080308c4: 4684        mov	ip, r0
@   0x080308c6: 30c8        adds	r0, #200	@ 0xc8
@   0x080308c8: 01b2        lsls	r2, r6, #6
@   0x080308ca: 6800        ldr	r0, [r0, #0]
@   0x080308cc: 1887        adds	r7, r0, r2
@   0x080308ce: 4662        mov	r2, ip
@   0x080308d0: 32c0        adds	r2, #192	@ 0xc0
@   0x080308d2: 00f0        lsls	r0, r6, #3
@   0x080308d4: 1b80        subs	r0, r0, r6
@   0x080308d6: 0080        lsls	r0, r0, #2
@   0x080308d8: 6812        ldr	r2, [r2, #0]
@   0x080308da: 1814        adds	r4, r2, r0
@   0x080308dc: 4660        mov	r0, ip
@   0x080308de: 30c4        adds	r0, #196	@ 0xc4
@   0x080308e0: 6802        ldr	r2, [r0, #0]
@   0x080308e2: 00b0        lsls	r0, r6, #2
@   0x080308e4: 1880        adds	r0, r0, r2
@   0x080308e6: 2200        movs	r2, #0
@   0x080308e8: 4690        mov	r8, r2
@   0x080308ea: 6002        str	r2, [r0, #0]
@   0x080308ec: 6bb8        ldr	r0, [r7, #56]	@ 0x38
@   0x080308ee: 4a0f        ldr	r2, [pc, #60]	@ (0x3092c)
@   0x080308f0: 4010        ands	r0, r2
@   0x080308f2: 2280        movs	r2, #128	@ 0x80
@   0x080308f4: 0152        lsls	r2, r2, #5
@   0x080308f6: 4310        orrs	r0, r2
@   0x080308f8: 63b8        str	r0, [r7, #56]	@ 0x38
@   0x080308fa: 2088        movs	r0, #136	@ 0x88
@   0x080308fc: 0040        lsls	r0, r0, #1
@   0x080308fe: 4460        add	r0, ip
@   0x08030900: 6802        ldr	r2, [r0, #0]
@   0x08030902: 69d0        ldr	r0, [r2, #28]
@   0x08030904: 0089        lsls	r1, r1, #2
@   0x08030906: 1810        adds	r0, r2, r0
@   0x08030908: 1809        adds	r1, r1, r0
@   0x0803090a: 6808        ldr	r0, [r1, #0]
@   0x0803090c: 1812        adds	r2, r2, r0
@   0x0803090e: 6022        str	r2, [r4, #0]
@   0x08030910: 1c11        adds	r1, r2, #0
@   0x08030912: 3110        adds	r1, #16
@   0x08030914: 6061        str	r1, [r4, #4]
@   0x08030916: 6815        ldr	r5, [r2, #0]
@   0x08030918: 1948        adds	r0, r1, r5
@   0x0803091a: 60a0        str	r0, [r4, #8]
@   0x0803091c: 6852        ldr	r2, [r2, #4]
@   0x0803091e: 2a00        cmp	r2, #0
@   0x08030920: da06        bge.n	0x30930
@   0x08030922: 4640        mov	r0, r8
@   0x08030924: 60e0        str	r0, [r4, #12]
@   0x08030926: e006        b.n	0x30936
@   0x08030928: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803092a: 0300        lsls	r0, r0, #12
@   0x0803092c: b3ff        cbz	r7, 0x309ae
@   0x0803092e: ffff        1888 	vtbl.8	d17, {d31}, d8
@   0x08030932: 60e0        str	r0, [r4, #12]
@   0x08030934: 1aa8        subs	r0, r5, r2
@   0x08030936: 6120        str	r0, [r4, #16]
@   0x08030938: 4649        mov	r1, r9
@   0x0803093a: 2900        cmp	r1, #0
@   0x0803093c: d005        beq.n	0x3094a
@   0x0803093e: 6860        ldr	r0, [r4, #4]
@   0x08030940: 1842        adds	r2, r0, r1
@   0x08030942: 68a0        ldr	r0, [r4, #8]
@   0x08030944: 4282        cmp	r2, r0
@   0x08030946: d200        bcs.n	0x3094a
@   0x08030948: 6062        str	r2, [r4, #4]
@   0x0803094a: 2000        movs	r0, #0
@   0x0803094c: 2100        movs	r1, #0
@   0x0803094e: 82e1        strh	r1, [r4, #22]
@   0x08030950: 76a0        strb	r0, [r4, #26]
@   0x08030952: 1c38        adds	r0, r7, #0
@   0x08030954: 303d        adds	r0, #61	@ 0x3d
@   0x08030956: 7800        ldrb	r0, [r0, #0]
@   0x08030958: 2800        cmp	r0, #0
@   0x0803095a: d005        beq.n	0x30968
@   0x0803095c: 6818        ldr	r0, [r3, #0]
@   0x0803095e: 2287        movs	r2, #135	@ 0x87
@   0x08030960: 0052        lsls	r2, r2, #1
@   0x08030962: 1880        adds	r0, r0, r2
@   0x08030964: 7800        ldrb	r0, [r0, #0]
@   0x08030966: e000        b.n	0x3096a
@   0x08030968: 2000        movs	r0, #0
@   0x0803096a: 76e0        strb	r0, [r4, #27]
@   0x0803096c: 1c30        adds	r0, r6, #0
@   0x0803096e: f7fe        fd13 	bl	0x2f398
@   0x08030972: 4650        mov	r0, sl
@   0x08030974: 2800        cmp	r0, #0
@   0x08030976: d103        bne.n	0x30980
@   0x08030978: 1c30        adds	r0, r6, #0
@   0x0803097a: f7ff        f871 	bl	0x2fa60
@   0x0803097e: e007        b.n	0x30990
@   0x08030980: 2080        movs	r0, #128	@ 0x80
@   0x08030982: 0140        lsls	r0, r0, #5
@   0x08030984: 82a0        strh	r0, [r4, #20]
@   0x08030986: 6bb8        ldr	r0, [r7, #56]	@ 0x38
@   0x08030988: 2141        movs	r1, #65	@ 0x41
@   0x0803098a: 4249        negs	r1, r1
@   0x0803098c: 4008        ands	r0, r1
@   0x0803098e: 63b8        str	r0, [r7, #56]	@ 0x38
@   0x08030990: bc38        pop	{r3, r4, r5}
@   0x08030992: 4698        mov	r8, r3
@   0x08030994: 46a1        mov	r9, r4
@   0x08030996: 46aa        mov	sl, r5
@   0x08030998: bcf0        pop	{r4, r5, r6, r7}
@   0x0803099a: bc01        pop	{r0}
@   0x0803099c: 4700        bx	r0

        thumb_func_start sub_080308B0
sub_080308B0: @ 0x080308b0
        .incbin "frog_us_baserom.gba", 0x308b0, 0xf0
        thumb_func_end sub_080308B0
