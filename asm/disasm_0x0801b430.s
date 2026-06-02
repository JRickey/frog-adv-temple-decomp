@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b430, 0x0801b514)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b430 --end 0x801b514 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b430: b570        push	{r4, r5, r6, lr}
@   0x0801b432: 464e        mov	r6, r9
@   0x0801b434: 4645        mov	r5, r8
@   0x0801b436: b460        push	{r5, r6}
@   0x0801b438: 0600        lsls	r0, r0, #24
@   0x0801b43a: 4d27        ldr	r5, [pc, #156]	@ (0x1b4d8)
@   0x0801b43c: 4c27        ldr	r4, [pc, #156]	@ (0x1b4dc)
@   0x0801b43e: 4928        ldr	r1, [pc, #160]	@ (0x1b4e0)
@   0x0801b440: 4a28        ldr	r2, [pc, #160]	@ (0x1b4e4)
@   0x0801b442: 4690        mov	r8, r2
@   0x0801b444: 6812        ldr	r2, [r2, #0]
@   0x0801b446: 600a        str	r2, [r1, #0]
@   0x0801b448: 4b27        ldr	r3, [pc, #156]	@ (0x1b4e8)
@   0x0801b44a: 4699        mov	r9, r3
@   0x0801b44c: 604b        str	r3, [r1, #4]
@   0x0801b44e: 4e27        ldr	r6, [pc, #156]	@ (0x1b4ec)
@   0x0801b450: 608e        str	r6, [r1, #8]
@   0x0801b452: 688a        ldr	r2, [r1, #8]
@   0x0801b454: 600c        str	r4, [r1, #0]
@   0x0801b456: 4a26        ldr	r2, [pc, #152]	@ (0x1b4f0)
@   0x0801b458: 604a        str	r2, [r1, #4]
@   0x0801b45a: 4b26        ldr	r3, [pc, #152]	@ (0x1b4f4)
@   0x0801b45c: 608b        str	r3, [r1, #8]
@   0x0801b45e: 688a        ldr	r2, [r1, #8]
@   0x0801b460: 1c22        adds	r2, r4, #0
@   0x0801b462: 3208        adds	r2, #8
@   0x0801b464: 600a        str	r2, [r1, #0]
@   0x0801b466: 4a24        ldr	r2, [pc, #144]	@ (0x1b4f8)
@   0x0801b468: 604a        str	r2, [r1, #4]
@   0x0801b46a: 608b        str	r3, [r1, #8]
@   0x0801b46c: 688a        ldr	r2, [r1, #8]
@   0x0801b46e: 1c22        adds	r2, r4, #0
@   0x0801b470: 3210        adds	r2, #16
@   0x0801b472: 600a        str	r2, [r1, #0]
@   0x0801b474: 4a21        ldr	r2, [pc, #132]	@ (0x1b4fc)
@   0x0801b476: 604a        str	r2, [r1, #4]
@   0x0801b478: 608b        str	r3, [r1, #8]
@   0x0801b47a: 688a        ldr	r2, [r1, #8]
@   0x0801b47c: 3418        adds	r4, #24
@   0x0801b47e: 600c        str	r4, [r1, #0]
@   0x0801b480: 4a1f        ldr	r2, [pc, #124]	@ (0x1b500)
@   0x0801b482: 604a        str	r2, [r1, #4]
@   0x0801b484: 608b        str	r3, [r1, #8]
@   0x0801b486: 688a        ldr	r2, [r1, #8]
@   0x0801b488: 0d80        lsrs	r0, r0, #22
@   0x0801b48a: 301c        adds	r0, #28
@   0x0801b48c: 4440        add	r0, r8
@   0x0801b48e: 6800        ldr	r0, [r0, #0]
@   0x0801b490: 6008        str	r0, [r1, #0]
@   0x0801b492: 4648        mov	r0, r9
@   0x0801b494: 6048        str	r0, [r1, #4]
@   0x0801b496: 608e        str	r6, [r1, #8]
@   0x0801b498: 6888        ldr	r0, [r1, #8]
@   0x0801b49a: 600d        str	r5, [r1, #0]
@   0x0801b49c: 4819        ldr	r0, [pc, #100]	@ (0x1b504)
@   0x0801b49e: 6048        str	r0, [r1, #4]
@   0x0801b4a0: 608b        str	r3, [r1, #8]
@   0x0801b4a2: 6888        ldr	r0, [r1, #8]
@   0x0801b4a4: 1c28        adds	r0, r5, #0
@   0x0801b4a6: 3008        adds	r0, #8
@   0x0801b4a8: 6008        str	r0, [r1, #0]
@   0x0801b4aa: 4817        ldr	r0, [pc, #92]	@ (0x1b508)
@   0x0801b4ac: 6048        str	r0, [r1, #4]
@   0x0801b4ae: 608b        str	r3, [r1, #8]
@   0x0801b4b0: 6888        ldr	r0, [r1, #8]
@   0x0801b4b2: 1c28        adds	r0, r5, #0
@   0x0801b4b4: 3010        adds	r0, #16
@   0x0801b4b6: 6008        str	r0, [r1, #0]
@   0x0801b4b8: 4814        ldr	r0, [pc, #80]	@ (0x1b50c)
@   0x0801b4ba: 6048        str	r0, [r1, #4]
@   0x0801b4bc: 608b        str	r3, [r1, #8]
@   0x0801b4be: 6888        ldr	r0, [r1, #8]
@   0x0801b4c0: 3518        adds	r5, #24
@   0x0801b4c2: 600d        str	r5, [r1, #0]
@   0x0801b4c4: 4812        ldr	r0, [pc, #72]	@ (0x1b510)
@   0x0801b4c6: 6048        str	r0, [r1, #4]
@   0x0801b4c8: 608b        str	r3, [r1, #8]
@   0x0801b4ca: 6888        ldr	r0, [r1, #8]
@   0x0801b4cc: bc18        pop	{r3, r4}
@   0x0801b4ce: 4698        mov	r8, r3
@   0x0801b4d0: 46a1        mov	r9, r4
@   0x0801b4d2: bc70        pop	{r4, r5, r6}
@   0x0801b4d4: bc01        pop	{r0}
@   0x0801b4d6: 4700        bx	r0
@   0x0801b4d8: ab78        add	r3, sp, #480	@ 0x1e0
@   0x0801b4da: 081d        lsrs	r5, r3, #32
@   0x0801b4dc: ab58        add	r3, sp, #352	@ 0x160
@   0x0801b4de: 081d        lsrs	r5, r3, #32
@   0x0801b4e0: 00d4        lsls	r4, r2, #3
@   0x0801b4e2: 0400        lsls	r0, r0, #16
@   0x0801b4e4: 8f3c        ldrh	r4, [r7, #56]	@ 0x38
@   0x0801b4e6: 0830        lsrs	r0, r6, #32
@   0x0801b4e8: 01e0        lsls	r0, r4, #7
@   0x0801b4ea: 0500        lsls	r0, r0, #20
@   0x0801b4ec: 0010        movs	r0, r2
@   0x0801b4ee: 8000        strh	r0, [r0, #0]
@   0x0801b4f0: fbf4        0600 			@ <UNDEFINED> instruction: 0xfbf40600
@   0x0801b4f4: 0004        movs	r4, r0
@   0x0801b4f6: 8000        strh	r0, [r0, #0]
@   0x0801b4f8: fc34        0600 			@ <UNDEFINED> instruction: 0xfc340600
@   0x0801b4fc: fc74        0600 			@ <UNDEFINED> instruction: 0xfc740600
@   0x0801b500: fcb4        0600 			@ <UNDEFINED> instruction: 0xfcb40600
@   0x0801b504: f841        0600 	str.w	r0, [r1, <undefined>]
@   0x0801b508: f881        0600 	strb.w	r0, [r1, #1536]	@ 0x600
@   0x0801b50c: f8c1        0600 	str.w	r0, [r1, #1536]	@ 0x600
@   0x0801b510: f901        0600 	vst1.8	{d0-d2}, [r1], r0

        thumb_func_start sub_0801B430
sub_0801B430: @ 0x0801b430
        .incbin "frog_us_baserom.gba", 0x1b430, 0xe4
        thumb_func_end sub_0801B430
