@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004c64, 0x08004ca4)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004c64 --end 0x8004ca4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004c64: b530        push	{r4, r5, lr}
@   0x08004c66: 1c03        adds	r3, r0, #0
@   0x08004c68: 1c0c        adds	r4, r1, #0
@   0x08004c6a: 1c15        adds	r5, r2, #0
@   0x08004c6c: 2005        movs	r0, #5
@   0x08004c6e: 1c19        adds	r1, r3, #0
@   0x08004c70: f002        fcf6 	bl	0x7660
@   0x08004c74: f005        fb30 	bl	0xa2d8
@   0x08004c78: f7fb        fe30 	bl	0x8dc
@   0x08004c7c: f005        fb54 	bl	0xa328
@   0x08004c80: f004        fc3a 	bl	0x94f8
@   0x08004c84: f004        fe7e 	bl	0x9984
@   0x08004c88: 1c20        adds	r0, r4, #0
@   0x08004c8a: 1c29        adds	r1, r5, #0
@   0x08004c8c: f7ff        fcae 	bl	0x45ec
@   0x08004c90: 4903        ldr	r1, [pc, #12]	@ (0x4ca0)
@   0x08004c92: 6948        ldr	r0, [r1, #20]
@   0x08004c94: 3001        adds	r0, #1
@   0x08004c96: 6148        str	r0, [r1, #20]
@   0x08004c98: bc30        pop	{r4, r5}
@   0x08004c9a: bc01        pop	{r0}
@   0x08004c9c: 4700        bx	r0
@   0x08004c9e: 0000        movs	r0, r0
@   0x08004ca0: 5330        strh	r0, [r6, r4]
@   0x08004ca2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004C64
sub_08004C64: @ 0x08004c64
        .incbin "frog_us_baserom.gba", 0x4c64, 0x40
        thumb_func_end sub_08004C64
