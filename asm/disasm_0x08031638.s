@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031638, 0x08031688)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031638 --end 0x8031688 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031638: b570        push	{r4, r5, r6, lr}
@   0x0803163a: 1c04        adds	r4, r0, #0
@   0x0803163c: 1c0d        adds	r5, r1, #0
@   0x0803163e: 682e        ldr	r6, [r5, #0]
@   0x08031640: f7fe        f956 	bl	0x2f8f0
@   0x08031644: 2c03        cmp	r4, #3
@   0x08031646: dd16        ble.n	0x31676
@   0x08031648: 480e        ldr	r0, [pc, #56]	@ (0x31684)
@   0x0803164a: 6801        ldr	r1, [r0, #0]
@   0x0803164c: 2287        movs	r2, #135	@ 0x87
@   0x0803164e: 0052        lsls	r2, r2, #1
@   0x08031650: 1888        adds	r0, r1, r2
@   0x08031652: 7800        ldrb	r0, [r0, #0]
@   0x08031654: 2800        cmp	r0, #0
@   0x08031656: d00e        beq.n	0x31676
@   0x08031658: 1c08        adds	r0, r1, #0
@   0x0803165a: 30c0        adds	r0, #192	@ 0xc0
@   0x0803165c: 6801        ldr	r1, [r0, #0]
@   0x0803165e: 00e0        lsls	r0, r4, #3
@   0x08031660: 1b00        subs	r0, r0, r4
@   0x08031662: 0080        lsls	r0, r0, #2
@   0x08031664: 1840        adds	r0, r0, r1
@   0x08031666: 1c01        adds	r1, r0, #0
@   0x08031668: 3970        subs	r1, #112	@ 0x70
@   0x0803166a: 2200        movs	r2, #0
@   0x0803166c: 7870        ldrb	r0, [r6, #1]
@   0x0803166e: 2800        cmp	r0, #0
@   0x08031670: d100        bne.n	0x31674
@   0x08031672: 2201        movs	r2, #1
@   0x08031674: 76ca        strb	r2, [r1, #27]
@   0x08031676: 6828        ldr	r0, [r5, #0]
@   0x08031678: 3002        adds	r0, #2
@   0x0803167a: 6028        str	r0, [r5, #0]
@   0x0803167c: 2001        movs	r0, #1
@   0x0803167e: bc70        pop	{r4, r5, r6}
@   0x08031680: bc02        pop	{r1}
@   0x08031682: 4708        bx	r1
@   0x08031684: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031686: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031638
sub_08031638: @ 0x08031638
        .incbin "frog_us_baserom.gba", 0x31638, 0x50
        thumb_func_end sub_08031638
