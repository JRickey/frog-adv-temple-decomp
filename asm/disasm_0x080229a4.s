@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080229a4, 0x080229cc)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80229a4 --end 0x80229cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080229a4: b500        push	{lr}
@   0x080229a6: b083        sub	sp, #12
@   0x080229a8: 4907        ldr	r1, [pc, #28]	@ (0x229c8)
@   0x080229aa: 20d1        movs	r0, #209	@ 0xd1
@   0x080229ac: 9000        str	r0, [sp, #0]
@   0x080229ae: 2007        movs	r0, #7
@   0x080229b0: 9001        str	r0, [sp, #4]
@   0x080229b2: 200a        movs	r0, #10
@   0x080229b4: 9002        str	r0, [sp, #8]
@   0x080229b6: 2006        movs	r0, #6
@   0x080229b8: 2200        movs	r2, #0
@   0x080229ba: 230b        movs	r3, #11
@   0x080229bc: f7fe        fbc0 	bl	0x21140
@   0x080229c0: b003        add	sp, #12
@   0x080229c2: bc01        pop	{r0}
@   0x080229c4: 4700        bx	r0
@   0x080229c6: 0000        movs	r0, r0
@   0x080229c8: 1440        asrs	r0, r0, #17
@   0x080229ca: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080229A4
sub_080229A4: @ 0x080229a4
        .incbin "frog_us_baserom.gba", 0x229a4, 0x28
        thumb_func_end sub_080229A4
