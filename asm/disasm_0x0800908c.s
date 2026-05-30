@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800908c, 0x080090b0)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800908c --end 0x80090b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800908c: b500        push	{lr}
@   0x0800908e: f7fe        ff7b 	bl	0x7f88
@   0x08009092: 0600        lsls	r0, r0, #24
@   0x08009094: 2800        cmp	r0, #0
@   0x08009096: d101        bne.n	0x909c
@   0x08009098: 2000        movs	r0, #0
@   0x0800909a: e004        b.n	0x90a6
@   0x0800909c: 4803        ldr	r0, [pc, #12]	@ (0x90ac)
@   0x0800909e: 2101        movs	r1, #1
@   0x080090a0: f7fd        fd78 	bl	0x6b94
@   0x080090a4: 2001        movs	r0, #1
@   0x080090a6: bc02        pop	{r1}
@   0x080090a8: 4708        bx	r1
@   0x080090aa: 0000        movs	r0, r0
@   0x080090ac: 35e0        adds	r5, #224	@ 0xe0
@   0x080090ae: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800908C
sub_0800908C: @ 0x0800908c
        .incbin "frog_us_baserom.gba", 0x908c, 0x24
        thumb_func_end sub_0800908C
