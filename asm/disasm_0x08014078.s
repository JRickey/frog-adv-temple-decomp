@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014078, 0x080140a0)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014078 --end 0x80140a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014078: b500        push	{lr}
@   0x0801407a: 2002        movs	r0, #2
@   0x0801407c: f7fa        fbee 	bl	0xe85c
@   0x08014080: f7fa        fd4c 	bl	0xeb1c
@   0x08014084: 2005        movs	r0, #5
@   0x08014086: 2103        movs	r1, #3
@   0x08014088: f7fc        fc66 	bl	0x10958
@   0x0801408c: 2002        movs	r0, #2
@   0x0801408e: f7fb        f8dd 	bl	0xf24c
@   0x08014092: 2002        movs	r0, #2
@   0x08014094: f7fa        fda2 	bl	0xebdc
@   0x08014098: f002        fcd2 	bl	0x16a40
@   0x0801409c: bc01        pop	{r0}
@   0x0801409e: 4700        bx	r0

        thumb_func_start sub_08014078
sub_08014078: @ 0x08014078
        .incbin "frog_us_baserom.gba", 0x14078, 0x28
        thumb_func_end sub_08014078
