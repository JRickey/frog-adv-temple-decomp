@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a0a4, 0x0801a1c4)  (288 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a0a4 --end 0x801a1c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a0a4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a0a6: b082        sub	sp, #8
@   0x0801a0a8: f7ef        ffd8 	bl	0xa05c
@   0x0801a0ac: 4803        ldr	r0, [pc, #12]	@ (0x1a0bc)
@   0x0801a0ae: 7800        ldrb	r0, [r0, #0]
@   0x0801a0b0: 2800        cmp	r0, #0
@   0x0801a0b2: d005        beq.n	0x1a0c0
@   0x0801a0b4: 2802        cmp	r0, #2
@   0x0801a0b6: d009        beq.n	0x1a0cc
@   0x0801a0b8: e010        b.n	0x1a0dc
@   0x0801a0ba: 0000        movs	r0, r0
@   0x0801a0bc: 3540        adds	r5, #64	@ 0x40
@   0x0801a0be: 0300        lsls	r0, r0, #12
@   0x0801a0c0: 4801        ldr	r0, [pc, #4]	@ (0x1a0c8)
@   0x0801a0c2: 7a86        ldrb	r6, [r0, #10]
@   0x0801a0c4: e00a        b.n	0x1a0dc
@   0x0801a0c6: 0000        movs	r0, r0
@   0x0801a0c8: 5330        strh	r0, [r6, r4]
@   0x0801a0ca: 0300        lsls	r0, r0, #12
@   0x0801a0cc: f001        f842 	bl	0x1b154
@   0x0801a0d0: 3001        adds	r0, #1
@   0x0801a0d2: 0600        lsls	r0, r0, #24
@   0x0801a0d4: 0e06        lsrs	r6, r0, #24
@   0x0801a0d6: 2e0f        cmp	r6, #15
@   0x0801a0d8: d900        bls.n	0x1a0dc
@   0x0801a0da: 260f        movs	r6, #15
@   0x0801a0dc: f001        f83a 	bl	0x1b154
@   0x0801a0e0: 0600        lsls	r0, r0, #24
@   0x0801a0e2: 0e07        lsrs	r7, r0, #24
@   0x0801a0e4: 2f0e        cmp	r7, #14
@   0x0801a0e6: d900        bls.n	0x1a0ea
@   0x0801a0e8: 270f        movs	r7, #15
@   0x0801a0ea: 4918        ldr	r1, [pc, #96]	@ (0x1a14c)
@   0x0801a0ec: 00b0        lsls	r0, r6, #2
@   0x0801a0ee: 1840        adds	r0, r0, r1
@   0x0801a0f0: 8805        ldrh	r5, [r0, #0]
@   0x0801a0f2: 0070        lsls	r0, r6, #1
@   0x0801a0f4: 3001        adds	r0, #1
@   0x0801a0f6: 0040        lsls	r0, r0, #1
@   0x0801a0f8: 1840        adds	r0, r0, r1
@   0x0801a0fa: 8804        ldrh	r4, [r0, #0]
@   0x0801a0fc: 4814        ldr	r0, [pc, #80]	@ (0x1a150)
@   0x0801a0fe: 2200        movs	r2, #0
@   0x0801a100: 7282        strb	r2, [r0, #10]
@   0x0801a102: 4814        ldr	r0, [pc, #80]	@ (0x1a154)
@   0x0801a104: 4b14        ldr	r3, [pc, #80]	@ (0x1a158)
@   0x0801a106: 2101        movs	r1, #1
@   0x0801a108: 9100        str	r1, [sp, #0]
@   0x0801a10a: 9201        str	r2, [sp, #4]
@   0x0801a10c: 2114        movs	r1, #20
@   0x0801a10e: 2202        movs	r2, #2
@   0x0801a110: f7ec        fa3c 	bl	0x658c
@   0x0801a114: f7ef        ffa2 	bl	0xa05c
@   0x0801a118: 042d        lsls	r5, r5, #16
@   0x0801a11a: 142d        asrs	r5, r5, #16
@   0x0801a11c: 0424        lsls	r4, r4, #16
@   0x0801a11e: 1424        asrs	r4, r4, #16
@   0x0801a120: 1c28        adds	r0, r5, #0
@   0x0801a122: 1c21        adds	r1, r4, #0
@   0x0801a124: 2201        movs	r2, #1
@   0x0801a126: 2323        movs	r3, #35	@ 0x23
@   0x0801a128: f7ee        ffe8 	bl	0x90fc
@   0x0801a12c: 480b        ldr	r0, [pc, #44]	@ (0x1a15c)
@   0x0801a12e: 6800        ldr	r0, [r0, #0]
@   0x0801a130: f019        fdd2 	bl	0x33cd8
@   0x0801a134: 480a        ldr	r0, [pc, #40]	@ (0x1a160)
@   0x0801a136: 7800        ldrb	r0, [r0, #0]
@   0x0801a138: 2800        cmp	r0, #0
@   0x0801a13a: d117        bne.n	0x1a16c
@   0x0801a13c: 42b7        cmp	r7, r6
@   0x0801a13e: d911        bls.n	0x1a164
@   0x0801a140: 1c78        adds	r0, r7, #1
@   0x0801a142: 0600        lsls	r0, r0, #24
@   0x0801a144: 0e00        lsrs	r0, r0, #24
@   0x0801a146: f001        f897 	bl	0x1b278
@   0x0801a14a: e016        b.n	0x1a17a
@   0x0801a14c: d940        bls.n	0x1a1d0
@   0x0801a14e: 081b        lsrs	r3, r3, #32
@   0x0801a150: 5330        strh	r0, [r6, r4]
@   0x0801a152: 0300        lsls	r0, r0, #12
@   0x0801a154: 6110        str	r0, [r2, #16]
@   0x0801a156: 0300        lsls	r0, r0, #12
@   0x0801a158: 998c        ldr	r1, [sp, #560]	@ 0x230
@   0x0801a15a: 082f        lsrs	r7, r5, #32
@   0x0801a15c: 0cfc        lsrs	r4, r7, #19
@   0x0801a15e: 080c        lsrs	r4, r1, #32
@   0x0801a160: 3540        adds	r5, #64	@ 0x40
@   0x0801a162: 0300        lsls	r0, r0, #12
@   0x0801a164: 1c30        adds	r0, r6, #0
@   0x0801a166: f001        f887 	bl	0x1b278
@   0x0801a16a: e006        b.n	0x1a17a
@   0x0801a16c: 2802        cmp	r0, #2
@   0x0801a16e: d104        bne.n	0x1a17a
@   0x0801a170: 1c78        adds	r0, r7, #1
@   0x0801a172: 0600        lsls	r0, r0, #24
@   0x0801a174: 0e00        lsrs	r0, r0, #24
@   0x0801a176: f001        f87f 	bl	0x1b278
@   0x0801a17a: 2002        movs	r0, #2
@   0x0801a17c: f7f4        fd2e 	bl	0xebdc
@   0x0801a180: f001        fcac 	bl	0x1badc
@   0x0801a184: 4a0b        ldr	r2, [pc, #44]	@ (0x1a1b4)
@   0x0801a186: 480c        ldr	r0, [pc, #48]	@ (0x1a1b8)
@   0x0801a188: 490c        ldr	r1, [pc, #48]	@ (0x1a1bc)
@   0x0801a18a: 6150        str	r0, [r2, #20]
@   0x0801a18c: 6191        str	r1, [r2, #24]
@   0x0801a18e: 61d0        str	r0, [r2, #28]
@   0x0801a190: 6211        str	r1, [r2, #32]
@   0x0801a192: f7ed        ffef 	bl	0x8174
@   0x0801a196: 480a        ldr	r0, [pc, #40]	@ (0x1a1c0)
@   0x0801a198: 6800        ldr	r0, [r0, #0]
@   0x0801a19a: f019        fd9d 	bl	0x33cd8
@   0x0801a19e: f7ef        fc5b 	bl	0x9a58
@   0x0801a1a2: f7ee        fff1 	bl	0x9188
@   0x0801a1a6: f7f0        f8bf 	bl	0xa328
@   0x0801a1aa: b002        add	sp, #8
@   0x0801a1ac: bcf0        pop	{r4, r5, r6, r7}
@   0x0801a1ae: bc01        pop	{r0}
@   0x0801a1b0: 4700        bx	r0
@   0x0801a1b2: 0000        movs	r0, r0
@   0x0801a1b4: 6110        str	r0, [r2, #16]
@   0x0801a1b6: 0300        lsls	r0, r0, #12
@   0x0801a1b8: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801a1bc: 0000        movs	r0, r0
@   0x0801a1be: 0000        movs	r0, r0
@   0x0801a1c0: 0cb8        lsrs	r0, r7, #18
@   0x0801a1c2: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0801A0A4
sub_0801A0A4: @ 0x0801a0a4
        .incbin "frog_us_baserom.gba", 0x1a0a4, 0x120
        thumb_func_end sub_0801A0A4
