@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031c64, 0x08031c84)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031c64 --end 0x8031c84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031c64: b510        push	{r4, lr}
@   0x08031c66: 1c02        adds	r2, r0, #0
@   0x08031c68: 1c0c        adds	r4, r1, #0
@   0x08031c6a: 6821        ldr	r1, [r4, #0]
@   0x08031c6c: 2302        movs	r3, #2
@   0x08031c6e: 5ec8        ldrsh	r0, [r1, r3]
@   0x08031c70: 8889        ldrh	r1, [r1, #4]
@   0x08031c72: f7fc        ffc1 	bl	0x2ebf8
@   0x08031c76: 6820        ldr	r0, [r4, #0]
@   0x08031c78: 3006        adds	r0, #6
@   0x08031c7a: 6020        str	r0, [r4, #0]
@   0x08031c7c: 2001        movs	r0, #1
@   0x08031c7e: bc10        pop	{r4}
@   0x08031c80: bc02        pop	{r1}
@   0x08031c82: 4708        bx	r1

        thumb_func_start sub_08031C64
sub_08031C64: @ 0x08031c64
        .incbin "frog_us_baserom.gba", 0x31c64, 0x20
        thumb_func_end sub_08031C64
