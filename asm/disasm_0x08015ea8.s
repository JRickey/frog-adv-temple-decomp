@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015ea8, 0x08015ec4)  (28 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015ea8 --end 0x8015ec4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015ea8: b500        push	{lr}
@   0x08015eaa: 2002        movs	r0, #2
@   0x08015eac: f7f8        fcd6 	bl	0xe85c
@   0x08015eb0: 2002        movs	r0, #2
@   0x08015eb2: f004        fc0f 	bl	0x1a6d4
@   0x08015eb6: 2002        movs	r0, #2
@   0x08015eb8: f7f8        fe90 	bl	0xebdc
@   0x08015ebc: bc01        pop	{r0}
@   0x08015ebe: 4700        bx	r0
@   0x08015ec0: 4770        bx	lr

        thumb_func_start sub_08015EA8
sub_08015EA8: @ 0x08015ea8
        .incbin "frog_us_baserom.gba", 0x15ea8, 0x1c
        thumb_func_end sub_08015EA8
