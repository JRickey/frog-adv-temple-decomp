@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e118, 0x0801e1ac)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e118 --end 0x801e1ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e118: b510        push	{r4, lr}
@   0x0801e11a: 2000        movs	r0, #0
@   0x0801e11c: f7ff        f818 	bl	0x1d150
@   0x0801e120: 2000        movs	r0, #0
@   0x0801e122: f7ff        f8a1 	bl	0x1d268
@   0x0801e126: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e128: f7f2        fae0 	bl	0x106ec
@   0x0801e12c: e002        b.n	0x1e134
@   0x0801e12e: 2002        movs	r0, #2
@   0x0801e130: f000        f89e 	bl	0x1e270
@   0x0801e134: f7f2        faec 	bl	0x10710
@   0x0801e138: 2800        cmp	r0, #0
@   0x0801e13a: d1f8        bne.n	0x1e12e
@   0x0801e13c: 2078        movs	r0, #120	@ 0x78
@   0x0801e13e: f000        f897 	bl	0x1e270
@   0x0801e142: 2003        movs	r0, #3
@   0x0801e144: 2114        movs	r1, #20
@   0x0801e146: f7fc        fba5 	bl	0x1a894
@   0x0801e14a: 2000        movs	r0, #0
@   0x0801e14c: f7ff        f8f6 	bl	0x1d33c
@   0x0801e150: 2000        movs	r0, #0
@   0x0801e152: f7ff        f9bb 	bl	0x1d4cc
@   0x0801e156: 4c0d        ldr	r4, [pc, #52]	@ (0x1e18c)
@   0x0801e158: f7e2        f9b4 	bl	0x4c4
@   0x0801e15c: 8020        strh	r0, [r4, #0]
@   0x0801e15e: 2000        movs	r0, #0
@   0x0801e160: f000        f824 	bl	0x1e1ac
@   0x0801e164: 0600        lsls	r0, r0, #24
@   0x0801e166: 0e00        lsrs	r0, r0, #24
@   0x0801e168: 28fe        cmp	r0, #254	@ 0xfe
@   0x0801e16a: d1f5        bne.n	0x1e158
@   0x0801e16c: 2003        movs	r0, #3
@   0x0801e16e: 2114        movs	r1, #20
@   0x0801e170: f7fc        fc06 	bl	0x1a980
@   0x0801e174: 4806        ldr	r0, [pc, #24]	@ (0x1e190)
@   0x0801e176: 2100        movs	r1, #0
@   0x0801e178: 8001        strh	r1, [r0, #0]
@   0x0801e17a: 3004        adds	r0, #4
@   0x0801e17c: 8001        strh	r1, [r0, #0]
@   0x0801e17e: 2078        movs	r0, #120	@ 0x78
@   0x0801e180: f000        f876 	bl	0x1e270
@   0x0801e184: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e186: f7f2        fa85 	bl	0x10694
@   0x0801e18a: e006        b.n	0x1e19a
@   0x0801e18c: 5398        strh	r0, [r3, r6]
@   0x0801e18e: 0300        lsls	r0, r0, #12
@   0x0801e190: 0040        lsls	r0, r0, #1
@   0x0801e192: 0400        lsls	r0, r0, #16
@   0x0801e194: 2002        movs	r0, #2
@   0x0801e196: f000        f86b 	bl	0x1e270
@   0x0801e19a: f7f2        fa8d 	bl	0x106b8
@   0x0801e19e: 2800        cmp	r0, #0
@   0x0801e1a0: d1f8        bne.n	0x1e194
@   0x0801e1a2: 2001        movs	r0, #1
@   0x0801e1a4: bc10        pop	{r4}
@   0x0801e1a6: bc02        pop	{r1}
@   0x0801e1a8: 4708        bx	r1

        thumb_func_start sub_0801E118
sub_0801E118: @ 0x0801e118
        .incbin "frog_us_baserom.gba", 0x1e118, 0x94
        thumb_func_end sub_0801E118
