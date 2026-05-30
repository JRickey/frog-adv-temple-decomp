@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007f88, 0x0800803c)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007f88 --end 0x800803c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007f88: b570        push	{r4, r5, r6, lr}
@   0x08007f8a: 4d15        ldr	r5, [pc, #84]	@ (0x7fe0)
@   0x08007f8c: 7e28        ldrb	r0, [r5, #24]
@   0x08007f8e: 7e69        ldrb	r1, [r5, #25]
@   0x08007f90: 2308        movs	r3, #8
@   0x08007f92: 5eea        ldrsh	r2, [r5, r3]
@   0x08007f94: 240a        movs	r4, #10
@   0x08007f96: 5f2b        ldrsh	r3, [r5, r4]
@   0x08007f98: f004        fef6 	bl	0xcd88
@   0x08007f9c: 0600        lsls	r0, r0, #24
@   0x08007f9e: 0e01        lsrs	r1, r0, #24
@   0x08007fa0: 7ea8        ldrb	r0, [r5, #26]
@   0x08007fa2: 2800        cmp	r0, #0
@   0x08007fa4: d104        bne.n	0x7fb0
@   0x08007fa6: 2002        movs	r0, #2
@   0x08007fa8: 8a2e        ldrh	r6, [r5, #16]
@   0x08007faa: 4030        ands	r0, r6
@   0x08007fac: 2800        cmp	r0, #0
@   0x08007fae: d01b        beq.n	0x7fe8
@   0x08007fb0: 4a0c        ldr	r2, [pc, #48]	@ (0x7fe4)
@   0x08007fb2: 2102        movs	r1, #2
@   0x08007fb4: 5e50        ldrsh	r0, [r2, r1]
@   0x08007fb6: 2304        movs	r3, #4
@   0x08007fb8: 5ed1        ldrsh	r1, [r2, r3]
@   0x08007fba: 7b6e        ldrb	r6, [r5, #13]
@   0x08007fbc: 00f4        lsls	r4, r6, #3
@   0x08007fbe: 1ba4        subs	r4, r4, r6
@   0x08007fc0: 00e4        lsls	r4, r4, #3
@   0x08007fc2: 18a4        adds	r4, r4, r2
@   0x08007fc4: 8863        ldrh	r3, [r4, #2]
@   0x08007fc6: 8ca5        ldrh	r5, [r4, #36]	@ 0x24
@   0x08007fc8: 195a        adds	r2, r3, r5
@   0x08007fca: 0412        lsls	r2, r2, #16
@   0x08007fcc: 1412        asrs	r2, r2, #16
@   0x08007fce: 88a6        ldrh	r6, [r4, #4]
@   0x08007fd0: 8ce5        ldrh	r5, [r4, #38]	@ 0x26
@   0x08007fd2: 1973        adds	r3, r6, r5
@   0x08007fd4: 3429        adds	r4, #41	@ 0x29
@   0x08007fd6: 7824        ldrb	r4, [r4, #0]
@   0x08007fd8: 0864        lsrs	r4, r4, #1
@   0x08007fda: 1b1b        subs	r3, r3, r4
@   0x08007fdc: 041b        lsls	r3, r3, #16
@   0x08007fde: e01e        b.n	0x801e
@   0x08007fe0: 35e0        adds	r5, #224	@ 0xe0
@   0x08007fe2: 0300        lsls	r0, r0, #12
@   0x08007fe4: 3720        adds	r7, #32
@   0x08007fe6: 0300        lsls	r0, r0, #12
@   0x08007fe8: 1fc8        subs	r0, r1, #7
@   0x08007fea: 0600        lsls	r0, r0, #24
@   0x08007fec: 0e00        lsrs	r0, r0, #24
@   0x08007fee: 2801        cmp	r0, #1
@   0x08007ff0: d920        bls.n	0x8034
@   0x08007ff2: 290b        cmp	r1, #11
@   0x08007ff4: d01e        beq.n	0x8034
@   0x08007ff6: 490e        ldr	r1, [pc, #56]	@ (0x8030)
@   0x08007ff8: 2602        movs	r6, #2
@   0x08007ffa: 5f88        ldrsh	r0, [r1, r6]
@   0x08007ffc: 2204        movs	r2, #4
@   0x08007ffe: 5e89        ldrsh	r1, [r1, r2]
@   0x08008000: 2408        movs	r4, #8
@   0x08008002: 5f2b        ldrsh	r3, [r5, r4]
@   0x08008004: 005a        lsls	r2, r3, #1
@   0x08008006: 18d2        adds	r2, r2, r3
@   0x08008008: 04d2        lsls	r2, r2, #19
@   0x0800800a: 26b0        movs	r6, #176	@ 0xb0
@   0x0800800c: 0336        lsls	r6, r6, #12
@   0x0800800e: 1992        adds	r2, r2, r6
@   0x08008010: 1412        asrs	r2, r2, #16
@   0x08008012: 230a        movs	r3, #10
@   0x08008014: 5eec        ldrsh	r4, [r5, r3]
@   0x08008016: 0063        lsls	r3, r4, #1
@   0x08008018: 191b        adds	r3, r3, r4
@   0x0800801a: 04db        lsls	r3, r3, #19
@   0x0800801c: 199b        adds	r3, r3, r6
@   0x0800801e: 141b        asrs	r3, r3, #16
@   0x08008020: f000        f80c 	bl	0x803c
@   0x08008024: 0600        lsls	r0, r0, #24
@   0x08008026: 2800        cmp	r0, #0
@   0x08008028: d104        bne.n	0x8034
@   0x0800802a: 2000        movs	r0, #0
@   0x0800802c: e003        b.n	0x8036
@   0x0800802e: 0000        movs	r0, r0
@   0x08008030: 3720        adds	r7, #32
@   0x08008032: 0300        lsls	r0, r0, #12
@   0x08008034: 2001        movs	r0, #1
@   0x08008036: bc70        pop	{r4, r5, r6}
@   0x08008038: bc02        pop	{r1}
@   0x0800803a: 4708        bx	r1

        thumb_func_start sub_08007F88
sub_08007F88: @ 0x08007f88
        .incbin "frog_us_baserom.gba", 0x7f88, 0xb4
        thumb_func_end sub_08007F88
