@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006b40, 0x08006b64)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006b40 --end 0x8006b64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006b40: b500        push	{lr}
@   0x08006b42: 1c01        adds	r1, r0, #0
@   0x08006b44: 7908        ldrb	r0, [r1, #4]
@   0x08006b46: 3001        adds	r0, #1
@   0x08006b48: 7108        strb	r0, [r1, #4]
@   0x08006b4a: 0600        lsls	r0, r0, #24
@   0x08006b4c: 1600        asrs	r0, r0, #24
@   0x08006b4e: 280c        cmp	r0, #12
@   0x08006b50: dc03        bgt.n	0x6b5a
@   0x08006b52: f00f        ff75 	bl	0x16a40
@   0x08006b56: 2001        movs	r0, #1
@   0x08006b58: e002        b.n	0x6b60
@   0x08006b5a: 200c        movs	r0, #12
@   0x08006b5c: 7108        strb	r0, [r1, #4]
@   0x08006b5e: 2000        movs	r0, #0
@   0x08006b60: bc02        pop	{r1}
@   0x08006b62: 4708        bx	r1

        thumb_func_start sub_08006B40
sub_08006B40: @ 0x08006b40
        .incbin "frog_us_baserom.gba", 0x6b40, 0x24
        thumb_func_end sub_08006B40
