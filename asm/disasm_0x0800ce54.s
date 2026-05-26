@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ce54, 0x0800ce98)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ce54 --end 0x800ce98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ce54: b510        push	{r4, lr}
@   0x0800ce56: 0600        lsls	r0, r0, #24
@   0x0800ce58: 0609        lsls	r1, r1, #24
@   0x0800ce5a: 0e09        lsrs	r1, r1, #24
@   0x0800ce5c: 041b        lsls	r3, r3, #16
@   0x0800ce5e: 141b        asrs	r3, r3, #16
@   0x0800ce60: 4c0b        ldr	r4, [pc, #44]	@ (0xce90)
@   0x0800ce62: 0d40        lsrs	r0, r0, #21
@   0x0800ce64: 1900        adds	r0, r0, r4
@   0x0800ce66: 7900        ldrb	r0, [r0, #4]
@   0x0800ce68: 4343        muls	r3, r0
@   0x0800ce6a: 0412        lsls	r2, r2, #16
@   0x0800ce6c: 13d2        asrs	r2, r2, #15
@   0x0800ce6e: 0088        lsls	r0, r1, #2
@   0x0800ce70: 1840        adds	r0, r0, r1
@   0x0800ce72: 0300        lsls	r0, r0, #12
@   0x0800ce74: 005b        lsls	r3, r3, #1
@   0x0800ce76: 18c0        adds	r0, r0, r3
@   0x0800ce78: 1812        adds	r2, r2, r0
@   0x0800ce7a: 4806        ldr	r0, [pc, #24]	@ (0xce94)
@   0x0800ce7c: 1812        adds	r2, r2, r0
@   0x0800ce7e: 20c0        movs	r0, #192	@ 0xc0
@   0x0800ce80: 0100        lsls	r0, r0, #4
@   0x0800ce82: 8812        ldrh	r2, [r2, #0]
@   0x0800ce84: 4010        ands	r0, r2
@   0x0800ce86: 0a80        lsrs	r0, r0, #10
@   0x0800ce88: bc10        pop	{r4}
@   0x0800ce8a: bc02        pop	{r1}
@   0x0800ce8c: 4708        bx	r1
@   0x0800ce8e: 0000        movs	r0, r0
@   0x0800ce90: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ce92: 0830        lsrs	r0, r6, #32
@   0x0800ce94: 0000        movs	r0, r0
@   0x0800ce96: 0203        lsls	r3, r0, #8

        thumb_func_start sub_0800CE54
sub_0800CE54: @ 0x0800ce54
        .incbin "frog_us_baserom.gba", 0xce54, 0x44
        thumb_func_end sub_0800CE54
