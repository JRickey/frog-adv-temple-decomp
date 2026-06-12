@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802690c, 0x08026944)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802690c --end 0x8026944 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802690c: b530        push	{r4, r5, lr}
@   0x0802690e: 2400        movs	r4, #0
@   0x08026910: 4d0b        ldr	r5, [pc, #44]	@ (0x26940)
@   0x08026912: 00a0        lsls	r0, r4, #2
@   0x08026914: 1940        adds	r0, r0, r5
@   0x08026916: 6800        ldr	r0, [r0, #0]
@   0x08026918: 1d21        adds	r1, r4, #4
@   0x0802691a: f7fb        f84f 	bl	0x219bc
@   0x0802691e: 1c60        adds	r0, r4, #1
@   0x08026920: 0600        lsls	r0, r0, #24
@   0x08026922: 0e04        lsrs	r4, r0, #24
@   0x08026924: 2c0a        cmp	r4, #10
@   0x08026926: d9f4        bls.n	0x26912
@   0x08026928: 2004        movs	r0, #4
@   0x0802692a: 210e        movs	r1, #14
@   0x0802692c: f7fa        fb5a 	bl	0x20fe4
@   0x08026930: 2004        movs	r0, #4
@   0x08026932: 210e        movs	r1, #14
@   0x08026934: f7df        f9ec 	bl	0x5d10
@   0x08026938: bc30        pop	{r4, r5}
@   0x0802693a: bc01        pop	{r0}
@   0x0802693c: 4700        bx	r0
@   0x0802693e: 0000        movs	r0, r0
@   0x08026940: 5a48        ldrh	r0, [r1, r1]
@   0x08026942: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802690C
sub_0802690C: @ 0x0802690c
        .incbin "baserom.gba", 0x2690c, 0x38
        thumb_func_end sub_0802690C
