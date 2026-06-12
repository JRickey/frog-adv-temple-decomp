@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080125b0, 0x08012604)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80125b0 --end 0x8012604 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080125b0: b081        sub	sp, #4
@   0x080125b2: 4809        ldr	r0, [pc, #36]	@ (0x125d8)
@   0x080125b4: 2100        movs	r1, #0
@   0x080125b6: 2200        movs	r2, #0
@   0x080125b8: 86c2        strh	r2, [r0, #54]	@ 0x36
@   0x080125ba: 7001        strb	r1, [r0, #0]
@   0x080125bc: 7081        strb	r1, [r0, #2]
@   0x080125be: 4807        ldr	r0, [pc, #28]	@ (0x125dc)
@   0x080125c0: 7281        strb	r1, [r0, #10]
@   0x080125c2: 4668        mov	r0, sp
@   0x080125c4: 8002        strh	r2, [r0, #0]
@   0x080125c6: 4906        ldr	r1, [pc, #24]	@ (0x125e0)
@   0x080125c8: 6008        str	r0, [r1, #0]
@   0x080125ca: 4806        ldr	r0, [pc, #24]	@ (0x125e4)
@   0x080125cc: 6048        str	r0, [r1, #4]
@   0x080125ce: 4806        ldr	r0, [pc, #24]	@ (0x125e8)
@   0x080125d0: 6088        str	r0, [r1, #8]
@   0x080125d2: 6888        ldr	r0, [r1, #8]
@   0x080125d4: b001        add	sp, #4
@   0x080125d6: 4770        bx	lr
@   0x080125d8: 6480        str	r0, [r0, #72]	@ 0x48
@   0x080125da: 0300        lsls	r0, r0, #12
@   0x080125dc: 6540        str	r0, [r0, #84]	@ 0x54
@   0x080125de: 0300        lsls	r0, r0, #12
@   0x080125e0: 00d4        lsls	r4, r2, #3
@   0x080125e2: 0400        lsls	r0, r0, #16
@   0x080125e4: 0000        movs	r0, r0
@   0x080125e6: 0202        lsls	r2, r0, #8
@   0x080125e8: 8000        strh	r0, [r0, #0]
@   0x080125ea: 8100        strh	r0, [r0, #8]
@   0x080125ec: 4903        ldr	r1, [pc, #12]	@ (0x125fc)
@   0x080125ee: 2200        movs	r2, #0
@   0x080125f0: 2008        movs	r0, #8
@   0x080125f2: 7308        strb	r0, [r1, #12]
@   0x080125f4: 4802        ldr	r0, [pc, #8]	@ (0x12600)
@   0x080125f6: 86c2        strh	r2, [r0, #54]	@ 0x36
@   0x080125f8: 4770        bx	lr
@   0x080125fa: 0000        movs	r0, r0
@   0x080125fc: 6410        str	r0, [r2, #64]	@ 0x40
@   0x080125fe: 0300        lsls	r0, r0, #12
@   0x08012600: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08012602: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080125B0
sub_080125B0: @ 0x080125b0
        .incbin "baserom.gba", 0x125b0, 0x54
        thumb_func_end sub_080125B0
