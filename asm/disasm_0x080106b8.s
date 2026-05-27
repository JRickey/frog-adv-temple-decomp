@ Auto-emitted by tools/disasm/peel.py — sub_08010694 was decompiled
@ and removed from this file; sub_080106B8 remains as asm.
@ Range:  [0x080106B8, 0x08010740)  (136 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080106b8: 4a08        ldr	r2, [pc, #32]	@ (0x106dc)
@   0x080106ba: 7810        ldrb	r0, [r2, #0]
@   0x080106bc: 2800        cmp	r0, #0
@   0x080106be: d006        beq.n	0x106ce
@   0x080106c0: 3801        subs	r0, #1
@   0x080106c2: 7010        strb	r0, [r2, #0]
@   0x080106c4: 4806        ldr	r0, [pc, #24]	@ (0x106e0)
@   0x080106c6: 2100        movs	r1, #0
@   0x080106c8: 8001        strh	r1, [r0, #0]
@   0x080106ca: 4806        ldr	r0, [pc, #24]	@ (0x106e4)
@   0x080106cc: 7141        strb	r1, [r0, #5]
@   0x080106ce: 4806        ldr	r0, [pc, #24]	@ (0x106e8)
@   0x080106d0: 2110        movs	r1, #16
@   0x080106d2: 7813        ldrb	r3, [r2, #0]
@   0x080106d4: 1ac9        subs	r1, r1, r3
@   0x080106d6: 8001        strh	r1, [r0, #0]
@   0x080106d8: 7810        ldrb	r0, [r2, #0]
@   0x080106da: 4770        bx	lr
@   0x080106dc: 6538        str	r0, [r7, #80]	@ 0x50
@   0x080106de: 0300        lsls	r0, r0, #12
@   0x080106e0: 5398        strh	r0, [r3, r6]
@   0x080106e2: 0300        lsls	r0, r0, #12
@   0x080106e4: 3480        adds	r4, #128	@ 0x80
@   0x080106e6: 0300        lsls	r0, r0, #12
@   0x080106e8: 0054        lsls	r4, r2, #1
@   0x080106ea: 0400        lsls	r0, r0, #16

        thumb_func_start sub_080106B8
sub_080106B8: @ 0x080106B8
        .incbin "frog_us_baserom.gba", 0x106b8, 0x88
        thumb_func_end sub_080106B8
