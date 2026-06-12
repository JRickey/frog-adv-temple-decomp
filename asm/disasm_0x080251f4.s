@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080251f4, 0x08025218)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80251f4 --end 0x8025218 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080251f4: b500        push	{lr}
@   0x080251f6: b081        sub	sp, #4
@   0x080251f8: 4905        ldr	r1, [pc, #20]	@ (0x25210)
@   0x080251fa: 4b06        ldr	r3, [pc, #24]	@ (0x25214)
@   0x080251fc: 2000        movs	r0, #0
@   0x080251fe: 9000        str	r0, [sp, #0]
@   0x08025200: 2021        movs	r0, #33	@ 0x21
@   0x08025202: 220b        movs	r2, #11
@   0x08025204: f7fc        f984 	bl	0x21510
@   0x08025208: b001        add	sp, #4
@   0x0802520a: bc01        pop	{r0}
@   0x0802520c: 4700        bx	r0
@   0x0802520e: 0000        movs	r0, r0
@   0x08025210: 34d0        adds	r4, #208	@ 0xd0
@   0x08025212: 0831        lsrs	r1, r6, #32
@   0x08025214: 6110        str	r0, [r2, #16]
@   0x08025216: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080251F4
sub_080251F4: @ 0x080251f4
        .incbin "baserom.gba", 0x251f4, 0x24
        thumb_func_end sub_080251F4
