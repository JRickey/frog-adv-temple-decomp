@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080040c4, 0x080040ec)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80040c4 --end 0x80040ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080040c4: b500        push	{lr}
@   0x080040c6: f006        f907 	bl	0xa2d8
@   0x080040ca: f7fc        fc07 	bl	0x8dc
@   0x080040ce: f006        f92b 	bl	0xa328
@   0x080040d2: f005        fa11 	bl	0x94f8
@   0x080040d6: f005        fc55 	bl	0x9984
@   0x080040da: 4903        ldr	r1, [pc, #12]	@ (0x40e8)
@   0x080040dc: 6948        ldr	r0, [r1, #20]
@   0x080040de: 3001        adds	r0, #1
@   0x080040e0: 6148        str	r0, [r1, #20]
@   0x080040e2: bc01        pop	{r0}
@   0x080040e4: 4700        bx	r0
@   0x080040e6: 0000        movs	r0, r0
@   0x080040e8: 5330        strh	r0, [r6, r4]
@   0x080040ea: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080040C4
sub_080040C4: @ 0x080040c4
        .incbin "frog_us_baserom.gba", 0x40c4, 0x28
        thumb_func_end sub_080040C4
