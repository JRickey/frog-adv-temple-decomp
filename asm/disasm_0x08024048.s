@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024048, 0x08024070)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024048 --end 0x8024070 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024048: b500        push	{lr}
@   0x0802404a: b083        sub	sp, #12
@   0x0802404c: 4907        ldr	r1, [pc, #28]	@ (0x2406c)
@   0x0802404e: 2282        movs	r2, #130	@ 0x82
@   0x08024050: 00d2        lsls	r2, r2, #3
@   0x08024052: 20a1        movs	r0, #161	@ 0xa1
@   0x08024054: 9000        str	r0, [sp, #0]
@   0x08024056: 2003        movs	r0, #3
@   0x08024058: 9001        str	r0, [sp, #4]
@   0x0802405a: 2000        movs	r0, #0
@   0x0802405c: 9002        str	r0, [sp, #8]
@   0x0802405e: 2014        movs	r0, #20
@   0x08024060: 2302        movs	r3, #2
@   0x08024062: f7fd        f86d 	bl	0x21140
@   0x08024066: b003        add	sp, #12
@   0x08024068: bc01        pop	{r0}
@   0x0802406a: 4700        bx	r0
@   0x0802406c: 2148        movs	r1, #72	@ 0x48
@   0x0802406e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024048
sub_08024048: @ 0x08024048
        .incbin "frog_us_baserom.gba", 0x24048, 0x28
        thumb_func_end sub_08024048
