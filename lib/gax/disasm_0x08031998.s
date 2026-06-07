@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031998, 0x080319c0)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031998 --end 0x80319c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031998: b510        push	{r4, lr}
@   0x0803199a: 1c02        adds	r2, r0, #0
@   0x0803199c: 1c0c        adds	r4, r1, #0
@   0x0803199e: 6820        ldr	r0, [r4, #0]
@   0x080319a0: 2a01        cmp	r2, #1
@   0x080319a2: dd01        ble.n	0x319a8
@   0x080319a4: 2a03        cmp	r2, #3
@   0x080319a6: d103        bne.n	0x319b0
@   0x080319a8: 7840        ldrb	r0, [r0, #1]
@   0x080319aa: 1c11        adds	r1, r2, #0
@   0x080319ac: f7fd        ff70 	bl	0x2f890
@   0x080319b0: 6820        ldr	r0, [r4, #0]
@   0x080319b2: 3002        adds	r0, #2
@   0x080319b4: 6020        str	r0, [r4, #0]
@   0x080319b6: 2001        movs	r0, #1
@   0x080319b8: bc10        pop	{r4}
@   0x080319ba: bc02        pop	{r1}
@   0x080319bc: 4708        bx	r1

        thumb_func_start sub_08031998
sub_08031998: @ 0x08031998
        .incbin "frog_us_baserom.gba", 0x31998, 0x28
        thumb_func_end sub_08031998
