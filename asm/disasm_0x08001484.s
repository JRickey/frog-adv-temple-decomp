@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001484, 0x080014b8)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001484 --end 0x80014b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001484: b500        push	{lr}
@   0x08001486: b082        sub	sp, #8
@   0x08001488: 4809        ldr	r0, [pc, #36]	@ (0x14b0)
@   0x0800148a: 4b0a        ldr	r3, [pc, #40]	@ (0x14b4)
@   0x0800148c: 2101        movs	r1, #1
@   0x0800148e: 9100        str	r1, [sp, #0]
@   0x08001490: 2100        movs	r1, #0
@   0x08001492: 9101        str	r1, [sp, #4]
@   0x08001494: 2150        movs	r1, #80	@ 0x50
@   0x08001496: 2204        movs	r2, #4
@   0x08001498: f005        f878 	bl	0x658c
@   0x0800149c: 2004        movs	r0, #4
@   0x0800149e: 2100        movs	r1, #0
@   0x080014a0: f00b        fcfa 	bl	0xce98
@   0x080014a4: f008        fc0a 	bl	0x9cbc
@   0x080014a8: b002        add	sp, #8
@   0x080014aa: bc01        pop	{r0}
@   0x080014ac: 4700        bx	r0
@   0x080014ae: 0000        movs	r0, r0
@   0x080014b0: 6110        str	r0, [r2, #16]
@   0x080014b2: 0300        lsls	r0, r0, #12
@   0x080014b4: 9be0        ldr	r3, [sp, #896]	@ 0x380
@   0x080014b6: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08001484
sub_08001484: @ 0x08001484
        .incbin "frog_us_baserom.gba", 0x1484, 0x34
        thumb_func_end sub_08001484
