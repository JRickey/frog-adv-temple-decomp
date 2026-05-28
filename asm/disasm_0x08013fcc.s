@ Trailing stub split off the over-extended sub_08013FA0 peel.
@ Range:  [0x08013fcc, 0x08013fd0)  (4 bytes, thumb mode)
@
@ sub_08013FA0 compiles to 44 bytes (code + one pool word); the auto-peeler
@ pulled in 4 trailing bytes that are a separate dead stub function with no
@ callers or references — keep them verbatim so downstream layout matches.
@   0x08013fcc: 4770   bx lr
@   0x08013fce: 0000   .hword 0x0000

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08013FCC
sub_08013FCC: @ 0x08013fcc
        .incbin "frog_us_baserom.gba", 0x13fcc, 0x4
        thumb_func_end sub_08013FCC
