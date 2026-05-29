@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001850, 0x0800189c)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001850 --end 0x800189c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001850: b570        push	{r4, r5, r6, lr}
@   0x08001852: 1c04        adds	r4, r0, #0
@   0x08001854: 1c0d        adds	r5, r1, #0
@   0x08001856: 1c16        adds	r6, r2, #0
@   0x08001858: f008        f9dc 	bl	0x9c14
@   0x0800185c: 2800        cmp	r0, #0
@   0x0800185e: d101        bne.n	0x1864
@   0x08001860: 2007        movs	r0, #7
@   0x08001862: 7020        strb	r0, [r4, #0]
@   0x08001864: 1c28        adds	r0, r5, #0
@   0x08001866: 1c31        adds	r1, r6, #0
@   0x08001868: 2204        movs	r2, #4
@   0x0800186a: f009        ffa1 	bl	0xb7b0
@   0x0800186e: 4805        ldr	r0, [pc, #20]	@ (0x1884)
@   0x08001870: 7940        ldrb	r0, [r0, #5]
@   0x08001872: 0600        lsls	r0, r0, #24
@   0x08001874: 1600        asrs	r0, r0, #24
@   0x08001876: 2801        cmp	r0, #1
@   0x08001878: dc08        bgt.n	0x188c
@   0x0800187a: 4903        ldr	r1, [pc, #12]	@ (0x1888)
@   0x0800187c: 2000        movs	r0, #0
@   0x0800187e: 6108        str	r0, [r1, #16]
@   0x08001880: 84c8        strh	r0, [r1, #38]	@ 0x26
@   0x08001882: e006        b.n	0x1892
@   0x08001884: 35e0        adds	r5, #224	@ 0xe0
@   0x08001886: 0300        lsls	r0, r0, #12
@   0x08001888: 6110        str	r0, [r2, #16]
@   0x0800188a: 0300        lsls	r0, r0, #12
@   0x0800188c: 4902        ldr	r1, [pc, #8]	@ (0x1898)
@   0x0800188e: 2005        movs	r0, #5
@   0x08001890: 6108        str	r0, [r1, #16]
@   0x08001892: bc70        pop	{r4, r5, r6}
@   0x08001894: bc01        pop	{r0}
@   0x08001896: 4700        bx	r0
@   0x08001898: 6110        str	r0, [r2, #16]
@   0x0800189a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001850
sub_08001850: @ 0x08001850
        .incbin "frog_us_baserom.gba", 0x1850, 0x4c
        thumb_func_end sub_08001850
