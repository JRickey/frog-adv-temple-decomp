@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08030a44, 0x08030b34)  (240 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8030a44 --end 0x8030b34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030a44: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030a46: 464f        mov	r7, r9
@   0x08030a48: 4646        mov	r6, r8
@   0x08030a4a: b4c0        push	{r6, r7}
@   0x08030a4c: 1c02        adds	r2, r0, #0
@   0x08030a4e: 4689        mov	r9, r1
@   0x08030a50: 680c        ldr	r4, [r1, #0]
@   0x08030a52: 2a03        cmp	r2, #3
@   0x08030a54: dd62        ble.n	0x30b1c
@   0x08030a56: 3a04        subs	r2, #4
@   0x08030a58: 481a        ldr	r0, [pc, #104]	@ (0x30ac4)
@   0x08030a5a: 6803        ldr	r3, [r0, #0]
@   0x08030a5c: 1c18        adds	r0, r3, #0
@   0x08030a5e: 30c8        adds	r0, #200	@ 0xc8
@   0x08030a60: 0191        lsls	r1, r2, #6
@   0x08030a62: 6800        ldr	r0, [r0, #0]
@   0x08030a64: 1840        adds	r0, r0, r1
@   0x08030a66: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x08030a68: 2180        movs	r1, #128	@ 0x80
@   0x08030a6a: 0149        lsls	r1, r1, #5
@   0x08030a6c: 4008        ands	r0, r1
@   0x08030a6e: 2800        cmp	r0, #0
@   0x08030a70: d054        beq.n	0x30b1c
@   0x08030a72: 1c19        adds	r1, r3, #0
@   0x08030a74: 31c0        adds	r1, #192	@ 0xc0
@   0x08030a76: 00d0        lsls	r0, r2, #3
@   0x08030a78: 1a80        subs	r0, r0, r2
@   0x08030a7a: 0080        lsls	r0, r0, #2
@   0x08030a7c: 6809        ldr	r1, [r1, #0]
@   0x08030a7e: 180e        adds	r6, r1, r0
@   0x08030a80: 6830        ldr	r0, [r6, #0]
@   0x08030a82: 2110        movs	r1, #16
@   0x08030a84: 1809        adds	r1, r1, r0
@   0x08030a86: 468c        mov	ip, r1
@   0x08030a88: 8921        ldrh	r1, [r4, #8]
@   0x08030a8a: 040b        lsls	r3, r1, #16
@   0x08030a8c: 88e1        ldrh	r1, [r4, #6]
@   0x08030a8e: 430b        orrs	r3, r1
@   0x08030a90: 88a1        ldrh	r1, [r4, #4]
@   0x08030a92: 040a        lsls	r2, r1, #16
@   0x08030a94: 8861        ldrh	r1, [r4, #2]
@   0x08030a96: 430a        orrs	r2, r1
@   0x08030a98: 6801        ldr	r1, [r0, #0]
@   0x08030a9a: 428a        cmp	r2, r1
@   0x08030a9c: d300        bcc.n	0x30aa0
@   0x08030a9e: 2200        movs	r2, #0
@   0x08030aa0: 18d0        adds	r0, r2, r3
@   0x08030aa2: 4288        cmp	r0, r1
@   0x08030aa4: d303        bcc.n	0x30aae
@   0x08030aa6: 2a00        cmp	r2, #0
@   0x08030aa8: d000        beq.n	0x30aac
@   0x08030aaa: 3a01        subs	r2, #1
@   0x08030aac: 1a8b        subs	r3, r1, r2
@   0x08030aae: 68f0        ldr	r0, [r6, #12]
@   0x08030ab0: 4680        mov	r8, r0
@   0x08030ab2: 7861        ldrb	r1, [r4, #1]
@   0x08030ab4: 2080        movs	r0, #128	@ 0x80
@   0x08030ab6: 4008        ands	r0, r1
@   0x08030ab8: 2800        cmp	r0, #0
@   0x08030aba: d005        beq.n	0x30ac8
@   0x08030abc: 6830        ldr	r0, [r6, #0]
@   0x08030abe: 6807        ldr	r7, [r0, #0]
@   0x08030ac0: e003        b.n	0x30aca
@   0x08030ac2: 0000        movs	r0, r0
@   0x08030ac4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030ac6: 0300        lsls	r0, r0, #12
@   0x08030ac8: 6937        ldr	r7, [r6, #16]
@   0x08030aca: 207f        movs	r0, #127	@ 0x7f
@   0x08030acc: 4008        ands	r0, r1
@   0x08030ace: 2800        cmp	r0, #0
@   0x08030ad0: d10d        bne.n	0x30aee
@   0x08030ad2: 4661        mov	r1, ip
@   0x08030ad4: 188d        adds	r5, r1, r2
@   0x08030ad6: 2b00        cmp	r3, #0
@   0x08030ad8: d103        bne.n	0x30ae2
@   0x08030ada: 6830        ldr	r0, [r6, #0]
@   0x08030adc: 6800        ldr	r0, [r0, #0]
@   0x08030ade: 180c        adds	r4, r1, r0
@   0x08030ae0: e000        b.n	0x30ae4
@   0x08030ae2: 18ec        adds	r4, r5, r3
@   0x08030ae4: 2f00        cmp	r7, #0
@   0x08030ae6: d010        beq.n	0x30b0a
@   0x08030ae8: 46a8        mov	r8, r5
@   0x08030aea: 1b67        subs	r7, r4, r5
@   0x08030aec: e00d        b.n	0x30b0a
@   0x08030aee: 6830        ldr	r0, [r6, #0]
@   0x08030af0: 6800        ldr	r0, [r0, #0]
@   0x08030af2: 4460        add	r0, ip
@   0x08030af4: 1c51        adds	r1, r2, #1
@   0x08030af6: 1a45        subs	r5, r0, r1
@   0x08030af8: 1aec        subs	r4, r5, r3
@   0x08030afa: 2b00        cmp	r3, #0
@   0x08030afc: d101        bne.n	0x30b02
@   0x08030afe: 4664        mov	r4, ip
@   0x08030b00: 3c01        subs	r4, #1
@   0x08030b02: 2f00        cmp	r7, #0
@   0x08030b04: d001        beq.n	0x30b0a
@   0x08030b06: 46a8        mov	r8, r5
@   0x08030b08: 1b2f        subs	r7, r5, r4
@   0x08030b0a: f7fd        fc85 	bl	0x2e418
@   0x08030b0e: 6075        str	r5, [r6, #4]
@   0x08030b10: 60b4        str	r4, [r6, #8]
@   0x08030b12: 4640        mov	r0, r8
@   0x08030b14: 60f0        str	r0, [r6, #12]
@   0x08030b16: 6137        str	r7, [r6, #16]
@   0x08030b18: f7fd        fc6e 	bl	0x2e3f8
@   0x08030b1c: 4649        mov	r1, r9
@   0x08030b1e: 6808        ldr	r0, [r1, #0]
@   0x08030b20: 300a        adds	r0, #10
@   0x08030b22: 6008        str	r0, [r1, #0]
@   0x08030b24: 2001        movs	r0, #1
@   0x08030b26: bc18        pop	{r3, r4}
@   0x08030b28: 4698        mov	r8, r3
@   0x08030b2a: 46a1        mov	r9, r4
@   0x08030b2c: bcf0        pop	{r4, r5, r6, r7}
@   0x08030b2e: bc02        pop	{r1}
@   0x08030b30: 4708        bx	r1

        thumb_func_start sub_08030A44
sub_08030A44: @ 0x08030a44
        .incbin "frog_us_baserom.gba", 0x30a44, 0xf0
        thumb_func_end sub_08030A44
