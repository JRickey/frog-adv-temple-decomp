@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033da8, 0x08033de0)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033da8 --end 0x8033de0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033da8: 46f7        mov	pc, lr
@   0x08033daa: 0000        movs	r0, r0
@   0x08033dac: b510        push	{r4, lr}
@   0x08033dae: 1c04        adds	r4, r0, #0
@   0x08033db0: 4904        ldr	r1, [pc, #16]	@ (0x33dc4)
@   0x08033db2: f000        fcd5 	bl	0x34760
@   0x08033db6: 2800        cmp	r0, #0
@   0x08033db8: da06        bge.n	0x33dc8
@   0x08033dba: 1c20        adds	r0, r4, #0
@   0x08033dbc: f000        fd6c 	bl	0x34898
@   0x08033dc0: e00b        b.n	0x33dda
@   0x08033dc2: 0000        movs	r0, r0
@   0x08033dc4: 0000        movs	r0, r0
@   0x08033dc6: 4f00        ldr	r7, [pc, #0]	@ (0x33dc8)
@   0x08033dc8: 4904        ldr	r1, [pc, #16]	@ (0x33ddc)
@   0x08033dca: 1c20        adds	r0, r4, #0
@   0x08033dcc: f000        fa7e 	bl	0x342cc
@   0x08033dd0: f000        fd62 	bl	0x34898
@   0x08033dd4: 2180        movs	r1, #128	@ 0x80
@   0x08033dd6: 0609        lsls	r1, r1, #24
@   0x08033dd8: 1840        adds	r0, r0, r1
@   0x08033dda: bd10        pop	{r4, pc}
@   0x08033ddc: 0000        movs	r0, r0
@   0x08033dde: cf00        ldmia	r7!, {}

        thumb_func_start sub_08033DA8
sub_08033DA8: @ 0x08033da8
        .incbin "frog_us_baserom.gba", 0x33da8, 0x38
        thumb_func_end sub_08033DA8
