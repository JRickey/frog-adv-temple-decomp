@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e1fc, 0x0801e270)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e1fc --end 0x801e270 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e1fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801e1fe: b081        sub	sp, #4
@   0x0801e200: 0600        lsls	r0, r0, #24
@   0x0801e202: 0e06        lsrs	r6, r0, #24
@   0x0801e204: 0609        lsls	r1, r1, #24
@   0x0801e206: 0b49        lsrs	r1, r1, #13
@   0x0801e208: 2080        movs	r0, #128	@ 0x80
@   0x0801e20a: 0480        lsls	r0, r0, #18
@   0x0801e20c: 180d        adds	r5, r1, r0
@   0x0801e20e: 4669        mov	r1, sp
@   0x0801e210: 2000        movs	r0, #0
@   0x0801e212: 8008        strh	r0, [r1, #0]
@   0x0801e214: 480f        ldr	r0, [pc, #60]	@ (0x1e254)
@   0x0801e216: 6001        str	r1, [r0, #0]
@   0x0801e218: 6045        str	r5, [r0, #4]
@   0x0801e21a: 490f        ldr	r1, [pc, #60]	@ (0x1e258)
@   0x0801e21c: 6081        str	r1, [r0, #8]
@   0x0801e21e: 6880        ldr	r0, [r0, #8]
@   0x0801e220: 2400        movs	r4, #0
@   0x0801e222: 4f0e        ldr	r7, [pc, #56]	@ (0x1e25c)
@   0x0801e224: 0130        lsls	r0, r6, #4
@   0x0801e226: 1900        adds	r0, r0, r4
@   0x0801e228: 0080        lsls	r0, r0, #2
@   0x0801e22a: 19c0        adds	r0, r0, r7
@   0x0801e22c: 6801        ldr	r1, [r0, #0]
@   0x0801e22e: 480c        ldr	r0, [pc, #48]	@ (0x1e260)
@   0x0801e230: 4281        cmp	r1, r0
@   0x0801e232: d017        beq.n	0x1e264
@   0x0801e234: 2900        cmp	r1, #0
@   0x0801e236: d015        beq.n	0x1e264
@   0x0801e238: 0663        lsls	r3, r4, #25
@   0x0801e23a: 0e1b        lsrs	r3, r3, #24
@   0x0801e23c: 1c08        adds	r0, r1, #0
@   0x0801e23e: 1c29        adds	r1, r5, #0
@   0x0801e240: 2200        movs	r2, #0
@   0x0801e242: f7ff        fcb7 	bl	0x1dbb4
@   0x0801e246: 1c60        adds	r0, r4, #1
@   0x0801e248: 0600        lsls	r0, r0, #24
@   0x0801e24a: 0e04        lsrs	r4, r0, #24
@   0x0801e24c: 2c0f        cmp	r4, #15
@   0x0801e24e: d9e9        bls.n	0x1e224
@   0x0801e250: 2001        movs	r0, #1
@   0x0801e252: e008        b.n	0x1e266
@   0x0801e254: 00d4        lsls	r4, r2, #3
@   0x0801e256: 0400        lsls	r0, r0, #16
@   0x0801e258: 0400        lsls	r0, r0, #16
@   0x0801e25a: 8100        strh	r0, [r0, #8]
@   0x0801e25c: 8808        ldrh	r0, [r1, #0]
@   0x0801e25e: 0830        lsrs	r0, r6, #32
@   0x0801e260: e2fc        b.n	0x1e85c
@   0x0801e262: 081b        lsrs	r3, r3, #32
@   0x0801e264: 2000        movs	r0, #0
@   0x0801e266: b001        add	sp, #4
@   0x0801e268: bcf0        pop	{r4, r5, r6, r7}
@   0x0801e26a: bc02        pop	{r1}
@   0x0801e26c: 4708        bx	r1

        thumb_func_start sub_0801E1FC
sub_0801E1FC: @ 0x0801e1fc
        .incbin "frog_us_baserom.gba", 0x1e1fc, 0x74
        thumb_func_end sub_0801E1FC
