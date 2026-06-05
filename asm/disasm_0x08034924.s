@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034924, 0x0803493c)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034924 --end 0x803493c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034924: b500        push	{lr}
@   0x08034926: b084        sub	sp, #16
@   0x08034928: 9000        str	r0, [sp, #0]
@   0x0803492a: 9101        str	r1, [sp, #4]
@   0x0803492c: 9202        str	r2, [sp, #8]
@   0x0803492e: 9303        str	r3, [sp, #12]
@   0x08034930: 4668        mov	r0, sp
@   0x08034932: f7ff        fb73 	bl	0x3401c
@   0x08034936: b004        add	sp, #16
@   0x08034938: bd00        pop	{pc}

        thumb_func_start sub_08034924
sub_08034924: @ 0x08034924
        .incbin "frog_us_baserom.gba", 0x34924, 0x18
        thumb_func_end sub_08034924
