@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e1ac, 0x0801e1fc)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e1ac --end 0x801e1fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e1ac: b530        push	{r4, r5, lr}
@   0x0801e1ae: 0600        lsls	r0, r0, #24
@   0x0801e1b0: 0e03        lsrs	r3, r0, #24
@   0x0801e1b2: 2201        movs	r2, #1
@   0x0801e1b4: 4c0e        ldr	r4, [pc, #56]	@ (0x1e1f0)
@   0x0801e1b6: 8e20        ldrh	r0, [r4, #48]	@ 0x30
@   0x0801e1b8: 2800        cmp	r0, #0
@   0x0801e1ba: d101        bne.n	0x1e1c0
@   0x0801e1bc: 2008        movs	r0, #8
@   0x0801e1be: 72e0        strb	r0, [r4, #11]
@   0x0801e1c0: 4d0c        ldr	r5, [pc, #48]	@ (0x1e1f4)
@   0x0801e1c2: 6828        ldr	r0, [r5, #0]
@   0x0801e1c4: 6861        ldr	r1, [r4, #4]
@   0x0801e1c6: 1a40        subs	r0, r0, r1
@   0x0801e1c8: 7ae1        ldrb	r1, [r4, #11]
@   0x0801e1ca: 4288        cmp	r0, r1
@   0x0801e1cc: d306        bcc.n	0x1e1dc
@   0x0801e1ce: 1c18        adds	r0, r3, #0
@   0x0801e1d0: f7ff        f9ce 	bl	0x1d570
@   0x0801e1d4: 0600        lsls	r0, r0, #24
@   0x0801e1d6: 0e02        lsrs	r2, r0, #24
@   0x0801e1d8: 6828        ldr	r0, [r5, #0]
@   0x0801e1da: 6060        str	r0, [r4, #4]
@   0x0801e1dc: 4806        ldr	r0, [pc, #24]	@ (0x1e1f8)
@   0x0801e1de: 8800        ldrh	r0, [r0, #0]
@   0x0801e1e0: 2820        cmp	r0, #32
@   0x0801e1e2: d100        bne.n	0x1e1e6
@   0x0801e1e4: 22fe        movs	r2, #254	@ 0xfe
@   0x0801e1e6: 1c10        adds	r0, r2, #0
@   0x0801e1e8: bc30        pop	{r4, r5}
@   0x0801e1ea: bc02        pop	{r1}
@   0x0801e1ec: 4708        bx	r1
@   0x0801e1ee: 0000        movs	r0, r0
@   0x0801e1f0: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801e1f2: 0300        lsls	r0, r0, #12
@   0x0801e1f4: 5330        strh	r0, [r6, r4]
@   0x0801e1f6: 0300        lsls	r0, r0, #12
@   0x0801e1f8: 5398        strh	r0, [r3, r6]
@   0x0801e1fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801E1AC
sub_0801E1AC: @ 0x0801e1ac
        .incbin "frog_us_baserom.gba", 0x1e1ac, 0x50
        thumb_func_end sub_0801E1AC
