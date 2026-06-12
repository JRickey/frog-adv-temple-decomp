@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026020, 0x08026090)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026020 --end 0x8026090 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026020: b510        push	{r4, lr}
@   0x08026022: b081        sub	sp, #4
@   0x08026024: 2400        movs	r4, #0
@   0x08026026: 00e0        lsls	r0, r4, #3
@   0x08026028: 1b00        subs	r0, r0, r4
@   0x0802602a: 00c0        lsls	r0, r0, #3
@   0x0802602c: 4904        ldr	r1, [pc, #16]	@ (0x26040)
@   0x0802602e: 1840        adds	r0, r0, r1
@   0x08026030: 7ec1        ldrb	r1, [r0, #27]
@   0x08026032: 2909        cmp	r1, #9
@   0x08026034: d011        beq.n	0x2605a
@   0x08026036: 2909        cmp	r1, #9
@   0x08026038: dc04        bgt.n	0x26044
@   0x0802603a: 2906        cmp	r1, #6
@   0x0802603c: d007        beq.n	0x2604e
@   0x0802603e: e011        b.n	0x26064
@   0x08026040: 48a0        ldr	r0, [pc, #640]	@ (0x262c4)
@   0x08026042: 0300        lsls	r0, r0, #12
@   0x08026044: 2911        cmp	r1, #17
@   0x08026046: d002        beq.n	0x2604e
@   0x08026048: 2914        cmp	r1, #20
@   0x0802604a: d006        beq.n	0x2605a
@   0x0802604c: e00a        b.n	0x26064
@   0x0802604e: 2108        movs	r1, #8
@   0x08026050: 2202        movs	r2, #2
@   0x08026052: 2302        movs	r3, #2
@   0x08026054: f7fa        fede 	bl	0x20e14
@   0x08026058: e004        b.n	0x26064
@   0x0802605a: 2109        movs	r1, #9
@   0x0802605c: 2202        movs	r2, #2
@   0x0802605e: 2302        movs	r3, #2
@   0x08026060: f7fa        fed8 	bl	0x20e14
@   0x08026064: 1c60        adds	r0, r4, #1
@   0x08026066: 0600        lsls	r0, r0, #24
@   0x08026068: 0e04        lsrs	r4, r0, #24
@   0x0802606a: 2c02        cmp	r4, #2
@   0x0802606c: d9db        bls.n	0x26026
@   0x0802606e: 4906        ldr	r1, [pc, #24]	@ (0x26088)
@   0x08026070: 4b06        ldr	r3, [pc, #24]	@ (0x2608c)
@   0x08026072: 2000        movs	r0, #0
@   0x08026074: 9000        str	r0, [sp, #0]
@   0x08026076: 2050        movs	r0, #80	@ 0x50
@   0x08026078: 2228        movs	r2, #40	@ 0x28
@   0x0802607a: f7fb        fa49 	bl	0x21510
@   0x0802607e: b001        add	sp, #4
@   0x08026080: bc10        pop	{r4}
@   0x08026082: bc01        pop	{r0}
@   0x08026084: 4700        bx	r0
@   0x08026086: 0000        movs	r0, r0
@   0x08026088: 4828        ldr	r0, [pc, #160]	@ (0x2612c)
@   0x0802608a: 0831        lsrs	r1, r6, #32
@   0x0802608c: 6110        str	r0, [r2, #16]
@   0x0802608e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08026020
sub_08026020: @ 0x08026020
        .incbin "baserom.gba", 0x26020, 0x70
        thumb_func_end sub_08026020
