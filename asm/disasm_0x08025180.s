@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025180, 0x080251a8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025180 --end 0x80251a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025180: b500        push	{lr}
@   0x08025182: b083        sub	sp, #12
@   0x08025184: 4907        ldr	r1, [pc, #28]	@ (0x251a4)
@   0x08025186: 2041        movs	r0, #65	@ 0x41
@   0x08025188: 9000        str	r0, [sp, #0]
@   0x0802518a: 2001        movs	r0, #1
@   0x0802518c: 9001        str	r0, [sp, #4]
@   0x0802518e: 2000        movs	r0, #0
@   0x08025190: 9002        str	r0, [sp, #8]
@   0x08025192: 2002        movs	r0, #2
@   0x08025194: 2210        movs	r2, #16
@   0x08025196: 2302        movs	r3, #2
@   0x08025198: f7fb        ffd2 	bl	0x21140
@   0x0802519c: b003        add	sp, #12
@   0x0802519e: bc01        pop	{r0}
@   0x080251a0: 4700        bx	r0
@   0x080251a2: 0000        movs	r0, r0
@   0x080251a4: 33d0        adds	r3, #208	@ 0xd0
@   0x080251a6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025180
sub_08025180: @ 0x08025180
        .incbin "baserom.gba", 0x25180, 0x28
        thumb_func_end sub_08025180
