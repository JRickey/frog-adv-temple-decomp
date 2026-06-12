@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026edc, 0x08026f14)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026edc --end 0x8026f14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026edc: b530        push	{r4, r5, lr}
@   0x08026ede: 2400        movs	r4, #0
@   0x08026ee0: 4d0b        ldr	r5, [pc, #44]	@ (0x26f10)
@   0x08026ee2: 00a0        lsls	r0, r4, #2
@   0x08026ee4: 1940        adds	r0, r0, r5
@   0x08026ee6: 6800        ldr	r0, [r0, #0]
@   0x08026ee8: 1c21        adds	r1, r4, #0
@   0x08026eea: 3174        adds	r1, #116	@ 0x74
@   0x08026eec: f7fa        fd66 	bl	0x219bc
@   0x08026ef0: 1c60        adds	r0, r4, #1
@   0x08026ef2: 0600        lsls	r0, r0, #24
@   0x08026ef4: 0e04        lsrs	r4, r0, #24
@   0x08026ef6: 2c02        cmp	r4, #2
@   0x08026ef8: d9f3        bls.n	0x26ee2
@   0x08026efa: 2074        movs	r0, #116	@ 0x74
@   0x08026efc: 2176        movs	r1, #118	@ 0x76
@   0x08026efe: f7fa        f871 	bl	0x20fe4
@   0x08026f02: 2074        movs	r0, #116	@ 0x74
@   0x08026f04: 2176        movs	r1, #118	@ 0x76
@   0x08026f06: f7de        ff03 	bl	0x5d10
@   0x08026f0a: bc30        pop	{r4, r5}
@   0x08026f0c: bc01        pop	{r0}
@   0x08026f0e: 4700        bx	r0
@   0x08026f10: 5274        strh	r4, [r6, r1]
@   0x08026f12: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026EDC
sub_08026EDC: @ 0x08026edc
        .incbin "baserom.gba", 0x26edc, 0x38
        thumb_func_end sub_08026EDC
