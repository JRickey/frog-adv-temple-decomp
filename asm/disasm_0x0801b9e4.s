@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b9e4, 0x0801ba34)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b9e4 --end 0x801ba34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b9e4: b530        push	{r4, r5, lr}
@   0x0801b9e6: 0600        lsls	r0, r0, #24
@   0x0801b9e8: 0e03        lsrs	r3, r0, #24
@   0x0801b9ea: 2201        movs	r2, #1
@   0x0801b9ec: 4c0e        ldr	r4, [pc, #56]	@ (0x1ba28)
@   0x0801b9ee: 8e20        ldrh	r0, [r4, #48]	@ 0x30
@   0x0801b9f0: 2800        cmp	r0, #0
@   0x0801b9f2: d101        bne.n	0x1b9f8
@   0x0801b9f4: 2008        movs	r0, #8
@   0x0801b9f6: 72e0        strb	r0, [r4, #11]
@   0x0801b9f8: 4d0c        ldr	r5, [pc, #48]	@ (0x1ba2c)
@   0x0801b9fa: 6828        ldr	r0, [r5, #0]
@   0x0801b9fc: 6861        ldr	r1, [r4, #4]
@   0x0801b9fe: 1a40        subs	r0, r0, r1
@   0x0801ba00: 7ae1        ldrb	r1, [r4, #11]
@   0x0801ba02: 4288        cmp	r0, r1
@   0x0801ba04: d306        bcc.n	0x1ba14
@   0x0801ba06: 1c18        adds	r0, r3, #0
@   0x0801ba08: f7ff        fe88 	bl	0x1b71c
@   0x0801ba0c: 0600        lsls	r0, r0, #24
@   0x0801ba0e: 0e02        lsrs	r2, r0, #24
@   0x0801ba10: 6828        ldr	r0, [r5, #0]
@   0x0801ba12: 6060        str	r0, [r4, #4]
@   0x0801ba14: 4806        ldr	r0, [pc, #24]	@ (0x1ba30)
@   0x0801ba16: 8800        ldrh	r0, [r0, #0]
@   0x0801ba18: 2820        cmp	r0, #32
@   0x0801ba1a: d100        bne.n	0x1ba1e
@   0x0801ba1c: 22fe        movs	r2, #254	@ 0xfe
@   0x0801ba1e: 1c10        adds	r0, r2, #0
@   0x0801ba20: bc30        pop	{r4, r5}
@   0x0801ba22: bc02        pop	{r1}
@   0x0801ba24: 4708        bx	r1
@   0x0801ba26: 0000        movs	r0, r0
@   0x0801ba28: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801ba2a: 0300        lsls	r0, r0, #12
@   0x0801ba2c: 5330        strh	r0, [r6, r4]
@   0x0801ba2e: 0300        lsls	r0, r0, #12
@   0x0801ba30: 5398        strh	r0, [r3, r6]
@   0x0801ba32: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801B9E4
sub_0801B9E4: @ 0x0801b9e4
        .incbin "frog_us_baserom.gba", 0x1b9e4, 0x50
        thumb_func_end sub_0801B9E4
