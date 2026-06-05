@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023ab4, 0x08023bc0)  (268 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023ab4 --end 0x8023bc0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023ab4: b570        push	{r4, r5, r6, lr}
@   0x08023ab6: 2500        movs	r5, #0
@   0x08023ab8: 4e07        ldr	r6, [pc, #28]	@ (0x23ad8)
@   0x08023aba: 00e8        lsls	r0, r5, #3
@   0x08023abc: 1b40        subs	r0, r0, r5
@   0x08023abe: 00c0        lsls	r0, r0, #3
@   0x08023ac0: 4906        ldr	r1, [pc, #24]	@ (0x23adc)
@   0x08023ac2: 1842        adds	r2, r0, r1
@   0x08023ac4: 2104        movs	r1, #4
@   0x08023ac6: 5e50        ldrsh	r0, [r2, r1]
@   0x08023ac8: 4b05        ldr	r3, [pc, #20]	@ (0x23ae0)
@   0x08023aca: 18c0        adds	r0, r0, r3
@   0x08023acc: 2800        cmp	r0, #0
@   0x08023ace: db09        blt.n	0x23ae4
@   0x08023ad0: 8891        ldrh	r1, [r2, #4]
@   0x08023ad2: 18c8        adds	r0, r1, r3
@   0x08023ad4: e00a        b.n	0x23aec
@   0x08023ad6: 0000        movs	r0, r0
@   0x08023ad8: 0383        lsls	r3, r0, #14
@   0x08023ada: 0000        movs	r0, r0
@   0x08023adc: 3950        subs	r1, #80	@ 0x50
@   0x08023ade: 0300        lsls	r0, r0, #12
@   0x08023ae0: fcc5        ffff 			@ <UNDEFINED> instruction: 0xfcc5ffff
@   0x08023ae4: 8891        ldrh	r1, [r2, #4]
@   0x08023ae6: 4c07        ldr	r4, [pc, #28]	@ (0x23b04)
@   0x08023ae8: 1c20        adds	r0, r4, #0
@   0x08023aea: 1a40        subs	r0, r0, r1
@   0x08023aec: 0400        lsls	r0, r0, #16
@   0x08023aee: 0c00        lsrs	r0, r0, #16
@   0x08023af0: 1c03        adds	r3, r0, #0
@   0x08023af2: 2404        movs	r4, #4
@   0x08023af4: 5f10        ldrsh	r0, [r2, r4]
@   0x08023af6: 4c04        ldr	r4, [pc, #16]	@ (0x23b08)
@   0x08023af8: 1900        adds	r0, r0, r4
@   0x08023afa: 2800        cmp	r0, #0
@   0x08023afc: db06        blt.n	0x23b0c
@   0x08023afe: 1908        adds	r0, r1, r4
@   0x08023b00: e007        b.n	0x23b12
@   0x08023b02: 0000        movs	r0, r0
@   0x08023b04: 033b        lsls	r3, r7, #12
@   0x08023b06: 0000        movs	r0, r0
@   0x08023b08: fcad        ffff 			@ <UNDEFINED> instruction: 0xfcadffff
@   0x08023b0c: 4c07        ldr	r4, [pc, #28]	@ (0x23b2c)
@   0x08023b0e: 1c20        adds	r0, r4, #0
@   0x08023b10: 1a40        subs	r0, r0, r1
@   0x08023b12: 0400        lsls	r0, r0, #16
@   0x08023b14: 0c01        lsrs	r1, r0, #16
@   0x08023b16: 2402        movs	r4, #2
@   0x08023b18: 5f10        ldrsh	r0, [r2, r4]
@   0x08023b1a: 42b0        cmp	r0, r6
@   0x08023b1c: d108        bne.n	0x23b30
@   0x08023b1e: 1c10        adds	r0, r2, #0
@   0x08023b20: 2107        movs	r1, #7
@   0x08023b22: 220a        movs	r2, #10
@   0x08023b24: 2303        movs	r3, #3
@   0x08023b26: f7fd        f975 	bl	0x20e14
@   0x08023b2a: e018        b.n	0x23b5e
@   0x08023b2c: 0353        lsls	r3, r2, #13
@   0x08023b2e: 0000        movs	r0, r0
@   0x08023b30: 0418        lsls	r0, r3, #16
@   0x08023b32: 1400        asrs	r0, r0, #16
@   0x08023b34: 2804        cmp	r0, #4
@   0x08023b36: dc06        bgt.n	0x23b46
@   0x08023b38: 1c10        adds	r0, r2, #0
@   0x08023b3a: 2107        movs	r1, #7
@   0x08023b3c: 2205        movs	r2, #5
@   0x08023b3e: 230a        movs	r3, #10
@   0x08023b40: f7fd        f968 	bl	0x20e14
@   0x08023b44: e00b        b.n	0x23b5e
@   0x08023b46: 0408        lsls	r0, r1, #16
@   0x08023b48: 1400        asrs	r0, r0, #16
@   0x08023b4a: 2804        cmp	r0, #4
@   0x08023b4c: dc07        bgt.n	0x23b5e
@   0x08023b4e: 2d05        cmp	r5, #5
@   0x08023b50: d105        bne.n	0x23b5e
@   0x08023b52: 1c10        adds	r0, r2, #0
@   0x08023b54: 2107        movs	r1, #7
@   0x08023b56: 2203        movs	r2, #3
@   0x08023b58: 230a        movs	r3, #10
@   0x08023b5a: f7fd        f95b 	bl	0x20e14
@   0x08023b5e: 4916        ldr	r1, [pc, #88]	@ (0x23bb8)
@   0x08023b60: 00a8        lsls	r0, r5, #2
@   0x08023b62: 1840        adds	r0, r0, r1
@   0x08023b64: 6800        ldr	r0, [r0, #0]
@   0x08023b66: 1c2c        adds	r4, r5, #0
@   0x08023b68: 340a        adds	r4, #10
@   0x08023b6a: 1c21        adds	r1, r4, #0
@   0x08023b6c: f7fd        ff26 	bl	0x219bc
@   0x08023b70: 4812        ldr	r0, [pc, #72]	@ (0x23bbc)
@   0x08023b72: 1c21        adds	r1, r4, #0
@   0x08023b74: f7e2        fefa 	bl	0x696c
@   0x08023b78: 1c68        adds	r0, r5, #1
@   0x08023b7a: 0600        lsls	r0, r0, #24
@   0x08023b7c: 0e05        lsrs	r5, r0, #24
@   0x08023b7e: 2d09        cmp	r5, #9
@   0x08023b80: d99b        bls.n	0x23aba
@   0x08023b82: 200a        movs	r0, #10
@   0x08023b84: 210e        movs	r1, #14
@   0x08023b86: f7fd        fa2d 	bl	0x20fe4
@   0x08023b8a: 200a        movs	r0, #10
@   0x08023b8c: 210e        movs	r1, #14
@   0x08023b8e: f7e2        f8bf 	bl	0x5d10
@   0x08023b92: 200f        movs	r0, #15
@   0x08023b94: 210f        movs	r1, #15
@   0x08023b96: f7fd        fa25 	bl	0x20fe4
@   0x08023b9a: 200f        movs	r0, #15
@   0x08023b9c: 210f        movs	r1, #15
@   0x08023b9e: f7e2        f8b7 	bl	0x5d10
@   0x08023ba2: 2010        movs	r0, #16
@   0x08023ba4: 2113        movs	r1, #19
@   0x08023ba6: f7fd        fa1d 	bl	0x20fe4
@   0x08023baa: 2010        movs	r0, #16
@   0x08023bac: 2113        movs	r1, #19
@   0x08023bae: f7e2        f8af 	bl	0x5d10
@   0x08023bb2: bc70        pop	{r4, r5, r6}
@   0x08023bb4: bc01        pop	{r0}
@   0x08023bb6: 4700        bx	r0
@   0x08023bb8: 2d80        cmp	r5, #128	@ 0x80
@   0x08023bba: 0831        lsrs	r1, r6, #32
@   0x08023bbc: 6110        str	r0, [r2, #16]
@   0x08023bbe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023AB4
sub_08023AB4: @ 0x08023ab4
        .incbin "frog_us_baserom.gba", 0x23ab4, 0x10c
        thumb_func_end sub_08023AB4
