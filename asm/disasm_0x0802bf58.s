@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bf58, 0x0802c000)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bf58 --end 0x802c000 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bf58: b510        push	{r4, lr}
@   0x0802bf5a: 4c1d        ldr	r4, [pc, #116]	@ (0x2bfd0)
@   0x0802bf5c: 1c20        adds	r0, r4, #0
@   0x0802bf5e: 2103        movs	r1, #3
@   0x0802bf60: 2205        movs	r2, #5
@   0x0802bf62: f7da        fc1b 	bl	0x679c
@   0x0802bf66: 0600        lsls	r0, r0, #24
@   0x0802bf68: 2800        cmp	r0, #0
@   0x0802bf6a: d014        beq.n	0x2bf96
@   0x0802bf6c: 4919        ldr	r1, [pc, #100]	@ (0x2bfd4)
@   0x0802bf6e: 481a        ldr	r0, [pc, #104]	@ (0x2bfd8)
@   0x0802bf70: 180a        adds	r2, r1, r0
@   0x0802bf72: 481a        ldr	r0, [pc, #104]	@ (0x2bfdc)
@   0x0802bf74: 6800        ldr	r0, [r0, #0]
@   0x0802bf76: 6010        str	r0, [r2, #0]
@   0x0802bf78: 4819        ldr	r0, [pc, #100]	@ (0x2bfe0)
@   0x0802bf7a: 180a        adds	r2, r1, r0
@   0x0802bf7c: 2000        movs	r0, #0
@   0x0802bf7e: 7010        strb	r0, [r2, #0]
@   0x0802bf80: 4a18        ldr	r2, [pc, #96]	@ (0x2bfe4)
@   0x0802bf82: 1889        adds	r1, r1, r2
@   0x0802bf84: 2002        movs	r0, #2
@   0x0802bf86: 880a        ldrh	r2, [r1, #0]
@   0x0802bf88: 4310        orrs	r0, r2
@   0x0802bf8a: 8008        strh	r0, [r1, #0]
@   0x0802bf8c: 1c20        adds	r0, r4, #0
@   0x0802bf8e: 2103        movs	r1, #3
@   0x0802bf90: 2205        movs	r2, #5
@   0x0802bf92: f7da        fb97 	bl	0x66c4
@   0x0802bf96: 4911        ldr	r1, [pc, #68]	@ (0x2bfdc)
@   0x0802bf98: 480e        ldr	r0, [pc, #56]	@ (0x2bfd4)
@   0x0802bf9a: 4a0f        ldr	r2, [pc, #60]	@ (0x2bfd8)
@   0x0802bf9c: 1880        adds	r0, r0, r2
@   0x0802bf9e: 6809        ldr	r1, [r1, #0]
@   0x0802bfa0: 6800        ldr	r0, [r0, #0]
@   0x0802bfa2: 1a09        subs	r1, r1, r0
@   0x0802bfa4: 20c8        movs	r0, #200	@ 0xc8
@   0x0802bfa6: 0040        lsls	r0, r0, #1
@   0x0802bfa8: 4281        cmp	r1, r0
@   0x0802bfaa: d922        bls.n	0x2bff2
@   0x0802bfac: 1c21        adds	r1, r4, #0
@   0x0802bfae: 312b        adds	r1, #43	@ 0x2b
@   0x0802bfb0: 7808        ldrb	r0, [r1, #0]
@   0x0802bfb2: 3001        adds	r0, #1
@   0x0802bfb4: 7008        strb	r0, [r1, #0]
@   0x0802bfb6: 0600        lsls	r0, r0, #24
@   0x0802bfb8: 0e00        lsrs	r0, r0, #24
@   0x0802bfba: 2802        cmp	r0, #2
@   0x0802bfbc: d914        bls.n	0x2bfe8
@   0x0802bfbe: 2000        movs	r0, #0
@   0x0802bfc0: 7008        strb	r0, [r1, #0]
@   0x0802bfc2: 1c20        adds	r0, r4, #0
@   0x0802bfc4: 2103        movs	r1, #3
@   0x0802bfc6: 2206        movs	r2, #6
@   0x0802bfc8: f7da        fb1a 	bl	0x6600
@   0x0802bfcc: e011        b.n	0x2bff2
@   0x0802bfce: 0000        movs	r0, r0
@   0x0802bfd0: 6110        str	r0, [r2, #16]
@   0x0802bfd2: 0300        lsls	r0, r0, #12
@   0x0802bfd4: 3720        adds	r7, #32
@   0x0802bfd6: 0300        lsls	r0, r0, #12
@   0x0802bfd8: 0b1c        lsrs	r4, r3, #12
@   0x0802bfda: 0000        movs	r0, r0
@   0x0802bfdc: 5330        strh	r0, [r6, r4]
@   0x0802bfde: 0300        lsls	r0, r0, #12
@   0x0802bfe0: 04ea        lsls	r2, r5, #19
@   0x0802bfe2: 0000        movs	r0, r0
@   0x0802bfe4: 0504        lsls	r4, r0, #20
@   0x0802bfe6: 0000        movs	r0, r0
@   0x0802bfe8: 1c20        adds	r0, r4, #0
@   0x0802bfea: 2103        movs	r1, #3
@   0x0802bfec: 2205        movs	r2, #5
@   0x0802bfee: f7da        fb07 	bl	0x6600
@   0x0802bff2: 205c        movs	r0, #92	@ 0x5c
@   0x0802bff4: f000        f904 	bl	0x2c200
@   0x0802bff8: bc10        pop	{r4}
@   0x0802bffa: bc01        pop	{r0}
@   0x0802bffc: 4700        bx	r0

        thumb_func_start sub_0802BF58
sub_0802BF58: @ 0x0802bf58
        .incbin "frog_us_baserom.gba", 0x2bf58, 0xa8
        thumb_func_end sub_0802BF58
