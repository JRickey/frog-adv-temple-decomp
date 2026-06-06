@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080316fc, 0x08031720)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80316fc --end 0x8031720 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080316fc: b530        push	{r4, r5, lr}
@   0x080316fe: 1c03        adds	r3, r0, #0
@   0x08031700: 1c0c        adds	r4, r1, #0
@   0x08031702: 6822        ldr	r2, [r4, #0]
@   0x08031704: 7850        ldrb	r0, [r2, #1]
@   0x08031706: 2502        movs	r5, #2
@   0x08031708: 5f51        ldrsh	r1, [r2, r5]
@   0x0803170a: 2504        movs	r5, #4
@   0x0803170c: 5f52        ldrsh	r2, [r2, r5]
@   0x0803170e: f7fe        f945 	bl	0x2f99c
@   0x08031712: 6820        ldr	r0, [r4, #0]
@   0x08031714: 3006        adds	r0, #6
@   0x08031716: 6020        str	r0, [r4, #0]
@   0x08031718: 2001        movs	r0, #1
@   0x0803171a: bc30        pop	{r4, r5}
@   0x0803171c: bc02        pop	{r1}
@   0x0803171e: 4708        bx	r1

        thumb_func_start sub_080316FC
sub_080316FC: @ 0x080316fc
        .incbin "frog_us_baserom.gba", 0x316fc, 0x24
        thumb_func_end sub_080316FC
