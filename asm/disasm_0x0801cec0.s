@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801cec0, 0x0801cf18)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801cec0 --end 0x801cf18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801cec0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801cec2: 1c07        adds	r7, r0, #0
@   0x0801cec4: 0609        lsls	r1, r1, #24
@   0x0801cec6: 0e0d        lsrs	r5, r1, #24
@   0x0801cec8: 2600        movs	r6, #0
@   0x0801ceca: 2100        movs	r1, #0
@   0x0801cecc: 42ae        cmp	r6, r5
@   0x0801cece: d21c        bcs.n	0x1cf0a
@   0x0801ced0: 1878        adds	r0, r7, r1
@   0x0801ced2: 7800        ldrb	r0, [r0, #0]
@   0x0801ced4: 3830        subs	r0, #48	@ 0x30
@   0x0801ced6: 0600        lsls	r0, r0, #24
@   0x0801ced8: 0e00        lsrs	r0, r0, #24
@   0x0801ceda: 2809        cmp	r0, #9
@   0x0801cedc: d817        bhi.n	0x1cf0e
@   0x0801cede: 1c02        adds	r2, r0, #0
@   0x0801cee0: 2300        movs	r3, #0
@   0x0801cee2: 1a68        subs	r0, r5, r1
@   0x0801cee4: 3801        subs	r0, #1
@   0x0801cee6: 1c4c        adds	r4, r1, #1
@   0x0801cee8: 4283        cmp	r3, r0
@   0x0801ceea: da09        bge.n	0x1cf00
@   0x0801ceec: 1c01        adds	r1, r0, #0
@   0x0801ceee: 0090        lsls	r0, r2, #2
@   0x0801cef0: 1880        adds	r0, r0, r2
@   0x0801cef2: 0640        lsls	r0, r0, #25
@   0x0801cef4: 0e02        lsrs	r2, r0, #24
@   0x0801cef6: 1c58        adds	r0, r3, #1
@   0x0801cef8: 0600        lsls	r0, r0, #24
@   0x0801cefa: 0e03        lsrs	r3, r0, #24
@   0x0801cefc: 428b        cmp	r3, r1
@   0x0801cefe: dbf6        blt.n	0x1ceee
@   0x0801cf00: 18b6        adds	r6, r6, r2
@   0x0801cf02: 0620        lsls	r0, r4, #24
@   0x0801cf04: 0e01        lsrs	r1, r0, #24
@   0x0801cf06: 42a9        cmp	r1, r5
@   0x0801cf08: d3e2        bcc.n	0x1ced0
@   0x0801cf0a: 1c30        adds	r0, r6, #0
@   0x0801cf0c: e001        b.n	0x1cf12
@   0x0801cf0e: 2001        movs	r0, #1
@   0x0801cf10: 4240        negs	r0, r0
@   0x0801cf12: bcf0        pop	{r4, r5, r6, r7}
@   0x0801cf14: bc02        pop	{r1}
@   0x0801cf16: 4708        bx	r1

        thumb_func_start sub_0801CEC0
sub_0801CEC0: @ 0x0801cec0
        .incbin "frog_us_baserom.gba", 0x1cec0, 0x58
        thumb_func_end sub_0801CEC0
