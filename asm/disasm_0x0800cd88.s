@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800cd88, 0x0800ce10)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800cd88 --end 0x800ce10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800cd88: b510        push	{r4, lr}
@   0x0800cd8a: 0600        lsls	r0, r0, #24
@   0x0800cd8c: 0609        lsls	r1, r1, #24
@   0x0800cd8e: 0e09        lsrs	r1, r1, #24
@   0x0800cd90: 041b        lsls	r3, r3, #16
@   0x0800cd92: 141b        asrs	r3, r3, #16
@   0x0800cd94: 4c0b        ldr	r4, [pc, #44]	@ (0xcdc4)
@   0x0800cd96: 0d40        lsrs	r0, r0, #21
@   0x0800cd98: 1900        adds	r0, r0, r4
@   0x0800cd9a: 7900        ldrb	r0, [r0, #4]
@   0x0800cd9c: 4343        muls	r3, r0
@   0x0800cd9e: 0412        lsls	r2, r2, #16
@   0x0800cda0: 13d2        asrs	r2, r2, #15
@   0x0800cda2: 0088        lsls	r0, r1, #2
@   0x0800cda4: 1840        adds	r0, r0, r1
@   0x0800cda6: 0300        lsls	r0, r0, #12
@   0x0800cda8: 005b        lsls	r3, r3, #1
@   0x0800cdaa: 18c0        adds	r0, r0, r3
@   0x0800cdac: 1812        adds	r2, r2, r0
@   0x0800cdae: 4806        ldr	r0, [pc, #24]	@ (0xcdc8)
@   0x0800cdb0: 1812        adds	r2, r2, r0
@   0x0800cdb2: 20fc        movs	r0, #252	@ 0xfc
@   0x0800cdb4: 0080        lsls	r0, r0, #2
@   0x0800cdb6: 8812        ldrh	r2, [r2, #0]
@   0x0800cdb8: 4010        ands	r0, r2
@   0x0800cdba: 0900        lsrs	r0, r0, #4
@   0x0800cdbc: bc10        pop	{r4}
@   0x0800cdbe: bc02        pop	{r1}
@   0x0800cdc0: 4708        bx	r1
@   0x0800cdc2: 0000        movs	r0, r0
@   0x0800cdc4: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cdc6: 0830        lsrs	r0, r6, #32
@   0x0800cdc8: 0000        movs	r0, r0
@   0x0800cdca: 0203        lsls	r3, r0, #8
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

        thumb_func_start sub_0800CD88
sub_0800CD88: @ 0x0800cd88
        .incbin "frog_us_baserom.gba", 0xcd88, 0x88
        thumb_func_end sub_0800CD88
