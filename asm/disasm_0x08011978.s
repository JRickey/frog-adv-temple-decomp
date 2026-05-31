@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011978, 0x08011984)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011978 --end 0x8011984 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011978: b500        push	{lr}
@   0x0801197a: f005        fb41 	bl	0x17000
@   0x0801197e: bc01        pop	{r0}
@   0x08011980: 4700        bx	r0

        thumb_func_start sub_08011978
sub_08011978: @ 0x08011978
        .incbin "frog_us_baserom.gba", 0x11978, 0xc
        thumb_func_end sub_08011978
