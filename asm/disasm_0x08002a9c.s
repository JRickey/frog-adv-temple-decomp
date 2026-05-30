@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002a9c, 0x08002ac4)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002a9c --end 0x8002ac4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002a9c: b500        push	{lr}
@   0x08002a9e: f007        fc1b 	bl	0xa2d8
@   0x08002aa2: f7fd        ff1b 	bl	0x8dc
@   0x08002aa6: f007        fc3f 	bl	0xa328
@   0x08002aaa: f006        fd25 	bl	0x94f8
@   0x08002aae: f006        ff69 	bl	0x9984
@   0x08002ab2: 4903        ldr	r1, [pc, #12]	@ (0x2ac0)
@   0x08002ab4: 6948        ldr	r0, [r1, #20]
@   0x08002ab6: 3001        adds	r0, #1
@   0x08002ab8: 6148        str	r0, [r1, #20]
@   0x08002aba: bc01        pop	{r0}
@   0x08002abc: 4700        bx	r0
@   0x08002abe: 0000        movs	r0, r0
@   0x08002ac0: 5330        strh	r0, [r6, r4]
@   0x08002ac2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002A9C
sub_08002A9C: @ 0x08002a9c
        .incbin "frog_us_baserom.gba", 0x2a9c, 0x28
        thumb_func_end sub_08002A9C
