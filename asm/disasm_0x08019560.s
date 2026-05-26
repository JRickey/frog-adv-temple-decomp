@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019560, 0x08019580)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019560 --end 0x8019580 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019560: b500        push	{lr}
@   0x08019562: 4905        ldr	r1, [pc, #20]	@ (0x19578)
@   0x08019564: 4805        ldr	r0, [pc, #20]	@ (0x1957c)
@   0x08019566: 78c0        ldrb	r0, [r0, #3]
@   0x08019568: 0080        lsls	r0, r0, #2
@   0x0801956a: 1840        adds	r0, r0, r1
@   0x0801956c: 6800        ldr	r0, [r0, #0]
@   0x0801956e: f01a        fbb3 	bl	0x33cd8
@   0x08019572: bc01        pop	{r0}
@   0x08019574: 4700        bx	r0
@   0x08019576: 0000        movs	r0, r0
@   0x08019578: 8058        strh	r0, [r3, #2]
@   0x0801957a: 0830        lsrs	r0, r6, #32
@   0x0801957c: 3480        adds	r4, #128	@ 0x80
@   0x0801957e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019560
sub_08019560: @ 0x08019560
        .incbin "frog_us_baserom.gba", 0x19560, 0x20
        thumb_func_end sub_08019560
