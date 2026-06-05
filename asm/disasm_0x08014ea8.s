@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014ea8, 0x08014ee8)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014ea8 --end 0x8014ee8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014ea8: b500        push	{lr}
@   0x08014eaa: 4b0a        ldr	r3, [pc, #40]	@ (0x14ed4)
@   0x08014eac: 2000        movs	r0, #0
@   0x08014eae: 7018        strb	r0, [r3, #0]
@   0x08014eb0: 4a09        ldr	r2, [pc, #36]	@ (0x14ed8)
@   0x08014eb2: 7010        strb	r0, [r2, #0]
@   0x08014eb4: 2101        movs	r1, #1
@   0x08014eb6: 7219        strb	r1, [r3, #8]
@   0x08014eb8: 7211        strb	r1, [r2, #8]
@   0x08014eba: 4808        ldr	r0, [pc, #32]	@ (0x14edc)
@   0x08014ebc: 7201        strb	r1, [r0, #8]
@   0x08014ebe: 4808        ldr	r0, [pc, #32]	@ (0x14ee0)
@   0x08014ec0: 7201        strb	r1, [r0, #8]
@   0x08014ec2: 2002        movs	r0, #2
@   0x08014ec4: f7f9        ffb6 	bl	0xee34
@   0x08014ec8: 4906        ldr	r1, [pc, #24]	@ (0x14ee4)
@   0x08014eca: 2004        movs	r0, #4
@   0x08014ecc: 7008        strb	r0, [r1, #0]
@   0x08014ece: bc01        pop	{r0}
@   0x08014ed0: 4700        bx	r0
@   0x08014ed2: 0000        movs	r0, r0
@   0x08014ed4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08014ed6: 0300        lsls	r0, r0, #12
@   0x08014ed8: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08014eda: 0300        lsls	r0, r0, #12
@   0x08014edc: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08014ede: 0300        lsls	r0, r0, #12
@   0x08014ee0: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08014ee2: 0300        lsls	r0, r0, #12
@   0x08014ee4: 3610        adds	r6, #16
@   0x08014ee6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08014EA8
sub_08014EA8: @ 0x08014ea8
        .incbin "frog_us_baserom.gba", 0x14ea8, 0x40
        thumb_func_end sub_08014EA8
