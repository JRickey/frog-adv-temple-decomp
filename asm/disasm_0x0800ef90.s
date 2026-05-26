@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ef90, 0x0800eff4)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ef90 --end 0x800eff4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ef90: 2280        movs	r2, #128	@ 0x80
@   0x0800ef92: 04d2        lsls	r2, r2, #19
@   0x0800ef94: 8811        ldrh	r1, [r2, #0]
@   0x0800ef96: 4807        ldr	r0, [pc, #28]	@ (0xefb4)
@   0x0800ef98: 4008        ands	r0, r1
@   0x0800ef9a: 8010        strh	r0, [r2, #0]
@   0x0800ef9c: 4a06        ldr	r2, [pc, #24]	@ (0xefb8)
@   0x0800ef9e: 8811        ldrh	r1, [r2, #0]
@   0x0800efa0: 4806        ldr	r0, [pc, #24]	@ (0xefbc)
@   0x0800efa2: 4008        ands	r0, r1
@   0x0800efa4: 8010        strh	r0, [r2, #0]
@   0x0800efa6: 4a06        ldr	r2, [pc, #24]	@ (0xefc0)
@   0x0800efa8: 8811        ldrh	r1, [r2, #0]
@   0x0800efaa: 4806        ldr	r0, [pc, #24]	@ (0xefc4)
@   0x0800efac: 4008        ands	r0, r1
@   0x0800efae: 8010        strh	r0, [r2, #0]
@   0x0800efb0: 4770        bx	lr
@   0x0800efb2: 0000        movs	r0, r0
@   0x0800efb4: fbff        0000 			@ <UNDEFINED> instruction: 0xfbff0000
@   0x0800efb8: 0200        lsls	r0, r0, #8
@   0x0800efba: 0400        lsls	r0, r0, #16
@   0x0800efbc: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0800efc0: 0004        movs	r4, r0
@   0x0800efc2: 0400        lsls	r0, r0, #16
@   0x0800efc4: ffef        0000 	vaddl.u32	q8, d15, d0
@   0x0800efc8: b500        push	{lr}
@   0x0800efca: 2002        movs	r0, #2
@   0x0800efcc: f7ff        fc46 	bl	0xe85c
@   0x0800efd0: f7ff        fda4 	bl	0xeb1c
@   0x0800efd4: f002        f962 	bl	0x1129c
@   0x0800efd8: 2005        movs	r0, #5
@   0x0800efda: 2103        movs	r1, #3
@   0x0800efdc: f001        fcbc 	bl	0x10958
@   0x0800efe0: 2002        movs	r0, #2
@   0x0800efe2: f000        f933 	bl	0xf24c
@   0x0800efe6: 2002        movs	r0, #2
@   0x0800efe8: f7ff        fdf8 	bl	0xebdc
@   0x0800efec: f007        fd28 	bl	0x16a40
@   0x0800eff0: bc01        pop	{r0}
@   0x0800eff2: 4700        bx	r0

        thumb_func_start sub_0800EF90
sub_0800EF90: @ 0x0800ef90
        .incbin "frog_us_baserom.gba", 0xef90, 0x64
        thumb_func_end sub_0800EF90
