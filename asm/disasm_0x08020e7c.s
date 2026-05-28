@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020e7c, 0x08020e98)  (28 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020e7c --end 0x8020e98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020e7c: b500        push	{lr}
@   0x08020e7e: 0600        lsls	r0, r0, #24
@   0x08020e80: 4904        ldr	r1, [pc, #16]	@ (0x20e94)
@   0x08020e82: 0d40        lsrs	r0, r0, #21
@   0x08020e84: 3108        adds	r1, #8
@   0x08020e86: 1840        adds	r0, r0, r1
@   0x08020e88: 6800        ldr	r0, [r0, #0]
@   0x08020e8a: f00d        f939 	bl	0x2e100
@   0x08020e8e: bc01        pop	{r0}
@   0x08020e90: 4700        bx	r0
@   0x08020e92: 0000        movs	r0, r0
@   0x08020e94: 3570        adds	r5, #112	@ 0x70
@   0x08020e96: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020E7C
sub_08020E7C: @ 0x08020e7c
        .incbin "frog_us_baserom.gba", 0x20e7c, 0x1c
        thumb_func_end sub_08020E7C
