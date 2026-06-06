@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031910, 0x0803194c)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031910 --end 0x803194c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031910: b510        push	{r4, lr}
@   0x08031912: 1c02        adds	r2, r0, #0
@   0x08031914: 1c0c        adds	r4, r1, #0
@   0x08031916: 6820        ldr	r0, [r4, #0]
@   0x08031918: 7841        ldrb	r1, [r0, #1]
@   0x0803191a: 4805        ldr	r0, [pc, #20]	@ (0x31930)
@   0x0803191c: 6800        ldr	r0, [r0, #0]
@   0x0803191e: 7800        ldrb	r0, [r0, #0]
@   0x08031920: 3004        adds	r0, #4
@   0x08031922: 4281        cmp	r1, r0
@   0x08031924: da06        bge.n	0x31934
@   0x08031926: 1c08        adds	r0, r1, #0
@   0x08031928: f7fe        f862 	bl	0x2f9f0
@   0x0803192c: e007        b.n	0x3193e
@   0x0803192e: 0000        movs	r0, r0
@   0x08031930: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031932: 0300        lsls	r0, r0, #12
@   0x08031934: 29ff        cmp	r1, #255	@ 0xff
@   0x08031936: d102        bne.n	0x3193e
@   0x08031938: 1c10        adds	r0, r2, #0
@   0x0803193a: f7fe        f859 	bl	0x2f9f0
@   0x0803193e: 6820        ldr	r0, [r4, #0]
@   0x08031940: 3002        adds	r0, #2
@   0x08031942: 6020        str	r0, [r4, #0]
@   0x08031944: 2001        movs	r0, #1
@   0x08031946: bc10        pop	{r4}
@   0x08031948: bc02        pop	{r1}
@   0x0803194a: 4708        bx	r1

        thumb_func_start sub_08031910
sub_08031910: @ 0x08031910
        .incbin "frog_us_baserom.gba", 0x31910, 0x3c
        thumb_func_end sub_08031910
