@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d028, 0x0800d070)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d028 --end 0x800d070 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d028: b510        push	{r4, lr}
@   0x0800d02a: 4c0e        ldr	r4, [pc, #56]	@ (0xd064)
@   0x0800d02c: 2102        movs	r1, #2
@   0x0800d02e: 5e63        ldrsh	r3, [r4, r1]
@   0x0800d030: 00c1        lsls	r1, r0, #3
@   0x0800d032: 1a09        subs	r1, r1, r0
@   0x0800d034: 00c9        lsls	r1, r1, #3
@   0x0800d036: 1909        adds	r1, r1, r4
@   0x0800d038: 2202        movs	r2, #2
@   0x0800d03a: 5e88        ldrsh	r0, [r1, r2]
@   0x0800d03c: 1a1a        subs	r2, r3, r0
@   0x0800d03e: 2a00        cmp	r2, #0
@   0x0800d040: da00        bge.n	0xd044
@   0x0800d042: 1ac2        subs	r2, r0, r3
@   0x0800d044: 2082        movs	r0, #130	@ 0x82
@   0x0800d046: 0040        lsls	r0, r0, #1
@   0x0800d048: 4282        cmp	r2, r0
@   0x0800d04a: dc0d        bgt.n	0xd068
@   0x0800d04c: 2204        movs	r2, #4
@   0x0800d04e: 5ea0        ldrsh	r0, [r4, r2]
@   0x0800d050: 2204        movs	r2, #4
@   0x0800d052: 5e89        ldrsh	r1, [r1, r2]
@   0x0800d054: 1a42        subs	r2, r0, r1
@   0x0800d056: 2a00        cmp	r2, #0
@   0x0800d058: da00        bge.n	0xd05c
@   0x0800d05a: 1a0a        subs	r2, r1, r0
@   0x0800d05c: 2ab4        cmp	r2, #180	@ 0xb4
@   0x0800d05e: dc03        bgt.n	0xd068
@   0x0800d060: 2001        movs	r0, #1
@   0x0800d062: e002        b.n	0xd06a
@   0x0800d064: 3720        adds	r7, #32
@   0x0800d066: 0300        lsls	r0, r0, #12
@   0x0800d068: 2000        movs	r0, #0
@   0x0800d06a: bc10        pop	{r4}
@   0x0800d06c: bc02        pop	{r1}
@   0x0800d06e: 4708        bx	r1

        thumb_func_start sub_0800D028
sub_0800D028: @ 0x0800d028
        .incbin "frog_us_baserom.gba", 0xd028, 0x48
        thumb_func_end sub_0800D028
