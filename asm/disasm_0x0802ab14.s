@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ab14, 0x0802ab64)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ab14 --end 0x802ab64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ab14: b530        push	{r4, r5, lr}
@   0x0802ab16: 4911        ldr	r1, [pc, #68]	@ (0x2ab5c)
@   0x0802ab18: 20fb        movs	r0, #251	@ 0xfb
@   0x0802ab1a: 0080        lsls	r0, r0, #2
@   0x0802ab1c: 1809        adds	r1, r1, r0
@   0x0802ab1e: 2008        movs	r0, #8
@   0x0802ab20: 8809        ldrh	r1, [r1, #0]
@   0x0802ab22: 4008        ands	r0, r1
@   0x0802ab24: 2800        cmp	r0, #0
@   0x0802ab26: d115        bne.n	0x2ab54
@   0x0802ab28: 2400        movs	r4, #0
@   0x0802ab2a: 4d0d        ldr	r5, [pc, #52]	@ (0x2ab60)
@   0x0802ab2c: 00a0        lsls	r0, r4, #2
@   0x0802ab2e: 1940        adds	r0, r0, r5
@   0x0802ab30: 6800        ldr	r0, [r0, #0]
@   0x0802ab32: 1c21        adds	r1, r4, #0
@   0x0802ab34: 3111        adds	r1, #17
@   0x0802ab36: f7f6        ff41 	bl	0x219bc
@   0x0802ab3a: 1c60        adds	r0, r4, #1
@   0x0802ab3c: 0600        lsls	r0, r0, #24
@   0x0802ab3e: 0e04        lsrs	r4, r0, #24
@   0x0802ab40: 2c01        cmp	r4, #1
@   0x0802ab42: d9f3        bls.n	0x2ab2c
@   0x0802ab44: 2011        movs	r0, #17
@   0x0802ab46: 2112        movs	r1, #18
@   0x0802ab48: f7f6        fa4c 	bl	0x20fe4
@   0x0802ab4c: 2011        movs	r0, #17
@   0x0802ab4e: 2112        movs	r1, #18
@   0x0802ab50: f7db        f8de 	bl	0x5d10
@   0x0802ab54: bc30        pop	{r4, r5}
@   0x0802ab56: bc01        pop	{r0}
@   0x0802ab58: 4700        bx	r0
@   0x0802ab5a: 0000        movs	r0, r0
@   0x0802ab5c: 3720        adds	r7, #32
@   0x0802ab5e: 0300        lsls	r0, r0, #12
@   0x0802ab60: 7e6c        ldrb	r4, [r5, #25]
@   0x0802ab62: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AB14
sub_0802AB14: @ 0x0802ab14
        .incbin "frog_us_baserom.gba", 0x2ab14, 0x50
        thumb_func_end sub_0802AB14
