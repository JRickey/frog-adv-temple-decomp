@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a104, 0x0800a158)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a104 --end 0x800a158 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a104: b510        push	{r4, lr}
@   0x0800a106: 1c04        adds	r4, r0, #0
@   0x0800a108: 2000        movs	r0, #0
@   0x0800a10a: 5620        ldrsb	r0, [r4, r0]
@   0x0800a10c: 2800        cmp	r0, #0
@   0x0800a10e: d103        bne.n	0xa118
@   0x0800a110: 20bf        movs	r0, #191	@ 0xbf
@   0x0800a112: f006        fabf 	bl	0x10694
@   0x0800a116: e00d        b.n	0xa134
@   0x0800a118: 2801        cmp	r0, #1
@   0x0800a11a: d104        bne.n	0xa126
@   0x0800a11c: f006        facc 	bl	0x106b8
@   0x0800a120: 2800        cmp	r0, #0
@   0x0800a122: d10a        bne.n	0xa13a
@   0x0800a124: e006        b.n	0xa134
@   0x0800a126: 2802        cmp	r0, #2
@   0x0800a128: d109        bne.n	0xa13e
@   0x0800a12a: f029        fdd7 	bl	0x33cdc
@   0x0800a12e: 20bf        movs	r0, #191	@ 0xbf
@   0x0800a130: f006        fadc 	bl	0x106ec
@   0x0800a134: 7820        ldrb	r0, [r4, #0]
@   0x0800a136: 3001        adds	r0, #1
@   0x0800a138: 7020        strb	r0, [r4, #0]
@   0x0800a13a: 2000        movs	r0, #0
@   0x0800a13c: e008        b.n	0xa150
@   0x0800a13e: 2803        cmp	r0, #3
@   0x0800a140: d106        bne.n	0xa150
@   0x0800a142: f006        fae5 	bl	0x10710
@   0x0800a146: 2800        cmp	r0, #0
@   0x0800a148: d101        bne.n	0xa14e
@   0x0800a14a: 2001        movs	r0, #1
@   0x0800a14c: e000        b.n	0xa150
@   0x0800a14e: 2000        movs	r0, #0
@   0x0800a150: bc10        pop	{r4}
@   0x0800a152: bc02        pop	{r1}
@   0x0800a154: 4708        bx	r1

        thumb_func_start sub_0800A104
sub_0800A104: @ 0x0800a104
        .incbin "frog_us_baserom.gba", 0xa104, 0x54
        thumb_func_end sub_0800A104
