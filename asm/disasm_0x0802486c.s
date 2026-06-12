@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802486c, 0x08024890)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802486c --end 0x8024890 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802486c: b500        push	{lr}
@   0x0802486e: b081        sub	sp, #4
@   0x08024870: 4905        ldr	r1, [pc, #20]	@ (0x24888)
@   0x08024872: 4b06        ldr	r3, [pc, #24]	@ (0x2488c)
@   0x08024874: 2000        movs	r0, #0
@   0x08024876: 9000        str	r0, [sp, #0]
@   0x08024878: 2025        movs	r0, #37	@ 0x25
@   0x0802487a: 2202        movs	r2, #2
@   0x0802487c: f7fc        fe48 	bl	0x21510
@   0x08024880: b001        add	sp, #4
@   0x08024882: bc01        pop	{r0}
@   0x08024884: 4700        bx	r0
@   0x08024886: 0000        movs	r0, r0
@   0x08024888: 3014        adds	r0, #20
@   0x0802488a: 0831        lsrs	r1, r6, #32
@   0x0802488c: 6110        str	r0, [r2, #16]
@   0x0802488e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802486C
sub_0802486C: @ 0x0802486c
        .incbin "baserom.gba", 0x2486c, 0x24
        thumb_func_end sub_0802486C
