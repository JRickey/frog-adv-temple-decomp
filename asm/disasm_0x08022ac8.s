@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022ac8, 0x08022aec)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022ac8 --end 0x8022aec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022ac8: b500        push	{lr}
@   0x08022aca: b081        sub	sp, #4
@   0x08022acc: 4905        ldr	r1, [pc, #20]	@ (0x22ae4)
@   0x08022ace: 4b06        ldr	r3, [pc, #24]	@ (0x22ae8)
@   0x08022ad0: 2000        movs	r0, #0
@   0x08022ad2: 9000        str	r0, [sp, #0]
@   0x08022ad4: 2059        movs	r0, #89	@ 0x59
@   0x08022ad6: 224c        movs	r2, #76	@ 0x4c
@   0x08022ad8: f7fe        fd1a 	bl	0x21510
@   0x08022adc: b001        add	sp, #4
@   0x08022ade: bc01        pop	{r0}
@   0x08022ae0: 4700        bx	r0
@   0x08022ae2: 0000        movs	r0, r0
@   0x08022ae4: 0b54        lsrs	r4, r2, #13
@   0x08022ae6: 0831        lsrs	r1, r6, #32
@   0x08022ae8: 6110        str	r0, [r2, #16]
@   0x08022aea: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022AC8
sub_08022AC8: @ 0x08022ac8
        .incbin "frog_us_baserom.gba", 0x22ac8, 0x24
        thumb_func_end sub_08022AC8
