@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002444, 0x08002450)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002444 --end 0x8002450 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002444: 4901        ldr	r1, [pc, #4]	@ (0x244c)
@   0x08002446: 2006        movs	r0, #6
@   0x08002448: 7288        strb	r0, [r1, #10]
@   0x0800244a: 4770        bx	lr
@   0x0800244c: 5330        strh	r0, [r6, r4]
@   0x0800244e: 0300        lsls	r0, r0, #12

        thumb_func_start SetGameMode_06
SetGameMode_06: @ 0x08002444
        .incbin "frog_us_baserom.gba", 0x2444, 0xc
        thumb_func_end SetGameMode_06
