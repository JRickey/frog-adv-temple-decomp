@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d890, 0x0802d8f8)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d890 --end 0x802d8f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d890: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d892: 4647        mov	r7, r8
@   0x0802d894: b480        push	{r7}
@   0x0802d896: 0400        lsls	r0, r0, #16
@   0x0802d898: 0c06        lsrs	r6, r0, #16
@   0x0802d89a: 0409        lsls	r1, r1, #16
@   0x0802d89c: 0c0f        lsrs	r7, r1, #16
@   0x0802d89e: 0412        lsls	r2, r2, #16
@   0x0802d8a0: 0c12        lsrs	r2, r2, #16
@   0x0802d8a2: 4690        mov	r8, r2
@   0x0802d8a4: 4c13        ldr	r4, [pc, #76]	@ (0x2d8f4)
@   0x0802d8a6: 6820        ldr	r0, [r4, #0]
@   0x0802d8a8: 30bb        adds	r0, #187	@ 0xbb
@   0x0802d8aa: 7801        ldrb	r1, [r0, #0]
@   0x0802d8ac: 3101        adds	r1, #1
@   0x0802d8ae: 7001        strb	r1, [r0, #0]
@   0x0802d8b0: 25ff        movs	r5, #255	@ 0xff
@   0x0802d8b2: 0609        lsls	r1, r1, #24
@   0x0802d8b4: 0e09        lsrs	r1, r1, #24
@   0x0802d8b6: 2901        cmp	r1, #1
@   0x0802d8b8: d101        bne.n	0x2d8be
@   0x0802d8ba: f008        fa67 	bl	0x35d8c
@   0x0802d8be: 6821        ldr	r1, [r4, #0]
@   0x0802d8c0: 2284        movs	r2, #132	@ 0x84
@   0x0802d8c2: 0052        lsls	r2, r2, #1
@   0x0802d8c4: 1888        adds	r0, r1, r2
@   0x0802d8c6: 8006        strh	r6, [r0, #0]
@   0x0802d8c8: 3202        adds	r2, #2
@   0x0802d8ca: 1888        adds	r0, r1, r2
@   0x0802d8cc: 8007        strh	r7, [r0, #0]
@   0x0802d8ce: 3202        adds	r2, #2
@   0x0802d8d0: 1888        adds	r0, r1, r2
@   0x0802d8d2: 4642        mov	r2, r8
@   0x0802d8d4: 8002        strh	r2, [r0, #0]
@   0x0802d8d6: 31bb        adds	r1, #187	@ 0xbb
@   0x0802d8d8: 7808        ldrb	r0, [r1, #0]
@   0x0802d8da: 3801        subs	r0, #1
@   0x0802d8dc: 7008        strb	r0, [r1, #0]
@   0x0802d8de: 4028        ands	r0, r5
@   0x0802d8e0: 2800        cmp	r0, #0
@   0x0802d8e2: d101        bne.n	0x2d8e8
@   0x0802d8e4: f008        fa56 	bl	0x35d94
@   0x0802d8e8: bc08        pop	{r3}
@   0x0802d8ea: 4698        mov	r8, r3
@   0x0802d8ec: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d8ee: bc01        pop	{r0}
@   0x0802d8f0: 4700        bx	r0
@   0x0802d8f2: 0000        movs	r0, r0
@   0x0802d8f4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d8f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802D890
sub_0802D890: @ 0x0802d890
        .incbin "frog_us_baserom.gba", 0x2d890, 0x68
        thumb_func_end sub_0802D890
