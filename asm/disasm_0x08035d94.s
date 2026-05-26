@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08035d94, 0x08035d9c)  (8 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8035d94 --end 0x8035d9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08035d94: 4778        bx	pc
@   0x08035d96: 46c0        nop			@ (mov r8, r8)
@   0x08035d98: f41f        eaff 	bfcsel	10, 0x3539a, 14, vc

        thumb_func_start sub_08035D94
sub_08035D94: @ 0x08035d94
        .incbin "frog_us_baserom.gba", 0x35d94, 0x8
        thumb_func_end sub_08035D94
