@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800b8a8, 0x0800b918)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800b8a8 --end 0x800b918 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800b8a8: b570        push	{r4, r5, r6, lr}
@   0x0800b8aa: 1c05        adds	r5, r0, #0
@   0x0800b8ac: 1c0e        adds	r6, r1, #0
@   0x0800b8ae: 0612        lsls	r2, r2, #24
@   0x0800b8b0: 0e10        lsrs	r0, r2, #24
@   0x0800b8b2: 061b        lsls	r3, r3, #24
@   0x0800b8b4: 0e1b        lsrs	r3, r3, #24
@   0x0800b8b6: 2b17        cmp	r3, #23
@   0x0800b8b8: d127        bne.n	0xb90a
@   0x0800b8ba: 0600        lsls	r0, r0, #24
@   0x0800b8bc: 1600        asrs	r0, r0, #24
@   0x0800b8be: 4a14        ldr	r2, [pc, #80]	@ (0xb910)
@   0x0800b8c0: 2308        movs	r3, #8
@   0x0800b8c2: 5ed1        ldrsh	r1, [r2, r3]
@   0x0800b8c4: 230a        movs	r3, #10
@   0x0800b8c6: 5ed2        ldrsh	r2, [r2, r3]
@   0x0800b8c8: f7fe        ff6e 	bl	0xa7a8
@   0x0800b8cc: 0600        lsls	r0, r0, #24
@   0x0800b8ce: 1604        asrs	r4, r0, #24
@   0x0800b8d0: 2001        movs	r0, #1
@   0x0800b8d2: 4240        negs	r0, r0
@   0x0800b8d4: 4284        cmp	r4, r0
@   0x0800b8d6: d018        beq.n	0xb90a
@   0x0800b8d8: 00e0        lsls	r0, r4, #3
@   0x0800b8da: 1941        adds	r1, r0, r5
@   0x0800b8dc: 7908        ldrb	r0, [r1, #4]
@   0x0800b8de: 2800        cmp	r0, #0
@   0x0800b8e0: d113        bne.n	0xb90a
@   0x0800b8e2: 7148        strb	r0, [r1, #5]
@   0x0800b8e4: 2001        movs	r0, #1
@   0x0800b8e6: 7108        strb	r0, [r1, #4]
@   0x0800b8e8: 480a        ldr	r0, [pc, #40]	@ (0xb914)
@   0x0800b8ea: 6800        ldr	r0, [r0, #0]
@   0x0800b8ec: 6008        str	r0, [r1, #0]
@   0x0800b8ee: 2016        movs	r0, #22
@   0x0800b8f0: f015        f9c2 	bl	0x20c78
@   0x0800b8f4: 2001        movs	r0, #1
@   0x0800b8f6: 2100        movs	r1, #0
@   0x0800b8f8: 1c22        adds	r2, r4, #0
@   0x0800b8fa: f028        f9d3 	bl	0x33ca4
@   0x0800b8fe: 6832        ldr	r2, [r6, #0]
@   0x0800b900: 6873        ldr	r3, [r6, #4]
@   0x0800b902: 4302        orrs	r2, r0
@   0x0800b904: 430b        orrs	r3, r1
@   0x0800b906: 6032        str	r2, [r6, #0]
@   0x0800b908: 6073        str	r3, [r6, #4]
@   0x0800b90a: bc70        pop	{r4, r5, r6}
@   0x0800b90c: bc01        pop	{r0}
@   0x0800b90e: 4700        bx	r0
@   0x0800b910: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b912: 0300        lsls	r0, r0, #12
@   0x0800b914: 5330        strh	r0, [r6, r4]
@   0x0800b916: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800B8A8
sub_0800B8A8: @ 0x0800b8a8
        .incbin "frog_us_baserom.gba", 0xb8a8, 0x70
        thumb_func_end sub_0800B8A8
