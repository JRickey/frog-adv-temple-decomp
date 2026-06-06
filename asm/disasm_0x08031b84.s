@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031b84, 0x08031bb8)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031b84 --end 0x8031bb8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031b84: b510        push	{r4, lr}
@   0x08031b86: 1c0b        adds	r3, r1, #0
@   0x08031b88: 681a        ldr	r2, [r3, #0]
@   0x08031b8a: 4807        ldr	r0, [pc, #28]	@ (0x31ba8)
@   0x08031b8c: 6800        ldr	r0, [r0, #0]
@   0x08031b8e: 2101        movs	r1, #1
@   0x08031b90: 7854        ldrb	r4, [r2, #1]
@   0x08031b92: 40a1        lsls	r1, r4
@   0x08031b94: 6880        ldr	r0, [r0, #8]
@   0x08031b96: 4008        ands	r0, r1
@   0x08031b98: 2800        cmp	r0, #0
@   0x08031b9a: d007        beq.n	0x31bac
@   0x08031b9c: 8891        ldrh	r1, [r2, #4]
@   0x08031b9e: 0408        lsls	r0, r1, #16
@   0x08031ba0: 8854        ldrh	r4, [r2, #2]
@   0x08031ba2: 4320        orrs	r0, r4
@   0x08031ba4: 1810        adds	r0, r2, r0
@   0x08031ba6: e002        b.n	0x31bae
@   0x08031ba8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031baa: 0300        lsls	r0, r0, #12
@   0x08031bac: 1d90        adds	r0, r2, #6
@   0x08031bae: 6018        str	r0, [r3, #0]
@   0x08031bb0: 2001        movs	r0, #1
@   0x08031bb2: bc10        pop	{r4}
@   0x08031bb4: bc02        pop	{r1}
@   0x08031bb6: 4708        bx	r1

        thumb_func_start sub_08031B84
sub_08031B84: @ 0x08031b84
        .incbin "frog_us_baserom.gba", 0x31b84, 0x34
        thumb_func_end sub_08031B84
