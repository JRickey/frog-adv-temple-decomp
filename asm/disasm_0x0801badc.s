@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801badc, 0x0801bb1c)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801badc --end 0x801bb1c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801badc: b500        push	{lr}
@   0x0801bade: b083        sub	sp, #12
@   0x0801bae0: f7ff        fb38 	bl	0x1b154
@   0x0801bae4: 0600        lsls	r0, r0, #24
@   0x0801bae6: 0e00        lsrs	r0, r0, #24
@   0x0801bae8: 2810        cmp	r0, #16
@   0x0801baea: d100        bne.n	0x1baee
@   0x0801baec: 200f        movs	r0, #15
@   0x0801baee: 4909        ldr	r1, [pc, #36]	@ (0x1bb14)
@   0x0801baf0: 0080        lsls	r0, r0, #2
@   0x0801baf2: 1840        adds	r0, r0, r1
@   0x0801baf4: 6801        ldr	r1, [r0, #0]
@   0x0801baf6: 2064        movs	r0, #100	@ 0x64
@   0x0801baf8: 9000        str	r0, [sp, #0]
@   0x0801bafa: 2003        movs	r0, #3
@   0x0801bafc: 9001        str	r0, [sp, #4]
@   0x0801bafe: 2000        movs	r0, #0
@   0x0801bb00: 9002        str	r0, [sp, #8]
@   0x0801bb02: 2004        movs	r0, #4
@   0x0801bb04: 2200        movs	r2, #0
@   0x0801bb06: 2333        movs	r3, #51	@ 0x33
@   0x0801bb08: f005        fb1a 	bl	0x21140
@   0x0801bb0c: b003        add	sp, #12
@   0x0801bb0e: bc01        pop	{r0}
@   0x0801bb10: 4700        bx	r0
@   0x0801bb12: 0000        movs	r0, r0
@   0x0801bb14: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x0801bb16: 0830        lsrs	r0, r6, #32
@   0x0801bb18: 4770        bx	lr

        thumb_func_start sub_0801BADC
sub_0801BADC: @ 0x0801badc
        .incbin "frog_us_baserom.gba", 0x1badc, 0x40
        thumb_func_end sub_0801BADC
