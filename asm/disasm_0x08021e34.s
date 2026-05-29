@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021e34, 0x08021ec0)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021e34 --end 0x8021ec0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021e34: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08021e36: 1c05        adds	r5, r0, #0
@   0x08021e38: 0609        lsls	r1, r1, #24
@   0x08021e3a: 0e0e        lsrs	r6, r1, #24
@   0x08021e3c: 0612        lsls	r2, r2, #24
@   0x08021e3e: 0e17        lsrs	r7, r2, #24
@   0x08021e40: 2102        movs	r1, #2
@   0x08021e42: 5e68        ldrsh	r0, [r5, r1]
@   0x08021e44: 2118        movs	r1, #24
@   0x08021e46: f011        ff65 	bl	0x33d14
@   0x08021e4a: 1c04        adds	r4, r0, #0
@   0x08021e4c: 0424        lsls	r4, r4, #16
@   0x08021e4e: 0c24        lsrs	r4, r4, #16
@   0x08021e50: 2204        movs	r2, #4
@   0x08021e52: 5ea8        ldrsh	r0, [r5, r2]
@   0x08021e54: 2118        movs	r1, #24
@   0x08021e56: f011        ff5d 	bl	0x33d14
@   0x08021e5a: 0400        lsls	r0, r0, #16
@   0x08021e5c: 0c03        lsrs	r3, r0, #16
@   0x08021e5e: 4906        ldr	r1, [pc, #24]	@ (0x21e78)
@   0x08021e60: 2208        movs	r2, #8
@   0x08021e62: 5e88        ldrsh	r0, [r1, r2]
@   0x08021e64: 0424        lsls	r4, r4, #16
@   0x08021e66: 1424        asrs	r4, r4, #16
@   0x08021e68: 1b00        subs	r0, r0, r4
@   0x08021e6a: 1c0a        adds	r2, r1, #0
@   0x08021e6c: 2800        cmp	r0, #0
@   0x08021e6e: db05        blt.n	0x21e7c
@   0x08021e70: 8911        ldrh	r1, [r2, #8]
@   0x08021e72: 1b08        subs	r0, r1, r4
@   0x08021e74: e004        b.n	0x21e80
@   0x08021e76: 0000        movs	r0, r0
@   0x08021e78: 35e0        adds	r5, #224	@ 0xe0
@   0x08021e7a: 0300        lsls	r0, r0, #12
@   0x08021e7c: 8911        ldrh	r1, [r2, #8]
@   0x08021e7e: 1a60        subs	r0, r4, r1
@   0x08021e80: 0400        lsls	r0, r0, #16
@   0x08021e82: 0c00        lsrs	r0, r0, #16
@   0x08021e84: 1c04        adds	r4, r0, #0
@   0x08021e86: 210a        movs	r1, #10
@   0x08021e88: 5e50        ldrsh	r0, [r2, r1]
@   0x08021e8a: 0419        lsls	r1, r3, #16
@   0x08021e8c: 1409        asrs	r1, r1, #16
@   0x08021e8e: 1a40        subs	r0, r0, r1
@   0x08021e90: 2800        cmp	r0, #0
@   0x08021e92: db02        blt.n	0x21e9a
@   0x08021e94: 8952        ldrh	r2, [r2, #10]
@   0x08021e96: 1a50        subs	r0, r2, r1
@   0x08021e98: e001        b.n	0x21e9e
@   0x08021e9a: 8952        ldrh	r2, [r2, #10]
@   0x08021e9c: 1a88        subs	r0, r1, r2
@   0x08021e9e: 0400        lsls	r0, r0, #16
@   0x08021ea0: 0c01        lsrs	r1, r0, #16
@   0x08021ea2: 0420        lsls	r0, r4, #16
@   0x08021ea4: 1400        asrs	r0, r0, #16
@   0x08021ea6: 42b0        cmp	r0, r6
@   0x08021ea8: dc05        bgt.n	0x21eb6
@   0x08021eaa: 0408        lsls	r0, r1, #16
@   0x08021eac: 1400        asrs	r0, r0, #16
@   0x08021eae: 42b8        cmp	r0, r7
@   0x08021eb0: dc01        bgt.n	0x21eb6
@   0x08021eb2: 2001        movs	r0, #1
@   0x08021eb4: e000        b.n	0x21eb8
@   0x08021eb6: 2000        movs	r0, #0
@   0x08021eb8: bcf0        pop	{r4, r5, r6, r7}
@   0x08021eba: bc02        pop	{r1}
@   0x08021ebc: 4708        bx	r1

        thumb_func_start sub_08021E34
sub_08021E34: @ 0x08021e34
        .incbin "frog_us_baserom.gba", 0x21e34, 0x8c
        thumb_func_end sub_08021E34
