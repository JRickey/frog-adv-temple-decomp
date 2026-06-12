@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080254dc, 0x08025508)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80254dc --end 0x8025508 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080254dc: b500        push	{lr}
@   0x080254de: b083        sub	sp, #12
@   0x080254e0: 4907        ldr	r1, [pc, #28]	@ (0x25500)
@   0x080254e2: 4808        ldr	r0, [pc, #32]	@ (0x25504)
@   0x080254e4: 9000        str	r0, [sp, #0]
@   0x080254e6: 200d        movs	r0, #13
@   0x080254e8: 9001        str	r0, [sp, #4]
@   0x080254ea: 2000        movs	r0, #0
@   0x080254ec: 9002        str	r0, [sp, #8]
@   0x080254ee: 2063        movs	r0, #99	@ 0x63
@   0x080254f0: 2210        movs	r2, #16
@   0x080254f2: 2328        movs	r3, #40	@ 0x28
@   0x080254f4: f7fb        fe24 	bl	0x21140
@   0x080254f8: b003        add	sp, #12
@   0x080254fa: bc01        pop	{r0}
@   0x080254fc: 4700        bx	r0
@   0x080254fe: 0000        movs	r0, r0
@   0x08025500: 33b0        adds	r3, #176	@ 0xb0
@   0x08025502: 0831        lsrs	r1, r6, #32
@   0x08025504: 0341        lsls	r1, r0, #13

        thumb_func_start sub_080254DC
sub_080254DC: @ 0x080254dc
        .incbin "baserom.gba", 0x254dc, 0x2c
        thumb_func_end sub_080254DC
