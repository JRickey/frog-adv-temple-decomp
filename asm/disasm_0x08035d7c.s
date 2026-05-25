@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08035d7c, 0x08035d84)  (8 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8035d7c --end 0x8035d84 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08035d7c: 46c04778    @ <UNDEFINED> instruction: 0x46c04778
@   0x08035d80: eaff28dd    b	0xfc

        arm_func_start sub_08035D7C
sub_08035D7C: @ 0x08035d7c
        .incbin "frog_us_baserom.gba", 0x35d7c, 0x8
        arm_func_end sub_08035D7C
