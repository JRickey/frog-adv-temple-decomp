@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d270, 0x0800d2c0)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d270 --end 0x800d2c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d270: 0409        lsls	r1, r1, #16
@   0x0800d272: 0c09        lsrs	r1, r1, #16
@   0x0800d274: 0400        lsls	r0, r0, #16
@   0x0800d276: 1402        asrs	r2, r0, #16
@   0x0800d278: 1ed3        subs	r3, r2, #3
@   0x0800d27a: 0418        lsls	r0, r3, #16
@   0x0800d27c: 0c00        lsrs	r0, r0, #16
@   0x0800d27e: 2807        cmp	r0, #7
@   0x0800d280: d805        bhi.n	0xd28e
@   0x0800d282: 0408        lsls	r0, r1, #16
@   0x0800d284: 1401        asrs	r1, r0, #16
@   0x0800d286: 2904        cmp	r1, #4
@   0x0800d288: dd01        ble.n	0xd28e
@   0x0800d28a: 290c        cmp	r1, #12
@   0x0800d28c: dd01        ble.n	0xd292
@   0x0800d28e: 2000        movs	r0, #0
@   0x0800d290: e013        b.n	0xd2ba
@   0x0800d292: 1ed0        subs	r0, r2, #3
@   0x0800d294: 0400        lsls	r0, r0, #16
@   0x0800d296: 0c00        lsrs	r0, r0, #16
@   0x0800d298: 2808        cmp	r0, #8
@   0x0800d29a: d804        bhi.n	0xd2a6
@   0x0800d29c: 1c08        adds	r0, r1, #0
@   0x0800d29e: 2804        cmp	r0, #4
@   0x0800d2a0: dd01        ble.n	0xd2a6
@   0x0800d2a2: 280d        cmp	r0, #13
@   0x0800d2a4: dd01        ble.n	0xd2aa
@   0x0800d2a6: 20ff        movs	r0, #255	@ 0xff
@   0x0800d2a8: e002        b.n	0xd2b0
@   0x0800d2aa: 3805        subs	r0, #5
@   0x0800d2ac: 00c0        lsls	r0, r0, #3
@   0x0800d2ae: 18c0        adds	r0, r0, r3
@   0x0800d2b0: 0600        lsls	r0, r0, #24
@   0x0800d2b2: 0e00        lsrs	r0, r0, #24
@   0x0800d2b4: 4901        ldr	r1, [pc, #4]	@ (0xd2bc)
@   0x0800d2b6: 1840        adds	r0, r0, r1
@   0x0800d2b8: 7800        ldrb	r0, [r0, #0]
@   0x0800d2ba: 4770        bx	lr
@   0x0800d2bc: 53a0        strh	r0, [r4, r6]
@   0x0800d2be: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800D270
sub_0800D270: @ 0x0800d270
        .incbin "frog_us_baserom.gba", 0xd270, 0x50
        thumb_func_end sub_0800D270
