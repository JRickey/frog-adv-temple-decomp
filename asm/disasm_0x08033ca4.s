@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033ca4, 0x08033cd8)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033ca4 --end 0x8033cd8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033ca4: b570        push	{r4, r5, r6, lr}
@   0x08033ca6: 1c0e        adds	r6, r1, #0
@   0x08033ca8: 1c05        adds	r5, r0, #0
@   0x08033caa: 2a00        cmp	r2, #0
@   0x08033cac: d012        beq.n	0x33cd4
@   0x08033cae: 2020        movs	r0, #32
@   0x08033cb0: 1a80        subs	r0, r0, r2
@   0x08033cb2: 2800        cmp	r0, #0
@   0x08033cb4: dc04        bgt.n	0x33cc0
@   0x08033cb6: 2300        movs	r3, #0
@   0x08033cb8: 4240        negs	r0, r0
@   0x08033cba: 1c2c        adds	r4, r5, #0
@   0x08033cbc: 4084        lsls	r4, r0
@   0x08033cbe: e007        b.n	0x33cd0
@   0x08033cc0: 1c29        adds	r1, r5, #0
@   0x08033cc2: 40c1        lsrs	r1, r0
@   0x08033cc4: 1c2b        adds	r3, r5, #0
@   0x08033cc6: 4093        lsls	r3, r2
@   0x08033cc8: 1c30        adds	r0, r6, #0
@   0x08033cca: 4090        lsls	r0, r2
@   0x08033ccc: 1c04        adds	r4, r0, #0
@   0x08033cce: 430c        orrs	r4, r1
@   0x08033cd0: 1c21        adds	r1, r4, #0
@   0x08033cd2: 1c18        adds	r0, r3, #0
@   0x08033cd4: bd70        pop	{r4, r5, r6, pc}

        thumb_func_start __ashldi3
__ashldi3: @ 0x08033ca4 — libgcc 64-bit left-shift helper
        .incbin "frog_us_baserom.gba", 0x33ca4, 0x34
        thumb_func_end __ashldi3
