@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dffc, 0x0800e048)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dffc --end 0x800e048 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dffc: 0400        lsls	r0, r0, #16
@   0x0800dffe: 1400        asrs	r0, r0, #16
@   0x0800e000: 0409        lsls	r1, r1, #16
@   0x0800e002: 1409        asrs	r1, r1, #16
@   0x0800e004: 4348        muls	r0, r1
@   0x0800e006: 1c01        adds	r1, r0, #0
@   0x0800e008: 2800        cmp	r0, #0
@   0x0800e00a: da00        bge.n	0xe00e
@   0x0800e00c: 31ff        adds	r1, #255	@ 0xff
@   0x0800e00e: 0208        lsls	r0, r1, #8
@   0x0800e010: 1400        asrs	r0, r0, #16
@   0x0800e012: 4770        bx	lr
@   0x0800e014: 0400        lsls	r0, r0, #16
@   0x0800e016: 1400        asrs	r0, r0, #16
@   0x0800e018: 0409        lsls	r1, r1, #16
@   0x0800e01a: 1409        asrs	r1, r1, #16
@   0x0800e01c: 4348        muls	r0, r1
@   0x0800e01e: 1c01        adds	r1, r0, #0
@   0x0800e020: 2800        cmp	r0, #0
@   0x0800e022: da01        bge.n	0xe028
@   0x0800e024: 4a01        ldr	r2, [pc, #4]	@ (0xe02c)
@   0x0800e026: 1881        adds	r1, r0, r2
@   0x0800e028: 1408        asrs	r0, r1, #16
@   0x0800e02a: 4770        bx	lr
@   0x0800e02c: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800e030: b500        push	{lr}
@   0x0800e032: 0400        lsls	r0, r0, #16
@   0x0800e034: 1200        asrs	r0, r0, #8
@   0x0800e036: 0409        lsls	r1, r1, #16
@   0x0800e038: 1409        asrs	r1, r1, #16
@   0x0800e03a: f025        fe6b 	bl	0x33d14
@   0x0800e03e: 0400        lsls	r0, r0, #16
@   0x0800e040: 1400        asrs	r0, r0, #16
@   0x0800e042: bc02        pop	{r1}
@   0x0800e044: 4708        bx	r1

        thumb_func_start sub_0800DFFC
sub_0800DFFC: @ 0x0800dffc
        .incbin "frog_us_baserom.gba", 0xdffc, 0x4c
        thumb_func_end sub_0800DFFC
