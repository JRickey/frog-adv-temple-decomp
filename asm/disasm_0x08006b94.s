@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006b94, 0x08006ba4)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006b94 --end 0x8006ba4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006b94: 0409        lsls	r1, r1, #16
@   0x08006b96: 0c09        lsrs	r1, r1, #16
@   0x08006b98: 8a02        ldrh	r2, [r0, #16]
@   0x08006b9a: 438a        bics	r2, r1
@   0x08006b9c: 1c11        adds	r1, r2, #0
@   0x08006b9e: 8201        strh	r1, [r0, #16]
@   0x08006ba0: 4770        bx	lr

        thumb_func_start sub_08006B94
sub_08006B94: @ 0x08006b94
        .incbin "frog_us_baserom.gba", 0x6b94, 0x10
        thumb_func_end sub_08006B94
