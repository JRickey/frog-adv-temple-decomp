@ sub_08000430: helper function called from AgbMain's prologue (bl at 0x2AE).
@ 148 bytes; prologue `push {r4, lr}` at 0x430. Literal pool at the tail
@ (0x080004A4-0x080004C3) holds 8 EWRAM/MMIO base addresses including
@ REG_IE and several gGameStuff-adjacent IWRAM structs.
@
@ Range:  [0x08000430, 0x080004c4)  (148 bytes, thumb mode)
@ Name `sub_08000430` until purpose is identified — likely Init1, the
@ initialization routine called once before the main dispatch loop.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08000430
sub_08000430: @ 0x08000430
        .incbin "frog_us_baserom.gba", 0x430, 0x94
        thumb_func_end sub_08000430
