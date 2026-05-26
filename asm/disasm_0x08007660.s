@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007660, 0x080076a4)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007660 --end 0x80076a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007660: b570        push	{r4, r5, r6, lr}
@   0x08007662: 1c0e        adds	r6, r1, #0
@   0x08007664: 490e        ldr	r1, [pc, #56]	@ (0x76a0)
@   0x08007666: 0600        lsls	r0, r0, #24
@   0x08007668: 1540        asrs	r0, r0, #21
@   0x0800766a: 1845        adds	r5, r0, r1
@   0x0800766c: 2400        movs	r4, #0
@   0x0800766e: 572c        ldrsb	r4, [r5, r4]
@   0x08007670: 1e62        subs	r2, r4, #1
@   0x08007672: 2302        movs	r3, #2
@   0x08007674: 56eb        ldrsb	r3, [r5, r3]
@   0x08007676: 1c30        adds	r0, r6, #0
@   0x08007678: 2100        movs	r1, #0
@   0x0800767a: f7ff        fb53 	bl	0x6d24
@   0x0800767e: 1c30        adds	r0, r6, #0
@   0x08007680: 1c21        adds	r1, r4, #0
@   0x08007682: f7ff        fcb3 	bl	0x6fec
@   0x08007686: 2800        cmp	r0, #0
@   0x08007688: d007        beq.n	0x769a
@   0x0800768a: 782a        ldrb	r2, [r5, #0]
@   0x0800768c: 3a01        subs	r2, #1
@   0x0800768e: 0612        lsls	r2, r2, #24
@   0x08007690: 1612        asrs	r2, r2, #24
@   0x08007692: 1c30        adds	r0, r6, #0
@   0x08007694: 2100        movs	r1, #0
@   0x08007696: f7ff        fbf9 	bl	0x6e8c
@   0x0800769a: bc70        pop	{r4, r5, r6}
@   0x0800769c: bc01        pop	{r0}
@   0x0800769e: 4700        bx	r0
@   0x080076a0: 0ab0        lsrs	r0, r6, #10
@   0x080076a2: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_08007660
sub_08007660: @ 0x08007660
        .incbin "frog_us_baserom.gba", 0x7660, 0x44
        thumb_func_end sub_08007660
