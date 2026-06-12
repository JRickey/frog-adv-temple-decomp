@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025fbc, 0x08025ff4)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025fbc --end 0x8025ff4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025fbc: b530        push	{r4, r5, lr}
@   0x08025fbe: 2400        movs	r4, #0
@   0x08025fc0: 4d0b        ldr	r5, [pc, #44]	@ (0x25ff0)
@   0x08025fc2: 00a0        lsls	r0, r4, #2
@   0x08025fc4: 1940        adds	r0, r0, r5
@   0x08025fc6: 6800        ldr	r0, [r0, #0]
@   0x08025fc8: 1c21        adds	r1, r4, #0
@   0x08025fca: 314a        adds	r1, #74	@ 0x4a
@   0x08025fcc: f7fb        fcf6 	bl	0x219bc
@   0x08025fd0: 1c60        adds	r0, r4, #1
@   0x08025fd2: 0600        lsls	r0, r0, #24
@   0x08025fd4: 0e04        lsrs	r4, r0, #24
@   0x08025fd6: 2c05        cmp	r4, #5
@   0x08025fd8: d9f3        bls.n	0x25fc2
@   0x08025fda: 204a        movs	r0, #74	@ 0x4a
@   0x08025fdc: 214f        movs	r1, #79	@ 0x4f
@   0x08025fde: f7fb        f801 	bl	0x20fe4
@   0x08025fe2: 204a        movs	r0, #74	@ 0x4a
@   0x08025fe4: 214f        movs	r1, #79	@ 0x4f
@   0x08025fe6: f7df        fe93 	bl	0x5d10
@   0x08025fea: bc30        pop	{r4, r5}
@   0x08025fec: bc01        pop	{r0}
@   0x08025fee: 4700        bx	r0
@   0x08025ff0: 4b08        ldr	r3, [pc, #32]	@ (0x26014)
@   0x08025ff2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025FBC
sub_08025FBC: @ 0x08025fbc
        .incbin "baserom.gba", 0x25fbc, 0x38
        thumb_func_end sub_08025FBC
