@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031868, 0x0803189c)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031868 --end 0x803189c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031868: b530        push	{r4, r5, lr}
@   0x0803186a: 1c0d        adds	r5, r1, #0
@   0x0803186c: 682c        ldr	r4, [r5, #0]
@   0x0803186e: 20ff        movs	r0, #255	@ 0xff
@   0x08031870: f7fc        fdaa 	bl	0x2e3c8
@   0x08031874: 0400        lsls	r0, r0, #16
@   0x08031876: 0c00        lsrs	r0, r0, #16
@   0x08031878: 7861        ldrb	r1, [r4, #1]
@   0x0803187a: 4288        cmp	r0, r1
@   0x0803187c: d306        bcc.n	0x3188c
@   0x0803187e: 88a0        ldrh	r0, [r4, #4]
@   0x08031880: 0401        lsls	r1, r0, #16
@   0x08031882: 8864        ldrh	r4, [r4, #2]
@   0x08031884: 4321        orrs	r1, r4
@   0x08031886: 6828        ldr	r0, [r5, #0]
@   0x08031888: 1840        adds	r0, r0, r1
@   0x0803188a: e001        b.n	0x31890
@   0x0803188c: 6828        ldr	r0, [r5, #0]
@   0x0803188e: 3006        adds	r0, #6
@   0x08031890: 6028        str	r0, [r5, #0]
@   0x08031892: 2001        movs	r0, #1
@   0x08031894: bc30        pop	{r4, r5}
@   0x08031896: bc02        pop	{r1}
@   0x08031898: 4708        bx	r1

        thumb_func_start sub_08031868
sub_08031868: @ 0x08031868
        .incbin "frog_us_baserom.gba", 0x31868, 0x34
        thumb_func_end sub_08031868
