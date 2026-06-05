@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023594, 0x080235c8)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023594 --end 0x80235c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023594: b500        push	{lr}
@   0x08023596: f7ff        fb55 	bl	0x22c44
@   0x0802359a: f7ff        fb17 	bl	0x22bcc
@   0x0802359e: f7ff        fe51 	bl	0x23244
@   0x080235a2: f7ff        fc1b 	bl	0x22ddc
@   0x080235a6: f7ff        fe91 	bl	0x232cc
@   0x080235aa: f7ff        ff29 	bl	0x23400
@   0x080235ae: f7ff        ff39 	bl	0x23424
@   0x080235b2: f7ff        fed5 	bl	0x23360
@   0x080235b6: f7ff        fefb 	bl	0x233b0
@   0x080235ba: f7ff        fd17 	bl	0x22fec
@   0x080235be: f7ff        ffa9 	bl	0x23514
@   0x080235c2: bc01        pop	{r0}
@   0x080235c4: 4700        bx	r0

        thumb_func_start sub_08023594
sub_08023594: @ 0x08023594
        .incbin "frog_us_baserom.gba", 0x23594, 0x34
        thumb_func_end sub_08023594
