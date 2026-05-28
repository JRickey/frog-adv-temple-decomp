@ Manually split from disasm_0x08020e98.s.
@ Range:  [0x08020ee4, 0x08020f08)  (36 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020ee4: b500        push	{lr}
@   0x08020ee6: 0600        lsls	r0, r0, #24
@   0x08020ee8: 0e02        lsrs	r2, r0, #24
@   0x08020eea: 4906        ldr	r1, [pc, #24]	@ (0x20f04)
@   0x08020eec: 78c8        ldrb	r0, [r1, #3]
@   0x08020eee: 28f4        cmp	r0, #244	@ 0xf4
@   0x08020ef0: d805        bhi.n	0x20efe
@   0x08020ef2: 3001        adds	r0, #1
@   0x08020ef4: 70c8        strb	r0, [r1, #3]
@   0x08020ef6: 78c9        ldrb	r1, [r1, #3]
@   0x08020ef8: 1c10        adds	r0, r2, #0
@   0x08020efa: f00c        fe8f 	bl	0x2dc1c
@   0x08020efe: bc01        pop	{r0}
@   0x08020f00: 4700        bx	r0
@   0x08020f02: 0000        movs	r0, r0  (filler)
@   0x08020f04: 3570        adds	r5, #112	@ 0x70 (pool: 0x03003570)
@   0x08020f06: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020EE4
sub_08020EE4: @ 0x08020ee4
        .incbin "frog_us_baserom.gba", 0x20ee4, 0x24
        thumb_func_end sub_08020EE4
