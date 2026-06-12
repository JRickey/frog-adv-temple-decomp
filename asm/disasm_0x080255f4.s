@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080255f4, 0x08025620)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80255f4 --end 0x8025620 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080255f4: b500        push	{lr}
@   0x080255f6: b083        sub	sp, #12
@   0x080255f8: 4907        ldr	r1, [pc, #28]	@ (0x25618)
@   0x080255fa: 4808        ldr	r0, [pc, #32]	@ (0x2561c)
@   0x080255fc: 9000        str	r0, [sp, #0]
@   0x080255fe: 200e        movs	r0, #14
@   0x08025600: 9001        str	r0, [sp, #4]
@   0x08025602: 2000        movs	r0, #0
@   0x08025604: 9002        str	r0, [sp, #8]
@   0x08025606: 2066        movs	r0, #102	@ 0x66
@   0x08025608: 2200        movs	r2, #0
@   0x0802560a: 234c        movs	r3, #76	@ 0x4c
@   0x0802560c: f7fb        fd98 	bl	0x21140
@   0x08025610: b003        add	sp, #12
@   0x08025612: bc01        pop	{r0}
@   0x08025614: 4700        bx	r0
@   0x08025616: 0000        movs	r0, r0
@   0x08025618: 33a0        adds	r3, #160	@ 0xa0
@   0x0802561a: 0831        lsrs	r1, r6, #32
@   0x0802561c: 0331        lsls	r1, r6, #12

        thumb_func_start sub_080255F4
sub_080255F4: @ 0x080255f4
        .incbin "baserom.gba", 0x255f4, 0x2c
        thumb_func_end sub_080255F4
