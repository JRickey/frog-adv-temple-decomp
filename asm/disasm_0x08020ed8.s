@ Manually split from disasm_0x08020e98.s (peel had over-grabbed; this is
@ a separate 4-instruction leaf function with no stack frame).
@ Range:  [0x08020ed8, 0x08020ee4)  (12 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020ed8: 4801        ldr	r0, [pc, #4]	@ (0x20ee0)
@   0x08020eda: 70c1        strb	r1, [r0, #3]
@   0x08020edc: 4770        bx	lr
@   0x08020ede: 0000        movs	r0, r0  (filler)
@   0x08020ee0: 3570        adds	r5, #112	@ 0x70 (pool: 0x03003570)
@   0x08020ee2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020ED8
sub_08020ED8: @ 0x08020ed8
        .incbin "frog_us_baserom.gba", 0x20ed8, 0xc
        thumb_func_end sub_08020ED8
