@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803194c, 0x08031998)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803194c --end 0x8031998 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803194c: b570        push	{r4, r5, r6, lr}
@   0x0803194e: 1c0d        adds	r5, r1, #0
@   0x08031950: 682e        ldr	r6, [r5, #0]
@   0x08031952: 2400        movs	r4, #0
@   0x08031954: e011        b.n	0x3197a
@   0x08031956: 6808        ldr	r0, [r1, #0]
@   0x08031958: 218a        movs	r1, #138	@ 0x8a
@   0x0803195a: 0049        lsls	r1, r1, #1
@   0x0803195c: 1840        adds	r0, r0, r1
@   0x0803195e: 6801        ldr	r1, [r0, #0]
@   0x08031960: 0120        lsls	r0, r4, #4
@   0x08031962: 1841        adds	r1, r0, r1
@   0x08031964: 6808        ldr	r0, [r1, #0]
@   0x08031966: 2800        cmp	r0, #0
@   0x08031968: d006        beq.n	0x31978
@   0x0803196a: 8989        ldrh	r1, [r1, #12]
@   0x0803196c: 8870        ldrh	r0, [r6, #2]
@   0x0803196e: 4281        cmp	r1, r0
@   0x08031970: d102        bne.n	0x31978
@   0x08031972: 1c20        adds	r0, r4, #0
@   0x08031974: f7fe        f83c 	bl	0x2f9f0
@   0x08031978: 3401        adds	r4, #1
@   0x0803197a: 4906        ldr	r1, [pc, #24]	@ (0x31994)
@   0x0803197c: 6808        ldr	r0, [r1, #0]
@   0x0803197e: 7800        ldrb	r0, [r0, #0]
@   0x08031980: 3004        adds	r0, #4
@   0x08031982: 4284        cmp	r4, r0
@   0x08031984: dbe7        blt.n	0x31956
@   0x08031986: 6828        ldr	r0, [r5, #0]
@   0x08031988: 3004        adds	r0, #4
@   0x0803198a: 6028        str	r0, [r5, #0]
@   0x0803198c: 2001        movs	r0, #1
@   0x0803198e: bc70        pop	{r4, r5, r6}
@   0x08031990: bc02        pop	{r1}
@   0x08031992: 4708        bx	r1
@   0x08031994: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031996: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0803194C
sub_0803194C: @ 0x0803194c
        .incbin "frog_us_baserom.gba", 0x3194c, 0x4c
        thumb_func_end sub_0803194C
