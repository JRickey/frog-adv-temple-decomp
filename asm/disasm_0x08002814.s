@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002814, 0x08002844)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002814 --end 0x8002844 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002814: b510        push	{r4, lr}
@   0x08002816: 4b0a        ldr	r3, [pc, #40]	@ (0x2840)
@   0x08002818: 2010        movs	r0, #16
@   0x0800281a: 8a19        ldrh	r1, [r3, #16]
@   0x0800281c: 4008        ands	r0, r1
@   0x0800281e: 2800        cmp	r0, #0
@   0x08002820: d00b        beq.n	0x283a
@   0x08002822: 7e18        ldrb	r0, [r3, #24]
@   0x08002824: 7e59        ldrb	r1, [r3, #25]
@   0x08002826: 2408        movs	r4, #8
@   0x08002828: 5f1a        ldrsh	r2, [r3, r4]
@   0x0800282a: 240a        movs	r4, #10
@   0x0800282c: 5f1b        ldrsh	r3, [r3, r4]
@   0x0800282e: f00a        faab 	bl	0xcd88
@   0x08002832: 0600        lsls	r0, r0, #24
@   0x08002834: 0e00        lsrs	r0, r0, #24
@   0x08002836: f009        fdd5 	bl	0xc3e4
@   0x0800283a: bc10        pop	{r4}
@   0x0800283c: bc01        pop	{r0}
@   0x0800283e: 4700        bx	r0
@   0x08002840: 35e0        adds	r5, #224	@ 0xe0
@   0x08002842: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002814
sub_08002814: @ 0x08002814
        .incbin "frog_us_baserom.gba", 0x2814, 0x30
        thumb_func_end sub_08002814
