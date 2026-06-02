@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022bcc, 0x08022c44)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022bcc --end 0x8022c44 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022bcc: b510        push	{r4, lr}
@   0x08022bce: b081        sub	sp, #4
@   0x08022bd0: 2400        movs	r4, #0
@   0x08022bd2: 00e0        lsls	r0, r4, #3
@   0x08022bd4: 1b00        subs	r0, r0, r4
@   0x08022bd6: 00c0        lsls	r0, r0, #3
@   0x08022bd8: 4905        ldr	r1, [pc, #20]	@ (0x22bf0)
@   0x08022bda: 1840        adds	r0, r0, r1
@   0x08022bdc: 7e81        ldrb	r1, [r0, #26]
@   0x08022bde: 2900        cmp	r1, #0
@   0x08022be0: d108        bne.n	0x22bf4
@   0x08022be2: 7ec1        ldrb	r1, [r0, #27]
@   0x08022be4: 2901        cmp	r1, #1
@   0x08022be6: d00a        beq.n	0x22bfe
@   0x08022be8: 2907        cmp	r1, #7
@   0x08022bea: d115        bne.n	0x22c18
@   0x08022bec: 2107        movs	r1, #7
@   0x08022bee: e007        b.n	0x22c00
@   0x08022bf0: 3790        adds	r7, #144	@ 0x90
@   0x08022bf2: 0300        lsls	r0, r0, #12
@   0x08022bf4: 2901        cmp	r1, #1
@   0x08022bf6: d10f        bne.n	0x22c18
@   0x08022bf8: 7ec1        ldrb	r1, [r0, #27]
@   0x08022bfa: 2903        cmp	r1, #3
@   0x08022bfc: d105        bne.n	0x22c0a
@   0x08022bfe: 2106        movs	r1, #6
@   0x08022c00: 2202        movs	r2, #2
@   0x08022c02: 2302        movs	r3, #2
@   0x08022c04: f7fe        f906 	bl	0x20e14
@   0x08022c08: e006        b.n	0x22c18
@   0x08022c0a: 2909        cmp	r1, #9
@   0x08022c0c: d104        bne.n	0x22c18
@   0x08022c0e: 2107        movs	r1, #7
@   0x08022c10: 2202        movs	r2, #2
@   0x08022c12: 2302        movs	r3, #2
@   0x08022c14: f7fe        f8fe 	bl	0x20e14
@   0x08022c18: 1c60        adds	r0, r4, #1
@   0x08022c1a: 0600        lsls	r0, r0, #24
@   0x08022c1c: 0e04        lsrs	r4, r0, #24
@   0x08022c1e: 2c03        cmp	r4, #3
@   0x08022c20: d9d7        bls.n	0x22bd2
@   0x08022c22: 4906        ldr	r1, [pc, #24]	@ (0x22c3c)
@   0x08022c24: 4b06        ldr	r3, [pc, #24]	@ (0x22c40)
@   0x08022c26: 2000        movs	r0, #0
@   0x08022c28: 9000        str	r0, [sp, #0]
@   0x08022c2a: 2002        movs	r0, #2
@   0x08022c2c: 2211        movs	r2, #17
@   0x08022c2e: f7fe        fc6f 	bl	0x21510
@   0x08022c32: b001        add	sp, #4
@   0x08022c34: bc10        pop	{r4}
@   0x08022c36: bc01        pop	{r0}
@   0x08022c38: 4700        bx	r0
@   0x08022c3a: 0000        movs	r0, r0
@   0x08022c3c: 1498        asrs	r0, r3, #18
@   0x08022c3e: 0831        lsrs	r1, r6, #32
@   0x08022c40: 6110        str	r0, [r2, #16]
@   0x08022c42: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022BCC
sub_08022BCC: @ 0x08022bcc
        .incbin "frog_us_baserom.gba", 0x22bcc, 0x78
        thumb_func_end sub_08022BCC
