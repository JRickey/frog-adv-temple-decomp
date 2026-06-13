@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080295ac, 0x080295d4)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80295ac --end 0x80295d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080295ac: b500        push	{lr}
@   0x080295ae: b083        sub	sp, #12
@   0x080295b0: 4907        ldr	r1, [pc, #28]	@ (0x295d0)
@   0x080295b2: 2041        movs	r0, #65	@ 0x41
@   0x080295b4: 9000        str	r0, [sp, #0]
@   0x080295b6: 2001        movs	r0, #1
@   0x080295b8: 9001        str	r0, [sp, #4]
@   0x080295ba: 2000        movs	r0, #0
@   0x080295bc: 9002        str	r0, [sp, #8]
@   0x080295be: 2002        movs	r0, #2
@   0x080295c0: 2210        movs	r2, #16
@   0x080295c2: 2302        movs	r3, #2
@   0x080295c4: f7f7        fdbc 	bl	0x21140
@   0x080295c8: b003        add	sp, #12
@   0x080295ca: bc01        pop	{r0}
@   0x080295cc: 4700        bx	r0
@   0x080295ce: 0000        movs	r0, r0
@   0x080295d0: 6f64        ldr	r4, [r4, #116]	@ 0x74
@   0x080295d2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080295AC
sub_080295AC: @ 0x080295ac
        .incbin "baserom.gba", 0x295ac, 0x28
        thumb_func_end sub_080295AC
