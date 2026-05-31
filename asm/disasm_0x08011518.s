@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011518, 0x08011574)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011518 --end 0x8011574 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011518: b500        push	{lr}
@   0x0801151a: 480f        ldr	r0, [pc, #60]	@ (0x11558)
@   0x0801151c: 30c8        adds	r0, #200	@ 0xc8
@   0x0801151e: 2200        movs	r2, #0
@   0x08011520: 7002        strb	r2, [r0, #0]
@   0x08011522: 480e        ldr	r0, [pc, #56]	@ (0x1155c)
@   0x08011524: 7002        strb	r2, [r0, #0]
@   0x08011526: 480e        ldr	r0, [pc, #56]	@ (0x11560)
@   0x08011528: 7002        strb	r2, [r0, #0]
@   0x0801152a: 4b0e        ldr	r3, [pc, #56]	@ (0x11564)
@   0x0801152c: 2000        movs	r0, #0
@   0x0801152e: 869a        strh	r2, [r3, #52]	@ 0x34
@   0x08011530: 490d        ldr	r1, [pc, #52]	@ (0x11568)
@   0x08011532: 86ca        strh	r2, [r1, #54]	@ 0x36
@   0x08011534: 72d8        strb	r0, [r3, #11]
@   0x08011536: 72c8        strb	r0, [r1, #11]
@   0x08011538: 7258        strb	r0, [r3, #9]
@   0x0801153a: 2002        movs	r0, #2
@   0x0801153c: 7248        strb	r0, [r1, #9]
@   0x0801153e: 490b        ldr	r1, [pc, #44]	@ (0x1156c)
@   0x08011540: 2050        movs	r0, #80	@ 0x50
@   0x08011542: 72c8        strb	r0, [r1, #11]
@   0x08011544: 2003        movs	r0, #3
@   0x08011546: 7288        strb	r0, [r1, #10]
@   0x08011548: 4909        ldr	r1, [pc, #36]	@ (0x11570)
@   0x0801154a: 2004        movs	r0, #4
@   0x0801154c: 2201        movs	r2, #1
@   0x0801154e: f7ff        ff93 	bl	0x11478
@   0x08011552: bc01        pop	{r0}
@   0x08011554: 4700        bx	r0
@   0x08011556: 0000        movs	r0, r0
@   0x08011558: 3610        adds	r6, #16
@   0x0801155a: 0300        lsls	r0, r0, #12
@   0x0801155c: 53a0        strh	r0, [r4, r6]
@   0x0801155e: 0300        lsls	r0, r0, #12
@   0x08011560: 60a0        str	r0, [r4, #8]
@   0x08011562: 0300        lsls	r0, r0, #12
@   0x08011564: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08011566: 0300        lsls	r0, r0, #12
@   0x08011568: 6480        str	r0, [r0, #72]	@ 0x48
@   0x0801156a: 0300        lsls	r0, r0, #12
@   0x0801156c: 6580        str	r0, [r0, #88]	@ 0x58
@   0x0801156e: 0300        lsls	r0, r0, #12
@   0x08011570: 6ad4        ldr	r4, [r2, #44]	@ 0x2c
@   0x08011572: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08011518
sub_08011518: @ 0x08011518
        .incbin "frog_us_baserom.gba", 0x11518, 0x5c
        thumb_func_end sub_08011518
