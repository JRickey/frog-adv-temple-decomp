@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024328, 0x08024390)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024328 --end 0x8024390 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024328: b570        push	{r4, r5, r6, lr}
@   0x0802432a: b084        sub	sp, #16
@   0x0802432c: 4e14        ldr	r6, [pc, #80]	@ (0x24380)
@   0x0802432e: 6831        ldr	r1, [r6, #0]
@   0x08024330: 4814        ldr	r0, [pc, #80]	@ (0x24384)
@   0x08024332: 9000        str	r0, [sp, #0]
@   0x08024334: 250a        movs	r5, #10
@   0x08024336: 9501        str	r5, [sp, #4]
@   0x08024338: 2403        movs	r4, #3
@   0x0802433a: 9402        str	r4, [sp, #8]
@   0x0802433c: 2002        movs	r0, #2
@   0x0802433e: 9003        str	r0, [sp, #12]
@   0x08024340: 2067        movs	r0, #103	@ 0x67
@   0x08024342: 2210        movs	r2, #16
@   0x08024344: 231c        movs	r3, #28
@   0x08024346: f7fc        feab 	bl	0x210a0
@   0x0802434a: 68f1        ldr	r1, [r6, #12]
@   0x0802434c: 480e        ldr	r0, [pc, #56]	@ (0x24388)
@   0x0802434e: 9000        str	r0, [sp, #0]
@   0x08024350: 9501        str	r5, [sp, #4]
@   0x08024352: 9402        str	r4, [sp, #8]
@   0x08024354: 9403        str	r4, [sp, #12]
@   0x08024356: 206a        movs	r0, #106	@ 0x6a
@   0x08024358: 2210        movs	r2, #16
@   0x0802435a: 231c        movs	r3, #28
@   0x0802435c: f7fc        fea0 	bl	0x210a0
@   0x08024360: 6931        ldr	r1, [r6, #16]
@   0x08024362: 480a        ldr	r0, [pc, #40]	@ (0x2438c)
@   0x08024364: 9000        str	r0, [sp, #0]
@   0x08024366: 9501        str	r5, [sp, #4]
@   0x08024368: 9402        str	r4, [sp, #8]
@   0x0802436a: 9403        str	r4, [sp, #12]
@   0x0802436c: 206b        movs	r0, #107	@ 0x6b
@   0x0802436e: 2210        movs	r2, #16
@   0x08024370: 231c        movs	r3, #28
@   0x08024372: f7fc        fe95 	bl	0x210a0
@   0x08024376: b004        add	sp, #16
@   0x08024378: bc70        pop	{r4, r5, r6}
@   0x0802437a: bc01        pop	{r0}
@   0x0802437c: 4700        bx	r0
@   0x0802437e: 0000        movs	r0, r0
@   0x08024380: 2c98        cmp	r4, #152	@ 0x98
@   0x08024382: 0831        lsrs	r1, r6, #32
@   0x08024384: 01f1        lsls	r1, r6, #7
@   0x08024386: 0000        movs	r0, r0
@   0x08024388: 0251        lsls	r1, r2, #9
@   0x0802438a: 0000        movs	r0, r0
@   0x0802438c: 0271        lsls	r1, r6, #9

        thumb_func_start sub_08024328
sub_08024328: @ 0x08024328
        .incbin "frog_us_baserom.gba", 0x24328, 0x68
        thumb_func_end sub_08024328
