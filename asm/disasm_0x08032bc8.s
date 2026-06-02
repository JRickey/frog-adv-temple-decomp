@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032bc8, 0x08032c18)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032bc8 --end 0x8032c18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032bc8: b510        push	{r4, lr}
@   0x08032bca: 4684        mov	ip, r0
@   0x08032bcc: 1c0c        adds	r4, r1, #0
@   0x08032bce: 20c0        movs	r0, #192	@ 0xc0
@   0x08032bd0: 0200        lsls	r0, r0, #8
@   0x08032bd2: 4661        mov	r1, ip
@   0x08032bd4: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08032bd6: 313f        adds	r1, #63	@ 0x3f
@   0x08032bd8: 2001        movs	r0, #1
@   0x08032bda: 7008        strb	r0, [r1, #0]
@   0x08032bdc: 4661        mov	r1, ip
@   0x08032bde: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x08032be0: 490c        ldr	r1, [pc, #48]	@ (0x32c14)
@   0x08032be2: 4008        ands	r0, r1
@   0x08032be4: 4661        mov	r1, ip
@   0x08032be6: 6388        str	r0, [r1, #56]	@ 0x38
@   0x08032be8: 0052        lsls	r2, r2, #1
@   0x08032bea: 312b        adds	r1, #43	@ 0x2b
@   0x08032bec: 700a        strb	r2, [r1, #0]
@   0x08032bee: 0610        lsls	r0, r2, #24
@   0x08032bf0: 2800        cmp	r0, #0
@   0x08032bf2: d001        beq.n	0x32bf8
@   0x08032bf4: 1c50        adds	r0, r2, #1
@   0x08032bf6: 7008        strb	r0, [r1, #0]
@   0x08032bf8: 4662        mov	r2, ip
@   0x08032bfa: 8693        strh	r3, [r2, #52]	@ 0x34
@   0x08032bfc: 2300        movs	r3, #0
@   0x08032bfe: 5ed0        ldrsh	r0, [r2, r3]
@   0x08032c00: 231c        movs	r3, #28
@   0x08032c02: 5ed1        ldrsh	r1, [r2, r3]
@   0x08032c04: 1840        adds	r0, r0, r1
@   0x08032c06: 8450        strh	r0, [r2, #34]	@ 0x22
@   0x08032c08: 0220        lsls	r0, r4, #8
@   0x08032c0a: 8010        strh	r0, [r2, #0]
@   0x08032c0c: bc10        pop	{r4}
@   0x08032c0e: bc01        pop	{r0}
@   0x08032c10: 4700        bx	r0
@   0x08032c12: 0000        movs	r0, r0
@   0x08032c14: 7eef        ldrb	r7, [r5, #27]
@   0x08032c16: ffff        vsli.64	<illegal reg q13.5>, q8, #63	@ 0x3f

        thumb_func_start sub_08032BC8
sub_08032BC8: @ 0x08032bc8
        .incbin "frog_us_baserom.gba", 0x32bc8, 0x50
        thumb_func_end sub_08032BC8
