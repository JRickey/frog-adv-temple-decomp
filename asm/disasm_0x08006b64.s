@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006b64, 0x08006b88)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006b64 --end 0x8006b88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006b64: b500        push	{lr}
@   0x08006b66: 1c01        adds	r1, r0, #0
@   0x08006b68: 8848        ldrh	r0, [r1, #2]
@   0x08006b6a: 3001        adds	r0, #1
@   0x08006b6c: 8048        strh	r0, [r1, #2]
@   0x08006b6e: 2000        movs	r0, #0
@   0x08006b70: 5608        ldrsb	r0, [r1, r0]
@   0x08006b72: 2800        cmp	r0, #0
@   0x08006b74: db03        blt.n	0x6b7e
@   0x08006b76: f00f        ff63 	bl	0x16a40
@   0x08006b7a: 2001        movs	r0, #1
@   0x08006b7c: e001        b.n	0x6b82
@   0x08006b7e: 2000        movs	r0, #0
@   0x08006b80: 8048        strh	r0, [r1, #2]
@   0x08006b82: bc02        pop	{r1}
@   0x08006b84: 4708        bx	r1

        thumb_func_start sub_08006B64
sub_08006B64: @ 0x08006b64
        .incbin "frog_us_baserom.gba", 0x6b64, 0x24
        thumb_func_end sub_08006B64
