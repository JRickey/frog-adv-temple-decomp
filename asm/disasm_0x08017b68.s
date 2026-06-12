@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08017b68, 0x08017bfc)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8017b68 --end 0x8017bfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017b68: b530        push	{r4, r5, lr}
@   0x08017b6a: 4d1d        ldr	r5, [pc, #116]	@ (0x17be0)
@   0x08017b6c: 2100        movs	r1, #0
@   0x08017b6e: 7169        strb	r1, [r5, #5]
@   0x08017b70: 481c        ldr	r0, [pc, #112]	@ (0x17be4)
@   0x08017b72: 3024        adds	r0, #36	@ 0x24
@   0x08017b74: 7001        strb	r1, [r0, #0]
@   0x08017b76: f7f8        fdcb 	bl	0x10710
@   0x08017b7a: 1c04        adds	r4, r0, #0
@   0x08017b7c: 2c00        cmp	r4, #0
@   0x08017b7e: d12c        bne.n	0x17bda
@   0x08017b80: f7e8        febe 	bl	0x900
@   0x08017b84: 68e9        ldr	r1, [r5, #12]
@   0x08017b86: 1a40        subs	r0, r0, r1
@   0x08017b88: 2877        cmp	r0, #119	@ 0x77
@   0x08017b8a: d926        bls.n	0x17bda
@   0x08017b8c: 4916        ldr	r1, [pc, #88]	@ (0x17be8)
@   0x08017b8e: 2001        movs	r0, #1
@   0x08017b90: 7048        strb	r0, [r1, #1]
@   0x08017b92: 7828        ldrb	r0, [r5, #0]
@   0x08017b94: 3001        adds	r0, #1
@   0x08017b96: 7028        strb	r0, [r5, #0]
@   0x08017b98: f7e8        feb2 	bl	0x900
@   0x08017b9c: 60e8        str	r0, [r5, #12]
@   0x08017b9e: 20bf        movs	r0, #191	@ 0xbf
@   0x08017ba0: f7f8        fd78 	bl	0x10694
@   0x08017ba4: 4911        ldr	r1, [pc, #68]	@ (0x17bec)
@   0x08017ba6: 700c        strb	r4, [r1, #0]
@   0x08017ba8: 704c        strb	r4, [r1, #1]
@   0x08017baa: 20f0        movs	r0, #240	@ 0xf0
@   0x08017bac: 7088        strb	r0, [r1, #2]
@   0x08017bae: 22a0        movs	r2, #160	@ 0xa0
@   0x08017bb0: 70ca        strb	r2, [r1, #3]
@   0x08017bb2: 490f        ldr	r1, [pc, #60]	@ (0x17bf0)
@   0x08017bb4: 700c        strb	r4, [r1, #0]
@   0x08017bb6: 704c        strb	r4, [r1, #1]
@   0x08017bb8: 2058        movs	r0, #88	@ 0x58
@   0x08017bba: 7088        strb	r0, [r1, #2]
@   0x08017bbc: 2010        movs	r0, #16
@   0x08017bbe: 70c8        strb	r0, [r1, #3]
@   0x08017bc0: 480c        ldr	r0, [pc, #48]	@ (0x17bf4)
@   0x08017bc2: 7004        strb	r4, [r0, #0]
@   0x08017bc4: 7044        strb	r4, [r0, #1]
@   0x08017bc6: 7082        strb	r2, [r0, #2]
@   0x08017bc8: 2150        movs	r1, #80	@ 0x50
@   0x08017bca: 70c1        strb	r1, [r0, #3]
@   0x08017bcc: 490a        ldr	r1, [pc, #40]	@ (0x17bf8)
@   0x08017bce: 700c        strb	r4, [r1, #0]
@   0x08017bd0: 704c        strb	r4, [r1, #1]
@   0x08017bd2: 2072        movs	r0, #114	@ 0x72
@   0x08017bd4: 7088        strb	r0, [r1, #2]
@   0x08017bd6: 2009        movs	r0, #9
@   0x08017bd8: 70c8        strb	r0, [r1, #3]
@   0x08017bda: bc30        pop	{r4, r5}
@   0x08017bdc: bc01        pop	{r0}
@   0x08017bde: 4700        bx	r0
@   0x08017be0: 3480        adds	r4, #128	@ 0x80
@   0x08017be2: 0300        lsls	r0, r0, #12
@   0x08017be4: 5330        strh	r0, [r6, r4]
@   0x08017be6: 0300        lsls	r0, r0, #12
@   0x08017be8: 34a0        adds	r4, #160	@ 0xa0
@   0x08017bea: 0300        lsls	r0, r0, #12
@   0x08017bec: 3470        adds	r4, #112	@ 0x70
@   0x08017bee: 0300        lsls	r0, r0, #12
@   0x08017bf0: 3478        adds	r4, #120	@ 0x78
@   0x08017bf2: 0300        lsls	r0, r0, #12
@   0x08017bf4: 3474        adds	r4, #116	@ 0x74
@   0x08017bf6: 0300        lsls	r0, r0, #12
@   0x08017bf8: 3498        adds	r4, #152	@ 0x98
@   0x08017bfa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08017B68
sub_08017B68: @ 0x08017b68
        .incbin "frog_us_baserom.gba", 0x17b68, 0x94
        thumb_func_end sub_08017B68
