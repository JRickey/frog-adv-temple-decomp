@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ce10, 0x0800ce54)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ce10 --end 0x800ce54 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ce10: b510        push	{r4, lr}
@   0x0800ce12: 0600        lsls	r0, r0, #24
@   0x0800ce14: 0609        lsls	r1, r1, #24
@   0x0800ce16: 0e09        lsrs	r1, r1, #24
@   0x0800ce18: 041b        lsls	r3, r3, #16
@   0x0800ce1a: 141b        asrs	r3, r3, #16
@   0x0800ce1c: 4c0b        ldr	r4, [pc, #44]	@ (0xce4c)
@   0x0800ce1e: 0d40        lsrs	r0, r0, #21
@   0x0800ce20: 1900        adds	r0, r0, r4
@   0x0800ce22: 7900        ldrb	r0, [r0, #4]
@   0x0800ce24: 4343        muls	r3, r0
@   0x0800ce26: 0412        lsls	r2, r2, #16
@   0x0800ce28: 13d2        asrs	r2, r2, #15
@   0x0800ce2a: 0088        lsls	r0, r1, #2
@   0x0800ce2c: 1840        adds	r0, r0, r1
@   0x0800ce2e: 0300        lsls	r0, r0, #12
@   0x0800ce30: 005b        lsls	r3, r3, #1
@   0x0800ce32: 18c0        adds	r0, r0, r3
@   0x0800ce34: 1812        adds	r2, r2, r0
@   0x0800ce36: 4806        ldr	r0, [pc, #24]	@ (0xce50)
@   0x0800ce38: 1812        adds	r2, r2, r0
@   0x0800ce3a: 20c0        movs	r0, #192	@ 0xc0
@   0x0800ce3c: 0180        lsls	r0, r0, #6
@   0x0800ce3e: 8812        ldrh	r2, [r2, #0]
@   0x0800ce40: 4010        ands	r0, r2
@   0x0800ce42: 0b00        lsrs	r0, r0, #12
@   0x0800ce44: bc10        pop	{r4}
@   0x0800ce46: bc02        pop	{r1}
@   0x0800ce48: 4708        bx	r1
@   0x0800ce4a: 0000        movs	r0, r0
@   0x0800ce4c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ce4e: 0830        lsrs	r0, r6, #32
@   0x0800ce50: 0000        movs	r0, r0
@   0x0800ce52: 0203        lsls	r3, r0, #8

        thumb_func_start sub_0800CE10
sub_0800CE10: @ 0x0800ce10
        .incbin "frog_us_baserom.gba", 0xce10, 0x44
        thumb_func_end sub_0800CE10
