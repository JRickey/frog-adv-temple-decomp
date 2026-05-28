@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e048, 0x0800e060)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e048 --end 0x800e060 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e048: b500        push	{lr}
@   0x0800e04a: 1c01        adds	r1, r0, #0
@   0x0800e04c: 2080        movs	r0, #128	@ 0x80
@   0x0800e04e: 0240        lsls	r0, r0, #9
@   0x0800e050: 0409        lsls	r1, r1, #16
@   0x0800e052: 1409        asrs	r1, r1, #16
@   0x0800e054: f025        fe5e 	bl	0x33d14
@   0x0800e058: 0400        lsls	r0, r0, #16
@   0x0800e05a: 1400        asrs	r0, r0, #16
@   0x0800e05c: bc02        pop	{r1}
@   0x0800e05e: 4708        bx	r1

        thumb_func_start sub_0800E048
sub_0800E048: @ 0x0800e048
        .incbin "frog_us_baserom.gba", 0xe048, 0x18
        thumb_func_end sub_0800E048
