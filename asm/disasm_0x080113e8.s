@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080113e8, 0x08011478)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80113e8 --end 0x8011478 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080113e8: b570        push	{r4, r5, r6, lr}
@   0x080113ea: b087        sub	sp, #28
@   0x080113ec: 2600        movs	r6, #0
@   0x080113ee: 2519        movs	r5, #25
@   0x080113f0: 2400        movs	r4, #0
@   0x080113f2: 2100        movs	r1, #0
@   0x080113f4: 2280        movs	r2, #128	@ 0x80
@   0x080113f6: 0152        lsls	r2, r2, #5
@   0x080113f8: 2c0c        cmp	r4, #12
@   0x080113fa: d101        bne.n	0x11400
@   0x080113fc: 4316        orrs	r6, r2
@   0x080113fe: e005        b.n	0x1140c
@   0x08011400: 1c08        adds	r0, r1, #0
@   0x08011402: 1c41        adds	r1, r0, #1
@   0x08011404: 0609        lsls	r1, r1, #24
@   0x08011406: 0e09        lsrs	r1, r1, #24
@   0x08011408: 4468        add	r0, sp
@   0x0801140a: 7004        strb	r4, [r0, #0]
@   0x0801140c: 1c60        adds	r0, r4, #1
@   0x0801140e: 0600        lsls	r0, r0, #24
@   0x08011410: 0e04        lsrs	r4, r0, #24
@   0x08011412: 2c18        cmp	r4, #24
@   0x08011414: d9f0        bls.n	0x113f8
@   0x08011416: 1e68        subs	r0, r5, #1
@   0x08011418: 0600        lsls	r0, r0, #24
@   0x0801141a: 0e05        lsrs	r5, r0, #24
@   0x0801141c: 2400        movs	r4, #0
@   0x0801141e: 4815        ldr	r0, [pc, #84]	@ (0x11474)
@   0x08011420: 8800        ldrh	r0, [r0, #0]
@   0x08011422: 0600        lsls	r0, r0, #24
@   0x08011424: 0e00        lsrs	r0, r0, #24
@   0x08011426: 216b        movs	r1, #107	@ 0x6b
@   0x08011428: 4348        muls	r0, r1
@   0x0801142a: 3007        adds	r0, #7
@   0x0801142c: 1c29        adds	r1, r5, #0
@   0x0801142e: f022        fcf1 	bl	0x33e14
@   0x08011432: 0600        lsls	r0, r0, #24
@   0x08011434: 0e03        lsrs	r3, r0, #24
@   0x08011436: 4668        mov	r0, sp
@   0x08011438: 18c1        adds	r1, r0, r3
@   0x0801143a: 1e68        subs	r0, r5, #1
@   0x0801143c: 0600        lsls	r0, r0, #24
@   0x0801143e: 0e05        lsrs	r5, r0, #24
@   0x08011440: 2001        movs	r0, #1
@   0x08011442: 7809        ldrb	r1, [r1, #0]
@   0x08011444: 4088        lsls	r0, r1
@   0x08011446: 4306        orrs	r6, r0
@   0x08011448: 3401        adds	r4, #1
@   0x0801144a: 42ab        cmp	r3, r5
@   0x0801144c: d209        bcs.n	0x11462
@   0x0801144e: 4668        mov	r0, sp
@   0x08011450: 18c2        adds	r2, r0, r3
@   0x08011452: 1c59        adds	r1, r3, #1
@   0x08011454: 1840        adds	r0, r0, r1
@   0x08011456: 7800        ldrb	r0, [r0, #0]
@   0x08011458: 7010        strb	r0, [r2, #0]
@   0x0801145a: 0609        lsls	r1, r1, #24
@   0x0801145c: 0e0b        lsrs	r3, r1, #24
@   0x0801145e: 42ab        cmp	r3, r5
@   0x08011460: d3f5        bcc.n	0x1144e
@   0x08011462: 0620        lsls	r0, r4, #24
@   0x08011464: 0e04        lsrs	r4, r0, #24
@   0x08011466: 2c03        cmp	r4, #3
@   0x08011468: d9d9        bls.n	0x1141e
@   0x0801146a: 1c30        adds	r0, r6, #0
@   0x0801146c: b007        add	sp, #28
@   0x0801146e: bc70        pop	{r4, r5, r6}
@   0x08011470: bc02        pop	{r1}
@   0x08011472: 4708        bx	r1
@   0x08011474: 0006        movs	r6, r0
@   0x08011476: 0400        lsls	r0, r0, #16

        thumb_func_start sub_080113E8
sub_080113E8: @ 0x080113e8
        .incbin "frog_us_baserom.gba", 0x113e8, 0x90
        thumb_func_end sub_080113E8
