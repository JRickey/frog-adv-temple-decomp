@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022920, 0x08022958)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022920 --end 0x8022958 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022920: b530        push	{r4, r5, lr}
@   0x08022922: 2400        movs	r4, #0
@   0x08022924: 4d0b        ldr	r5, [pc, #44]	@ (0x22954)
@   0x08022926: 00a0        lsls	r0, r4, #2
@   0x08022928: 1940        adds	r0, r0, r5
@   0x0802292a: 6800        ldr	r0, [r0, #0]
@   0x0802292c: 1c21        adds	r1, r4, #0
@   0x0802292e: 314c        adds	r1, #76	@ 0x4c
@   0x08022930: f7ff        f844 	bl	0x219bc
@   0x08022934: 1c60        adds	r0, r4, #1
@   0x08022936: 0600        lsls	r0, r0, #24
@   0x08022938: 0e04        lsrs	r4, r0, #24
@   0x0802293a: 2c07        cmp	r4, #7
@   0x0802293c: d9f3        bls.n	0x22926
@   0x0802293e: 204c        movs	r0, #76	@ 0x4c
@   0x08022940: 2153        movs	r1, #83	@ 0x53
@   0x08022942: f7fe        fb4f 	bl	0x20fe4
@   0x08022946: 204c        movs	r0, #76	@ 0x4c
@   0x08022948: 2153        movs	r1, #83	@ 0x53
@   0x0802294a: f7e3        f9e1 	bl	0x5d10
@   0x0802294e: bc30        pop	{r4, r5}
@   0x08022950: bc01        pop	{r0}
@   0x08022952: 4700        bx	r0
@   0x08022954: 13c8        asrs	r0, r1, #15
@   0x08022956: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022920
sub_08022920: @ 0x08022920
        .incbin "frog_us_baserom.gba", 0x22920, 0x38
        thumb_func_end sub_08022920
