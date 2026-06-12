@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025ff4, 0x08026020)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025ff4 --end 0x8026020 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025ff4: b500        push	{lr}
@   0x08025ff6: b083        sub	sp, #12
@   0x08025ff8: 4907        ldr	r1, [pc, #28]	@ (0x26018)
@   0x08025ffa: 4808        ldr	r0, [pc, #32]	@ (0x2601c)
@   0x08025ffc: 9000        str	r0, [sp, #0]
@   0x08025ffe: 200a        movs	r0, #10
@   0x08026000: 9001        str	r0, [sp, #4]
@   0x08026002: 2000        movs	r0, #0
@   0x08026004: 9002        str	r0, [sp, #8]
@   0x08026006: 2050        movs	r0, #80	@ 0x50
@   0x08026008: 2210        movs	r2, #16
@   0x0802600a: 2328        movs	r3, #40	@ 0x28
@   0x0802600c: f7fb        f898 	bl	0x21140
@   0x08026010: b003        add	sp, #12
@   0x08026012: bc01        pop	{r0}
@   0x08026014: 4700        bx	r0
@   0x08026016: 0000        movs	r0, r0
@   0x08026018: 4828        ldr	r0, [pc, #160]	@ (0x260bc)
@   0x0802601a: 0831        lsrs	r1, r6, #32
@   0x0802601c: 01c1        lsls	r1, r0, #7

        thumb_func_start sub_08025FF4
sub_08025FF4: @ 0x08025ff4
        .incbin "baserom.gba", 0x25ff4, 0x2c
        thumb_func_end sub_08025FF4
