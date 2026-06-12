@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026a58, 0x08026a98)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026a58 --end 0x8026a98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026a58: b570        push	{r4, r5, r6, lr}
@   0x08026a5a: b084        sub	sp, #16
@   0x08026a5c: 2400        movs	r4, #0
@   0x08026a5e: 4e0d        ldr	r6, [pc, #52]	@ (0x26a94)
@   0x08026a60: 2503        movs	r5, #3
@   0x08026a62: 1c20        adds	r0, r4, #0
@   0x08026a64: 302d        adds	r0, #45	@ 0x2d
@   0x08026a66: 00a1        lsls	r1, r4, #2
@   0x08026a68: 1989        adds	r1, r1, r6
@   0x08026a6a: 6809        ldr	r1, [r1, #0]
@   0x08026a6c: 2281        movs	r2, #129	@ 0x81
@   0x08026a6e: 9200        str	r2, [sp, #0]
@   0x08026a70: 2205        movs	r2, #5
@   0x08026a72: 9201        str	r2, [sp, #4]
@   0x08026a74: 9502        str	r5, [sp, #8]
@   0x08026a76: 9503        str	r5, [sp, #12]
@   0x08026a78: 2210        movs	r2, #16
@   0x08026a7a: 231d        movs	r3, #29
@   0x08026a7c: f7fa        fb10 	bl	0x210a0
@   0x08026a80: 1c60        adds	r0, r4, #1
@   0x08026a82: 0600        lsls	r0, r0, #24
@   0x08026a84: 0e04        lsrs	r4, r0, #24
@   0x08026a86: 2c00        cmp	r4, #0
@   0x08026a88: d0eb        beq.n	0x26a62
@   0x08026a8a: b004        add	sp, #16
@   0x08026a8c: bc70        pop	{r4, r5, r6}
@   0x08026a8e: bc01        pop	{r0}
@   0x08026a90: 4700        bx	r0
@   0x08026a92: 0000        movs	r0, r0
@   0x08026a94: 5adc        ldrh	r4, [r3, r3]
@   0x08026a96: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026A58
sub_08026A58: @ 0x08026a58
        .incbin "baserom.gba", 0x26a58, 0x40
        thumb_func_end sub_08026A58
