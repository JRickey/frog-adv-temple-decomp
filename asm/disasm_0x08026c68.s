@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026c68, 0x08026cc0)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026c68 --end 0x8026cc0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026c68: b570        push	{r4, r5, r6, lr}
@   0x08026c6a: b084        sub	sp, #16
@   0x08026c6c: 2600        movs	r6, #0
@   0x08026c6e: 1c35        adds	r5, r6, #0
@   0x08026c70: 3533        adds	r5, #51	@ 0x33
@   0x08026c72: 4911        ldr	r1, [pc, #68]	@ (0x26cb8)
@   0x08026c74: 00b0        lsls	r0, r6, #2
@   0x08026c76: 1840        adds	r0, r0, r1
@   0x08026c78: 6804        ldr	r4, [r0, #0]
@   0x08026c7a: 1c30        adds	r0, r6, #0
@   0x08026c7c: 210c        movs	r1, #12
@   0x08026c7e: f00d        f96d 	bl	0x33f5c
@   0x08026c82: 0600        lsls	r0, r0, #24
@   0x08026c84: 0900        lsrs	r0, r0, #4
@   0x08026c86: 490d        ldr	r1, [pc, #52]	@ (0x26cbc)
@   0x08026c88: 1840        adds	r0, r0, r1
@   0x08026c8a: 0c00        lsrs	r0, r0, #16
@   0x08026c8c: 9000        str	r0, [sp, #0]
@   0x08026c8e: 2002        movs	r0, #2
@   0x08026c90: 9001        str	r0, [sp, #4]
@   0x08026c92: 2003        movs	r0, #3
@   0x08026c94: 9002        str	r0, [sp, #8]
@   0x08026c96: 9003        str	r0, [sp, #12]
@   0x08026c98: 1c28        adds	r0, r5, #0
@   0x08026c9a: 1c21        adds	r1, r4, #0
@   0x08026c9c: 2210        movs	r2, #16
@   0x08026c9e: 2330        movs	r3, #48	@ 0x30
@   0x08026ca0: f7fa        f9fe 	bl	0x210a0
@   0x08026ca4: 1c70        adds	r0, r6, #1
@   0x08026ca6: 0600        lsls	r0, r0, #24
@   0x08026ca8: 0e06        lsrs	r6, r0, #24
@   0x08026caa: 2e18        cmp	r6, #24
@   0x08026cac: d9df        bls.n	0x26c6e
@   0x08026cae: b004        add	sp, #16
@   0x08026cb0: bc70        pop	{r4, r5, r6}
@   0x08026cb2: bc01        pop	{r0}
@   0x08026cb4: 4700        bx	r0
@   0x08026cb6: 0000        movs	r0, r0
@   0x08026cb8: 5b44        ldrh	r4, [r0, r5]
@   0x08026cba: 0831        lsrs	r1, r6, #32
@   0x08026cbc: 0000        movs	r0, r0
@   0x08026cbe: 0141        lsls	r1, r0, #5

        thumb_func_start sub_08026C68
sub_08026C68: @ 0x08026c68
        .incbin "baserom.gba", 0x26c68, 0x58
        thumb_func_end sub_08026C68
