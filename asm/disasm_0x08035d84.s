@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08035d84, 0x08035d8c)  (8 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8035d84 --end 0x8035d8c --mode thumb
@
@ Boundary evidence (manual; boundary.py has no model for 8-byte
@ interwork veneers — its recommended end walks past the ARM word, a
@ known false negative for this shape, same as the three mapped
@ veneers around it):
@   - bl target from mapped Thumb code at 0x0800090c (push {lr};
@     bl 0x35d84), so the entry executes in Thumb state.
@   - Body is the standard Thumb-to-ARM interwork veneer, byte-shape
@     identical to IntrEnable_Thunk (0x08035d7c), SoundIrqDisable
@     (0x08035d8c) and SoundIrqEnable (0x08035d94) beside it:
@     bx pc; nop (Thumb), then one ARM b.
@   - ARM word at 0x08035d88 is 0xeaff292c = b 0x08000240
@     (0x08035d90 - 0xd6d4*4), i.e. sub_08000240, the shipped ARM
@     runtime helper after IntrMain — hence the name.
@   - The ARM b is an unconditional control transfer; the veneer ends
@     exactly at 0x08035d8c = start of the already-mapped
@     SoundIrqDisable. Whole 8-byte gap consumed.

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below; the tail
@ word is ARM, decoded manually — objdump -Mforce-thumb mangles it):
@   0x08035d84: 4778        bx	pc                  @ Thumb
@   0x08035d86: 46c0        nop                      @ (mov r8, r8)
@   0x08035d88: eaff292c    b	0x8000240           @ ARM: -> sub_08000240

        thumb_func_start sub_08000240_Thunk
sub_08000240_Thunk: @ 0x08035d84
        .incbin "frog_us_baserom.gba", 0x35d84, 0x8
        thumb_func_end sub_08000240_Thunk
