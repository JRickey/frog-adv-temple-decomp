@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080339ac, 0x080339f0)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80339ac --end 0x80339f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080339ac: 490b        ldr	r1, [pc, #44]	@ (0x339dc)
@   0x080339ae: 6808        ldr	r0, [r1, #0]
@   0x080339b0: 2200        movs	r2, #0
@   0x080339b2: 8002        strh	r2, [r0, #0]
@   0x080339b4: 3002        adds	r0, #2
@   0x080339b6: 6008        str	r0, [r1, #0]
@   0x080339b8: 8002        strh	r2, [r0, #0]
@   0x080339ba: 3802        subs	r0, #2
@   0x080339bc: 6008        str	r0, [r1, #0]
@   0x080339be: 4b08        ldr	r3, [pc, #32]	@ (0x339e0)
@   0x080339c0: 801a        strh	r2, [r3, #0]
@   0x080339c2: 4a08        ldr	r2, [pc, #32]	@ (0x339e4)
@   0x080339c4: 4808        ldr	r0, [pc, #32]	@ (0x339e8)
@   0x080339c6: 7800        ldrb	r0, [r0, #0]
@   0x080339c8: 2108        movs	r1, #8
@   0x080339ca: 4081        lsls	r1, r0
@   0x080339cc: 8810        ldrh	r0, [r2, #0]
@   0x080339ce: 4388        bics	r0, r1
@   0x080339d0: 8010        strh	r0, [r2, #0]
@   0x080339d2: 4806        ldr	r0, [pc, #24]	@ (0x339ec)
@   0x080339d4: 8800        ldrh	r0, [r0, #0]
@   0x080339d6: 8018        strh	r0, [r3, #0]
@   0x080339d8: 4770        bx	lr
@   0x080339da: 0000        movs	r0, r0
@   0x080339dc: 3438        adds	r4, #56	@ 0x38
@   0x080339de: 0300        lsls	r0, r0, #12
@   0x080339e0: 0208        lsls	r0, r1, #8
@   0x080339e2: 0400        lsls	r0, r0, #16
@   0x080339e4: 0200        lsls	r0, r0, #8
@   0x080339e6: 0400        lsls	r0, r0, #16
@   0x080339e8: 3430        adds	r4, #48	@ 0x30
@   0x080339ea: 0300        lsls	r0, r0, #12
@   0x080339ec: 343c        adds	r4, #60	@ 0x3c
@   0x080339ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080339AC
sub_080339AC: @ 0x080339ac
        .incbin "baserom.gba", 0x339ac, 0x44
        thumb_func_end sub_080339AC
