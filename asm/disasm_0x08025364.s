@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025364, 0x08025390)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025364 --end 0x8025390 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025364: b500        push	{lr}
@   0x08025366: b083        sub	sp, #12
@   0x08025368: 4907        ldr	r1, [pc, #28]	@ (0x25388)
@   0x0802536a: 4808        ldr	r0, [pc, #32]	@ (0x2538c)
@   0x0802536c: 9000        str	r0, [sp, #0]
@   0x0802536e: 2006        movs	r0, #6
@   0x08025370: 9001        str	r0, [sp, #4]
@   0x08025372: 2000        movs	r0, #0
@   0x08025374: 9002        str	r0, [sp, #8]
@   0x08025376: 203a        movs	r0, #58	@ 0x3a
@   0x08025378: 2210        movs	r2, #16
@   0x0802537a: 2322        movs	r3, #34	@ 0x22
@   0x0802537c: f7fb        fee0 	bl	0x21140
@   0x08025380: b003        add	sp, #12
@   0x08025382: bc01        pop	{r0}
@   0x08025384: 4700        bx	r0
@   0x08025386: 0000        movs	r0, r0
@   0x08025388: 3508        adds	r5, #8
@   0x0802538a: 0831        lsrs	r1, r6, #32
@   0x0802538c: 0291        lsls	r1, r2, #10

        thumb_func_start sub_08025364
sub_08025364: @ 0x08025364
        .incbin "baserom.gba", 0x25364, 0x2c
        thumb_func_end sub_08025364
