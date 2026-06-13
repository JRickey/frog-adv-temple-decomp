@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080276b8, 0x080276f4)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80276b8 --end 0x80276f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080276b8: b530        push	{r4, r5, lr}
@   0x080276ba: b084        sub	sp, #16
@   0x080276bc: 2400        movs	r4, #0
@   0x080276be: 4d0d        ldr	r5, [pc, #52]	@ (0x276f4)
@   0x080276c0: 1c20        adds	r0, r4, #0
@   0x080276c2: 3068        adds	r0, #104	@ 0x68
@   0x080276c4: 00a1        lsls	r1, r4, #2
@   0x080276c6: 1949        adds	r1, r1, r5
@   0x080276c8: 6809        ldr	r1, [r1, #0]
@   0x080276ca: 4a0b        ldr	r2, [pc, #44]	@ (0x276f8)
@   0x080276cc: 9200        str	r2, [sp, #0]
@   0x080276ce: 220c        movs	r2, #12
@   0x080276d0: 9201        str	r2, [sp, #4]
@   0x080276d2: 2203        movs	r2, #3
@   0x080276d4: 9202        str	r2, [sp, #8]
@   0x080276d6: 2202        movs	r2, #2
@   0x080276d8: 9203        str	r2, [sp, #12]
@   0x080276da: 2210        movs	r2, #16
@   0x080276dc: 2337        movs	r3, #55	@ 0x37
@   0x080276de: f7f9        fcdf 	bl	0x210a0
@   0x080276e2: 1c60        adds	r0, r4, #1
@   0x080276e4: 0600        lsls	r0, r0, #24
@   0x080276e6: 0e04        lsrs	r4, r0, #24
@   0x080276e8: 2c02        cmp	r4, #2
@   0x080276ea: d9e9        bls.n	0x276c0
@   0x080276ec: b004        add	sp, #16
@   0x080276ee: bc30        pop	{r4, r5}
@   0x080276f0: bc01        pop	{r0}
@   0x080276f2: 4700        bx	r0

        thumb_func_start sub_080276B8
sub_080276B8: @ 0x080276b8
        .incbin "baserom.gba", 0x276b8, 0x3c
        thumb_func_end sub_080276B8
