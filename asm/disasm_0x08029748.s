@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029748, 0x08029780)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029748 --end 0x8029780 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029748: b530        push	{r4, r5, lr}
@   0x0802974a: 2400        movs	r4, #0
@   0x0802974c: 4d0b        ldr	r5, [pc, #44]	@ (0x2977c)
@   0x0802974e: 00a0        lsls	r0, r4, #2
@   0x08029750: 1940        adds	r0, r0, r5
@   0x08029752: 6800        ldr	r0, [r0, #0]
@   0x08029754: 1c21        adds	r1, r4, #0
@   0x08029756: 3146        adds	r1, #70	@ 0x46
@   0x08029758: f7f8        f930 	bl	0x219bc
@   0x0802975c: 1c60        adds	r0, r4, #1
@   0x0802975e: 0600        lsls	r0, r0, #24
@   0x08029760: 0e04        lsrs	r4, r0, #24
@   0x08029762: 2c05        cmp	r4, #5
@   0x08029764: d9f3        bls.n	0x2974e
@   0x08029766: 2046        movs	r0, #70	@ 0x46
@   0x08029768: 214b        movs	r1, #75	@ 0x4b
@   0x0802976a: f7f7        fc3b 	bl	0x20fe4
@   0x0802976e: 2046        movs	r0, #70	@ 0x46
@   0x08029770: 214b        movs	r1, #75	@ 0x4b
@   0x08029772: f7dc        facd 	bl	0x5d10
@   0x08029776: bc30        pop	{r4, r5}
@   0x08029778: bc01        pop	{r0}
@   0x0802977a: 4700        bx	r0
@   0x0802977c: 7a98        ldrb	r0, [r3, #10]
@   0x0802977e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08029748
sub_08029748: @ 0x08029748
        .incbin "baserom.gba", 0x29748, 0x38
        thumb_func_end sub_08029748
