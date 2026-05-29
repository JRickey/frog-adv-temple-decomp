@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001794, 0x080017a8)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001794 --end 0x80017a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001794: b500        push	{lr}
@   0x08001796: 4b03        ldr	r3, [pc, #12]	@ (0x17a4)
@   0x08001798: 2204        movs	r2, #4
@   0x0800179a: 729a        strb	r2, [r3, #10]
@   0x0800179c: f00a        f808 	bl	0xb7b0
@   0x080017a0: bc01        pop	{r0}
@   0x080017a2: 4700        bx	r0
@   0x080017a4: 5330        strh	r0, [r6, r4]
@   0x080017a6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001794
sub_08001794: @ 0x08001794
        .incbin "frog_us_baserom.gba", 0x1794, 0x14
        thumb_func_end sub_08001794
