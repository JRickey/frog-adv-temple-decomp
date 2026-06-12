@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025dac, 0x08025dd0)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025dac --end 0x8025dd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025dac: b500        push	{lr}
@   0x08025dae: b081        sub	sp, #4
@   0x08025db0: 4905        ldr	r1, [pc, #20]	@ (0x25dc8)
@   0x08025db2: 4b06        ldr	r3, [pc, #24]	@ (0x25dcc)
@   0x08025db4: 2000        movs	r0, #0
@   0x08025db6: 9000        str	r0, [sp, #0]
@   0x08025db8: 2026        movs	r0, #38	@ 0x26
@   0x08025dba: 220b        movs	r2, #11
@   0x08025dbc: f7fb        fba8 	bl	0x21510
@   0x08025dc0: b001        add	sp, #4
@   0x08025dc2: bc01        pop	{r0}
@   0x08025dc4: 4700        bx	r0
@   0x08025dc6: 0000        movs	r0, r0
@   0x08025dc8: 41e8        rors	r0, r5
@   0x08025dca: 0831        lsrs	r1, r6, #32
@   0x08025dcc: 6110        str	r0, [r2, #16]
@   0x08025dce: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025DAC
sub_08025DAC: @ 0x08025dac
        .incbin "baserom.gba", 0x25dac, 0x24
        thumb_func_end sub_08025DAC
