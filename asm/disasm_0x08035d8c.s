@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08035d8c, 0x08035d94)  (8 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8035d8c --end 0x8035d94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08035d8c: 4778        bx	pc
@   0x08035d8e: 46c0        nop			@ (mov r8, r8)
@   0x08035d90: f428        eaff 	bfcsel	10, 0x36392, 12, ge

        thumb_func_start sub_08035D8C
sub_08035D8C: @ 0x08035d8c
        .incbin "frog_us_baserom.gba", 0x35d8c, 0x8
        thumb_func_end sub_08035D8C
