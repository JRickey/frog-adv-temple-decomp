@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080229cc, 0x080229f0)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80229cc --end 0x80229f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080229cc: b500        push	{lr}
@   0x080229ce: b081        sub	sp, #4
@   0x080229d0: 4905        ldr	r1, [pc, #20]	@ (0x229e8)
@   0x080229d2: 4b06        ldr	r3, [pc, #24]	@ (0x229ec)
@   0x080229d4: 200a        movs	r0, #10
@   0x080229d6: 9000        str	r0, [sp, #0]
@   0x080229d8: 2006        movs	r0, #6
@   0x080229da: 220b        movs	r2, #11
@   0x080229dc: f7fe        fd98 	bl	0x21510
@   0x080229e0: b001        add	sp, #4
@   0x080229e2: bc01        pop	{r0}
@   0x080229e4: 4700        bx	r0
@   0x080229e6: 0000        movs	r0, r0
@   0x080229e8: 1440        asrs	r0, r0, #17
@   0x080229ea: 0831        lsrs	r1, r6, #32
@   0x080229ec: 6110        str	r0, [r2, #16]
@   0x080229ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080229CC
sub_080229CC: @ 0x080229cc
        .incbin "frog_us_baserom.gba", 0x229cc, 0x24
        thumb_func_end sub_080229CC
