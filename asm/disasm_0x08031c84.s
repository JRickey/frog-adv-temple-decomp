@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031c84, 0x08031d2c)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031c84 --end 0x8031d2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031c84: b570        push	{r4, r5, r6, lr}
@   0x08031c86: 1c02        adds	r2, r0, #0
@   0x08031c88: 1c0d        adds	r5, r1, #0
@   0x08031c8a: 682e        ldr	r6, [r5, #0]
@   0x08031c8c: 2a03        cmp	r2, #3
@   0x08031c8e: dd29        ble.n	0x31ce4
@   0x08031c90: 4818        ldr	r0, [pc, #96]	@ (0x31cf4)
@   0x08031c92: 6803        ldr	r3, [r0, #0]
@   0x08031c94: 1c18        adds	r0, r3, #0
@   0x08031c96: 30c8        adds	r0, #200	@ 0xc8
@   0x08031c98: 6801        ldr	r1, [r0, #0]
@   0x08031c9a: 0190        lsls	r0, r2, #6
@   0x08031c9c: 1840        adds	r0, r0, r1
@   0x08031c9e: 4916        ldr	r1, [pc, #88]	@ (0x31cf8)
@   0x08031ca0: 1840        adds	r0, r0, r1
@   0x08031ca2: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x08031ca4: 2180        movs	r1, #128	@ 0x80
@   0x08031ca6: 0149        lsls	r1, r1, #5
@   0x08031ca8: 4008        ands	r0, r1
@   0x08031caa: 2800        cmp	r0, #0
@   0x08031cac: d01a        beq.n	0x31ce4
@   0x08031cae: 1c18        adds	r0, r3, #0
@   0x08031cb0: 30c0        adds	r0, #192	@ 0xc0
@   0x08031cb2: 00d1        lsls	r1, r2, #3
@   0x08031cb4: 1a89        subs	r1, r1, r2
@   0x08031cb6: 0089        lsls	r1, r1, #2
@   0x08031cb8: 3970        subs	r1, #112	@ 0x70
@   0x08031cba: 6800        ldr	r0, [r0, #0]
@   0x08031cbc: 1842        adds	r2, r0, r1
@   0x08031cbe: 68d3        ldr	r3, [r2, #12]
@   0x08031cc0: 2b00        cmp	r3, #0
@   0x08031cc2: d00f        beq.n	0x31ce4
@   0x08031cc4: 6811        ldr	r1, [r2, #0]
@   0x08031cc6: 6808        ldr	r0, [r1, #0]
@   0x08031cc8: 3010        adds	r0, #16
@   0x08031cca: 180c        adds	r4, r1, r0
@   0x08031ccc: 2002        movs	r0, #2
@   0x08031cce: 5e31        ldrsh	r1, [r6, r0]
@   0x08031cd0: 6910        ldr	r0, [r2, #16]
@   0x08031cd2: 1841        adds	r1, r0, r1
@   0x08031cd4: 2900        cmp	r1, #0
@   0x08031cd6: da00        bge.n	0x31cda
@   0x08031cd8: 2100        movs	r1, #0
@   0x08031cda: 1858        adds	r0, r3, r1
@   0x08031cdc: 42a0        cmp	r0, r4
@   0x08031cde: d900        bls.n	0x31ce2
@   0x08031ce0: 1ae1        subs	r1, r4, r3
@   0x08031ce2: 6111        str	r1, [r2, #16]
@   0x08031ce4: 6828        ldr	r0, [r5, #0]
@   0x08031ce6: 3004        adds	r0, #4
@   0x08031ce8: 6028        str	r0, [r5, #0]
@   0x08031cea: 2001        movs	r0, #1
@   0x08031cec: bc70        pop	{r4, r5, r6}
@   0x08031cee: bc02        pop	{r1}
@   0x08031cf0: 4708        bx	r1
@   0x08031cf2: 0000        movs	r0, r0
@   0x08031cf4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031cf6: 0300        lsls	r0, r0, #12
@   0x08031cf8: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08031cfc: b510        push	{r4, lr}
@   0x08031cfe: 1c03        adds	r3, r0, #0
@   0x08031d00: 1c0a        adds	r2, r1, #0
@   0x08031d02: 6814        ldr	r4, [r2, #0]
@   0x08031d04: 2b03        cmp	r3, #3
@   0x08031d06: dd08        ble.n	0x31d1a
@   0x08031d08: 4807        ldr	r0, [pc, #28]	@ (0x31d28)
@   0x08031d0a: 6800        ldr	r0, [r0, #0]
@   0x08031d0c: 30c8        adds	r0, #200	@ 0xc8
@   0x08031d0e: 6801        ldr	r1, [r0, #0]
@   0x08031d10: 0198        lsls	r0, r3, #6
@   0x08031d12: 1840        adds	r0, r0, r1
@   0x08031d14: 7861        ldrb	r1, [r4, #1]
@   0x08031d16: 38c1        subs	r0, #193	@ 0xc1
@   0x08031d18: 7001        strb	r1, [r0, #0]
@   0x08031d1a: 6810        ldr	r0, [r2, #0]
@   0x08031d1c: 3002        adds	r0, #2
@   0x08031d1e: 6010        str	r0, [r2, #0]
@   0x08031d20: 2001        movs	r0, #1
@   0x08031d22: bc10        pop	{r4}
@   0x08031d24: bc02        pop	{r1}
@   0x08031d26: 4708        bx	r1
@   0x08031d28: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031d2a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031C84
sub_08031C84: @ 0x08031c84
        .incbin "frog_us_baserom.gba", 0x31c84, 0xa8
        thumb_func_end sub_08031C84
