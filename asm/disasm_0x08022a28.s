@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022a28, 0x08022a9c)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022a28 --end 0x8022a9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022a28: b500        push	{lr}
@   0x08022a2a: 2031        movs	r0, #49	@ 0x31
@   0x08022a2c: f7ea        fafc 	bl	0xd028
@   0x08022a30: 2800        cmp	r0, #0
@   0x08022a32: d003        beq.n	0x22a3c
@   0x08022a34: 4814        ldr	r0, [pc, #80]	@ (0x22a88)
@   0x08022a36: 2131        movs	r1, #49	@ 0x31
@   0x08022a38: f7ff        fa58 	bl	0x21eec
@   0x08022a3c: 2032        movs	r0, #50	@ 0x32
@   0x08022a3e: f7ea        faf3 	bl	0xd028
@   0x08022a42: 2800        cmp	r0, #0
@   0x08022a44: d003        beq.n	0x22a4e
@   0x08022a46: 4811        ldr	r0, [pc, #68]	@ (0x22a8c)
@   0x08022a48: 2132        movs	r1, #50	@ 0x32
@   0x08022a4a: f7ff        fa4f 	bl	0x21eec
@   0x08022a4e: 2033        movs	r0, #51	@ 0x33
@   0x08022a50: f7ea        faea 	bl	0xd028
@   0x08022a54: 2800        cmp	r0, #0
@   0x08022a56: d003        beq.n	0x22a60
@   0x08022a58: 480d        ldr	r0, [pc, #52]	@ (0x22a90)
@   0x08022a5a: 2133        movs	r1, #51	@ 0x33
@   0x08022a5c: f7ff        fa46 	bl	0x21eec
@   0x08022a60: 2034        movs	r0, #52	@ 0x34
@   0x08022a62: f7ea        fae1 	bl	0xd028
@   0x08022a66: 2800        cmp	r0, #0
@   0x08022a68: d003        beq.n	0x22a72
@   0x08022a6a: 480a        ldr	r0, [pc, #40]	@ (0x22a94)
@   0x08022a6c: 2134        movs	r1, #52	@ 0x34
@   0x08022a6e: f7ff        fa3d 	bl	0x21eec
@   0x08022a72: 2035        movs	r0, #53	@ 0x35
@   0x08022a74: f7ea        fad8 	bl	0xd028
@   0x08022a78: 2800        cmp	r0, #0
@   0x08022a7a: d003        beq.n	0x22a84
@   0x08022a7c: 4806        ldr	r0, [pc, #24]	@ (0x22a98)
@   0x08022a7e: 2135        movs	r1, #53	@ 0x35
@   0x08022a80: f7ff        fa34 	bl	0x21eec
@   0x08022a84: bc01        pop	{r0}
@   0x08022a86: 4700        bx	r0
@   0x08022a88: 0df4        lsrs	r4, r6, #23
@   0x08022a8a: 0831        lsrs	r1, r6, #32
@   0x08022a8c: 0e14        lsrs	r4, r2, #24
@   0x08022a8e: 0831        lsrs	r1, r6, #32
@   0x08022a90: 0e44        lsrs	r4, r0, #25
@   0x08022a92: 0831        lsrs	r1, r6, #32
@   0x08022a94: 0e74        lsrs	r4, r6, #25
@   0x08022a96: 0831        lsrs	r1, r6, #32
@   0x08022a98: 0e94        lsrs	r4, r2, #26
@   0x08022a9a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022A28
sub_08022A28: @ 0x08022a28
        .incbin "frog_us_baserom.gba", 0x22a28, 0x74
        thumb_func_end sub_08022A28
