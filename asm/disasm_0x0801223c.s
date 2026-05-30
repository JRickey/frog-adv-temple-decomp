@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801223c, 0x080122e4)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801223c --end 0x80122e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801223c: b570        push	{r4, r5, r6, lr}
@   0x0801223e: 9804        ldr	r0, [sp, #16]
@   0x08012240: 0600        lsls	r0, r0, #24
@   0x08012242: 0e01        lsrs	r1, r0, #24
@   0x08012244: 4822        ldr	r0, [pc, #136]	@ (0x122d0)
@   0x08012246: 1c02        adds	r2, r0, #0
@   0x08012248: 32ff        adds	r2, #255	@ 0xff
@   0x0801224a: 7810        ldrb	r0, [r2, #0]
@   0x0801224c: 4d21        ldr	r5, [pc, #132]	@ (0x122d4)
@   0x0801224e: 4c22        ldr	r4, [pc, #136]	@ (0x122d8)
@   0x08012250: 4b22        ldr	r3, [pc, #136]	@ (0x122dc)
@   0x08012252: 4e23        ldr	r6, [pc, #140]	@ (0x122e0)
@   0x08012254: 2800        cmp	r0, #0
@   0x08012256: d10b        bne.n	0x12270
@   0x08012258: 6068        str	r0, [r5, #4]
@   0x0801225a: 6060        str	r0, [r4, #4]
@   0x0801225c: 7b18        ldrb	r0, [r3, #12]
@   0x0801225e: 7328        strb	r0, [r5, #12]
@   0x08012260: 7b30        ldrb	r0, [r6, #12]
@   0x08012262: 7320        strb	r0, [r4, #12]
@   0x08012264: 2004        movs	r0, #4
@   0x08012266: 7028        strb	r0, [r5, #0]
@   0x08012268: 2001        movs	r0, #1
@   0x0801226a: 7020        strb	r0, [r4, #0]
@   0x0801226c: 81e9        strh	r1, [r5, #14]
@   0x0801226e: 7010        strb	r0, [r2, #0]
@   0x08012270: 1c2a        adds	r2, r5, #0
@   0x08012272: 6851        ldr	r1, [r2, #4]
@   0x08012274: 6858        ldr	r0, [r3, #4]
@   0x08012276: 4281        cmp	r1, r0
@   0x08012278: d104        bne.n	0x12284
@   0x0801227a: 2003        movs	r0, #3
@   0x0801227c: 7010        strb	r0, [r2, #0]
@   0x0801227e: 89d0        ldrh	r0, [r2, #14]
@   0x08012280: 3801        subs	r0, #1
@   0x08012282: 81d0        strh	r0, [r2, #14]
@   0x08012284: 6851        ldr	r1, [r2, #4]
@   0x08012286: 6958        ldr	r0, [r3, #20]
@   0x08012288: 4281        cmp	r1, r0
@   0x0801228a: d104        bne.n	0x12296
@   0x0801228c: 2004        movs	r0, #4
@   0x0801228e: 7010        strb	r0, [r2, #0]
@   0x08012290: 89d0        ldrh	r0, [r2, #14]
@   0x08012292: 3801        subs	r0, #1
@   0x08012294: 81d0        strh	r0, [r2, #14]
@   0x08012296: 1c23        adds	r3, r4, #0
@   0x08012298: 6859        ldr	r1, [r3, #4]
@   0x0801229a: 6870        ldr	r0, [r6, #4]
@   0x0801229c: 4281        cmp	r1, r0
@   0x0801229e: d104        bne.n	0x122aa
@   0x080122a0: 2001        movs	r0, #1
@   0x080122a2: 7018        strb	r0, [r3, #0]
@   0x080122a4: 89d0        ldrh	r0, [r2, #14]
@   0x080122a6: 3801        subs	r0, #1
@   0x080122a8: 81d0        strh	r0, [r2, #14]
@   0x080122aa: 6861        ldr	r1, [r4, #4]
@   0x080122ac: 6970        ldr	r0, [r6, #20]
@   0x080122ae: 4281        cmp	r1, r0
@   0x080122b0: d104        bne.n	0x122bc
@   0x080122b2: 2002        movs	r0, #2
@   0x080122b4: 7020        strb	r0, [r4, #0]
@   0x080122b6: 89d0        ldrh	r0, [r2, #14]
@   0x080122b8: 3801        subs	r0, #1
@   0x080122ba: 81d0        strh	r0, [r2, #14]
@   0x080122bc: 210e        movs	r1, #14
@   0x080122be: 5e68        ldrsh	r0, [r5, r1]
@   0x080122c0: 2800        cmp	r0, #0
@   0x080122c2: dc01        bgt.n	0x122c8
@   0x080122c4: 2000        movs	r0, #0
@   0x080122c6: 81e8        strh	r0, [r5, #14]
@   0x080122c8: bc70        pop	{r4, r5, r6}
@   0x080122ca: bc01        pop	{r0}
@   0x080122cc: 4700        bx	r0
@   0x080122ce: 0000        movs	r0, r0
@   0x080122d0: 53a0        strh	r0, [r4, r6]
@   0x080122d2: 0300        lsls	r0, r0, #12
@   0x080122d4: 5360        strh	r0, [r4, r5]
@   0x080122d6: 0300        lsls	r0, r0, #12
@   0x080122d8: 6150        str	r0, [r2, #20]
@   0x080122da: 0300        lsls	r0, r0, #12
@   0x080122dc: 6e08        ldr	r0, [r1, #96]	@ 0x60
@   0x080122de: 0830        lsrs	r0, r6, #32
@   0x080122e0: 6e28        ldr	r0, [r5, #96]	@ 0x60
@   0x080122e2: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_0801223C
sub_0801223C: @ 0x0801223c
        .incbin "frog_us_baserom.gba", 0x1223c, 0xa8
        thumb_func_end sub_0801223C
