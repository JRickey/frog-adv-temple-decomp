@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000e0c, 0x08000eb8)  (172 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000e0c --end 0x8000eb8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000e0c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08000e0e: 4647        mov	r7, r8
@   0x08000e10: b480        push	{r7}
@   0x08000e12: 1c07        adds	r7, r0, #0
@   0x08000e14: 4688        mov	r8, r1
@   0x08000e16: 2203        movs	r2, #3
@   0x08000e18: f00a        fd7e 	bl	0xb918
@   0x08000e1c: 4e20        ldr	r6, [pc, #128]	@ (0xea0)
@   0x08000e1e: 2004        movs	r0, #4
@   0x08000e20: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x08000e22: 4008        ands	r0, r1
@   0x08000e24: 2800        cmp	r0, #0
@   0x08000e26: d135        bne.n	0xe94
@   0x08000e28: 4c1e        ldr	r4, [pc, #120]	@ (0xea4)
@   0x08000e2a: 7e20        ldrb	r0, [r4, #24]
@   0x08000e2c: 7e61        ldrb	r1, [r4, #25]
@   0x08000e2e: 2308        movs	r3, #8
@   0x08000e30: 5ee2        ldrsh	r2, [r4, r3]
@   0x08000e32: 250a        movs	r5, #10
@   0x08000e34: 5f63        ldrsh	r3, [r4, r5]
@   0x08000e36: f00b        ffa7 	bl	0xcd88
@   0x08000e3a: 0600        lsls	r0, r0, #24
@   0x08000e3c: 0e05        lsrs	r5, r0, #24
@   0x08000e3e: 2010        movs	r0, #16
@   0x08000e40: 8a21        ldrh	r1, [r4, #16]
@   0x08000e42: 4008        ands	r0, r1
@   0x08000e44: 2800        cmp	r0, #0
@   0x08000e46: d008        beq.n	0xe5a
@   0x08000e48: 1c28        adds	r0, r5, #0
@   0x08000e4a: f00b        fa85 	bl	0xc358
@   0x08000e4e: 1c38        adds	r0, r7, #0
@   0x08000e50: 4641        mov	r1, r8
@   0x08000e52: 2203        movs	r2, #3
@   0x08000e54: 1c2b        adds	r3, r5, #0
@   0x08000e56: f00a        fd27 	bl	0xb8a8
@   0x08000e5a: 1c20        adds	r0, r4, #0
@   0x08000e5c: 2140        movs	r1, #64	@ 0x40
@   0x08000e5e: f005        fea1 	bl	0x6ba4
@   0x08000e62: 0600        lsls	r0, r0, #24
@   0x08000e64: 2800        cmp	r0, #0
@   0x08000e66: d015        beq.n	0xe94
@   0x08000e68: 68a2        ldr	r2, [r4, #8]
@   0x08000e6a: 480f        ldr	r0, [pc, #60]	@ (0xea8)
@   0x08000e6c: 1c11        adds	r1, r2, #0
@   0x08000e6e: 4281        cmp	r1, r0
@   0x08000e70: d101        bne.n	0xe76
@   0x08000e72: 2002        movs	r0, #2
@   0x08000e74: 71b0        strb	r0, [r6, #6]
@   0x08000e76: 480d        ldr	r0, [pc, #52]	@ (0xeac)
@   0x08000e78: 4281        cmp	r1, r0
@   0x08000e7a: d101        bne.n	0xe80
@   0x08000e7c: 2003        movs	r0, #3
@   0x08000e7e: 71b0        strb	r0, [r6, #6]
@   0x08000e80: 480b        ldr	r0, [pc, #44]	@ (0xeb0)
@   0x08000e82: 4281        cmp	r1, r0
@   0x08000e84: d101        bne.n	0xe8a
@   0x08000e86: 2003        movs	r0, #3
@   0x08000e88: 71b0        strb	r0, [r6, #6]
@   0x08000e8a: 480a        ldr	r0, [pc, #40]	@ (0xeb4)
@   0x08000e8c: 4282        cmp	r2, r0
@   0x08000e8e: d101        bne.n	0xe94
@   0x08000e90: 2002        movs	r0, #2
@   0x08000e92: 71b0        strb	r0, [r6, #6]
@   0x08000e94: bc08        pop	{r3}
@   0x08000e96: 4698        mov	r8, r3
@   0x08000e98: bcf0        pop	{r4, r5, r6, r7}
@   0x08000e9a: bc01        pop	{r0}
@   0x08000e9c: 4700        bx	r0
@   0x08000e9e: 0000        movs	r0, r0
@   0x08000ea0: 3720        adds	r7, #32
@   0x08000ea2: 0300        lsls	r0, r0, #12
@   0x08000ea4: 35e0        adds	r5, #224	@ 0xe0
@   0x08000ea6: 0300        lsls	r0, r0, #12
@   0x08000ea8: 0006        movs	r6, r0
@   0x08000eaa: 001c        movs	r4, r3
@   0x08000eac: 0007        movs	r7, r0
@   0x08000eae: 001c        movs	r4, r3
@   0x08000eb0: 000d        movs	r5, r1
@   0x08000eb2: 001c        movs	r4, r3
@   0x08000eb4: 000e        movs	r6, r1
@   0x08000eb6: 001c        movs	r4, r3

        thumb_func_start sub_08000E0C
sub_08000E0C: @ 0x08000e0c
        .incbin "frog_us_baserom.gba", 0xe0c, 0xac
        thumb_func_end sub_08000E0C
