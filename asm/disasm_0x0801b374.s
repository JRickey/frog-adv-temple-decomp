@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b374, 0x0801b430)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b374 --end 0x801b430 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b374: b510        push	{r4, lr}
@   0x0801b376: b081        sub	sp, #4
@   0x0801b378: 0600        lsls	r0, r0, #24
@   0x0801b37a: 4b1e        ldr	r3, [pc, #120]	@ (0x1b3f4)
@   0x0801b37c: 491e        ldr	r1, [pc, #120]	@ (0x1b3f8)
@   0x0801b37e: 680a        ldr	r2, [r1, #0]
@   0x0801b380: 0051        lsls	r1, r2, #1
@   0x0801b382: 1889        adds	r1, r1, r2
@   0x0801b384: 00c9        lsls	r1, r1, #3
@   0x0801b386: 3304        adds	r3, #4
@   0x0801b388: 18c9        adds	r1, r1, r3
@   0x0801b38a: 680b        ldr	r3, [r1, #0]
@   0x0801b38c: 466a        mov	r2, sp
@   0x0801b38e: 2100        movs	r1, #0
@   0x0801b390: 8011        strh	r1, [r2, #0]
@   0x0801b392: 491a        ldr	r1, [pc, #104]	@ (0x1b3fc)
@   0x0801b394: 600a        str	r2, [r1, #0]
@   0x0801b396: 4a1a        ldr	r2, [pc, #104]	@ (0x1b400)
@   0x0801b398: 604a        str	r2, [r1, #4]
@   0x0801b39a: 4a1a        ldr	r2, [pc, #104]	@ (0x1b404)
@   0x0801b39c: 608a        str	r2, [r1, #8]
@   0x0801b39e: 688a        ldr	r2, [r1, #8]
@   0x0801b3a0: 600b        str	r3, [r1, #0]
@   0x0801b3a2: 4a19        ldr	r2, [pc, #100]	@ (0x1b408)
@   0x0801b3a4: 604a        str	r2, [r1, #4]
@   0x0801b3a6: 4a19        ldr	r2, [pc, #100]	@ (0x1b40c)
@   0x0801b3a8: 608a        str	r2, [r1, #8]
@   0x0801b3aa: 688a        ldr	r2, [r1, #8]
@   0x0801b3ac: 4c18        ldr	r4, [pc, #96]	@ (0x1b410)
@   0x0801b3ae: 0d80        lsrs	r0, r0, #22
@   0x0801b3b0: 301c        adds	r0, #28
@   0x0801b3b2: 1902        adds	r2, r0, r4
@   0x0801b3b4: 6812        ldr	r2, [r2, #0]
@   0x0801b3b6: 600a        str	r2, [r1, #0]
@   0x0801b3b8: 4a16        ldr	r2, [pc, #88]	@ (0x1b414)
@   0x0801b3ba: 604a        str	r2, [r1, #4]
@   0x0801b3bc: 4b16        ldr	r3, [pc, #88]	@ (0x1b418)
@   0x0801b3be: 608b        str	r3, [r1, #8]
@   0x0801b3c0: 688a        ldr	r2, [r1, #8]
@   0x0801b3c2: 6822        ldr	r2, [r4, #0]
@   0x0801b3c4: 600a        str	r2, [r1, #0]
@   0x0801b3c6: 4a15        ldr	r2, [pc, #84]	@ (0x1b41c)
@   0x0801b3c8: 604a        str	r2, [r1, #4]
@   0x0801b3ca: 608b        str	r3, [r1, #8]
@   0x0801b3cc: 688a        ldr	r2, [r1, #8]
@   0x0801b3ce: 4b14        ldr	r3, [pc, #80]	@ (0x1b420)
@   0x0801b3d0: 681a        ldr	r2, [r3, #0]
@   0x0801b3d2: 600a        str	r2, [r1, #0]
@   0x0801b3d4: 4a13        ldr	r2, [pc, #76]	@ (0x1b424)
@   0x0801b3d6: 604a        str	r2, [r1, #4]
@   0x0801b3d8: 4a13        ldr	r2, [pc, #76]	@ (0x1b428)
@   0x0801b3da: 608a        str	r2, [r1, #8]
@   0x0801b3dc: 688c        ldr	r4, [r1, #8]
@   0x0801b3de: 18c0        adds	r0, r0, r3
@   0x0801b3e0: 6800        ldr	r0, [r0, #0]
@   0x0801b3e2: 6008        str	r0, [r1, #0]
@   0x0801b3e4: 4811        ldr	r0, [pc, #68]	@ (0x1b42c)
@   0x0801b3e6: 6048        str	r0, [r1, #4]
@   0x0801b3e8: 608a        str	r2, [r1, #8]
@   0x0801b3ea: 6888        ldr	r0, [r1, #8]
@   0x0801b3ec: b001        add	sp, #4
@   0x0801b3ee: bc10        pop	{r4}
@   0x0801b3f0: bc01        pop	{r0}
@   0x0801b3f2: 4700        bx	r0
@   0x0801b3f4: 1254        asrs	r4, r2, #9
@   0x0801b3f6: 080c        lsrs	r4, r1, #32
@   0x0801b3f8: 34b0        adds	r4, #176	@ 0xb0
@   0x0801b3fa: 0300        lsls	r0, r0, #12
@   0x0801b3fc: 00d4        lsls	r4, r2, #3
@   0x0801b3fe: 0400        lsls	r0, r0, #16
@   0x0801b400: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801b404: 0400        lsls	r0, r0, #16
@   0x0801b406: 8100        strh	r0, [r0, #8]
@   0x0801b408: 8000        strh	r0, [r0, #0]
@   0x0801b40a: 0600        lsls	r0, r0, #24
@   0x0801b40c: 2000        movs	r0, #0
@   0x0801b40e: 8000        strh	r0, [r0, #0]
@   0x0801b410: 8f08        ldrh	r0, [r1, #56]	@ 0x38
@   0x0801b412: 0830        lsrs	r0, r6, #32
@   0x0801b414: 8020        strh	r0, [r4, #0]
@   0x0801b416: 0600        lsls	r0, r0, #24
@   0x0801b418: 0100        lsls	r0, r0, #4
@   0x0801b41a: 8000        strh	r0, [r0, #0]
@   0x0801b41c: 8220        strh	r0, [r4, #16]
@   0x0801b41e: 0600        lsls	r0, r0, #24
@   0x0801b420: 8f3c        ldrh	r4, [r7, #56]	@ 0x38
@   0x0801b422: 0830        lsrs	r0, r6, #32
@   0x0801b424: 01a0        lsls	r0, r4, #6
@   0x0801b426: 0500        lsls	r0, r0, #20
@   0x0801b428: 0010        movs	r0, r2
@   0x0801b42a: 8000        strh	r0, [r0, #0]
@   0x0801b42c: 01e0        lsls	r0, r4, #7
@   0x0801b42e: 0500        lsls	r0, r0, #20

        thumb_func_start sub_0801B374
sub_0801B374: @ 0x0801b374
        .incbin "frog_us_baserom.gba", 0x1b374, 0xbc
        thumb_func_end sub_0801B374
