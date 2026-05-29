@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017a88, 0x08017aa8)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017a88 --end 0x8017aa8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017a88: b500        push	{lr}
@   0x08017a8a: f000        f80d 	bl	0x17aa8
@   0x08017a8e: 4a04        ldr	r2, [pc, #16]	@ (0x17aa0)
@   0x08017a90: 4804        ldr	r0, [pc, #16]	@ (0x17aa4)
@   0x08017a92: 7880        ldrb	r0, [r0, #2]
@   0x08017a94: 2100        movs	r1, #0
@   0x08017a96: 7010        strb	r0, [r2, #0]
@   0x08017a98: 8051        strh	r1, [r2, #2]
@   0x08017a9a: bc01        pop	{r0}
@   0x08017a9c: 4700        bx	r0
@   0x08017a9e: 0000        movs	r0, r0
@   0x08017aa0: 35e0        adds	r5, #224	@ 0xe0
@   0x08017aa2: 0300        lsls	r0, r0, #12
@   0x08017aa4: 34b4        adds	r4, #180	@ 0xb4
@   0x08017aa6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08017A88
sub_08017A88: @ 0x08017a88
        .incbin "frog_us_baserom.gba", 0x17a88, 0x20
        thumb_func_end sub_08017A88
