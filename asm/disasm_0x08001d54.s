@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001d54, 0x08001d94)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001d54 --end 0x8001d94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001d54: b530        push	{r4, r5, lr}
@   0x08001d56: 1c03        adds	r3, r0, #0
@   0x08001d58: 1c0c        adds	r4, r1, #0
@   0x08001d5a: 1c15        adds	r5, r2, #0
@   0x08001d5c: 2000        movs	r0, #0
@   0x08001d5e: 1c19        adds	r1, r3, #0
@   0x08001d60: f005        fc7e 	bl	0x7660
@   0x08001d64: f008        fab8 	bl	0xa2d8
@   0x08001d68: f7fe        fdb8 	bl	0x8dc
@   0x08001d6c: f008        fadc 	bl	0xa328
@   0x08001d70: f007        fbc2 	bl	0x94f8
@   0x08001d74: f007        fe06 	bl	0x9984
@   0x08001d78: 1c20        adds	r0, r4, #0
@   0x08001d7a: 1c29        adds	r1, r5, #0
@   0x08001d7c: f7ff        fdbc 	bl	0x18f8
@   0x08001d80: 4903        ldr	r1, [pc, #12]	@ (0x1d90)
@   0x08001d82: 6948        ldr	r0, [r1, #20]
@   0x08001d84: 3001        adds	r0, #1
@   0x08001d86: 6148        str	r0, [r1, #20]
@   0x08001d88: bc30        pop	{r4, r5}
@   0x08001d8a: bc01        pop	{r0}
@   0x08001d8c: 4700        bx	r0
@   0x08001d8e: 0000        movs	r0, r0
@   0x08001d90: 5330        strh	r0, [r6, r4]
@   0x08001d92: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001D54
sub_08001D54: @ 0x08001d54
        .incbin "frog_us_baserom.gba", 0x1d54, 0x40
        thumb_func_end sub_08001D54
