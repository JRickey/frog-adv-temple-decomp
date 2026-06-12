@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802af4c, 0x0802af84)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802af4c --end 0x802af84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802af4c: b530        push	{r4, r5, lr}
@   0x0802af4e: 2400        movs	r4, #0
@   0x0802af50: 4d0b        ldr	r5, [pc, #44]	@ (0x2af80)
@   0x0802af52: 00a0        lsls	r0, r4, #2
@   0x0802af54: 1940        adds	r0, r0, r5
@   0x0802af56: 6800        ldr	r0, [r0, #0]
@   0x0802af58: 1ce1        adds	r1, r4, #3
@   0x0802af5a: f7f6        fd2f 	bl	0x219bc
@   0x0802af5e: 1c60        adds	r0, r4, #1
@   0x0802af60: 0600        lsls	r0, r0, #24
@   0x0802af62: 0e04        lsrs	r4, r0, #24
@   0x0802af64: 2c03        cmp	r4, #3
@   0x0802af66: d9f4        bls.n	0x2af52
@   0x0802af68: 2003        movs	r0, #3
@   0x0802af6a: 2106        movs	r1, #6
@   0x0802af6c: f7f6        f83a 	bl	0x20fe4
@   0x0802af70: 2003        movs	r0, #3
@   0x0802af72: 2106        movs	r1, #6
@   0x0802af74: f7da        fecc 	bl	0x5d10
@   0x0802af78: bc30        pop	{r4, r5}
@   0x0802af7a: bc01        pop	{r0}
@   0x0802af7c: 4700        bx	r0
@   0x0802af7e: 0000        movs	r0, r0
@   0x0802af80: 7f58        ldrb	r0, [r3, #29]
@   0x0802af82: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AF4C
sub_0802AF4C: @ 0x0802af4c
        .incbin "baserom.gba", 0x2af4c, 0x38
        thumb_func_end sub_0802AF4C
