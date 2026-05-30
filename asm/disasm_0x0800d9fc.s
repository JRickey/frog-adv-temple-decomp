@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d9fc, 0x0800da10)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d9fc --end 0x800da10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d9fc: 4903        ldr	r1, [pc, #12]	@ (0xda0c)
@   0x0800d9fe: 0600        lsls	r0, r0, #24
@   0x0800da00: 1600        asrs	r0, r0, #24
@   0x0800da02: 1840        adds	r0, r0, r1
@   0x0800da04: 7800        ldrb	r0, [r0, #0]
@   0x0800da06: 0600        lsls	r0, r0, #24
@   0x0800da08: 1600        asrs	r0, r0, #24
@   0x0800da0a: 4770        bx	lr
@   0x0800da0c: 6814        ldr	r4, [r2, #0]
@   0x0800da0e: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_0800D9FC
sub_0800D9FC: @ 0x0800d9fc
        .incbin "frog_us_baserom.gba", 0xd9fc, 0x14
        thumb_func_end sub_0800D9FC
