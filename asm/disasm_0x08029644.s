@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029644, 0x0802966c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029644 --end 0x802966c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029644: b500        push	{lr}
@   0x08029646: b083        sub	sp, #12
@   0x08029648: 4907        ldr	r1, [pc, #28]	@ (0x29668)
@   0x0802964a: 2061        movs	r0, #97	@ 0x61
@   0x0802964c: 9000        str	r0, [sp, #0]
@   0x0802964e: 2003        movs	r0, #3
@   0x08029650: 9001        str	r0, [sp, #4]
@   0x08029652: 2000        movs	r0, #0
@   0x08029654: 9002        str	r0, [sp, #8]
@   0x08029656: 201e        movs	r0, #30
@   0x08029658: 2210        movs	r2, #16
@   0x0802965a: 230b        movs	r3, #11
@   0x0802965c: f7f7        fd70 	bl	0x21140
@   0x08029660: b003        add	sp, #12
@   0x08029662: bc01        pop	{r0}
@   0x08029664: 4700        bx	r0
@   0x08029666: 0000        movs	r0, r0
@   0x08029668: 7054        strb	r4, [r2, #1]
@   0x0802966a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08029644
sub_08029644: @ 0x08029644
        .incbin "baserom.gba", 0x29644, 0x28
        thumb_func_end sub_08029644
