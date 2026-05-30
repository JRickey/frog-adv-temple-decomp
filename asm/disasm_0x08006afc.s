@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006afc, 0x08006b20)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006afc --end 0x8006b20 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006afc: b500        push	{lr}
@   0x08006afe: 1c01        adds	r1, r0, #0
@   0x08006b00: 8848        ldrh	r0, [r1, #2]
@   0x08006b02: 3001        adds	r0, #1
@   0x08006b04: 8048        strh	r0, [r1, #2]
@   0x08006b06: 0400        lsls	r0, r0, #16
@   0x08006b08: 1400        asrs	r0, r0, #16
@   0x08006b0a: 2863        cmp	r0, #99	@ 0x63
@   0x08006b0c: dc03        bgt.n	0x6b16
@   0x08006b0e: f00f        ff97 	bl	0x16a40
@   0x08006b12: 2001        movs	r0, #1
@   0x08006b14: e002        b.n	0x6b1c
@   0x08006b16: 2063        movs	r0, #99	@ 0x63
@   0x08006b18: 8048        strh	r0, [r1, #2]
@   0x08006b1a: 2000        movs	r0, #0
@   0x08006b1c: bc02        pop	{r1}
@   0x08006b1e: 4708        bx	r1

        thumb_func_start sub_08006AFC
sub_08006AFC: @ 0x08006afc
        .incbin "frog_us_baserom.gba", 0x6afc, 0x24
        thumb_func_end sub_08006AFC
