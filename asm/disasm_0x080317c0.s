@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080317c0, 0x080317e0)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80317c0 --end 0x80317e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080317c0: b510        push	{r4, lr}
@   0x080317c2: 1c02        adds	r2, r0, #0
@   0x080317c4: 1c0c        adds	r4, r1, #0
@   0x080317c6: 6821        ldr	r1, [r4, #0]
@   0x080317c8: 7848        ldrb	r0, [r1, #1]
@   0x080317ca: 8849        ldrh	r1, [r1, #2]
@   0x080317cc: f7fd        fbd6 	bl	0x2ef7c
@   0x080317d0: 6820        ldr	r0, [r4, #0]
@   0x080317d2: 3004        adds	r0, #4
@   0x080317d4: 6020        str	r0, [r4, #0]
@   0x080317d6: 2001        movs	r0, #1
@   0x080317d8: bc10        pop	{r4}
@   0x080317da: bc02        pop	{r1}
@   0x080317dc: 4708        bx	r1

        thumb_func_start sub_080317C0
sub_080317C0: @ 0x080317c0
        .incbin "frog_us_baserom.gba", 0x317c0, 0x20
        thumb_func_end sub_080317C0
