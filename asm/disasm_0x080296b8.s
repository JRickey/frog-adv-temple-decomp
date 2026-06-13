@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080296b8, 0x08029710)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80296b8 --end 0x8029710 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080296b8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080296ba: b084        sub	sp, #16
@   0x080296bc: 2600        movs	r6, #0
@   0x080296be: 2705        movs	r7, #5
@   0x080296c0: 1c35        adds	r5, r6, #0
@   0x080296c2: 3532        adds	r5, #50	@ 0x32
@   0x080296c4: 4910        ldr	r1, [pc, #64]	@ (0x29708)
@   0x080296c6: 00b0        lsls	r0, r6, #2
@   0x080296c8: 1840        adds	r0, r0, r1
@   0x080296ca: 6804        ldr	r4, [r0, #0]
@   0x080296cc: 1c30        adds	r0, r6, #0
@   0x080296ce: 2105        movs	r1, #5
@   0x080296d0: f00a        fc44 	bl	0x33f5c
@   0x080296d4: 0600        lsls	r0, r0, #24
@   0x080296d6: 0980        lsrs	r0, r0, #6
@   0x080296d8: 490c        ldr	r1, [pc, #48]	@ (0x2970c)
@   0x080296da: 1840        adds	r0, r0, r1
@   0x080296dc: 0c00        lsrs	r0, r0, #16
@   0x080296de: 9000        str	r0, [sp, #0]
@   0x080296e0: 9701        str	r7, [sp, #4]
@   0x080296e2: 2003        movs	r0, #3
@   0x080296e4: 9002        str	r0, [sp, #8]
@   0x080296e6: 9003        str	r0, [sp, #12]
@   0x080296e8: 1c28        adds	r0, r5, #0
@   0x080296ea: 1c21        adds	r1, r4, #0
@   0x080296ec: 2210        movs	r2, #16
@   0x080296ee: 2347        movs	r3, #71	@ 0x47
@   0x080296f0: f7f7        fcd6 	bl	0x210a0
@   0x080296f4: 1c70        adds	r0, r6, #1
@   0x080296f6: 0600        lsls	r0, r0, #24
@   0x080296f8: 0e06        lsrs	r6, r0, #24
@   0x080296fa: 2e04        cmp	r6, #4
@   0x080296fc: d9e0        bls.n	0x296c0
@   0x080296fe: b004        add	sp, #16
@   0x08029700: bcf0        pop	{r4, r5, r6, r7}
@   0x08029702: bc01        pop	{r0}
@   0x08029704: 4700        bx	r0
@   0x08029706: 0000        movs	r0, r0
@   0x08029708: 7a4c        ldrb	r4, [r1, #9]
@   0x0802970a: 0831        lsrs	r1, r6, #32
@   0x0802970c: 0000        movs	r0, r0
@   0x0802970e: 0111        lsls	r1, r2, #4

        thumb_func_start sub_080296B8
sub_080296B8: @ 0x080296b8
        .incbin "baserom.gba", 0x296b8, 0x58
        thumb_func_end sub_080296B8
