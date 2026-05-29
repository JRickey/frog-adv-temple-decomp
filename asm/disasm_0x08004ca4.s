@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004ca4, 0x08004d04)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004ca4 --end 0x8004d04 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004ca4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08004ca6: 1c05        adds	r5, r0, #0
@   0x08004ca8: 1c0e        adds	r6, r1, #0
@   0x08004caa: 1c17        adds	r7, r2, #0
@   0x08004cac: 4808        ldr	r0, [pc, #32]	@ (0x4cd0)
@   0x08004cae: 7940        ldrb	r0, [r0, #5]
@   0x08004cb0: 0600        lsls	r0, r0, #24
@   0x08004cb2: 1600        asrs	r0, r0, #24
@   0x08004cb4: 2802        cmp	r0, #2
@   0x08004cb6: dc0f        bgt.n	0x4cd8
@   0x08004cb8: 4c06        ldr	r4, [pc, #24]	@ (0x4cd4)
@   0x08004cba: 1c20        adds	r0, r4, #0
@   0x08004cbc: 2103        movs	r1, #3
@   0x08004cbe: 2200        movs	r2, #0
@   0x08004cc0: f001        fd00 	bl	0x66c4
@   0x08004cc4: 1c20        adds	r0, r4, #0
@   0x08004cc6: 2103        movs	r1, #3
@   0x08004cc8: 2201        movs	r2, #1
@   0x08004cca: f001        fcfb 	bl	0x66c4
@   0x08004cce: e008        b.n	0x4ce2
@   0x08004cd0: 35e0        adds	r5, #224	@ 0xe0
@   0x08004cd2: 0300        lsls	r0, r0, #12
@   0x08004cd4: 6110        str	r0, [r2, #16]
@   0x08004cd6: 0300        lsls	r0, r0, #12
@   0x08004cd8: 4809        ldr	r0, [pc, #36]	@ (0x4d00)
@   0x08004cda: 2103        movs	r1, #3
@   0x08004cdc: 2201        movs	r2, #1
@   0x08004cde: f001        fc8f 	bl	0x6600
@   0x08004ce2: 1c28        adds	r0, r5, #0
@   0x08004ce4: f004        ff96 	bl	0x9c14
@   0x08004ce8: 2800        cmp	r0, #0
@   0x08004cea: d101        bne.n	0x4cf0
@   0x08004cec: 2007        movs	r0, #7
@   0x08004cee: 7028        strb	r0, [r5, #0]
@   0x08004cf0: 1c30        adds	r0, r6, #0
@   0x08004cf2: 1c39        adds	r1, r7, #0
@   0x08004cf4: 2211        movs	r2, #17
@   0x08004cf6: f006        fd5b 	bl	0xb7b0
@   0x08004cfa: bcf0        pop	{r4, r5, r6, r7}
@   0x08004cfc: bc01        pop	{r0}
@   0x08004cfe: 4700        bx	r0
@   0x08004d00: 6110        str	r0, [r2, #16]
@   0x08004d02: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004CA4
sub_08004CA4: @ 0x08004ca4
        .incbin "frog_us_baserom.gba", 0x4ca4, 0x60
        thumb_func_end sub_08004CA4
