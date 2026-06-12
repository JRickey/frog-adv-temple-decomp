@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080248e4, 0x0802491c)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80248e4 --end 0x802491c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080248e4: b530        push	{r4, r5, lr}
@   0x080248e6: 2400        movs	r4, #0
@   0x080248e8: 4d0b        ldr	r5, [pc, #44]	@ (0x24918)
@   0x080248ea: 00a0        lsls	r0, r4, #2
@   0x080248ec: 1940        adds	r0, r0, r5
@   0x080248ee: 6800        ldr	r0, [r0, #0]
@   0x080248f0: 1c21        adds	r1, r4, #0
@   0x080248f2: 3143        adds	r1, #67	@ 0x43
@   0x080248f4: f7fd        f862 	bl	0x219bc
@   0x080248f8: 1c60        adds	r0, r4, #1
@   0x080248fa: 0600        lsls	r0, r0, #24
@   0x080248fc: 0e04        lsrs	r4, r0, #24
@   0x080248fe: 2c02        cmp	r4, #2
@   0x08024900: d9f3        bls.n	0x248ea
@   0x08024902: 2043        movs	r0, #67	@ 0x43
@   0x08024904: 2145        movs	r1, #69	@ 0x45
@   0x08024906: f7fc        fb6d 	bl	0x20fe4
@   0x0802490a: 2043        movs	r0, #67	@ 0x43
@   0x0802490c: 2145        movs	r1, #69	@ 0x45
@   0x0802490e: f7e1        f9ff 	bl	0x5d10
@   0x08024912: bc30        pop	{r4, r5}
@   0x08024914: bc01        pop	{r0}
@   0x08024916: 4700        bx	r0
@   0x08024918: 332c        adds	r3, #44	@ 0x2c
@   0x0802491a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080248E4
sub_080248E4: @ 0x080248e4
        .incbin "baserom.gba", 0x248e4, 0x38
        thumb_func_end sub_080248E4
