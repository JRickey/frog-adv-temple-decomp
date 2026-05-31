@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e380, 0x0802e3f8)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e380 --end 0x802e3f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e380: 2900        cmp	r1, #0
@   0x0802e382: d005        beq.n	0x2e390
@   0x0802e384: 2200        movs	r2, #0
@   0x0802e386: 7002        strb	r2, [r0, #0]
@   0x0802e388: 3001        adds	r0, #1
@   0x0802e38a: 3901        subs	r1, #1
@   0x0802e38c: 2900        cmp	r1, #0
@   0x0802e38e: d1fa        bne.n	0x2e386
@   0x0802e390: 4770        bx	lr
@   0x0802e392: 0000        movs	r0, r0
@   0x0802e394: 1c03        adds	r3, r0, #0
@   0x0802e396: 2a00        cmp	r2, #0
@   0x0802e398: d006        beq.n	0x2e3a8
@   0x0802e39a: 7808        ldrb	r0, [r1, #0]
@   0x0802e39c: 7018        strb	r0, [r3, #0]
@   0x0802e39e: 3101        adds	r1, #1
@   0x0802e3a0: 3301        adds	r3, #1
@   0x0802e3a2: 3a01        subs	r2, #1
@   0x0802e3a4: 2a00        cmp	r2, #0
@   0x0802e3a6: d1f8        bne.n	0x2e39a
@   0x0802e3a8: 4770        bx	lr
@   0x0802e3aa: 0000        movs	r0, r0
@   0x0802e3ac: 4804        ldr	r0, [pc, #16]	@ (0x2e3c0)
@   0x0802e3ae: 6802        ldr	r2, [r0, #0]
@   0x0802e3b0: 6851        ldr	r1, [r2, #4]
@   0x0802e3b2: 4804        ldr	r0, [pc, #16]	@ (0x2e3c4)
@   0x0802e3b4: 4348        muls	r0, r1
@   0x0802e3b6: 6050        str	r0, [r2, #4]
@   0x0802e3b8: 02c0        lsls	r0, r0, #11
@   0x0802e3ba: 0c40        lsrs	r0, r0, #17
@   0x0802e3bc: 4770        bx	lr
@   0x0802e3be: 0000        movs	r0, r0
@   0x0802e3c0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e3c2: 0300        lsls	r0, r0, #12
@   0x0802e3c4: 1d63        adds	r3, r4, #5
@   0x0802e3c6: a835        add	r0, sp, #212	@ 0xd4
@   0x0802e3c8: b500        push	{lr}
@   0x0802e3ca: 0400        lsls	r0, r0, #16
@   0x0802e3cc: 0c03        lsrs	r3, r0, #16
@   0x0802e3ce: 4808        ldr	r0, [pc, #32]	@ (0x2e3f0)
@   0x0802e3d0: 6802        ldr	r2, [r0, #0]
@   0x0802e3d2: 6851        ldr	r1, [r2, #4]
@   0x0802e3d4: 4807        ldr	r0, [pc, #28]	@ (0x2e3f4)
@   0x0802e3d6: 4348        muls	r0, r1
@   0x0802e3d8: 6050        str	r0, [r2, #4]
@   0x0802e3da: 0280        lsls	r0, r0, #10
@   0x0802e3dc: 0c00        lsrs	r0, r0, #16
@   0x0802e3de: 4298        cmp	r0, r3
@   0x0802e3e0: d904        bls.n	0x2e3ec
@   0x0802e3e2: 1c19        adds	r1, r3, #0
@   0x0802e3e4: f005        fdba 	bl	0x33f5c
@   0x0802e3e8: 0400        lsls	r0, r0, #16
@   0x0802e3ea: 0c00        lsrs	r0, r0, #16
@   0x0802e3ec: bc02        pop	{r1}
@   0x0802e3ee: 4708        bx	r1
@   0x0802e3f0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e3f2: 0300        lsls	r0, r0, #12
@   0x0802e3f4: 1d63        adds	r3, r4, #5
@   0x0802e3f6: a835        add	r0, sp, #212	@ 0xd4

        thumb_func_start sub_0802E380
sub_0802E380: @ 0x0802e380
        .incbin "frog_us_baserom.gba", 0x2e380, 0x78
        thumb_func_end sub_0802E380
