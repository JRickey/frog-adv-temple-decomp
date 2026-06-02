@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b1b4, 0x0801b278)  (196 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b1b4 --end 0x801b278 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b1b4: b510        push	{r4, lr}
@   0x0801b1b6: 0600        lsls	r0, r0, #24
@   0x0801b1b8: 4911        ldr	r1, [pc, #68]	@ (0x1b200)
@   0x0801b1ba: 4c12        ldr	r4, [pc, #72]	@ (0x1b204)
@   0x0801b1bc: 0d80        lsrs	r0, r0, #22
@   0x0801b1be: 3004        adds	r0, #4
@   0x0801b1c0: 1902        adds	r2, r0, r4
@   0x0801b1c2: 6812        ldr	r2, [r2, #0]
@   0x0801b1c4: 600a        str	r2, [r1, #0]
@   0x0801b1c6: 4a10        ldr	r2, [pc, #64]	@ (0x1b208)
@   0x0801b1c8: 604a        str	r2, [r1, #4]
@   0x0801b1ca: 4b10        ldr	r3, [pc, #64]	@ (0x1b20c)
@   0x0801b1cc: 608b        str	r3, [r1, #8]
@   0x0801b1ce: 688a        ldr	r2, [r1, #8]
@   0x0801b1d0: 6822        ldr	r2, [r4, #0]
@   0x0801b1d2: 600a        str	r2, [r1, #0]
@   0x0801b1d4: 4a0e        ldr	r2, [pc, #56]	@ (0x1b210)
@   0x0801b1d6: 604a        str	r2, [r1, #4]
@   0x0801b1d8: 608b        str	r3, [r1, #8]
@   0x0801b1da: 688a        ldr	r2, [r1, #8]
@   0x0801b1dc: 4b0d        ldr	r3, [pc, #52]	@ (0x1b214)
@   0x0801b1de: 681a        ldr	r2, [r3, #0]
@   0x0801b1e0: 600a        str	r2, [r1, #0]
@   0x0801b1e2: 4a0d        ldr	r2, [pc, #52]	@ (0x1b218)
@   0x0801b1e4: 604a        str	r2, [r1, #4]
@   0x0801b1e6: 4a0d        ldr	r2, [pc, #52]	@ (0x1b21c)
@   0x0801b1e8: 608a        str	r2, [r1, #8]
@   0x0801b1ea: 688c        ldr	r4, [r1, #8]
@   0x0801b1ec: 18c0        adds	r0, r0, r3
@   0x0801b1ee: 6800        ldr	r0, [r0, #0]
@   0x0801b1f0: 6008        str	r0, [r1, #0]
@   0x0801b1f2: 480b        ldr	r0, [pc, #44]	@ (0x1b220)
@   0x0801b1f4: 6048        str	r0, [r1, #4]
@   0x0801b1f6: 608a        str	r2, [r1, #8]
@   0x0801b1f8: 6888        ldr	r0, [r1, #8]
@   0x0801b1fa: bc10        pop	{r4}
@   0x0801b1fc: bc01        pop	{r0}
@   0x0801b1fe: 4700        bx	r0
@   0x0801b200: 00d4        lsls	r4, r2, #3
@   0x0801b202: 0400        lsls	r0, r0, #16
@   0x0801b204: 8f08        ldrh	r0, [r1, #56]	@ 0x38
@   0x0801b206: 0830        lsrs	r0, r6, #32
@   0x0801b208: 8020        strh	r0, [r4, #0]
@   0x0801b20a: 0600        lsls	r0, r0, #24
@   0x0801b20c: 0100        lsls	r0, r0, #4
@   0x0801b20e: 8000        strh	r0, [r0, #0]
@   0x0801b210: 8220        strh	r0, [r4, #16]
@   0x0801b212: 0600        lsls	r0, r0, #24
@   0x0801b214: 8f3c        ldrh	r4, [r7, #56]	@ 0x38
@   0x0801b216: 0830        lsrs	r0, r6, #32
@   0x0801b218: 01a0        lsls	r0, r4, #6
@   0x0801b21a: 0500        lsls	r0, r0, #20
@   0x0801b21c: 0010        movs	r0, r2
@   0x0801b21e: 8000        strh	r0, [r0, #0]
@   0x0801b220: 01e0        lsls	r0, r4, #7
@   0x0801b222: 0500        lsls	r0, r0, #20
@   0x0801b224: b530        push	{r4, r5, lr}
@   0x0801b226: 0600        lsls	r0, r0, #24
@   0x0801b228: 0e03        lsrs	r3, r0, #24
@   0x0801b22a: 2201        movs	r2, #1
@   0x0801b22c: 4c0e        ldr	r4, [pc, #56]	@ (0x1b268)
@   0x0801b22e: 8e20        ldrh	r0, [r4, #48]	@ 0x30
@   0x0801b230: 2800        cmp	r0, #0
@   0x0801b232: d101        bne.n	0x1b238
@   0x0801b234: 2008        movs	r0, #8
@   0x0801b236: 72e0        strb	r0, [r4, #11]
@   0x0801b238: 4d0c        ldr	r5, [pc, #48]	@ (0x1b26c)
@   0x0801b23a: 6828        ldr	r0, [r5, #0]
@   0x0801b23c: 6861        ldr	r1, [r4, #4]
@   0x0801b23e: 1a40        subs	r0, r0, r1
@   0x0801b240: 7ae1        ldrb	r1, [r4, #11]
@   0x0801b242: 4288        cmp	r0, r1
@   0x0801b244: d306        bcc.n	0x1b254
@   0x0801b246: 1c18        adds	r0, r3, #0
@   0x0801b248: f7ff        fdae 	bl	0x1ada8
@   0x0801b24c: 0600        lsls	r0, r0, #24
@   0x0801b24e: 0e02        lsrs	r2, r0, #24
@   0x0801b250: 6828        ldr	r0, [r5, #0]
@   0x0801b252: 6060        str	r0, [r4, #4]
@   0x0801b254: 4806        ldr	r0, [pc, #24]	@ (0x1b270)
@   0x0801b256: 8800        ldrh	r0, [r0, #0]
@   0x0801b258: 2820        cmp	r0, #32
@   0x0801b25a: d100        bne.n	0x1b25e
@   0x0801b25c: 22fe        movs	r2, #254	@ 0xfe
@   0x0801b25e: 1c10        adds	r0, r2, #0
@   0x0801b260: bc30        pop	{r4, r5}
@   0x0801b262: bc02        pop	{r1}
@   0x0801b264: 4708        bx	r1
@   0x0801b266: 0000        movs	r0, r0
@   0x0801b268: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801b26a: 0300        lsls	r0, r0, #12
@   0x0801b26c: 5330        strh	r0, [r6, r4]
@   0x0801b26e: 0300        lsls	r0, r0, #12
@   0x0801b270: 5398        strh	r0, [r3, r6]
@   0x0801b272: 0300        lsls	r0, r0, #12
@   0x0801b274: 4770        bx	lr

        thumb_func_start sub_0801B1B4
sub_0801B1B4: @ 0x0801b1b4
        .incbin "frog_us_baserom.gba", 0x1b1b4, 0xc4
        thumb_func_end sub_0801B1B4
