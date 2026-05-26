@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000cec, 0x08000d2c)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000cec --end 0x8000d2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000cec: b530        push	{r4, r5, lr}
@   0x08000cee: 1c04        adds	r4, r0, #0
@   0x08000cf0: 1c0d        adds	r5, r1, #0
@   0x08000cf2: f009        faf1 	bl	0xa2d8
@   0x08000cf6: f7ff        fdf1 	bl	0x8dc
@   0x08000cfa: f009        fb15 	bl	0xa328
@   0x08000cfe: 4809        ldr	r0, [pc, #36]	@ (0xd24)
@   0x08000d00: 2105        movs	r1, #5
@   0x08000d02: f015        fb7f 	bl	0x16404
@   0x08000d06: f008        fbf7 	bl	0x94f8
@   0x08000d0a: f008        fe3b 	bl	0x9984
@   0x08000d0e: 1c20        adds	r0, r4, #0
@   0x08000d10: 1c29        adds	r1, r5, #0
@   0x08000d12: f7ff        ff2b 	bl	0xb6c
@   0x08000d16: 4904        ldr	r1, [pc, #16]	@ (0xd28)
@   0x08000d18: 6948        ldr	r0, [r1, #20]
@   0x08000d1a: 3001        adds	r0, #1
@   0x08000d1c: 6148        str	r0, [r1, #20]
@   0x08000d1e: bc30        pop	{r4, r5}
@   0x08000d20: bc01        pop	{r0}
@   0x08000d22: 4700        bx	r0
@   0x08000d24: 6944        ldr	r4, [r0, #20]
@   0x08000d26: 0830        lsrs	r0, r6, #32
@   0x08000d28: 5330        strh	r0, [r6, r4]
@   0x08000d2a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000CEC
sub_08000CEC: @ 0x08000cec
        .incbin "frog_us_baserom.gba", 0xcec, 0x40
        thumb_func_end sub_08000CEC
