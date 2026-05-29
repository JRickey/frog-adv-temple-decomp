@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c4e0, 0x0800c4e8)  (8 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c4e0 --end 0x800c4e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c4e0: 4770        bx	lr
@   0x0800c4e2: 0000        movs	r0, r0
@   0x0800c4e4: 4770        bx	lr

        thumb_func_start sub_0800C4E0
sub_0800C4E0: @ 0x0800c4e0
        .incbin "frog_us_baserom.gba", 0xc4e0, 0x8
        thumb_func_end sub_0800C4E0
