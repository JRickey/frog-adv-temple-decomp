@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080024e4, 0x08002518)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80024e4 --end 0x8002518 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080024e4: b510        push	{r4, lr}
@   0x080024e6: 1c04        adds	r4, r0, #0
@   0x080024e8: f007        fb94 	bl	0x9c14
@   0x080024ec: 2800        cmp	r0, #0
@   0x080024ee: d101        bne.n	0x24f4
@   0x080024f0: 2008        movs	r0, #8
@   0x080024f2: 7020        strb	r0, [r4, #0]
@   0x080024f4: 4807        ldr	r0, [pc, #28]	@ (0x2514)
@   0x080024f6: 1c02        adds	r2, r0, #0
@   0x080024f8: 322a        adds	r2, #42	@ 0x2a
@   0x080024fa: 2100        movs	r1, #0
@   0x080024fc: 7011        strb	r1, [r2, #0]
@   0x080024fe: 8181        strh	r1, [r0, #12]
@   0x08002500: 302b        adds	r0, #43	@ 0x2b
@   0x08002502: 7800        ldrb	r0, [r0, #0]
@   0x08002504: 2801        cmp	r0, #1
@   0x08002506: d101        bne.n	0x250c
@   0x08002508: f028        fb2c 	bl	0x2ab64
@   0x0800250c: bc10        pop	{r4}
@   0x0800250e: bc01        pop	{r0}
@   0x08002510: 4700        bx	r0
@   0x08002512: 0000        movs	r0, r0
@   0x08002514: 6110        str	r0, [r2, #16]
@   0x08002516: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080024E4
sub_080024E4: @ 0x080024e4
        .incbin "frog_us_baserom.gba", 0x24e4, 0x34
        thumb_func_end sub_080024E4
