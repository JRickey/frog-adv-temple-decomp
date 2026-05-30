@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006b20, 0x08006b40)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006b20 --end 0x8006b40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006b20: b500        push	{lr}
@   0x08006b22: 1c01        adds	r1, r0, #0
@   0x08006b24: 8848        ldrh	r0, [r1, #2]
@   0x08006b26: 3001        adds	r0, #1
@   0x08006b28: 8048        strh	r0, [r1, #2]
@   0x08006b2a: 0400        lsls	r0, r0, #16
@   0x08006b2c: 2800        cmp	r0, #0
@   0x08006b2e: db03        blt.n	0x6b38
@   0x08006b30: f00f        ff86 	bl	0x16a40
@   0x08006b34: 2001        movs	r0, #1
@   0x08006b36: e001        b.n	0x6b3c
@   0x08006b38: 2000        movs	r0, #0
@   0x08006b3a: 8048        strh	r0, [r1, #2]
@   0x08006b3c: bc02        pop	{r1}
@   0x08006b3e: 4708        bx	r1

        thumb_func_start sub_08006B20
sub_08006B20: @ 0x08006b20
        .incbin "frog_us_baserom.gba", 0x6b20, 0x20
        thumb_func_end sub_08006B20
