@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803457c, 0x08034660)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803457c --end 0x8034660 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803457c: b510        push	{r4, lr}
@   0x0803457e: 1c04        adds	r4, r0, #0
@   0x08034580: 2000        movs	r0, #0
@   0x08034582: 6822        ldr	r2, [r4, #0]
@   0x08034584: 2a01        cmp	r2, #1
@   0x08034586: d800        bhi.n	0x3458a
@   0x08034588: 2001        movs	r0, #1
@   0x0803458a: 2800        cmp	r0, #0
@   0x0803458c: d106        bne.n	0x3459c
@   0x0803458e: 2000        movs	r0, #0
@   0x08034590: 680b        ldr	r3, [r1, #0]
@   0x08034592: 2b01        cmp	r3, #1
@   0x08034594: d800        bhi.n	0x34598
@   0x08034596: 2001        movs	r0, #1
@   0x08034598: 2800        cmp	r0, #0
@   0x0803459a: d001        beq.n	0x345a0
@   0x0803459c: 2001        movs	r0, #1
@   0x0803459e: e05e        b.n	0x3465e
@   0x080345a0: 2000        movs	r0, #0
@   0x080345a2: 2a04        cmp	r2, #4
@   0x080345a4: d100        bne.n	0x345a8
@   0x080345a6: 2001        movs	r0, #1
@   0x080345a8: 2800        cmp	r0, #0
@   0x080345aa: d009        beq.n	0x345c0
@   0x080345ac: 2000        movs	r0, #0
@   0x080345ae: 2b04        cmp	r3, #4
@   0x080345b0: d100        bne.n	0x345b4
@   0x080345b2: 2001        movs	r0, #1
@   0x080345b4: 2800        cmp	r0, #0
@   0x080345b6: d003        beq.n	0x345c0
@   0x080345b8: 6848        ldr	r0, [r1, #4]
@   0x080345ba: 6861        ldr	r1, [r4, #4]
@   0x080345bc: 1a40        subs	r0, r0, r1
@   0x080345be: e04e        b.n	0x3465e
@   0x080345c0: 2200        movs	r2, #0
@   0x080345c2: 6820        ldr	r0, [r4, #0]
@   0x080345c4: 2804        cmp	r0, #4
@   0x080345c6: d100        bne.n	0x345ca
@   0x080345c8: 2201        movs	r2, #1
@   0x080345ca: 2a00        cmp	r2, #0
@   0x080345cc: d124        bne.n	0x34618
@   0x080345ce: 2200        movs	r2, #0
@   0x080345d0: 2b04        cmp	r3, #4
@   0x080345d2: d100        bne.n	0x345d6
@   0x080345d4: 2201        movs	r2, #1
@   0x080345d6: 2a00        cmp	r2, #0
@   0x080345d8: d006        beq.n	0x345e8
@   0x080345da: 6848        ldr	r0, [r1, #4]
@   0x080345dc: 2101        movs	r1, #1
@   0x080345de: 4249        negs	r1, r1
@   0x080345e0: 2800        cmp	r0, #0
@   0x080345e2: d01e        beq.n	0x34622
@   0x080345e4: 2101        movs	r1, #1
@   0x080345e6: e01c        b.n	0x34622
@   0x080345e8: 2200        movs	r2, #0
@   0x080345ea: 2802        cmp	r0, #2
@   0x080345ec: d100        bne.n	0x345f0
@   0x080345ee: 2201        movs	r2, #1
@   0x080345f0: 2a00        cmp	r2, #0
@   0x080345f2: d005        beq.n	0x34600
@   0x080345f4: 2200        movs	r2, #0
@   0x080345f6: 2b02        cmp	r3, #2
@   0x080345f8: d100        bne.n	0x345fc
@   0x080345fa: 2201        movs	r2, #1
@   0x080345fc: 2a00        cmp	r2, #0
@   0x080345fe: d12d        bne.n	0x3465c
@   0x08034600: 2200        movs	r2, #0
@   0x08034602: 2802        cmp	r0, #2
@   0x08034604: d100        bne.n	0x34608
@   0x08034606: 2201        movs	r2, #1
@   0x08034608: 2a00        cmp	r2, #0
@   0x0803460a: d1e6        bne.n	0x345da
@   0x0803460c: 2000        movs	r0, #0
@   0x0803460e: 2b02        cmp	r3, #2
@   0x08034610: d100        bne.n	0x34614
@   0x08034612: 2001        movs	r0, #1
@   0x08034614: 2800        cmp	r0, #0
@   0x08034616: d006        beq.n	0x34626
@   0x08034618: 6860        ldr	r0, [r4, #4]
@   0x0803461a: 2101        movs	r1, #1
@   0x0803461c: 2800        cmp	r0, #0
@   0x0803461e: d000        beq.n	0x34622
@   0x08034620: 3902        subs	r1, #2
@   0x08034622: 1c08        adds	r0, r1, #0
@   0x08034624: e01b        b.n	0x3465e
@   0x08034626: 6863        ldr	r3, [r4, #4]
@   0x08034628: 6848        ldr	r0, [r1, #4]
@   0x0803462a: 4283        cmp	r3, r0
@   0x0803462c: d004        beq.n	0x34638
@   0x0803462e: 2001        movs	r0, #1
@   0x08034630: 2b00        cmp	r3, #0
@   0x08034632: d014        beq.n	0x3465e
@   0x08034634: 3802        subs	r0, #2
@   0x08034636: e012        b.n	0x3465e
@   0x08034638: 68a2        ldr	r2, [r4, #8]
@   0x0803463a: 6888        ldr	r0, [r1, #8]
@   0x0803463c: 4282        cmp	r2, r0
@   0x0803463e: dcf6        bgt.n	0x3462e
@   0x08034640: 4282        cmp	r2, r0
@   0x08034642: da05        bge.n	0x34650
@   0x08034644: 2001        movs	r0, #1
@   0x08034646: 4240        negs	r0, r0
@   0x08034648: 2b00        cmp	r3, #0
@   0x0803464a: d008        beq.n	0x3465e
@   0x0803464c: 2001        movs	r0, #1
@   0x0803464e: e006        b.n	0x3465e
@   0x08034650: 68e0        ldr	r0, [r4, #12]
@   0x08034652: 68c9        ldr	r1, [r1, #12]
@   0x08034654: 4288        cmp	r0, r1
@   0x08034656: d8ea        bhi.n	0x3462e
@   0x08034658: 4288        cmp	r0, r1
@   0x0803465a: d3f3        bcc.n	0x34644
@   0x0803465c: 2000        movs	r0, #0
@   0x0803465e: bd10        pop	{r4, pc}

        thumb_func_start sub_0803457C
sub_0803457C: @ 0x0803457c
        .incbin "frog_us_baserom.gba", 0x3457c, 0xe4
        thumb_func_end sub_0803457C
