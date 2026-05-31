@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801377c, 0x08013880)  (260 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801377c --end 0x8013880 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801377c: b510        push	{r4, lr}
@   0x0801377e: 2033        movs	r0, #51	@ 0x33
@   0x08013780: f00d        fa7a 	bl	0x20c78
@   0x08013784: 4b1c        ldr	r3, [pc, #112]	@ (0x137f8)
@   0x08013786: 2118        movs	r1, #24
@   0x08013788: 60d9        str	r1, [r3, #12]
@   0x0801378a: 2228        movs	r2, #40	@ 0x28
@   0x0801378c: 611a        str	r2, [r3, #16]
@   0x0801378e: 62d9        str	r1, [r3, #44]	@ 0x2c
@   0x08013790: 631a        str	r2, [r3, #48]	@ 0x30
@   0x08013792: 481a        ldr	r0, [pc, #104]	@ (0x137fc)
@   0x08013794: 8001        strh	r1, [r0, #0]
@   0x08013796: 3002        adds	r0, #2
@   0x08013798: 8002        strh	r2, [r0, #0]
@   0x0801379a: 3002        adds	r0, #2
@   0x0801379c: 8001        strh	r1, [r0, #0]
@   0x0801379e: 3002        adds	r0, #2
@   0x080137a0: 8002        strh	r2, [r0, #0]
@   0x080137a2: 4a17        ldr	r2, [pc, #92]	@ (0x13800)
@   0x080137a4: 2400        movs	r4, #0
@   0x080137a6: 2000        movs	r0, #0
@   0x080137a8: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x080137aa: 4916        ldr	r1, [pc, #88]	@ (0x13804)
@   0x080137ac: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x080137ae: 72d4        strb	r4, [r2, #11]
@   0x080137b0: 2012        movs	r0, #18
@   0x080137b2: 72c8        strb	r0, [r1, #11]
@   0x080137b4: 7254        strb	r4, [r2, #9]
@   0x080137b6: 2001        movs	r0, #1
@   0x080137b8: 7248        strb	r0, [r1, #9]
@   0x080137ba: 4913        ldr	r1, [pc, #76]	@ (0x13808)
@   0x080137bc: 4813        ldr	r0, [pc, #76]	@ (0x1380c)
@   0x080137be: 7880        ldrb	r0, [r0, #2]
@   0x080137c0: 72c8        strb	r0, [r1, #11]
@   0x080137c2: 2042        movs	r0, #66	@ 0x42
@   0x080137c4: 8718        strh	r0, [r3, #56]	@ 0x38
@   0x080137c6: 4812        ldr	r0, [pc, #72]	@ (0x13810)
@   0x080137c8: 4912        ldr	r1, [pc, #72]	@ (0x13814)
@   0x080137ca: 6001        str	r1, [r0, #0]
@   0x080137cc: 2180        movs	r1, #128	@ 0x80
@   0x080137ce: 0489        lsls	r1, r1, #18
@   0x080137d0: 6041        str	r1, [r0, #4]
@   0x080137d2: 4a11        ldr	r2, [pc, #68]	@ (0x13818)
@   0x080137d4: 6082        str	r2, [r0, #8]
@   0x080137d6: 6881        ldr	r1, [r0, #8]
@   0x080137d8: 4910        ldr	r1, [pc, #64]	@ (0x1381c)
@   0x080137da: 6001        str	r1, [r0, #0]
@   0x080137dc: 4910        ldr	r1, [pc, #64]	@ (0x13820)
@   0x080137de: 6041        str	r1, [r0, #4]
@   0x080137e0: 6082        str	r2, [r0, #8]
@   0x080137e2: 6880        ldr	r0, [r0, #8]
@   0x080137e4: 480f        ldr	r0, [pc, #60]	@ (0x13824)
@   0x080137e6: 7004        strb	r4, [r0, #0]
@   0x080137e8: 1c01        adds	r1, r0, #0
@   0x080137ea: 31dc        adds	r1, #220	@ 0xdc
@   0x080137ec: 700c        strb	r4, [r1, #0]
@   0x080137ee: 30d4        adds	r0, #212	@ 0xd4
@   0x080137f0: 7004        strb	r4, [r0, #0]
@   0x080137f2: bc10        pop	{r4}
@   0x080137f4: bc01        pop	{r0}
@   0x080137f6: 4700        bx	r0
@   0x080137f8: 60a0        str	r0, [r4, #8]
@   0x080137fa: 0300        lsls	r0, r0, #12
@   0x080137fc: 0010        movs	r0, r2
@   0x080137fe: 0400        lsls	r0, r0, #16
@   0x08013800: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08013802: 0300        lsls	r0, r0, #12
@   0x08013804: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08013806: 0300        lsls	r0, r0, #12
@   0x08013808: 6500        str	r0, [r0, #80]	@ 0x50
@   0x0801380a: 0300        lsls	r0, r0, #12
@   0x0801380c: 6f6c        ldr	r4, [r5, #116]	@ 0x74
@   0x0801380e: 0830        lsrs	r0, r6, #32
@   0x08013810: 00d4        lsls	r4, r2, #3
@   0x08013812: 0400        lsls	r0, r0, #16
@   0x08013814: df68        svc	104	@ 0x68
@   0x08013816: 0813        lsrs	r3, r2, #32
@   0x08013818: 8000        strh	r0, [r0, #0]
@   0x0801381a: 8000        strh	r0, [r0, #0]
@   0x0801381c: 2e84        cmp	r6, #132	@ 0x84
@   0x0801381e: 0814        lsrs	r4, r2, #32
@   0x08013820: 0000        movs	r0, r0
@   0x08013822: 0201        lsls	r1, r0, #8
@   0x08013824: 3610        adds	r6, #16
@   0x08013826: 0300        lsls	r0, r0, #12
@   0x08013828: b500        push	{lr}
@   0x0801382a: 2003        movs	r0, #3
@   0x0801382c: f7fb        f816 	bl	0xe85c
@   0x08013830: f7fb        f974 	bl	0xeb1c
@   0x08013834: 2002        movs	r0, #2
@   0x08013836: f7fb        fd09 	bl	0xf24c
@   0x0801383a: 480f        ldr	r0, [pc, #60]	@ (0x13878)
@   0x0801383c: 2200        movs	r2, #0
@   0x0801383e: 7002        strb	r2, [r0, #0]
@   0x08013840: 1c01        adds	r1, r0, #0
@   0x08013842: 31dc        adds	r1, #220	@ 0xdc
@   0x08013844: 700a        strb	r2, [r1, #0]
@   0x08013846: 30d4        adds	r0, #212	@ 0xd4
@   0x08013848: 7002        strb	r2, [r0, #0]
@   0x0801384a: 490c        ldr	r1, [pc, #48]	@ (0x1387c)
@   0x0801384c: 850a        strh	r2, [r1, #40]	@ 0x28
@   0x0801384e: 312b        adds	r1, #43	@ 0x2b
@   0x08013850: 200f        movs	r0, #15
@   0x08013852: 780a        ldrb	r2, [r1, #0]
@   0x08013854: 4010        ands	r0, r2
@   0x08013856: 7008        strb	r0, [r1, #0]
@   0x08013858: f7ff        fc58 	bl	0x1310c
@   0x0801385c: f7ff        fc56 	bl	0x1310c
@   0x08013860: 2003        movs	r0, #3
@   0x08013862: f7fb        f9bb 	bl	0xebdc
@   0x08013866: f003        f8eb 	bl	0x16a40
@   0x0801386a: f7ff        fadf 	bl	0x12e2c
@   0x0801386e: 2002        movs	r0, #2
@   0x08013870: f7fb        fae0 	bl	0xee34
@   0x08013874: bc01        pop	{r0}
@   0x08013876: 4700        bx	r0
@   0x08013878: 3610        adds	r6, #16
@   0x0801387a: 0300        lsls	r0, r0, #12
@   0x0801387c: 6110        str	r0, [r2, #16]
@   0x0801387e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801377C
sub_0801377C: @ 0x0801377c
        .incbin "frog_us_baserom.gba", 0x1377c, 0x104
        thumb_func_end sub_0801377C
