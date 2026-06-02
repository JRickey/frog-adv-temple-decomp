@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801bb1c, 0x0801bb54)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801bb1c --end 0x801bb54 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801bb1c: b500        push	{lr}
@   0x0801bb1e: b081        sub	sp, #4
@   0x0801bb20: f7ff        fb18 	bl	0x1b154
@   0x0801bb24: 0600        lsls	r0, r0, #24
@   0x0801bb26: 0e00        lsrs	r0, r0, #24
@   0x0801bb28: 2810        cmp	r0, #16
@   0x0801bb2a: d100        bne.n	0x1bb2e
@   0x0801bb2c: 200f        movs	r0, #15
@   0x0801bb2e: 4907        ldr	r1, [pc, #28]	@ (0x1bb4c)
@   0x0801bb30: 0080        lsls	r0, r0, #2
@   0x0801bb32: 1840        adds	r0, r0, r1
@   0x0801bb34: 6801        ldr	r1, [r0, #0]
@   0x0801bb36: 4b06        ldr	r3, [pc, #24]	@ (0x1bb50)
@   0x0801bb38: 2000        movs	r0, #0
@   0x0801bb3a: 9000        str	r0, [sp, #0]
@   0x0801bb3c: 2004        movs	r0, #4
@   0x0801bb3e: 2233        movs	r2, #51	@ 0x33
@   0x0801bb40: f005        fce6 	bl	0x21510
@   0x0801bb44: b001        add	sp, #4
@   0x0801bb46: bc01        pop	{r0}
@   0x0801bb48: 4700        bx	r0
@   0x0801bb4a: 0000        movs	r0, r0
@   0x0801bb4c: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x0801bb4e: 0830        lsrs	r0, r6, #32
@   0x0801bb50: 6110        str	r0, [r2, #16]
@   0x0801bb52: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801BB1C
sub_0801BB1C: @ 0x0801bb1c
        .incbin "frog_us_baserom.gba", 0x1bb1c, 0x38
        thumb_func_end sub_0801BB1C
