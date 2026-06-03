@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012cac, 0x08012d40)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012cac --end 0x8012d40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012cac: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08012cae: 4b0c        ldr	r3, [pc, #48]	@ (0x12ce0)
@   0x08012cb0: 4d0c        ldr	r5, [pc, #48]	@ (0x12ce4)
@   0x08012cb2: 6929        ldr	r1, [r5, #16]
@   0x08012cb4: 4a0c        ldr	r2, [pc, #48]	@ (0x12ce8)
@   0x08012cb6: 6850        ldr	r0, [r2, #4]
@   0x08012cb8: 1a08        subs	r0, r1, r0
@   0x08012cba: 895c        ldrh	r4, [r3, #10]
@   0x08012cbc: 1826        adds	r6, r4, r0
@   0x08012cbe: 815e        strh	r6, [r3, #10]
@   0x08012cc0: 6051        str	r1, [r2, #4]
@   0x08012cc2: 4c0a        ldr	r4, [pc, #40]	@ (0x12cec)
@   0x08012cc4: 6821        ldr	r1, [r4, #0]
@   0x08012cc6: 6890        ldr	r0, [r2, #8]
@   0x08012cc8: 1a09        subs	r1, r1, r0
@   0x08012cca: 1c1f        adds	r7, r3, #0
@   0x08012ccc: 7b10        ldrb	r0, [r2, #12]
@   0x08012cce: 4281        cmp	r1, r0
@   0x08012cd0: d314        bcc.n	0x12cfc
@   0x08012cd2: 7810        ldrb	r0, [r2, #0]
@   0x08012cd4: 2801        cmp	r0, #1
@   0x08012cd6: d00b        beq.n	0x12cf0
@   0x08012cd8: 2802        cmp	r0, #2
@   0x08012cda: d00b        beq.n	0x12cf4
@   0x08012cdc: e00c        b.n	0x12cf8
@   0x08012cde: 0000        movs	r0, r0
@   0x08012ce0: 3550        adds	r5, #80	@ 0x50
@   0x08012ce2: 0300        lsls	r0, r0, #12
@   0x08012ce4: 60a0        str	r0, [r4, #8]
@   0x08012ce6: 0300        lsls	r0, r0, #12
@   0x08012ce8: 6400        str	r0, [r0, #64]	@ 0x40
@   0x08012cea: 0300        lsls	r0, r0, #12
@   0x08012cec: 5330        strh	r0, [r6, r4]
@   0x08012cee: 0300        lsls	r0, r0, #12
@   0x08012cf0: 1c70        adds	r0, r6, #1
@   0x08012cf2: e000        b.n	0x12cf6
@   0x08012cf4: 1e70        subs	r0, r6, #1
@   0x08012cf6: 8178        strh	r0, [r7, #10]
@   0x08012cf8: 6820        ldr	r0, [r4, #0]
@   0x08012cfa: 6090        str	r0, [r2, #8]
@   0x08012cfc: 1c3e        adds	r6, r7, #0
@   0x08012cfe: 68e9        ldr	r1, [r5, #12]
@   0x08012d00: 4a09        ldr	r2, [pc, #36]	@ (0x12d28)
@   0x08012d02: 6850        ldr	r0, [r2, #4]
@   0x08012d04: 1a08        subs	r0, r1, r0
@   0x08012d06: 8935        ldrh	r5, [r6, #8]
@   0x08012d08: 182b        adds	r3, r5, r0
@   0x08012d0a: 8133        strh	r3, [r6, #8]
@   0x08012d0c: 6051        str	r1, [r2, #4]
@   0x08012d0e: 6820        ldr	r0, [r4, #0]
@   0x08012d10: 6891        ldr	r1, [r2, #8]
@   0x08012d12: 1a40        subs	r0, r0, r1
@   0x08012d14: 7b11        ldrb	r1, [r2, #12]
@   0x08012d16: 4288        cmp	r0, r1
@   0x08012d18: d30f        bcc.n	0x12d3a
@   0x08012d1a: 7810        ldrb	r0, [r2, #0]
@   0x08012d1c: 2803        cmp	r0, #3
@   0x08012d1e: d005        beq.n	0x12d2c
@   0x08012d20: 2804        cmp	r0, #4
@   0x08012d22: d006        beq.n	0x12d32
@   0x08012d24: e007        b.n	0x12d36
@   0x08012d26: 0000        movs	r0, r0
@   0x08012d28: 6410        str	r0, [r2, #64]	@ 0x40
@   0x08012d2a: 0300        lsls	r0, r0, #12
@   0x08012d2c: 1c58        adds	r0, r3, #1
@   0x08012d2e: 8130        strh	r0, [r6, #8]
@   0x08012d30: e001        b.n	0x12d36
@   0x08012d32: 1e58        subs	r0, r3, #1
@   0x08012d34: 8138        strh	r0, [r7, #8]
@   0x08012d36: 6820        ldr	r0, [r4, #0]
@   0x08012d38: 6090        str	r0, [r2, #8]
@   0x08012d3a: bcf0        pop	{r4, r5, r6, r7}
@   0x08012d3c: bc01        pop	{r0}
@   0x08012d3e: 4700        bx	r0
