@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027338, 0x0802735c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027338 --end 0x802735c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027338: b500        push	{lr}
@   0x0802733a: b081        sub	sp, #4
@   0x0802733c: 4905        ldr	r1, [pc, #20]	@ (0x27354)
@   0x0802733e: 4b06        ldr	r3, [pc, #24]	@ (0x27358)
@   0x08027340: 2000        movs	r0, #0
@   0x08027342: 9000        str	r0, [sp, #0]
@   0x08027344: 2002        movs	r0, #2
@   0x08027346: 2202        movs	r2, #2
@   0x08027348: f7fa        f8e2 	bl	0x21510
@   0x0802734c: b001        add	sp, #4
@   0x0802734e: bc01        pop	{r0}
@   0x08027350: 4700        bx	r0
@   0x08027352: 0000        movs	r0, r0
@   0x08027354: 5c10        ldrb	r0, [r2, r0]
@   0x08027356: 0831        lsrs	r1, r6, #32
@   0x08027358: 6110        str	r0, [r2, #16]
@   0x0802735a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027338
sub_08027338: @ 0x08027338
        .incbin "baserom.gba", 0x27338, 0x24
        thumb_func_end sub_08027338
