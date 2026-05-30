@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004470, 0x080044a4)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004470 --end 0x80044a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004470: b500        push	{lr}
@   0x08004472: b082        sub	sp, #8
@   0x08004474: 4809        ldr	r0, [pc, #36]	@ (0x449c)
@   0x08004476: 4b0a        ldr	r3, [pc, #40]	@ (0x44a0)
@   0x08004478: 2101        movs	r1, #1
@   0x0800447a: 9100        str	r1, [sp, #0]
@   0x0800447c: 2103        movs	r1, #3
@   0x0800447e: 9101        str	r1, [sp, #4]
@   0x08004480: 2180        movs	r1, #128	@ 0x80
@   0x08004482: 220e        movs	r2, #14
@   0x08004484: f002        f882 	bl	0x658c
@   0x08004488: 200e        movs	r0, #14
@   0x0800448a: 2100        movs	r1, #0
@   0x0800448c: f008        fd04 	bl	0xce98
@   0x08004490: f005        fc14 	bl	0x9cbc
@   0x08004494: b002        add	sp, #8
@   0x08004496: bc01        pop	{r0}
@   0x08004498: 4700        bx	r0
@   0x0800449a: 0000        movs	r0, r0
@   0x0800449c: 6110        str	r0, [r2, #16]
@   0x0800449e: 0300        lsls	r0, r0, #12
@   0x080044a0: 9b6c        ldr	r3, [sp, #432]	@ 0x1b0
@   0x080044a2: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08004470
sub_08004470: @ 0x08004470
        .incbin "frog_us_baserom.gba", 0x4470, 0x34
        thumb_func_end sub_08004470
