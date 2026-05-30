@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006ab8, 0x08006adc)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006ab8 --end 0x8006adc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006ab8: b500        push	{lr}
@   0x08006aba: 1c01        adds	r1, r0, #0
@   0x08006abc: 7808        ldrb	r0, [r1, #0]
@   0x08006abe: 3001        adds	r0, #1
@   0x08006ac0: 7008        strb	r0, [r1, #0]
@   0x08006ac2: 0600        lsls	r0, r0, #24
@   0x08006ac4: 1600        asrs	r0, r0, #24
@   0x08006ac6: 280a        cmp	r0, #10
@   0x08006ac8: dc03        bgt.n	0x6ad2
@   0x08006aca: f00f        ffb9 	bl	0x16a40
@   0x08006ace: 2001        movs	r0, #1
@   0x08006ad0: e002        b.n	0x6ad8
@   0x08006ad2: 200a        movs	r0, #10
@   0x08006ad4: 7008        strb	r0, [r1, #0]
@   0x08006ad6: 2000        movs	r0, #0
@   0x08006ad8: bc02        pop	{r1}
@   0x08006ada: 4708        bx	r1

        thumb_func_start sub_08006AB8
sub_08006AB8: @ 0x08006ab8
        .incbin "frog_us_baserom.gba", 0x6ab8, 0x24
        thumb_func_end sub_08006AB8
