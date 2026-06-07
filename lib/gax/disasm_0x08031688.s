@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031688, 0x080316dc)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031688 --end 0x80316dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031688: b570        push	{r4, r5, r6, lr}
@   0x0803168a: 1c06        adds	r6, r0, #0
@   0x0803168c: 1c0d        adds	r5, r1, #0
@   0x0803168e: 682c        ldr	r4, [r5, #0]
@   0x08031690: 78a0        ldrb	r0, [r4, #2]
@   0x08031692: 2800        cmp	r0, #0
@   0x08031694: d104        bne.n	0x316a0
@   0x08031696: 7860        ldrb	r0, [r4, #1]
@   0x08031698: 1c31        adds	r1, r6, #0
@   0x0803169a: f7fd        f893 	bl	0x2e7c4
@   0x0803169e: e015        b.n	0x316cc
@   0x080316a0: 78a1        ldrb	r1, [r4, #2]
@   0x080316a2: 0048        lsls	r0, r1, #1
@   0x080316a4: f7fc        fe90 	bl	0x2e3c8
@   0x080316a8: 0400        lsls	r0, r0, #16
@   0x080316aa: 0c00        lsrs	r0, r0, #16
@   0x080316ac: 78a1        ldrb	r1, [r4, #2]
@   0x080316ae: 1a40        subs	r0, r0, r1
@   0x080316b0: 7864        ldrb	r4, [r4, #1]
@   0x080316b2: 1820        adds	r0, r4, r0
@   0x080316b4: 2800        cmp	r0, #0
@   0x080316b6: da01        bge.n	0x316bc
@   0x080316b8: 2000        movs	r0, #0
@   0x080316ba: e002        b.n	0x316c2
@   0x080316bc: 287f        cmp	r0, #127	@ 0x7f
@   0x080316be: dd00        ble.n	0x316c2
@   0x080316c0: 207f        movs	r0, #127	@ 0x7f
@   0x080316c2: 0600        lsls	r0, r0, #24
@   0x080316c4: 0e00        lsrs	r0, r0, #24
@   0x080316c6: 1c31        adds	r1, r6, #0
@   0x080316c8: f7fd        f87c 	bl	0x2e7c4
@   0x080316cc: 6828        ldr	r0, [r5, #0]
@   0x080316ce: 3004        adds	r0, #4
@   0x080316d0: 6028        str	r0, [r5, #0]
@   0x080316d2: 2001        movs	r0, #1
@   0x080316d4: bc70        pop	{r4, r5, r6}
@   0x080316d6: bc02        pop	{r1}
@   0x080316d8: 4708        bx	r1

        thumb_func_start sub_08031688
sub_08031688: @ 0x08031688
        .incbin "frog_us_baserom.gba", 0x31688, 0x54
        thumb_func_end sub_08031688
