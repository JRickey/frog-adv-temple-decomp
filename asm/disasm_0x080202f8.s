@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080202f8, 0x08020414)  (284 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80202f8 --end 0x8020414 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080202f8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080202fa: b083        sub	sp, #12
@   0x080202fc: 0600        lsls	r0, r0, #24
@   0x080202fe: 0e00        lsrs	r0, r0, #24
@   0x08020300: 1c02        adds	r2, r0, #0
@   0x08020302: 2801        cmp	r0, #1
@   0x08020304: d00b        beq.n	0x2031e
@   0x08020306: 2801        cmp	r0, #1
@   0x08020308: dc02        bgt.n	0x20310
@   0x0802030a: 2800        cmp	r0, #0
@   0x0802030c: d005        beq.n	0x2031a
@   0x0802030e: e00b        b.n	0x20328
@   0x08020310: 2a02        cmp	r2, #2
@   0x08020312: d006        beq.n	0x20322
@   0x08020314: 2a03        cmp	r2, #3
@   0x08020316: d006        beq.n	0x20326
@   0x08020318: e006        b.n	0x20328
@   0x0802031a: 2704        movs	r7, #4
@   0x0802031c: e004        b.n	0x20328
@   0x0802031e: 2708        movs	r7, #8
@   0x08020320: e002        b.n	0x20328
@   0x08020322: 270c        movs	r7, #12
@   0x08020324: e000        b.n	0x20328
@   0x08020326: 2710        movs	r7, #16
@   0x08020328: 26a0        movs	r6, #160	@ 0xa0
@   0x0802032a: 0076        lsls	r6, r6, #1
@   0x0802032c: 9600        str	r6, [sp, #0]
@   0x0802032e: 2504        movs	r5, #4
@   0x08020330: 9501        str	r5, [sp, #4]
@   0x08020332: 2402        movs	r4, #2
@   0x08020334: 9402        str	r4, [sp, #8]
@   0x08020336: 1c08        adds	r0, r1, #0
@   0x08020338: 2103        movs	r1, #3
@   0x0802033a: 2203        movs	r2, #3
@   0x0802033c: 1c3b        adds	r3, r7, #0
@   0x0802033e: f7fb        fd9d 	bl	0x1be7c
@   0x08020342: 480f        ldr	r0, [pc, #60]	@ (0x20380)
@   0x08020344: 7880        ldrb	r0, [r0, #2]
@   0x08020346: 9500        str	r5, [sp, #0]
@   0x08020348: 9401        str	r4, [sp, #4]
@   0x0802034a: 210c        movs	r1, #12
@   0x0802034c: 1c3a        adds	r2, r7, #0
@   0x0802034e: 1c33        adds	r3, r6, #0
@   0x08020350: f7fc        fde2 	bl	0x1cf18
@   0x08020354: 480b        ldr	r0, [pc, #44]	@ (0x20384)
@   0x08020356: 9600        str	r6, [sp, #0]
@   0x08020358: 9501        str	r5, [sp, #4]
@   0x0802035a: 9402        str	r4, [sp, #8]
@   0x0802035c: 2103        movs	r1, #3
@   0x0802035e: 2212        movs	r2, #18
@   0x08020360: 1c3b        adds	r3, r7, #0
@   0x08020362: f7fb        fd8b 	bl	0x1be7c
@   0x08020366: 9500        str	r5, [sp, #0]
@   0x08020368: 9401        str	r4, [sp, #4]
@   0x0802036a: 2000        movs	r0, #0
@   0x0802036c: 2117        movs	r1, #23
@   0x0802036e: 1c3a        adds	r2, r7, #0
@   0x08020370: 1c33        adds	r3, r6, #0
@   0x08020372: f7fc        fdd1 	bl	0x1cf18
@   0x08020376: b003        add	sp, #12
@   0x08020378: bcf0        pop	{r4, r5, r6, r7}
@   0x0802037a: bc01        pop	{r0}
@   0x0802037c: 4700        bx	r0
@   0x0802037e: 0000        movs	r0, r0
@   0x08020380: 34b4        adds	r4, #180	@ 0xb4
@   0x08020382: 0300        lsls	r0, r0, #12
@   0x08020384: e810        081b 			@ <UNDEFINED> instruction: 0xe810081b
@   0x08020388: b510        push	{r4, lr}
@   0x0802038a: 4910        ldr	r1, [pc, #64]	@ (0x203cc)
@   0x0802038c: 2200        movs	r2, #0
@   0x0802038e: 2080        movs	r0, #128	@ 0x80
@   0x08020390: 0180        lsls	r0, r0, #6
@   0x08020392: 8008        strh	r0, [r1, #0]
@   0x08020394: 70ca        strb	r2, [r1, #3]
@   0x08020396: 2008        movs	r0, #8
@   0x08020398: 7088        strb	r0, [r1, #2]
@   0x0802039a: 480d        ldr	r0, [pc, #52]	@ (0x203d0)
@   0x0802039c: 6088        str	r0, [r1, #8]
@   0x0802039e: f00d        fafd 	bl	0x2d99c
@   0x080203a2: 2100        movs	r1, #0
@   0x080203a4: 4b0b        ldr	r3, [pc, #44]	@ (0x203d4)
@   0x080203a6: 2201        movs	r2, #1
@   0x080203a8: 4252        negs	r2, r2
@   0x080203aa: 00c8        lsls	r0, r1, #3
@   0x080203ac: 18c0        adds	r0, r0, r3
@   0x080203ae: 6002        str	r2, [r0, #0]
@   0x080203b0: 1c48        adds	r0, r1, #1
@   0x080203b2: 0600        lsls	r0, r0, #24
@   0x080203b4: 0e01        lsrs	r1, r0, #24
@   0x080203b6: 290b        cmp	r1, #11
@   0x080203b8: d9f7        bls.n	0x203aa
@   0x080203ba: 4804        ldr	r0, [pc, #16]	@ (0x203cc)
@   0x080203bc: 4906        ldr	r1, [pc, #24]	@ (0x203d8)
@   0x080203be: f012        fc2b 	bl	0x32c18
@   0x080203c2: 21d0        movs	r1, #208	@ 0xd0
@   0x080203c4: 0189        lsls	r1, r1, #6
@   0x080203c6: 4288        cmp	r0, r1
@   0x080203c8: d908        bls.n	0x203dc
@   0x080203ca: e7fe        b.n	0x203ca
@   0x080203cc: 0000        movs	r0, r0
@   0x080203ce: 0300        lsls	r0, r0, #12
@   0x080203d0: 81c0        strh	r0, [r0, #14]
@   0x080203d2: 0831        lsrs	r1, r6, #32
@   0x080203d4: 3574        adds	r5, #116	@ 0x74
@   0x080203d6: 0300        lsls	r0, r0, #12
@   0x080203d8: 0010        movs	r0, r2
@   0x080203da: 0300        lsls	r0, r0, #12
@   0x080203dc: 4809        ldr	r0, [pc, #36]	@ (0x20404)
@   0x080203de: 490a        ldr	r1, [pc, #40]	@ (0x20408)
@   0x080203e0: 4c0a        ldr	r4, [pc, #40]	@ (0x2040c)
@   0x080203e2: 1c22        adds	r2, r4, #0
@   0x080203e4: f012        fd0e 	bl	0x32e04
@   0x080203e8: 4809        ldr	r0, [pc, #36]	@ (0x20410)
@   0x080203ea: 1c21        adds	r1, r4, #0
@   0x080203ec: f00d        f8fe 	bl	0x2d5ec
@   0x080203f0: 20f5        movs	r0, #245	@ 0xf5
@   0x080203f2: f00d        ffa7 	bl	0x2e344
@   0x080203f6: 20cd        movs	r0, #205	@ 0xcd
@   0x080203f8: f00d        ff98 	bl	0x2e32c
@   0x080203fc: bc10        pop	{r4}
@   0x080203fe: bc01        pop	{r0}
@   0x08020400: 4700        bx	r0
@   0x08020402: 0000        movs	r0, r0
@   0x08020404: 0010        movs	r0, r2
@   0x08020406: 0300        lsls	r0, r0, #12
@   0x08020408: 0030        movs	r0, r6
@   0x0802040a: 0300        lsls	r0, r0, #12
@   0x0802040c: 0020        movs	r0, r4
@   0x0802040e: 0300        lsls	r0, r0, #12
@   0x08020410: 0000        movs	r0, r0
@   0x08020412: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080202F8
sub_080202F8: @ 0x080202f8
        .incbin "frog_us_baserom.gba", 0x202f8, 0x11c
        thumb_func_end sub_080202F8
