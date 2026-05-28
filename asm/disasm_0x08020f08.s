@ Manually split from disasm_0x08020e98.s.
@ Range:  [0x08020f08, 0x08020f3c)  (52 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020f08: b500        push	{lr}
@   0x08020f0a: 0600        lsls	r0, r0, #24
@   0x08020f0c: 0e02        lsrs	r2, r0, #24
@   0x08020f0e: 4906        ldr	r1, [pc, #24]	@ (0x20f28)
@   0x08020f10: 78c8        ldrb	r0, [r1, #3]
@   0x08020f12: 3801        subs	r0, #1
@   0x08020f14: 70c8        strb	r0, [r1, #3]
@   0x08020f16: 0600        lsls	r0, r0, #24
@   0x08020f18: 0e00        lsrs	r0, r0, #24
@   0x08020f1a: 28ff        cmp	r0, #255	@ 0xff
@   0x08020f1c: d006        beq.n	0x20f2c
@   0x08020f1e: 78c9        ldrb	r1, [r1, #3]
@   0x08020f20: 1c10        adds	r0, r2, #0
@   0x08020f22: f00c        fe7b 	bl	0x2dc1c
@   0x08020f26: e007        b.n	0x20f38
@   0x08020f28: 3570        adds	r5, #112	@ 0x70 (pool: 0x03003570, branched over)
@   0x08020f2a: 0300        lsls	r0, r0, #12
@   0x08020f2c: 00d0        lsls	r0, r2, #3
@   0x08020f2e: 3108        adds	r1, #8
@   0x08020f30: 1840        adds	r0, r0, r1
@   0x08020f32: 6800        ldr	r0, [r0, #0]
@   0x08020f34: f00d        f8e4 	bl	0x2e100
@   0x08020f38: bc01        pop	{r0}
@   0x08020f3a: 4700        bx	r0

        thumb_func_start sub_08020F08
sub_08020F08: @ 0x08020f08
        .incbin "frog_us_baserom.gba", 0x20f08, 0x34
        thumb_func_end sub_08020F08
