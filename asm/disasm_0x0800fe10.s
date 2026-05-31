@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800fe10, 0x0800fe88)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800fe10 --end 0x800fe88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800fe10: b570        push	{r4, r5, r6, lr}
@   0x0800fe12: 4e1b        ldr	r6, [pc, #108]	@ (0xfe80)
@   0x0800fe14: 7a30        ldrb	r0, [r6, #8]
@   0x0800fe16: 28ff        cmp	r0, #255	@ 0xff
@   0x0800fe18: d02e        beq.n	0xfe78
@   0x0800fe1a: 8e33        ldrh	r3, [r6, #48]	@ 0x30
@   0x0800fe1c: 8e71        ldrh	r1, [r6, #50]	@ 0x32
@   0x0800fe1e: 6975        ldr	r5, [r6, #20]
@   0x0800fe20: 01ca        lsls	r2, r1, #7
@   0x0800fe22: 0058        lsls	r0, r3, #1
@   0x0800fe24: 1940        adds	r0, r0, r5
@   0x0800fe26: 1812        adds	r2, r2, r0
@   0x0800fe28: 0189        lsls	r1, r1, #6
@   0x0800fe2a: 4816        ldr	r0, [pc, #88]	@ (0xfe84)
@   0x0800fe2c: 1c04        adds	r4, r0, #0
@   0x0800fe2e: 1909        adds	r1, r1, r4
@   0x0800fe30: 185b        adds	r3, r3, r1
@   0x0800fe32: 8013        strh	r3, [r2, #0]
@   0x0800fe34: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x0800fe36: 8e73        ldrh	r3, [r6, #50]	@ 0x32
@   0x0800fe38: 01da        lsls	r2, r3, #7
@   0x0800fe3a: 0048        lsls	r0, r1, #1
@   0x0800fe3c: 1940        adds	r0, r0, r5
@   0x0800fe3e: 1812        adds	r2, r2, r0
@   0x0800fe40: 3240        adds	r2, #64	@ 0x40
@   0x0800fe42: 1909        adds	r1, r1, r4
@   0x0800fe44: 019b        lsls	r3, r3, #6
@   0x0800fe46: 18c9        adds	r1, r1, r3
@   0x0800fe48: 3120        adds	r1, #32
@   0x0800fe4a: 8011        strh	r1, [r2, #0]
@   0x0800fe4c: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0800fe4e: 3001        adds	r0, #1
@   0x0800fe50: 8630        strh	r0, [r6, #48]	@ 0x30
@   0x0800fe52: 0400        lsls	r0, r0, #16
@   0x0800fe54: 0c00        lsrs	r0, r0, #16
@   0x0800fe56: 2820        cmp	r0, #32
@   0x0800fe58: d10e        bne.n	0xfe78
@   0x0800fe5a: 2000        movs	r0, #0
@   0x0800fe5c: 8630        strh	r0, [r6, #48]	@ 0x30
@   0x0800fe5e: 2100        movs	r1, #0
@   0x0800fe60: 8e70        ldrh	r0, [r6, #50]	@ 0x32
@   0x0800fe62: 2800        cmp	r0, #0
@   0x0800fe64: d100        bne.n	0xfe68
@   0x0800fe66: 2101        movs	r1, #1
@   0x0800fe68: 8671        strh	r1, [r6, #50]	@ 0x32
@   0x0800fe6a: 7a30        ldrb	r0, [r6, #8]
@   0x0800fe6c: 3001        adds	r0, #1
@   0x0800fe6e: 7230        strb	r0, [r6, #8]
@   0x0800fe70: 212c        movs	r1, #44	@ 0x2c
@   0x0800fe72: 5e70        ldrsh	r0, [r6, r1]
@   0x0800fe74: f009        fe3a 	bl	0x19aec
@   0x0800fe78: bc70        pop	{r4, r5, r6}
@   0x0800fe7a: bc01        pop	{r0}
@   0x0800fe7c: 4700        bx	r0
@   0x0800fe7e: 0000        movs	r0, r0
@   0x0800fe80: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0800fe82: 0300        lsls	r0, r0, #12
@   0x0800fe84: e0a0        b.n	0xffc8
@   0x0800fe86: ffff        vsli.64	<illegal reg q13.5>, q8, #63	@ 0x3f

        thumb_func_start sub_0800FE10
sub_0800FE10: @ 0x0800fe10
        .incbin "frog_us_baserom.gba", 0xfe10, 0x78
        thumb_func_end sub_0800FE10
