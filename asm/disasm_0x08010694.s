@ Auto-emitted by tools/disasm/peel.py — manually split into two functions.
@ Range:  [0x08010694, 0x08010740)  (172 bytes, thumb mode)
@   sub_08010694 spans [0x08010694, 0x080106B8)  (36 bytes)
@   sub_080106B8 spans [0x080106B8, 0x08010740)  (136 bytes)
@ Boundary detector picked the larger range — split manually because both
@ are distinct functions (each ends in `bx lr`).

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08010694: 0400        lsls	r0, r0, #16
@   0x08010696: 0c00        lsrs	r0, r0, #16
@   0x08010698: 4a04        ldr	r2, [pc, #16]	@ (0x106ac)
@   0x0801069a: 2110        movs	r1, #16
@   0x0801069c: 7011        strb	r1, [r2, #0]
@   0x0801069e: 4a04        ldr	r2, [pc, #16]	@ (0x106b0)
@   0x080106a0: 2100        movs	r1, #0
@   0x080106a2: 8011        strh	r1, [r2, #0]
@   0x080106a4: 4903        ldr	r1, [pc, #12]	@ (0x106b4)
@   0x080106a6: 8008        strh	r0, [r1, #0]
@   0x080106a8: 4770        bx	lr
@   0x080106aa: 0000        movs	r0, r0
@   0x080106ac: 6538        str	r0, [r7, #80]	@ 0x50
@   0x080106ae: 0300        lsls	r0, r0, #12
@   0x080106b0: 0054        lsls	r4, r2, #1
@   0x080106b2: 0400        lsls	r0, r0, #16
@   0x080106b4: 0050        lsls	r0, r2, #1
@   0x080106b6: 0400        lsls	r0, r0, #16
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
@   0x080106ec: 0400        lsls	r0, r0, #16
@   0x080106ee: 0c00        lsrs	r0, r0, #16
@   0x080106f0: 4a04        ldr	r2, [pc, #16]	@ (0x10704)
@   0x080106f2: 2110        movs	r1, #16
@   0x080106f4: 7011        strb	r1, [r2, #0]
@   0x080106f6: 4a04        ldr	r2, [pc, #16]	@ (0x10708)
@   0x080106f8: 2110        movs	r1, #16
@   0x080106fa: 8011        strh	r1, [r2, #0]
@   0x080106fc: 4903        ldr	r1, [pc, #12]	@ (0x1070c)
@   0x080106fe: 8008        strh	r0, [r1, #0]
@   0x08010700: 4770        bx	lr
@   0x08010702: 0000        movs	r0, r0
@   0x08010704: 6538        str	r0, [r7, #80]	@ 0x50
@   0x08010706: 0300        lsls	r0, r0, #12
@   0x08010708: 0054        lsls	r4, r2, #1
@   0x0801070a: 0400        lsls	r0, r0, #16
@   0x0801070c: 0050        lsls	r0, r2, #1
@   0x0801070e: 0400        lsls	r0, r0, #16
@   0x08010710: 4a07        ldr	r2, [pc, #28]	@ (0x10730)
@   0x08010712: 7810        ldrb	r0, [r2, #0]
@   0x08010714: 2800        cmp	r0, #0
@   0x08010716: d006        beq.n	0x10726
@   0x08010718: 3801        subs	r0, #1
@   0x0801071a: 7010        strb	r0, [r2, #0]
@   0x0801071c: 4805        ldr	r0, [pc, #20]	@ (0x10734)
@   0x0801071e: 2100        movs	r1, #0
@   0x08010720: 8001        strh	r1, [r0, #0]
@   0x08010722: 4805        ldr	r0, [pc, #20]	@ (0x10738)
@   0x08010724: 7141        strb	r1, [r0, #5]
@   0x08010726: 4805        ldr	r0, [pc, #20]	@ (0x1073c)
@   0x08010728: 7811        ldrb	r1, [r2, #0]
@   0x0801072a: 8001        strh	r1, [r0, #0]
@   0x0801072c: 7810        ldrb	r0, [r2, #0]
@   0x0801072e: 4770        bx	lr
@   0x08010730: 6538        str	r0, [r7, #80]	@ 0x50
@   0x08010732: 0300        lsls	r0, r0, #12
@   0x08010734: 5398        strh	r0, [r3, r6]
@   0x08010736: 0300        lsls	r0, r0, #12
@   0x08010738: 3480        adds	r4, #128	@ 0x80
@   0x0801073a: 0300        lsls	r0, r0, #12
@   0x0801073c: 0054        lsls	r4, r2, #1
@   0x0801073e: 0400        lsls	r0, r0, #16

        thumb_func_start sub_08010694
sub_08010694: @ 0x08010694
        .incbin "frog_us_baserom.gba", 0x10694, 0x24
        thumb_func_end sub_08010694

        thumb_func_start sub_080106B8
sub_080106B8: @ 0x080106B8
        .incbin "frog_us_baserom.gba", 0x106b8, 0x88
        thumb_func_end sub_080106B8
