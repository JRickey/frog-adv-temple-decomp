@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080017dc, 0x08001850)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80017dc --end 0x8001850 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080017dc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080017de: 1c05        adds	r5, r0, #0
@   0x080017e0: 1c0e        adds	r6, r1, #0
@   0x080017e2: f008        fd79 	bl	0xa2d8
@   0x080017e6: f7ff        f879 	bl	0x8dc
@   0x080017ea: f008        fd9d 	bl	0xa328
@   0x080017ee: f007        fe83 	bl	0x94f8
@   0x080017f2: f008        f8c7 	bl	0x9984
@   0x080017f6: 1c28        adds	r0, r5, #0
@   0x080017f8: 1c31        adds	r1, r6, #0
@   0x080017fa: 2204        movs	r2, #4
@   0x080017fc: f00a        f88c 	bl	0xb918
@   0x08001800: 4910        ldr	r1, [pc, #64]	@ (0x1844)
@   0x08001802: 2004        movs	r0, #4
@   0x08001804: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08001806: 4008        ands	r0, r1
@   0x08001808: 2800        cmp	r0, #0
@   0x0800180a: d114        bne.n	0x1836
@   0x0800180c: 4c0e        ldr	r4, [pc, #56]	@ (0x1848)
@   0x0800180e: 7e20        ldrb	r0, [r4, #24]
@   0x08001810: 7e61        ldrb	r1, [r4, #25]
@   0x08001812: 2308        movs	r3, #8
@   0x08001814: 5ee2        ldrsh	r2, [r4, r3]
@   0x08001816: 270a        movs	r7, #10
@   0x08001818: 5fe3        ldrsh	r3, [r4, r7]
@   0x0800181a: f00b        fab5 	bl	0xcd88
@   0x0800181e: 0600        lsls	r0, r0, #24
@   0x08001820: 0e03        lsrs	r3, r0, #24
@   0x08001822: 2010        movs	r0, #16
@   0x08001824: 8a24        ldrh	r4, [r4, #16]
@   0x08001826: 4020        ands	r0, r4
@   0x08001828: 2800        cmp	r0, #0
@   0x0800182a: d004        beq.n	0x1836
@   0x0800182c: 1c28        adds	r0, r5, #0
@   0x0800182e: 1c31        adds	r1, r6, #0
@   0x08001830: 2204        movs	r2, #4
@   0x08001832: f00a        f839 	bl	0xb8a8
@   0x08001836: 4905        ldr	r1, [pc, #20]	@ (0x184c)
@   0x08001838: 6948        ldr	r0, [r1, #20]
@   0x0800183a: 3001        adds	r0, #1
@   0x0800183c: 6148        str	r0, [r1, #20]
@   0x0800183e: bcf0        pop	{r4, r5, r6, r7}
@   0x08001840: bc01        pop	{r0}
@   0x08001842: 4700        bx	r0
@   0x08001844: 3720        adds	r7, #32
@   0x08001846: 0300        lsls	r0, r0, #12
@   0x08001848: 35e0        adds	r5, #224	@ 0xe0
@   0x0800184a: 0300        lsls	r0, r0, #12
@   0x0800184c: 5330        strh	r0, [r6, r4]
@   0x0800184e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080017DC
sub_080017DC: @ 0x080017dc
        .incbin "frog_us_baserom.gba", 0x17dc, 0x74
        thumb_func_end sub_080017DC
