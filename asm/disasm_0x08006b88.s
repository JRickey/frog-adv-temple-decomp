@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006b88, 0x08006b94)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006b88 --end 0x8006b94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006b88: 0409        lsls	r1, r1, #16
@   0x08006b8a: 0c09        lsrs	r1, r1, #16
@   0x08006b8c: 8a02        ldrh	r2, [r0, #16]
@   0x08006b8e: 4311        orrs	r1, r2
@   0x08006b90: 8201        strh	r1, [r0, #16]
@   0x08006b92: 4770        bx	lr

        thumb_func_start sub_08006B88
sub_08006B88: @ 0x08006b88
        .incbin "frog_us_baserom.gba", 0x6b88, 0xc
        thumb_func_end sub_08006B88
