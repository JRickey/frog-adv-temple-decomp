@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803578c, 0x080357ec)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803578c --end 0x80357ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803578c: b530        push	{r4, r5, lr}
@   0x0803578e: 1c05        adds	r5, r0, #0
@   0x08035790: 1c2c        adds	r4, r5, #0
@   0x08035792: 1c0b        adds	r3, r1, #0
@   0x08035794: 2a0f        cmp	r2, #15
@   0x08035796: d919        bls.n	0x357cc
@   0x08035798: 1c18        adds	r0, r3, #0
@   0x0803579a: 4328        orrs	r0, r5
@   0x0803579c: 2103        movs	r1, #3
@   0x0803579e: 4008        ands	r0, r1
@   0x080357a0: 2800        cmp	r0, #0
@   0x080357a2: d113        bne.n	0x357cc
@   0x080357a4: 1c29        adds	r1, r5, #0
@   0x080357a6: cb01        ldmia	r3!, {r0}
@   0x080357a8: c101        stmia	r1!, {r0}
@   0x080357aa: cb01        ldmia	r3!, {r0}
@   0x080357ac: c101        stmia	r1!, {r0}
@   0x080357ae: cb01        ldmia	r3!, {r0}
@   0x080357b0: c101        stmia	r1!, {r0}
@   0x080357b2: cb01        ldmia	r3!, {r0}
@   0x080357b4: c101        stmia	r1!, {r0}
@   0x080357b6: 3a10        subs	r2, #16
@   0x080357b8: 2a0f        cmp	r2, #15
@   0x080357ba: d8f4        bhi.n	0x357a6
@   0x080357bc: 2a03        cmp	r2, #3
@   0x080357be: d904        bls.n	0x357ca
@   0x080357c0: cb01        ldmia	r3!, {r0}
@   0x080357c2: c101        stmia	r1!, {r0}
@   0x080357c4: 3a04        subs	r2, #4
@   0x080357c6: 2a03        cmp	r2, #3
@   0x080357c8: d8fa        bhi.n	0x357c0
@   0x080357ca: 1c0c        adds	r4, r1, #0
@   0x080357cc: 3a01        subs	r2, #1
@   0x080357ce: 2001        movs	r0, #1
@   0x080357d0: 4240        negs	r0, r0
@   0x080357d2: 4282        cmp	r2, r0
@   0x080357d4: d007        beq.n	0x357e6
@   0x080357d6: 1c01        adds	r1, r0, #0
@   0x080357d8: 7818        ldrb	r0, [r3, #0]
@   0x080357da: 7020        strb	r0, [r4, #0]
@   0x080357dc: 3301        adds	r3, #1
@   0x080357de: 3401        adds	r4, #1
@   0x080357e0: 3a01        subs	r2, #1
@   0x080357e2: 428a        cmp	r2, r1
@   0x080357e4: d1f8        bne.n	0x357d8
@   0x080357e6: 1c28        adds	r0, r5, #0
@   0x080357e8: bd30        pop	{r4, r5, pc}

        thumb_func_start sub_0803578C
sub_0803578C: @ 0x0803578c
        .incbin "frog_us_baserom.gba", 0x3578c, 0x60
        thumb_func_end sub_0803578C
