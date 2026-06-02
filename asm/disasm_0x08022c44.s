@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022c44, 0x08022cd4)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022c44 --end 0x8022cd4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022c44: b510        push	{r4, lr}
@   0x08022c46: b081        sub	sp, #4
@   0x08022c48: 2400        movs	r4, #0
@   0x08022c4a: 00e0        lsls	r0, r4, #3
@   0x08022c4c: 1b00        subs	r0, r0, r4
@   0x08022c4e: 00c0        lsls	r0, r0, #3
@   0x08022c50: 4904        ldr	r1, [pc, #16]	@ (0x22c64)
@   0x08022c52: 1840        adds	r0, r0, r1
@   0x08022c54: 7e81        ldrb	r1, [r0, #26]
@   0x08022c56: 2902        cmp	r1, #2
@   0x08022c58: d10c        bne.n	0x22c74
@   0x08022c5a: 7ec1        ldrb	r1, [r0, #27]
@   0x08022c5c: 2903        cmp	r1, #3
@   0x08022c5e: d103        bne.n	0x22c68
@   0x08022c60: 2109        movs	r1, #9
@   0x08022c62: e018        b.n	0x22c96
@   0x08022c64: 3870        subs	r0, #112	@ 0x70
@   0x08022c66: 0300        lsls	r0, r0, #12
@   0x08022c68: 2908        cmp	r1, #8
@   0x08022c6a: d11e        bne.n	0x22caa
@   0x08022c6c: 2009        movs	r0, #9
@   0x08022c6e: f7fe        f905 	bl	0x20e7c
@   0x08022c72: e01a        b.n	0x22caa
@   0x08022c74: 2903        cmp	r1, #3
@   0x08022c76: d108        bne.n	0x22c8a
@   0x08022c78: 7ec1        ldrb	r1, [r0, #27]
@   0x08022c7a: 2905        cmp	r1, #5
@   0x08022c7c: d00a        beq.n	0x22c94
@   0x08022c7e: 290a        cmp	r1, #10
@   0x08022c80: d113        bne.n	0x22caa
@   0x08022c82: 2008        movs	r0, #8
@   0x08022c84: f7fe        f8fa 	bl	0x20e7c
@   0x08022c88: e00f        b.n	0x22caa
@   0x08022c8a: 2904        cmp	r1, #4
@   0x08022c8c: d10d        bne.n	0x22caa
@   0x08022c8e: 7ec1        ldrb	r1, [r0, #27]
@   0x08022c90: 2903        cmp	r1, #3
@   0x08022c92: d105        bne.n	0x22ca0
@   0x08022c94: 2108        movs	r1, #8
@   0x08022c96: 2202        movs	r2, #2
@   0x08022c98: 2302        movs	r3, #2
@   0x08022c9a: f7fe        f8bb 	bl	0x20e14
@   0x08022c9e: e004        b.n	0x22caa
@   0x08022ca0: 290a        cmp	r1, #10
@   0x08022ca2: d102        bne.n	0x22caa
@   0x08022ca4: 2008        movs	r0, #8
@   0x08022ca6: f7fe        f8e9 	bl	0x20e7c
@   0x08022caa: 1c60        adds	r0, r4, #1
@   0x08022cac: 0600        lsls	r0, r0, #24
@   0x08022cae: 0e04        lsrs	r4, r0, #24
@   0x08022cb0: 2c05        cmp	r4, #5
@   0x08022cb2: d9ca        bls.n	0x22c4a
@   0x08022cb4: 4905        ldr	r1, [pc, #20]	@ (0x22ccc)
@   0x08022cb6: 4b06        ldr	r3, [pc, #24]	@ (0x22cd0)
@   0x08022cb8: 2000        movs	r0, #0
@   0x08022cba: 9000        str	r0, [sp, #0]
@   0x08022cbc: 2006        movs	r0, #6
@   0x08022cbe: 2212        movs	r2, #18
@   0x08022cc0: f7fe        fc26 	bl	0x21510
@   0x08022cc4: b001        add	sp, #4
@   0x08022cc6: bc10        pop	{r4}
@   0x08022cc8: bc01        pop	{r0}
@   0x08022cca: 4700        bx	r0
@   0x08022ccc: 14c0        asrs	r0, r0, #19
@   0x08022cce: 0831        lsrs	r1, r6, #32
@   0x08022cd0: 6110        str	r0, [r2, #16]
@   0x08022cd2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022C44
sub_08022C44: @ 0x08022c44
        .incbin "frog_us_baserom.gba", 0x22c44, 0x90
        thumb_func_end sub_08022C44
