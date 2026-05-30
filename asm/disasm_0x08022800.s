@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022800, 0x08022838)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022800 --end 0x8022838 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022800: b530        push	{r4, r5, lr}
@   0x08022802: 2400        movs	r4, #0
@   0x08022804: 4d0b        ldr	r5, [pc, #44]	@ (0x22834)
@   0x08022806: 00a0        lsls	r0, r4, #2
@   0x08022808: 1940        adds	r0, r0, r5
@   0x0802280a: 6800        ldr	r0, [r0, #0]
@   0x0802280c: 1c21        adds	r1, r4, #0
@   0x0802280e: 3119        adds	r1, #25
@   0x08022810: f7ff        f8d4 	bl	0x219bc
@   0x08022814: 1c60        adds	r0, r4, #1
@   0x08022816: 0600        lsls	r0, r0, #24
@   0x08022818: 0e04        lsrs	r4, r0, #24
@   0x0802281a: 2c0d        cmp	r4, #13
@   0x0802281c: d9f3        bls.n	0x22806
@   0x0802281e: 2019        movs	r0, #25
@   0x08022820: 2126        movs	r1, #38	@ 0x26
@   0x08022822: f7fe        fbdf 	bl	0x20fe4
@   0x08022826: 2019        movs	r0, #25
@   0x08022828: 2126        movs	r1, #38	@ 0x26
@   0x0802282a: f7e3        fa71 	bl	0x5d10
@   0x0802282e: bc30        pop	{r4, r5}
@   0x08022830: bc01        pop	{r0}
@   0x08022832: 4700        bx	r0
@   0x08022834: 1074        asrs	r4, r6, #1
@   0x08022836: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022800
sub_08022800: @ 0x08022800
        .incbin "frog_us_baserom.gba", 0x22800, 0x38
        thumb_func_end sub_08022800
