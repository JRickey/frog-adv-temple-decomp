@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c2a8, 0x0800c2d0)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c2a8 --end 0x800c2d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c2a8: b510        push	{r4, lr}
@   0x0800c2aa: 4c08        ldr	r4, [pc, #32]	@ (0xc2cc)
@   0x0800c2ac: 0609        lsls	r1, r1, #24
@   0x0800c2ae: 1609        asrs	r1, r1, #24
@   0x0800c2b0: 004b        lsls	r3, r1, #1
@   0x0800c2b2: 185b        adds	r3, r3, r1
@   0x0800c2b4: 009b        lsls	r3, r3, #2
@   0x0800c2b6: 3404        adds	r4, #4
@   0x0800c2b8: 191b        adds	r3, r3, r4
@   0x0800c2ba: 0612        lsls	r2, r2, #24
@   0x0800c2bc: 6819        ldr	r1, [r3, #0]
@   0x0800c2be: 1592        asrs	r2, r2, #22
@   0x0800c2c0: 1852        adds	r2, r2, r1
@   0x0800c2c2: 6811        ldr	r1, [r2, #0]
@   0x0800c2c4: 6001        str	r1, [r0, #0]
@   0x0800c2c6: bc10        pop	{r4}
@   0x0800c2c8: bc02        pop	{r1}
@   0x0800c2ca: 4708        bx	r1
@   0x0800c2cc: 0b00        lsrs	r0, r0, #12
@   0x0800c2ce: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800C2A8
sub_0800C2A8: @ 0x0800c2a8
        .incbin "frog_us_baserom.gba", 0xc2a8, 0x28
        thumb_func_end sub_0800C2A8
