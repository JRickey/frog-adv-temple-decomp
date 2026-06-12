@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027510, 0x08027558)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027510 --end 0x8027558 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027510: b570        push	{r4, r5, r6, lr}
@   0x08027512: 2500        movs	r5, #0
@   0x08027514: 4e0e        ldr	r6, [pc, #56]	@ (0x27550)
@   0x08027516: 00a8        lsls	r0, r5, #2
@   0x08027518: 1980        adds	r0, r0, r6
@   0x0802751a: 6800        ldr	r0, [r0, #0]
@   0x0802751c: 1c2c        adds	r4, r5, #0
@   0x0802751e: 3435        adds	r4, #53	@ 0x35
@   0x08027520: 1c21        adds	r1, r4, #0
@   0x08027522: f7fa        fa4b 	bl	0x219bc
@   0x08027526: 480b        ldr	r0, [pc, #44]	@ (0x27554)
@   0x08027528: 1c21        adds	r1, r4, #0
@   0x0802752a: f7df        fa1f 	bl	0x696c
@   0x0802752e: 1c68        adds	r0, r5, #1
@   0x08027530: 0600        lsls	r0, r0, #24
@   0x08027532: 0e05        lsrs	r5, r0, #24
@   0x08027534: 2d13        cmp	r5, #19
@   0x08027536: d9ee        bls.n	0x27516
@   0x08027538: 2035        movs	r0, #53	@ 0x35
@   0x0802753a: 2148        movs	r1, #72	@ 0x48
@   0x0802753c: f7f9        fd52 	bl	0x20fe4
@   0x08027540: 2035        movs	r0, #53	@ 0x35
@   0x08027542: 2148        movs	r1, #72	@ 0x48
@   0x08027544: f7de        fbe4 	bl	0x5d10
@   0x08027548: bc70        pop	{r4, r5, r6}
@   0x0802754a: bc01        pop	{r0}
@   0x0802754c: 4700        bx	r0
@   0x0802754e: 0000        movs	r0, r0
@   0x08027550: 667c        str	r4, [r7, #100]	@ 0x64
@   0x08027552: 0831        lsrs	r1, r6, #32
@   0x08027554: 6110        str	r0, [r2, #16]
@   0x08027556: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027510
sub_08027510: @ 0x08027510
        .incbin "baserom.gba", 0x27510, 0x48
        thumb_func_end sub_08027510
