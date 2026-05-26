@ libgcc _call_via_rX.o helper table — peeled from baserom at 0x08033cd8.
@ Range:  [0x08033cd8, 0x08033d14)  (60 bytes, 14 entries × 4 bytes each)
@
@ Each entry is `bx rN; nop` (Thumb interwork call-via-register thunk).
@ agbcc emits `bl _call_via_rN` for `(*fp)()` when the function pointer
@ lands in rN. Bytewise-identical to tools/agbcc/lib/libgcc.a:_call_via_rX.o.
@
@ Symbols declared individually so the linker resolves each canonical
@ _call_via_rN to its in-ROM location (per docs/codegen-notes.md
@ "In-ROM libgcc helpers — rename the peeled symbol, don't extern it").

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start _call_via_r0
_call_via_r0: @ 0x08033cd8
        .incbin "frog_us_baserom.gba", 0x33cd8, 0x4
        thumb_func_end _call_via_r0

        thumb_func_start _call_via_r1
_call_via_r1: @ 0x08033cdc
        .incbin "frog_us_baserom.gba", 0x33cdc, 0x4
        thumb_func_end _call_via_r1

        thumb_func_start _call_via_r2
_call_via_r2: @ 0x08033ce0
        .incbin "frog_us_baserom.gba", 0x33ce0, 0x4
        thumb_func_end _call_via_r2

        thumb_func_start _call_via_r3
_call_via_r3: @ 0x08033ce4
        .incbin "frog_us_baserom.gba", 0x33ce4, 0x4
        thumb_func_end _call_via_r3

        thumb_func_start _call_via_r4
_call_via_r4: @ 0x08033ce8
        .incbin "frog_us_baserom.gba", 0x33ce8, 0x4
        thumb_func_end _call_via_r4

        thumb_func_start _call_via_r5
_call_via_r5: @ 0x08033cec
        .incbin "frog_us_baserom.gba", 0x33cec, 0x4
        thumb_func_end _call_via_r5

        thumb_func_start _call_via_r6
_call_via_r6: @ 0x08033cf0
        .incbin "frog_us_baserom.gba", 0x33cf0, 0x4
        thumb_func_end _call_via_r6

        thumb_func_start _call_via_r7
_call_via_r7: @ 0x08033cf4
        .incbin "frog_us_baserom.gba", 0x33cf4, 0x4
        thumb_func_end _call_via_r7

        thumb_func_start _call_via_r8
_call_via_r8: @ 0x08033cf8
        .incbin "frog_us_baserom.gba", 0x33cf8, 0x4
        thumb_func_end _call_via_r8

        thumb_func_start _call_via_r9
_call_via_r9: @ 0x08033cfc
        .incbin "frog_us_baserom.gba", 0x33cfc, 0x4
        thumb_func_end _call_via_r9

        thumb_func_start _call_via_sl
_call_via_sl: @ 0x08033d00
        .incbin "frog_us_baserom.gba", 0x33d00, 0x4
        thumb_func_end _call_via_sl

        thumb_func_start _call_via_fp
_call_via_fp: @ 0x08033d04
        .incbin "frog_us_baserom.gba", 0x33d04, 0x4
        thumb_func_end _call_via_fp

        thumb_func_start _call_via_ip
_call_via_ip: @ 0x08033d08
        .incbin "frog_us_baserom.gba", 0x33d08, 0x4
        thumb_func_end _call_via_ip

        thumb_func_start _call_via_sp
_call_via_sp: @ 0x08033d0c
        .incbin "frog_us_baserom.gba", 0x33d0c, 0x4
        thumb_func_end _call_via_sp

        thumb_func_start _call_via_lr
_call_via_lr: @ 0x08033d10
        .incbin "frog_us_baserom.gba", 0x33d10, 0x4
        thumb_func_end _call_via_lr
