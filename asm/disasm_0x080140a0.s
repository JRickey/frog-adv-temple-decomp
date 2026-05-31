@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080140a0, 0x08014140)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80140a0 --end 0x8014140 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080140a0: b084        sub	sp, #16
@   0x080140a2: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080140a4: 9005        str	r0, [sp, #20]
@   0x080140a6: 9106        str	r1, [sp, #24]
@   0x080140a8: 9207        str	r2, [sp, #28]
@   0x080140aa: 9308        str	r3, [sp, #32]
@   0x080140ac: 9b0b        ldr	r3, [sp, #44]	@ 0x2c
@   0x080140ae: 980c        ldr	r0, [sp, #48]	@ 0x30
@   0x080140b0: 0600        lsls	r0, r0, #24
@   0x080140b2: 0e06        lsrs	r6, r0, #24
@   0x080140b4: a805        add	r0, sp, #20
@   0x080140b6: 7a02        ldrb	r2, [r0, #8]
@   0x080140b8: 725a        strb	r2, [r3, #9]
@   0x080140ba: 8885        ldrh	r5, [r0, #4]
@   0x080140bc: 861d        strh	r5, [r3, #48]	@ 0x30
@   0x080140be: 88c4        ldrh	r4, [r0, #6]
@   0x080140c0: 865c        strh	r4, [r3, #50]	@ 0x32
@   0x080140c2: 859d        strh	r5, [r3, #44]	@ 0x2c
@   0x080140c4: 85dc        strh	r4, [r3, #46]	@ 0x2e
@   0x080140c6: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x080140c8: 7a1f        ldrb	r7, [r3, #8]
@   0x080140ca: 00b8        lsls	r0, r7, #2
@   0x080140cc: 1840        adds	r0, r0, r1
@   0x080140ce: 6801        ldr	r1, [r0, #0]
@   0x080140d0: 6119        str	r1, [r3, #16]
@   0x080140d2: a805        add	r0, sp, #20
@   0x080140d4: 7b00        ldrb	r0, [r0, #12]
@   0x080140d6: 72d8        strb	r0, [r3, #11]
@   0x080140d8: 200f        movs	r0, #15
@   0x080140da: 4010        ands	r0, r2
@   0x080140dc: 2802        cmp	r0, #2
@   0x080140de: d009        beq.n	0x140f4
@   0x080140e0: 2802        cmp	r0, #2
@   0x080140e2: dc02        bgt.n	0x140ea
@   0x080140e4: 2801        cmp	r0, #1
@   0x080140e6: d012        beq.n	0x1410e
@   0x080140e8: e025        b.n	0x14136
@   0x080140ea: 2803        cmp	r0, #3
@   0x080140ec: d00f        beq.n	0x1410e
@   0x080140ee: 2804        cmp	r0, #4
@   0x080140f0: d014        beq.n	0x1411c
@   0x080140f2: e020        b.n	0x14136
@   0x080140f4: a805        add	r0, sp, #20
@   0x080140f6: 8800        ldrh	r0, [r0, #0]
@   0x080140f8: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x080140fa: a805        add	r0, sp, #20
@   0x080140fc: 8840        ldrh	r0, [r0, #2]
@   0x080140fe: 1820        adds	r0, r4, r0
@   0x08014100: 1b80        subs	r0, r0, r6
@   0x08014102: 86d8        strh	r0, [r3, #54]	@ 0x36
@   0x08014104: 8e5a        ldrh	r2, [r3, #50]	@ 0x32
@   0x08014106: 1b90        subs	r0, r2, r6
@   0x08014108: 8e1f        ldrh	r7, [r3, #48]	@ 0x30
@   0x0801410a: 4378        muls	r0, r7
@   0x0801410c: e010        b.n	0x14130
@   0x0801410e: a805        add	r0, sp, #20
@   0x08014110: 8800        ldrh	r0, [r0, #0]
@   0x08014112: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x08014114: a805        add	r0, sp, #20
@   0x08014116: 8840        ldrh	r0, [r0, #2]
@   0x08014118: 86d8        strh	r0, [r3, #54]	@ 0x36
@   0x0801411a: e00c        b.n	0x14136
@   0x0801411c: a805        add	r0, sp, #20
@   0x0801411e: 8800        ldrh	r0, [r0, #0]
@   0x08014120: 1828        adds	r0, r5, r0
@   0x08014122: 1b80        subs	r0, r0, r6
@   0x08014124: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x08014126: a805        add	r0, sp, #20
@   0x08014128: 8840        ldrh	r0, [r0, #2]
@   0x0801412a: 86d8        strh	r0, [r3, #54]	@ 0x36
@   0x0801412c: 8e1a        ldrh	r2, [r3, #48]	@ 0x30
@   0x0801412e: 1b90        subs	r0, r2, r6
@   0x08014130: 0040        lsls	r0, r0, #1
@   0x08014132: 1808        adds	r0, r1, r0
@   0x08014134: 6118        str	r0, [r3, #16]
@   0x08014136: bcf0        pop	{r4, r5, r6, r7}
@   0x08014138: bc08        pop	{r3}
@   0x0801413a: b004        add	sp, #16
@   0x0801413c: 4718        bx	r3

        thumb_func_start sub_080140A0
sub_080140A0: @ 0x080140a0
        .incbin "frog_us_baserom.gba", 0x140a0, 0xa0
        thumb_func_end sub_080140A0
