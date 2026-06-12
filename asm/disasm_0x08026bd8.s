@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026bd8, 0x08026c10)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026bd8 --end 0x8026c10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026bd8: b530        push	{r4, r5, lr}
@   0x08026bda: 2400        movs	r4, #0
@   0x08026bdc: 4d0b        ldr	r5, [pc, #44]	@ (0x26c0c)
@   0x08026bde: 00a0        lsls	r0, r4, #2
@   0x08026be0: 1940        adds	r0, r0, r5
@   0x08026be2: 6800        ldr	r0, [r0, #0]
@   0x08026be4: 1c21        adds	r1, r4, #0
@   0x08026be6: 3130        adds	r1, #48	@ 0x30
@   0x08026be8: f7fa        fee8 	bl	0x219bc
@   0x08026bec: 1c60        adds	r0, r4, #1
@   0x08026bee: 0600        lsls	r0, r0, #24
@   0x08026bf0: 0e04        lsrs	r4, r0, #24
@   0x08026bf2: 2c02        cmp	r4, #2
@   0x08026bf4: d9f3        bls.n	0x26bde
@   0x08026bf6: 2030        movs	r0, #48	@ 0x30
@   0x08026bf8: 2132        movs	r1, #50	@ 0x32
@   0x08026bfa: f7fa        f9f3 	bl	0x20fe4
@   0x08026bfe: 2030        movs	r0, #48	@ 0x30
@   0x08026c00: 2132        movs	r1, #50	@ 0x32
@   0x08026c02: f7df        f885 	bl	0x5d10
@   0x08026c06: bc30        pop	{r4, r5}
@   0x08026c08: bc01        pop	{r0}
@   0x08026c0a: 4700        bx	r0
@   0x08026c0c: 5268        strh	r0, [r5, r1]
@   0x08026c0e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026BD8
sub_08026BD8: @ 0x08026bd8
        .incbin "baserom.gba", 0x26bd8, 0x38
        thumb_func_end sub_08026BD8
