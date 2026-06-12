@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025240, 0x08025264)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025240 --end 0x8025264 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025240: b500        push	{lr}
@   0x08025242: b081        sub	sp, #4
@   0x08025244: 4905        ldr	r1, [pc, #20]	@ (0x2525c)
@   0x08025246: 4b06        ldr	r3, [pc, #24]	@ (0x25260)
@   0x08025248: 2000        movs	r0, #0
@   0x0802524a: 9000        str	r0, [sp, #0]
@   0x0802524c: 2027        movs	r0, #39	@ 0x27
@   0x0802524e: 2204        movs	r2, #4
@   0x08025250: f7fc        f95e 	bl	0x21510
@   0x08025254: b001        add	sp, #4
@   0x08025256: bc01        pop	{r0}
@   0x08025258: 4700        bx	r0
@   0x0802525a: 0000        movs	r0, r0
@   0x0802525c: 3528        adds	r5, #40	@ 0x28
@   0x0802525e: 0831        lsrs	r1, r6, #32
@   0x08025260: 6110        str	r0, [r2, #16]
@   0x08025262: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025240
sub_08025240: @ 0x08025240
        .incbin "baserom.gba", 0x25240, 0x24
        thumb_func_end sub_08025240
