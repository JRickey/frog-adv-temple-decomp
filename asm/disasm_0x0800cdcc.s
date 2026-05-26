@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800cdcc, 0x0800ce10)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800cdcc --end 0x800ce10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800cdcc: b510        push	{r4, lr}
@   0x0800cdce: 0600        lsls	r0, r0, #24
@   0x0800cdd0: 0609        lsls	r1, r1, #24
@   0x0800cdd2: 0e09        lsrs	r1, r1, #24
@   0x0800cdd4: 041b        lsls	r3, r3, #16
@   0x0800cdd6: 141b        asrs	r3, r3, #16
@   0x0800cdd8: 4c0b        ldr	r4, [pc, #44]	@ (0xce08)
@   0x0800cdda: 0d40        lsrs	r0, r0, #21
@   0x0800cddc: 1900        adds	r0, r0, r4
@   0x0800cdde: 7900        ldrb	r0, [r0, #4]
@   0x0800cde0: 4343        muls	r3, r0
@   0x0800cde2: 0412        lsls	r2, r2, #16
@   0x0800cde4: 13d2        asrs	r2, r2, #15
@   0x0800cde6: 0088        lsls	r0, r1, #2
@   0x0800cde8: 1840        adds	r0, r0, r1
@   0x0800cdea: 0300        lsls	r0, r0, #12
@   0x0800cdec: 005b        lsls	r3, r3, #1
@   0x0800cdee: 18c0        adds	r0, r0, r3
@   0x0800cdf0: 1812        adds	r2, r2, r0
@   0x0800cdf2: 4806        ldr	r0, [pc, #24]	@ (0xce0c)
@   0x0800cdf4: 1812        adds	r2, r2, r0
@   0x0800cdf6: 2080        movs	r0, #128	@ 0x80
@   0x0800cdf8: 01c0        lsls	r0, r0, #7
@   0x0800cdfa: 8812        ldrh	r2, [r2, #0]
@   0x0800cdfc: 4010        ands	r0, r2
@   0x0800cdfe: 0400        lsls	r0, r0, #16
@   0x0800ce00: 0f80        lsrs	r0, r0, #30
@   0x0800ce02: bc10        pop	{r4}
@   0x0800ce04: bc02        pop	{r1}
@   0x0800ce06: 4708        bx	r1
@   0x0800ce08: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ce0a: 0830        lsrs	r0, r6, #32
@   0x0800ce0c: 0000        movs	r0, r0
@   0x0800ce0e: 0203        lsls	r3, r0, #8

        thumb_func_start sub_0800CDCC
sub_0800CDCC: @ 0x0800cdcc
        .incbin "frog_us_baserom.gba", 0xcdcc, 0x44
        thumb_func_end sub_0800CDCC
