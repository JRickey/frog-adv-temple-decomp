@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026a98, 0x08026ad0)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026a98 --end 0x8026ad0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026a98: b530        push	{r4, r5, lr}
@   0x08026a9a: 2400        movs	r4, #0
@   0x08026a9c: 4d0b        ldr	r5, [pc, #44]	@ (0x26acc)
@   0x08026a9e: 00a0        lsls	r0, r4, #2
@   0x08026aa0: 1940        adds	r0, r0, r5
@   0x08026aa2: 6800        ldr	r0, [r0, #0]
@   0x08026aa4: 1c21        adds	r1, r4, #0
@   0x08026aa6: 312d        adds	r1, #45	@ 0x2d
@   0x08026aa8: f7fa        ff88 	bl	0x219bc
@   0x08026aac: 1c60        adds	r0, r4, #1
@   0x08026aae: 0600        lsls	r0, r0, #24
@   0x08026ab0: 0e04        lsrs	r4, r0, #24
@   0x08026ab2: 2c00        cmp	r4, #0
@   0x08026ab4: d0f3        beq.n	0x26a9e
@   0x08026ab6: 202d        movs	r0, #45	@ 0x2d
@   0x08026ab8: 212d        movs	r1, #45	@ 0x2d
@   0x08026aba: f7fa        fa93 	bl	0x20fe4
@   0x08026abe: 202d        movs	r0, #45	@ 0x2d
@   0x08026ac0: 212d        movs	r1, #45	@ 0x2d
@   0x08026ac2: f7df        f925 	bl	0x5d10
@   0x08026ac6: bc30        pop	{r4, r5}
@   0x08026ac8: bc01        pop	{r0}
@   0x08026aca: 4700        bx	r0
@   0x08026acc: 5adc        ldrh	r4, [r3, r3]
@   0x08026ace: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026A98
sub_08026A98: @ 0x08026a98
        .incbin "baserom.gba", 0x26a98, 0x38
        thumb_func_end sub_08026A98
