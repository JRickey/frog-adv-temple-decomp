@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026f8c, 0x08027000)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026f8c --end 0x8027000 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026f8c: b510        push	{r4, lr}
@   0x08026f8e: f7ff        ffa5 	bl	0x26edc
@   0x08026f92: f7ff        fcbb 	bl	0x2690c
@   0x08026f96: f7ff        fd09 	bl	0x269ac
@   0x08026f9a: f7ff        fd37 	bl	0x26a0c
@   0x08026f9e: f7ff        f9c7 	bl	0x26330
@   0x08026fa2: f7ff        fdb7 	bl	0x26b14
@   0x08026fa6: f7ff        fe17 	bl	0x26bd8
@   0x08026faa: f7ff        fe9d 	bl	0x26ce8
@   0x08026fae: f7ff        fec1 	bl	0x26d34
@   0x08026fb2: f7ff        fb0f 	bl	0x265d4
@   0x08026fb6: f7ff        ff59 	bl	0x26e6c
@   0x08026fba: 4804        ldr	r0, [pc, #16]	@ (0x26fcc)
@   0x08026fbc: 210a        movs	r1, #10
@   0x08026fbe: 5e40        ldrsh	r0, [r0, r1]
@   0x08026fc0: 286e        cmp	r0, #110	@ 0x6e
@   0x08026fc2: dc05        bgt.n	0x26fd0
@   0x08026fc4: f7ff        fa46 	bl	0x26454
@   0x08026fc8: e004        b.n	0x26fd4
@   0x08026fca: 0000        movs	r0, r0
@   0x08026fcc: 35e0        adds	r5, #224	@ 0xe0
@   0x08026fce: 0300        lsls	r0, r0, #12
@   0x08026fd0: f7ff        fa72 	bl	0x264b8
@   0x08026fd4: 4c06        ldr	r4, [pc, #24]	@ (0x26ff0)
@   0x08026fd6: 8960        ldrh	r0, [r4, #10]
@   0x08026fd8: 2823        cmp	r0, #35	@ 0x23
@   0x08026fda: d101        bne.n	0x26fe0
@   0x08026fdc: f7ff        fef6 	bl	0x26dcc
@   0x08026fe0: 210a        movs	r1, #10
@   0x08026fe2: 5e60        ldrsh	r0, [r4, r1]
@   0x08026fe4: 2822        cmp	r0, #34	@ 0x22
@   0x08026fe6: dc05        bgt.n	0x26ff4
@   0x08026fe8: f7ff        ff06 	bl	0x26df8
@   0x08026fec: e004        b.n	0x26ff8
@   0x08026fee: 0000        movs	r0, r0
@   0x08026ff0: 35e0        adds	r5, #224	@ 0xe0
@   0x08026ff2: 0300        lsls	r0, r0, #12
@   0x08026ff4: f7ff        fec6 	bl	0x26d84
@   0x08026ff8: bc10        pop	{r4}
@   0x08026ffa: bc01        pop	{r0}
@   0x08026ffc: 4700        bx	r0

        thumb_func_start sub_08026F8C
sub_08026F8C: @ 0x08026f8c
        .incbin "baserom.gba", 0x26f8c, 0x74
        thumb_func_end sub_08026F8C
