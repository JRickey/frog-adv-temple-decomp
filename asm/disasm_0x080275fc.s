@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080275fc, 0x08027634)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80275fc --end 0x8027634 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080275fc: b530        push	{r4, r5, lr}
@   0x080275fe: 2400        movs	r4, #0
@   0x08027600: 4d0b        ldr	r5, [pc, #44]	@ (0x27630)
@   0x08027602: 00a0        lsls	r0, r4, #2
@   0x08027604: 1940        adds	r0, r0, r5
@   0x08027606: 6800        ldr	r0, [r0, #0]
@   0x08027608: 1c21        adds	r1, r4, #0
@   0x0802760a: 315f        adds	r1, #95	@ 0x5f
@   0x0802760c: f7fa        f9d6 	bl	0x219bc
@   0x08027610: 1c60        adds	r0, r4, #1
@   0x08027612: 0600        lsls	r0, r0, #24
@   0x08027614: 0e04        lsrs	r4, r0, #24
@   0x08027616: 2c04        cmp	r4, #4
@   0x08027618: d9f3        bls.n	0x27602
@   0x0802761a: 205f        movs	r0, #95	@ 0x5f
@   0x0802761c: 2163        movs	r1, #99	@ 0x63
@   0x0802761e: f7f9        fce1 	bl	0x20fe4
@   0x08027622: 205f        movs	r0, #95	@ 0x5f
@   0x08027624: 2163        movs	r1, #99	@ 0x63
@   0x08027626: f7de        fb73 	bl	0x5d10
@   0x0802762a: bc30        pop	{r4, r5}
@   0x0802762c: bc01        pop	{r0}
@   0x0802762e: 4700        bx	r0
@   0x08027630: 66e0        str	r0, [r4, #108]	@ 0x6c
@   0x08027632: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080275FC
sub_080275FC: @ 0x080275fc
        .incbin "baserom.gba", 0x275fc, 0x38
        thumb_func_end sub_080275FC
