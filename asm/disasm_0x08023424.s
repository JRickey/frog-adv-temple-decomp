@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023424, 0x0802349c)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023424 --end 0x802349c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023424: b530        push	{r4, r5, lr}
@   0x08023426: 2400        movs	r4, #0
@   0x08023428: 4d1b        ldr	r5, [pc, #108]	@ (0x23498)
@   0x0802342a: 00a0        lsls	r0, r4, #2
@   0x0802342c: 1940        adds	r0, r0, r5
@   0x0802342e: 6800        ldr	r0, [r0, #0]
@   0x08023430: 1c21        adds	r1, r4, #0
@   0x08023432: 3151        adds	r1, #81	@ 0x51
@   0x08023434: f7fe        fac2 	bl	0x219bc
@   0x08023438: 1c60        adds	r0, r4, #1
@   0x0802343a: 0600        lsls	r0, r0, #24
@   0x0802343c: 0e04        lsrs	r4, r0, #24
@   0x0802343e: 2c09        cmp	r4, #9
@   0x08023440: d9f3        bls.n	0x2342a
@   0x08023442: 2051        movs	r0, #81	@ 0x51
@   0x08023444: 2153        movs	r1, #83	@ 0x53
@   0x08023446: f7fd        fdcd 	bl	0x20fe4
@   0x0802344a: 2051        movs	r0, #81	@ 0x51
@   0x0802344c: 2153        movs	r1, #83	@ 0x53
@   0x0802344e: f7e2        fc5f 	bl	0x5d10
@   0x08023452: 2054        movs	r0, #84	@ 0x54
@   0x08023454: 2154        movs	r1, #84	@ 0x54
@   0x08023456: f7fd        fdc5 	bl	0x20fe4
@   0x0802345a: 2054        movs	r0, #84	@ 0x54
@   0x0802345c: 2154        movs	r1, #84	@ 0x54
@   0x0802345e: f7e2        fc57 	bl	0x5d10
@   0x08023462: 2055        movs	r0, #85	@ 0x55
@   0x08023464: 2156        movs	r1, #86	@ 0x56
@   0x08023466: f7fd        fdbd 	bl	0x20fe4
@   0x0802346a: 2055        movs	r0, #85	@ 0x55
@   0x0802346c: 2156        movs	r1, #86	@ 0x56
@   0x0802346e: f7e2        fc4f 	bl	0x5d10
@   0x08023472: 2057        movs	r0, #87	@ 0x57
@   0x08023474: 2158        movs	r1, #88	@ 0x58
@   0x08023476: f7fd        fdb5 	bl	0x20fe4
@   0x0802347a: 2057        movs	r0, #87	@ 0x57
@   0x0802347c: 2158        movs	r1, #88	@ 0x58
@   0x0802347e: f7e2        fc47 	bl	0x5d10
@   0x08023482: 2059        movs	r0, #89	@ 0x59
@   0x08023484: 215a        movs	r1, #90	@ 0x5a
@   0x08023486: f7fd        fdad 	bl	0x20fe4
@   0x0802348a: 2059        movs	r0, #89	@ 0x59
@   0x0802348c: 215a        movs	r1, #90	@ 0x5a
@   0x0802348e: f7e2        fc3f 	bl	0x5d10
@   0x08023492: bc30        pop	{r4, r5}
@   0x08023494: bc01        pop	{r0}
@   0x08023496: 4700        bx	r0
@   0x08023498: 1ec0        subs	r0, r0, #3
@   0x0802349a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08023424
sub_08023424: @ 0x08023424
        .incbin "frog_us_baserom.gba", 0x23424, 0x78
        thumb_func_end sub_08023424
