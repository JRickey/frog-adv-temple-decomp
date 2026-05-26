@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a3a4, 0x0800a3d0)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a3a4 --end 0x800a3d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a3a4: b530        push	{r4, r5, lr}
@   0x0800a3a6: 6802        ldr	r2, [r0, #0]
@   0x0800a3a8: 6843        ldr	r3, [r0, #4]
@   0x0800a3aa: 680c        ldr	r4, [r1, #0]
@   0x0800a3ac: 684d        ldr	r5, [r1, #4]
@   0x0800a3ae: 8840        ldrh	r0, [r0, #2]
@   0x0800a3b0: 8849        ldrh	r1, [r1, #2]
@   0x0800a3b2: 4288        cmp	r0, r1
@   0x0800a3b4: d201        bcs.n	0xa3ba
@   0x0800a3b6: 2001        movs	r0, #1
@   0x0800a3b8: e007        b.n	0xa3ca
@   0x0800a3ba: 0c11        lsrs	r1, r2, #16
@   0x0800a3bc: 0c20        lsrs	r0, r4, #16
@   0x0800a3be: 4281        cmp	r1, r0
@   0x0800a3c0: d801        bhi.n	0xa3c6
@   0x0800a3c2: 2000        movs	r0, #0
@   0x0800a3c4: e001        b.n	0xa3ca
@   0x0800a3c6: 2001        movs	r0, #1
@   0x0800a3c8: 4240        negs	r0, r0
@   0x0800a3ca: bc30        pop	{r4, r5}
@   0x0800a3cc: bc02        pop	{r1}
@   0x0800a3ce: 4708        bx	r1

        thumb_func_start sub_0800A3A4
sub_0800A3A4: @ 0x0800a3a4
        .incbin "frog_us_baserom.gba", 0xa3a4, 0x2c
        thumb_func_end sub_0800A3A4
