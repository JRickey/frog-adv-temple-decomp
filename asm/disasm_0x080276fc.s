@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080276fc, 0x08027744)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80276fc --end 0x8027744 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080276fc: b570        push	{r4, r5, r6, lr}
@   0x080276fe: 2500        movs	r5, #0
@   0x08027700: 4e0e        ldr	r6, [pc, #56]	@ (0x2773c)
@   0x08027702: 00a8        lsls	r0, r5, #2
@   0x08027704: 1980        adds	r0, r0, r6
@   0x08027706: 6800        ldr	r0, [r0, #0]
@   0x08027708: 1c2c        adds	r4, r5, #0
@   0x0802770a: 3468        adds	r4, #104	@ 0x68
@   0x0802770c: 1c21        adds	r1, r4, #0
@   0x0802770e: f7fa        f955 	bl	0x219bc
@   0x08027712: 480b        ldr	r0, [pc, #44]	@ (0x27740)
@   0x08027714: 1c21        adds	r1, r4, #0
@   0x08027716: f7df        f929 	bl	0x696c
@   0x0802771a: 1c68        adds	r0, r5, #1
@   0x0802771c: 0600        lsls	r0, r0, #24
@   0x0802771e: 0e05        lsrs	r5, r0, #24
@   0x08027720: 2d02        cmp	r5, #2
@   0x08027722: d9ee        bls.n	0x27702
@   0x08027724: 2068        movs	r0, #104	@ 0x68
@   0x08027726: 216a        movs	r1, #106	@ 0x6a
@   0x08027728: f7f9        fc5c 	bl	0x20fe4
@   0x0802772c: 2068        movs	r0, #104	@ 0x68
@   0x0802772e: 216a        movs	r1, #106	@ 0x6a
@   0x08027730: f7de        faee 	bl	0x5d10
@   0x08027734: bc70        pop	{r4, r5, r6}
@   0x08027736: bc01        pop	{r0}
@   0x08027738: 4700        bx	r0
@   0x0802773a: 0000        movs	r0, r0
@   0x0802773c: 6704        str	r4, [r0, #112]	@ 0x70
@   0x0802773e: 0831        lsrs	r1, r6, #32
@   0x08027740: 6110        str	r0, [r2, #16]
@   0x08027742: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080276FC
sub_080276FC: @ 0x080276fc
        .incbin "baserom.gba", 0x276fc, 0x48
        thumb_func_end sub_080276FC
