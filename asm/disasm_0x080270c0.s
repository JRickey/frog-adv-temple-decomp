@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080270c0, 0x08027138)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80270c0 --end 0x8027138 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080270c0: b510        push	{r4, lr}
@   0x080270c2: b081        sub	sp, #4
@   0x080270c4: 2400        movs	r4, #0
@   0x080270c6: 00e0        lsls	r0, r4, #3
@   0x080270c8: 1b00        subs	r0, r0, r4
@   0x080270ca: 00c0        lsls	r0, r0, #3
@   0x080270cc: 4905        ldr	r1, [pc, #20]	@ (0x270e4)
@   0x080270ce: 1840        adds	r0, r0, r1
@   0x080270d0: 7e81        ldrb	r1, [r0, #26]
@   0x080270d2: 2900        cmp	r1, #0
@   0x080270d4: d108        bne.n	0x270e8
@   0x080270d6: 7ec1        ldrb	r1, [r0, #27]
@   0x080270d8: 2901        cmp	r1, #1
@   0x080270da: d00a        beq.n	0x270f2
@   0x080270dc: 2907        cmp	r1, #7
@   0x080270de: d115        bne.n	0x2710c
@   0x080270e0: 2107        movs	r1, #7
@   0x080270e2: e007        b.n	0x270f4
@   0x080270e4: 4718        bx	r3
@   0x080270e6: 0300        lsls	r0, r0, #12
@   0x080270e8: 2901        cmp	r1, #1
@   0x080270ea: d10f        bne.n	0x2710c
@   0x080270ec: 7ec1        ldrb	r1, [r0, #27]
@   0x080270ee: 2903        cmp	r1, #3
@   0x080270f0: d105        bne.n	0x270fe
@   0x080270f2: 2102        movs	r1, #2
@   0x080270f4: 2202        movs	r2, #2
@   0x080270f6: 2302        movs	r3, #2
@   0x080270f8: f7f9        fe8c 	bl	0x20e14
@   0x080270fc: e006        b.n	0x2710c
@   0x080270fe: 2909        cmp	r1, #9
@   0x08027100: d104        bne.n	0x2710c
@   0x08027102: 2107        movs	r1, #7
@   0x08027104: 2202        movs	r2, #2
@   0x08027106: 2302        movs	r3, #2
@   0x08027108: f7f9        fe84 	bl	0x20e14
@   0x0802710c: 1c60        adds	r0, r4, #1
@   0x0802710e: 0600        lsls	r0, r0, #24
@   0x08027110: 0e04        lsrs	r4, r0, #24
@   0x08027112: 2c0b        cmp	r4, #11
@   0x08027114: d9d7        bls.n	0x270c6
@   0x08027116: 4906        ldr	r1, [pc, #24]	@ (0x27130)
@   0x08027118: 4b06        ldr	r3, [pc, #24]	@ (0x27134)
@   0x0802711a: 2000        movs	r0, #0
@   0x0802711c: 9000        str	r0, [sp, #0]
@   0x0802711e: 2049        movs	r0, #73	@ 0x49
@   0x08027120: 2211        movs	r2, #17
@   0x08027122: f7fa        f9f5 	bl	0x21510
@   0x08027126: b001        add	sp, #4
@   0x08027128: bc10        pop	{r4}
@   0x0802712a: bc01        pop	{r0}
@   0x0802712c: 4700        bx	r0
@   0x0802712e: 0000        movs	r0, r0
@   0x08027130: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x08027132: 0831        lsrs	r1, r6, #32
@   0x08027134: 6110        str	r0, [r2, #16]
@   0x08027136: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080270C0
sub_080270C0: @ 0x080270c0
        .incbin "baserom.gba", 0x270c0, 0x78
        thumb_func_end sub_080270C0
