@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015a2c, 0x08015a50)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015a2c --end 0x8015a50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015a2c: b500        push	{lr}
@   0x08015a2e: f7f8        fed1 	bl	0xe7d4
@   0x08015a32: 4806        ldr	r0, [pc, #24]	@ (0x15a4c)
@   0x08015a34: 3033        adds	r0, #51	@ 0x33
@   0x08015a36: 7800        ldrb	r0, [r0, #0]
@   0x08015a38: 2800        cmp	r0, #0
@   0x08015a3a: d101        bne.n	0x15a40
@   0x08015a3c: f016        f92a 	bl	0x2bc94
@   0x08015a40: f001        fade 	bl	0x17000
@   0x08015a44: f7ef        fc82 	bl	0x534c
@   0x08015a48: bc01        pop	{r0}
@   0x08015a4a: 4700        bx	r0
@   0x08015a4c: 6110        str	r0, [r2, #16]
@   0x08015a4e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08015A2C
sub_08015A2C: @ 0x08015a2c
        .incbin "frog_us_baserom.gba", 0x15a2c, 0x24
        thumb_func_end sub_08015A2C
