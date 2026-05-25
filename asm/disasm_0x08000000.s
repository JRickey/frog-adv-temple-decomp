@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000000, 0x08000004)  (4 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000000 --end 0x8000004 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000000: ea00002e    b	0xc0

        arm_func_start entry_branch
entry_branch: @ 0x08000000
        .incbin "frog_us_baserom.gba", 0x0, 0x4
        arm_func_end entry_branch
