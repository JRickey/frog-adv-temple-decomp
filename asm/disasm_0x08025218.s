@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025218, 0x08025240)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025218 --end 0x8025240 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025218: b500        push	{lr}
@   0x0802521a: b083        sub	sp, #12
@   0x0802521c: 4907        ldr	r1, [pc, #28]	@ (0x2523c)
@   0x0802521e: 2061        movs	r0, #97	@ 0x61
@   0x08025220: 9000        str	r0, [sp, #0]
@   0x08025222: 2003        movs	r0, #3
@   0x08025224: 9001        str	r0, [sp, #4]
@   0x08025226: 2000        movs	r0, #0
@   0x08025228: 9002        str	r0, [sp, #8]
@   0x0802522a: 2027        movs	r0, #39	@ 0x27
@   0x0802522c: 2210        movs	r2, #16
@   0x0802522e: 2304        movs	r3, #4
@   0x08025230: f7fb        ff86 	bl	0x21140
@   0x08025234: b003        add	sp, #12
@   0x08025236: bc01        pop	{r0}
@   0x08025238: 4700        bx	r0
@   0x0802523a: 0000        movs	r0, r0
@   0x0802523c: 3528        adds	r5, #40	@ 0x28
@   0x0802523e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025218
sub_08025218: @ 0x08025218
        .incbin "baserom.gba", 0x25218, 0x28
        thumb_func_end sub_08025218
