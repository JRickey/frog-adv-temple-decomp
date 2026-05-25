@ Trailing stubs after sub_08000820 (which now lives in src/game/sub_08000820.c).
@ Range:  [0x08000884, 0x0800088c)  (8 bytes, thumb mode)
@
@ Two tiny empty functions that just return. Their callers are not yet
@ identified; they are kept as separate symbols so the surrounding layout
@ stays byte-identical to the baserom.
@
@   0x08000884: 4770   bx lr
@   0x08000886: 0000   movs r0, r0   (2-byte align pad)
@   0x08000888: 4770   bx lr
@   0x0800088a: 0000   movs r0, r0   (2-byte align pad)

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08000884
sub_08000884: @ 0x08000884
        bx      lr
        .hword  0x0000
        thumb_func_end sub_08000884

        thumb_func_start sub_08000888
sub_08000888: @ 0x08000888
        bx      lr
        .hword  0x0000
        thumb_func_end sub_08000888
