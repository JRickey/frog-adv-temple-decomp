@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08033948, 0x080339ac)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8033948 --end 0x80339ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033948: b530        push	{r4, r5, lr}
@   0x0803394a: 4a11        ldr	r2, [pc, #68]	@ (0x33990)
@   0x0803394c: 4b11        ldr	r3, [pc, #68]	@ (0x33994)
@   0x0803394e: 8819        ldrh	r1, [r3, #0]
@   0x08033950: 8011        strh	r1, [r2, #0]
@   0x08033952: 2500        movs	r5, #0
@   0x08033954: 801d        strh	r5, [r3, #0]
@   0x08033956: 4c10        ldr	r4, [pc, #64]	@ (0x33998)
@   0x08033958: 4910        ldr	r1, [pc, #64]	@ (0x3399c)
@   0x0803395a: 7809        ldrb	r1, [r1, #0]
@   0x0803395c: 2208        movs	r2, #8
@   0x0803395e: 408a        lsls	r2, r1
@   0x08033960: 8821        ldrh	r1, [r4, #0]
@   0x08033962: 4311        orrs	r1, r2
@   0x08033964: 8021        strh	r1, [r4, #0]
@   0x08033966: 2101        movs	r1, #1
@   0x08033968: 8019        strh	r1, [r3, #0]
@   0x0803396a: 490d        ldr	r1, [pc, #52]	@ (0x339a0)
@   0x0803396c: 700d        strb	r5, [r1, #0]
@   0x0803396e: 4a0d        ldr	r2, [pc, #52]	@ (0x339a4)
@   0x08033970: 8801        ldrh	r1, [r0, #0]
@   0x08033972: 8011        strh	r1, [r2, #0]
@   0x08033974: 3002        adds	r0, #2
@   0x08033976: 4b0c        ldr	r3, [pc, #48]	@ (0x339a8)
@   0x08033978: 6819        ldr	r1, [r3, #0]
@   0x0803397a: 8802        ldrh	r2, [r0, #0]
@   0x0803397c: 800a        strh	r2, [r1, #0]
@   0x0803397e: 3102        adds	r1, #2
@   0x08033980: 6019        str	r1, [r3, #0]
@   0x08033982: 8840        ldrh	r0, [r0, #2]
@   0x08033984: 8008        strh	r0, [r1, #0]
@   0x08033986: 3902        subs	r1, #2
@   0x08033988: 6019        str	r1, [r3, #0]
@   0x0803398a: bc30        pop	{r4, r5}
@   0x0803398c: bc01        pop	{r0}
@   0x0803398e: 4700        bx	r0
@   0x08033990: 343c        adds	r4, #60	@ 0x3c
@   0x08033992: 0300        lsls	r0, r0, #12
@   0x08033994: 0208        lsls	r0, r1, #8
@   0x08033996: 0400        lsls	r0, r0, #16
@   0x08033998: 0200        lsls	r0, r0, #8
@   0x0803399a: 0400        lsls	r0, r0, #16
@   0x0803399c: 3430        adds	r4, #48	@ 0x30
@   0x0803399e: 0300        lsls	r0, r0, #12
@   0x080339a0: 3434        adds	r4, #52	@ 0x34
@   0x080339a2: 0300        lsls	r0, r0, #12
@   0x080339a4: 3432        adds	r4, #50	@ 0x32
@   0x080339a6: 0300        lsls	r0, r0, #12
@   0x080339a8: 3438        adds	r4, #56	@ 0x38
@   0x080339aa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08033948
sub_08033948: @ 0x08033948
        .incbin "baserom.gba", 0x33948, 0x64
        thumb_func_end sub_08033948
