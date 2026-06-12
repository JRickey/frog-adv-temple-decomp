@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080261f8, 0x08026240)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80261f8 --end 0x8026240 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080261f8: b570        push	{r4, r5, r6, lr}
@   0x080261fa: b084        sub	sp, #16
@   0x080261fc: 490d        ldr	r1, [pc, #52]	@ (0x26234)
@   0x080261fe: 4e0e        ldr	r6, [pc, #56]	@ (0x26238)
@   0x08026200: 9600        str	r6, [sp, #0]
@   0x08026202: 250d        movs	r5, #13
@   0x08026204: 9501        str	r5, [sp, #4]
@   0x08026206: 2403        movs	r4, #3
@   0x08026208: 9402        str	r4, [sp, #8]
@   0x0802620a: 9403        str	r4, [sp, #12]
@   0x0802620c: 205f        movs	r0, #95	@ 0x5f
@   0x0802620e: 2200        movs	r2, #0
@   0x08026210: 235f        movs	r3, #95	@ 0x5f
@   0x08026212: f7fa        ff45 	bl	0x210a0
@   0x08026216: 4909        ldr	r1, [pc, #36]	@ (0x2623c)
@   0x08026218: 9600        str	r6, [sp, #0]
@   0x0802621a: 9501        str	r5, [sp, #4]
@   0x0802621c: 9402        str	r4, [sp, #8]
@   0x0802621e: 9403        str	r4, [sp, #12]
@   0x08026220: 2060        movs	r0, #96	@ 0x60
@   0x08026222: 2200        movs	r2, #0
@   0x08026224: 235f        movs	r3, #95	@ 0x5f
@   0x08026226: f7fa        ff3b 	bl	0x210a0
@   0x0802622a: b004        add	sp, #16
@   0x0802622c: bc70        pop	{r4, r5, r6}
@   0x0802622e: bc01        pop	{r0}
@   0x08026230: 4700        bx	r0
@   0x08026232: 0000        movs	r0, r0
@   0x08026234: 4a28        ldr	r2, [pc, #160]	@ (0x262d8)
@   0x08026236: 0831        lsrs	r1, r6, #32
@   0x08026238: 0251        lsls	r1, r2, #9
@   0x0802623a: 0000        movs	r0, r0
@   0x0802623c: 4a48        ldr	r2, [pc, #288]	@ (0x26360)
@   0x0802623e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080261F8
sub_080261F8: @ 0x080261f8
        .incbin "baserom.gba", 0x261f8, 0x48
        thumb_func_end sub_080261F8
