@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d150, 0x0801d268)  (280 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d150 --end 0x801d268 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d150: b530        push	{r4, r5, lr}
@   0x0801d152: b081        sub	sp, #4
@   0x0801d154: 0600        lsls	r0, r0, #24
@   0x0801d156: 0e00        lsrs	r0, r0, #24
@   0x0801d158: 4669        mov	r1, sp
@   0x0801d15a: 2400        movs	r4, #0
@   0x0801d15c: 800c        strh	r4, [r1, #0]
@   0x0801d15e: 4930        ldr	r1, [pc, #192]	@ (0x1d220)
@   0x0801d160: 466a        mov	r2, sp
@   0x0801d162: 600a        str	r2, [r1, #0]
@   0x0801d164: 22c0        movs	r2, #192	@ 0xc0
@   0x0801d166: 04d2        lsls	r2, r2, #19
@   0x0801d168: 604a        str	r2, [r1, #4]
@   0x0801d16a: 4b2e        ldr	r3, [pc, #184]	@ (0x1d224)
@   0x0801d16c: 608b        str	r3, [r1, #8]
@   0x0801d16e: 688a        ldr	r2, [r1, #8]
@   0x0801d170: 466a        mov	r2, sp
@   0x0801d172: 8014        strh	r4, [r2, #0]
@   0x0801d174: 600a        str	r2, [r1, #0]
@   0x0801d176: 4a2c        ldr	r2, [pc, #176]	@ (0x1d228)
@   0x0801d178: 604a        str	r2, [r1, #4]
@   0x0801d17a: 608b        str	r3, [r1, #8]
@   0x0801d17c: 688a        ldr	r2, [r1, #8]
@   0x0801d17e: 466a        mov	r2, sp
@   0x0801d180: 8014        strh	r4, [r2, #0]
@   0x0801d182: 600a        str	r2, [r1, #0]
@   0x0801d184: 4a29        ldr	r2, [pc, #164]	@ (0x1d22c)
@   0x0801d186: 604a        str	r2, [r1, #4]
@   0x0801d188: 4b29        ldr	r3, [pc, #164]	@ (0x1d230)
@   0x0801d18a: 608b        str	r3, [r1, #8]
@   0x0801d18c: 688a        ldr	r2, [r1, #8]
@   0x0801d18e: 466a        mov	r2, sp
@   0x0801d190: 8014        strh	r4, [r2, #0]
@   0x0801d192: 600a        str	r2, [r1, #0]
@   0x0801d194: 4a27        ldr	r2, [pc, #156]	@ (0x1d234)
@   0x0801d196: 604a        str	r2, [r1, #4]
@   0x0801d198: 608b        str	r3, [r1, #8]
@   0x0801d19a: 6889        ldr	r1, [r1, #8]
@   0x0801d19c: 4926        ldr	r1, [pc, #152]	@ (0x1d238)
@   0x0801d19e: 23f0        movs	r3, #240	@ 0xf0
@   0x0801d1a0: 800b        strh	r3, [r1, #0]
@   0x0801d1a2: 4a26        ldr	r2, [pc, #152]	@ (0x1d23c)
@   0x0801d1a4: 4d26        ldr	r5, [pc, #152]	@ (0x1d240)
@   0x0801d1a6: 1c29        adds	r1, r5, #0
@   0x0801d1a8: 8011        strh	r1, [r2, #0]
@   0x0801d1aa: 4926        ldr	r1, [pc, #152]	@ (0x1d244)
@   0x0801d1ac: 800b        strh	r3, [r1, #0]
@   0x0801d1ae: 3202        adds	r2, #2
@   0x0801d1b0: 2130        movs	r1, #48	@ 0x30
@   0x0801d1b2: 8011        strh	r1, [r2, #0]
@   0x0801d1b4: 3202        adds	r2, #2
@   0x0801d1b6: 4b24        ldr	r3, [pc, #144]	@ (0x1d248)
@   0x0801d1b8: 1c19        adds	r1, r3, #0
@   0x0801d1ba: 8011        strh	r1, [r2, #0]
@   0x0801d1bc: 4b23        ldr	r3, [pc, #140]	@ (0x1d24c)
@   0x0801d1be: 4d24        ldr	r5, [pc, #144]	@ (0x1d250)
@   0x0801d1c0: 1c29        adds	r1, r5, #0
@   0x0801d1c2: 8019        strh	r1, [r3, #0]
@   0x0801d1c4: 8819        ldrh	r1, [r3, #0]
@   0x0801d1c6: 2208        movs	r2, #8
@   0x0801d1c8: 4051        eors	r1, r2
@   0x0801d1ca: 8019        strh	r1, [r3, #0]
@   0x0801d1cc: 2280        movs	r2, #128	@ 0x80
@   0x0801d1ce: 04d2        lsls	r2, r2, #19
@   0x0801d1d0: 2390        movs	r3, #144	@ 0x90
@   0x0801d1d2: 011b        lsls	r3, r3, #4
@   0x0801d1d4: 1c19        adds	r1, r3, #0
@   0x0801d1d6: 8011        strh	r1, [r2, #0]
@   0x0801d1d8: 3208        adds	r2, #8
@   0x0801d1da: 4d1e        ldr	r5, [pc, #120]	@ (0x1d254)
@   0x0801d1dc: 1c29        adds	r1, r5, #0
@   0x0801d1de: 8011        strh	r1, [r2, #0]
@   0x0801d1e0: 3206        adds	r2, #6
@   0x0801d1e2: 4b1d        ldr	r3, [pc, #116]	@ (0x1d258)
@   0x0801d1e4: 1c19        adds	r1, r3, #0
@   0x0801d1e6: 8011        strh	r1, [r2, #0]
@   0x0801d1e8: 4a1c        ldr	r2, [pc, #112]	@ (0x1d25c)
@   0x0801d1ea: 2100        movs	r1, #0
@   0x0801d1ec: 8011        strh	r1, [r2, #0]
@   0x0801d1ee: 8051        strh	r1, [r2, #2]
@   0x0801d1f0: 8191        strh	r1, [r2, #12]
@   0x0801d1f2: 81d1        strh	r1, [r2, #14]
@   0x0801d1f4: 4a1a        ldr	r2, [pc, #104]	@ (0x1d260)
@   0x0801d1f6: 8011        strh	r1, [r2, #0]
@   0x0801d1f8: 3202        adds	r2, #2
@   0x0801d1fa: 8011        strh	r1, [r2, #0]
@   0x0801d1fc: 320a        adds	r2, #10
@   0x0801d1fe: 8011        strh	r1, [r2, #0]
@   0x0801d200: 3202        adds	r2, #2
@   0x0801d202: 8011        strh	r1, [r2, #0]
@   0x0801d204: f000        f830 	bl	0x1d268
@   0x0801d208: 4816        ldr	r0, [pc, #88]	@ (0x1d264)
@   0x0801d20a: 7044        strb	r4, [r0, #1]
@   0x0801d20c: 7304        strb	r4, [r0, #12]
@   0x0801d20e: f003        fccd 	bl	0x20bac
@   0x0801d212: 2000        movs	r0, #0
@   0x0801d214: f003        fcb8 	bl	0x20b88
@   0x0801d218: b001        add	sp, #4
@   0x0801d21a: bc30        pop	{r4, r5}
@   0x0801d21c: bc01        pop	{r0}
@   0x0801d21e: 4700        bx	r0
@   0x0801d220: 00d4        lsls	r4, r2, #3
@   0x0801d222: 0400        lsls	r0, r0, #16
@   0x0801d224: 2000        movs	r0, #0
@   0x0801d226: 8100        strh	r0, [r0, #8]
@   0x0801d228: 8000        strh	r0, [r0, #0]
@   0x0801d22a: 0600        lsls	r0, r0, #24
@   0x0801d22c: e000        b.n	0x1d230
@   0x0801d22e: 0600        lsls	r0, r0, #24
@   0x0801d230: 0400        lsls	r0, r0, #16
@   0x0801d232: 8100        strh	r0, [r0, #8]
@   0x0801d234: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801d238: 0040        lsls	r0, r0, #1
@   0x0801d23a: 0400        lsls	r0, r0, #16
@   0x0801d23c: 0044        lsls	r4, r0, #1
@   0x0801d23e: 0400        lsls	r0, r0, #16
@   0x0801d240: 70a0        strb	r0, [r4, #2]
@   0x0801d242: 0000        movs	r0, r0
@   0x0801d244: 0042        lsls	r2, r0, #1
@   0x0801d246: 0400        lsls	r0, r0, #16
@   0x0801d248: 0808        lsrs	r0, r1, #32
@   0x0801d24a: 0000        movs	r0, r0
@   0x0801d24c: 004a        lsls	r2, r1, #1
@   0x0801d24e: 0400        lsls	r0, r0, #16
@   0x0801d250: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801d252: 0000        movs	r0, r0
@   0x0801d254: 1c83        adds	r3, r0, #2
@   0x0801d256: 0000        movs	r0, r0
@   0x0801d258: 1f08        subs	r0, r1, #4
@   0x0801d25a: 0000        movs	r0, r0
@   0x0801d25c: 3550        adds	r5, #80	@ 0x50
@   0x0801d25e: 0300        lsls	r0, r0, #12
@   0x0801d260: 0010        movs	r0, r2
@   0x0801d262: 0400        lsls	r0, r0, #16
@   0x0801d264: 3540        adds	r5, #64	@ 0x40
@   0x0801d266: 0300        lsls	r0, r0, #12
