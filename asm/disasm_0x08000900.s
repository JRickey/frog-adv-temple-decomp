@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000900, 0x0800090c)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000900 --end 0x800090c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000900: 4801        ldr	r0, [pc, #4]	@ (0x908)
@   0x08000902: 6800        ldr	r0, [r0, #0]
@   0x08000904: 4770        bx	lr
@   0x08000906: 0000        movs	r0, r0
@   0x08000908: 5330        strh	r0, [r6, r4]   @ pool: 0x03005330 (gGameStuff)
@   0x0800090a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000900
sub_08000900: @ 0x08000900
        .incbin "frog_us_baserom.gba", 0x900, 0xc
        thumb_func_end sub_08000900
