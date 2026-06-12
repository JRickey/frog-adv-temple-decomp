@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025508, 0x08025578)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025508 --end 0x8025578 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025508: b510        push	{r4, lr}
@   0x0802550a: b081        sub	sp, #4
@   0x0802550c: 2400        movs	r4, #0
@   0x0802550e: 00e0        lsls	r0, r4, #3
@   0x08025510: 1b00        subs	r0, r0, r4
@   0x08025512: 00c0        lsls	r0, r0, #3
@   0x08025514: 4904        ldr	r1, [pc, #16]	@ (0x25528)
@   0x08025516: 1840        adds	r0, r0, r1
@   0x08025518: 7ec1        ldrb	r1, [r0, #27]
@   0x0802551a: 2909        cmp	r1, #9
@   0x0802551c: d011        beq.n	0x25542
@   0x0802551e: 2909        cmp	r1, #9
@   0x08025520: dc04        bgt.n	0x2552c
@   0x08025522: 2906        cmp	r1, #6
@   0x08025524: d007        beq.n	0x25536
@   0x08025526: e011        b.n	0x2554c
@   0x08025528: 4cc8        ldr	r4, [pc, #800]	@ (0x2584c)
@   0x0802552a: 0300        lsls	r0, r0, #12
@   0x0802552c: 2911        cmp	r1, #17
@   0x0802552e: d002        beq.n	0x25536
@   0x08025530: 2914        cmp	r1, #20
@   0x08025532: d006        beq.n	0x25542
@   0x08025534: e00a        b.n	0x2554c
@   0x08025536: 2108        movs	r1, #8
@   0x08025538: 2202        movs	r2, #2
@   0x0802553a: 2302        movs	r3, #2
@   0x0802553c: f7fb        fc6a 	bl	0x20e14
@   0x08025540: e004        b.n	0x2554c
@   0x08025542: 2109        movs	r1, #9
@   0x08025544: 2202        movs	r2, #2
@   0x08025546: 2302        movs	r3, #2
@   0x08025548: f7fb        fc64 	bl	0x20e14
@   0x0802554c: 1c60        adds	r0, r4, #1
@   0x0802554e: 0600        lsls	r0, r0, #24
@   0x08025550: 0e04        lsrs	r4, r0, #24
@   0x08025552: 2c02        cmp	r4, #2
@   0x08025554: d9db        bls.n	0x2550e
@   0x08025556: 4906        ldr	r1, [pc, #24]	@ (0x25570)
@   0x08025558: 4b06        ldr	r3, [pc, #24]	@ (0x25574)
@   0x0802555a: 2000        movs	r0, #0
@   0x0802555c: 9000        str	r0, [sp, #0]
@   0x0802555e: 2063        movs	r0, #99	@ 0x63
@   0x08025560: 2228        movs	r2, #40	@ 0x28
@   0x08025562: f7fb        ffd5 	bl	0x21510
@   0x08025566: b001        add	sp, #4
@   0x08025568: bc10        pop	{r4}
@   0x0802556a: bc01        pop	{r0}
@   0x0802556c: 4700        bx	r0
@   0x0802556e: 0000        movs	r0, r0
@   0x08025570: 33b0        adds	r3, #176	@ 0xb0
@   0x08025572: 0831        lsrs	r1, r6, #32
@   0x08025574: 6110        str	r0, [r2, #16]
@   0x08025576: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025508
sub_08025508: @ 0x08025508
        .incbin "baserom.gba", 0x25508, 0x70
        thumb_func_end sub_08025508
