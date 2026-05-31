@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020da0, 0x08020dc4)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020da0 --end 0x8020dc4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020da0: b530        push	{r4, r5, lr}
@   0x08020da2: 1c04        adds	r4, r0, #0
@   0x08020da4: 0624        lsls	r4, r4, #24
@   0x08020da6: 4d06        ldr	r5, [pc, #24]	@ (0x20dc0)
@   0x08020da8: 0d64        lsrs	r4, r4, #21
@   0x08020daa: 1d28        adds	r0, r5, #4
@   0x08020dac: 1820        adds	r0, r4, r0
@   0x08020dae: 6800        ldr	r0, [r0, #0]
@   0x08020db0: f7ff        ff62 	bl	0x20c78
@   0x08020db4: 3508        adds	r5, #8
@   0x08020db6: 1964        adds	r4, r4, r5
@   0x08020db8: 6020        str	r0, [r4, #0]
@   0x08020dba: bc30        pop	{r4, r5}
@   0x08020dbc: bc01        pop	{r0}
@   0x08020dbe: 4700        bx	r0
@   0x08020dc0: 3570        adds	r5, #112	@ 0x70
@   0x08020dc2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020DA0
sub_08020DA0: @ 0x08020da0
        .incbin "frog_us_baserom.gba", 0x20da0, 0x24
        thumb_func_end sub_08020DA0
