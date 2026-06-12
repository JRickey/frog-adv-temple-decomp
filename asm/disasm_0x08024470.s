@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024470, 0x08024494)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024470 --end 0x8024494 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024470: b500        push	{lr}
@   0x08024472: b081        sub	sp, #4
@   0x08024474: 4905        ldr	r1, [pc, #20]	@ (0x2448c)
@   0x08024476: 4b06        ldr	r3, [pc, #24]	@ (0x24490)
@   0x08024478: 2000        movs	r0, #0
@   0x0802447a: 9000        str	r0, [sp, #0]
@   0x0802447c: 2077        movs	r0, #119	@ 0x77
@   0x0802447e: 224c        movs	r2, #76	@ 0x4c
@   0x08024480: f7fd        f846 	bl	0x21510
@   0x08024484: b001        add	sp, #4
@   0x08024486: bc01        pop	{r0}
@   0x08024488: 4700        bx	r0
@   0x0802448a: 0000        movs	r0, r0
@   0x0802448c: 2138        movs	r1, #56	@ 0x38
@   0x0802448e: 0831        lsrs	r1, r6, #32
@   0x08024490: 6110        str	r0, [r2, #16]
@   0x08024492: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024470
sub_08024470: @ 0x08024470
        .incbin "baserom.gba", 0x24470, 0x24
        thumb_func_end sub_08024470
