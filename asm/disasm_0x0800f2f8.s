@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800f2f8, 0x0800f398)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800f2f8 --end 0x800f398 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800f2f8: 0600        lsls	r0, r0, #24
@   0x0800f2fa: 0e00        lsrs	r0, r0, #24
@   0x0800f2fc: 0609        lsls	r1, r1, #24
@   0x0800f2fe: 0e09        lsrs	r1, r1, #24
@   0x0800f300: 2901        cmp	r1, #1
@   0x0800f302: d01d        beq.n	0xf340
@   0x0800f304: 2901        cmp	r1, #1
@   0x0800f306: dc02        bgt.n	0xf30e
@   0x0800f308: 2900        cmp	r1, #0
@   0x0800f30a: d003        beq.n	0xf314
@   0x0800f30c: e03f        b.n	0xf38e
@   0x0800f30e: 2902        cmp	r1, #2
@   0x0800f310: d02c        beq.n	0xf36c
@   0x0800f312: e03c        b.n	0xf38e
@   0x0800f314: 2800        cmp	r0, #0
@   0x0800f316: d109        bne.n	0xf32c
@   0x0800f318: 4802        ldr	r0, [pc, #8]	@ (0xf324)
@   0x0800f31a: 4903        ldr	r1, [pc, #12]	@ (0xf328)
@   0x0800f31c: 8a89        ldrh	r1, [r1, #20]
@   0x0800f31e: 8001        strh	r1, [r0, #0]
@   0x0800f320: e035        b.n	0xf38e
@   0x0800f322: 0000        movs	r0, r0
@   0x0800f324: 3550        adds	r5, #80	@ 0x50
@   0x0800f326: 0300        lsls	r0, r0, #12
@   0x0800f328: 60a0        str	r0, [r4, #8]
@   0x0800f32a: 0300        lsls	r0, r0, #12
@   0x0800f32c: 4802        ldr	r0, [pc, #8]	@ (0xf338)
@   0x0800f32e: 4903        ldr	r1, [pc, #12]	@ (0xf33c)
@   0x0800f330: 8ac9        ldrh	r1, [r1, #22]
@   0x0800f332: 8041        strh	r1, [r0, #2]
@   0x0800f334: e02b        b.n	0xf38e
@   0x0800f336: 0000        movs	r0, r0
@   0x0800f338: 3550        adds	r5, #80	@ 0x50
@   0x0800f33a: 0300        lsls	r0, r0, #12
@   0x0800f33c: 60a0        str	r0, [r4, #8]
@   0x0800f33e: 0300        lsls	r0, r0, #12
@   0x0800f340: 2800        cmp	r0, #0
@   0x0800f342: d109        bne.n	0xf358
@   0x0800f344: 4802        ldr	r0, [pc, #8]	@ (0xf350)
@   0x0800f346: 4903        ldr	r1, [pc, #12]	@ (0xf354)
@   0x0800f348: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800f34a: 8081        strh	r1, [r0, #4]
@   0x0800f34c: e01f        b.n	0xf38e
@   0x0800f34e: 0000        movs	r0, r0
@   0x0800f350: 3550        adds	r5, #80	@ 0x50
@   0x0800f352: 0300        lsls	r0, r0, #12
@   0x0800f354: 60a0        str	r0, [r4, #8]
@   0x0800f356: 0300        lsls	r0, r0, #12
@   0x0800f358: 4802        ldr	r0, [pc, #8]	@ (0xf364)
@   0x0800f35a: 4903        ldr	r1, [pc, #12]	@ (0xf368)
@   0x0800f35c: 8ec9        ldrh	r1, [r1, #54]	@ 0x36
@   0x0800f35e: 80c1        strh	r1, [r0, #6]
@   0x0800f360: e015        b.n	0xf38e
@   0x0800f362: 0000        movs	r0, r0
@   0x0800f364: 3550        adds	r5, #80	@ 0x50
@   0x0800f366: 0300        lsls	r0, r0, #12
@   0x0800f368: 60a0        str	r0, [r4, #8]
@   0x0800f36a: 0300        lsls	r0, r0, #12
@   0x0800f36c: 2800        cmp	r0, #0
@   0x0800f36e: d109        bne.n	0xf384
@   0x0800f370: 4802        ldr	r0, [pc, #8]	@ (0xf37c)
@   0x0800f372: 4903        ldr	r1, [pc, #12]	@ (0xf380)
@   0x0800f374: 3140        adds	r1, #64	@ 0x40
@   0x0800f376: 8a89        ldrh	r1, [r1, #20]
@   0x0800f378: 8101        strh	r1, [r0, #8]
@   0x0800f37a: e008        b.n	0xf38e
@   0x0800f37c: 3550        adds	r5, #80	@ 0x50
@   0x0800f37e: 0300        lsls	r0, r0, #12
@   0x0800f380: 60a0        str	r0, [r4, #8]
@   0x0800f382: 0300        lsls	r0, r0, #12
@   0x0800f384: 4802        ldr	r0, [pc, #8]	@ (0xf390)
@   0x0800f386: 4903        ldr	r1, [pc, #12]	@ (0xf394)
@   0x0800f388: 3140        adds	r1, #64	@ 0x40
@   0x0800f38a: 8ac9        ldrh	r1, [r1, #22]
@   0x0800f38c: 8141        strh	r1, [r0, #10]
@   0x0800f38e: 4770        bx	lr
@   0x0800f390: 3550        adds	r5, #80	@ 0x50
@   0x0800f392: 0300        lsls	r0, r0, #12
@   0x0800f394: 60a0        str	r0, [r4, #8]
@   0x0800f396: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800F2F8
sub_0800F2F8: @ 0x0800f2f8
        .incbin "frog_us_baserom.gba", 0xf2f8, 0xa0
        thumb_func_end sub_0800F2F8
