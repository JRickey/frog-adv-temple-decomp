@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006a0c, 0x08006a74)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006a0c --end 0x8006a74 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006a0c: b530        push	{r4, r5, lr}
@   0x08006a0e: 1c04        adds	r4, r0, #0
@   0x08006a10: 0409        lsls	r1, r1, #16
@   0x08006a12: 0c0d        lsrs	r5, r1, #16
@   0x08006a14: 2008        movs	r0, #8
@   0x08006a16: 8a21        ldrh	r1, [r4, #16]
@   0x08006a18: 4008        ands	r0, r1
@   0x08006a1a: 2800        cmp	r0, #0
@   0x08006a1c: d001        beq.n	0x6a22
@   0x08006a1e: 2001        movs	r0, #1
@   0x08006a20: e000        b.n	0x6a24
@   0x08006a22: 2000        movs	r0, #0
@   0x08006a24: 2800        cmp	r0, #0
@   0x08006a26: d015        beq.n	0x6a54
@   0x08006a28: 2d10        cmp	r5, #16
@   0x08006a2a: d107        bne.n	0x6a3c
@   0x08006a2c: 8265        strh	r5, [r4, #18]
@   0x08006a2e: 2009        movs	r0, #9
@   0x08006a30: 4240        negs	r0, r0
@   0x08006a32: 8a21        ldrh	r1, [r4, #16]
@   0x08006a34: 4008        ands	r0, r1
@   0x08006a36: 8220        strh	r0, [r4, #16]
@   0x08006a38: 2001        movs	r0, #1
@   0x08006a3a: e015        b.n	0x6a68
@   0x08006a3c: f7f9        ff60 	bl	0x900
@   0x08006a40: 6961        ldr	r1, [r4, #20]
@   0x08006a42: 1a40        subs	r0, r0, r1
@   0x08006a44: 281e        cmp	r0, #30
@   0x08006a46: d905        bls.n	0x6a54
@   0x08006a48: 2009        movs	r0, #9
@   0x08006a4a: 4240        negs	r0, r0
@   0x08006a4c: 8a21        ldrh	r1, [r4, #16]
@   0x08006a4e: 4008        ands	r0, r1
@   0x08006a50: 8220        strh	r0, [r4, #16]
@   0x08006a52: e008        b.n	0x6a66
@   0x08006a54: 2d10        cmp	r5, #16
@   0x08006a56: d106        bne.n	0x6a66
@   0x08006a58: 2008        movs	r0, #8
@   0x08006a5a: 8a21        ldrh	r1, [r4, #16]
@   0x08006a5c: 4308        orrs	r0, r1
@   0x08006a5e: 8220        strh	r0, [r4, #16]
@   0x08006a60: 4803        ldr	r0, [pc, #12]	@ (0x6a70)
@   0x08006a62: 6800        ldr	r0, [r0, #0]
@   0x08006a64: 6160        str	r0, [r4, #20]
@   0x08006a66: 2000        movs	r0, #0
@   0x08006a68: bc30        pop	{r4, r5}
@   0x08006a6a: bc02        pop	{r1}
@   0x08006a6c: 4708        bx	r1
@   0x08006a6e: 0000        movs	r0, r0
@   0x08006a70: 5330        strh	r0, [r6, r4]
@   0x08006a72: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08006A0C
sub_08006A0C: @ 0x08006a0c
        .incbin "frog_us_baserom.gba", 0x6a0c, 0x68
        thumb_func_end sub_08006A0C
