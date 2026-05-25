@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ea80, 0x0802eb34)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ea80 --end 0x802eb34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ea80: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ea82: 2400        movs	r4, #0
@   0x0802ea84: 4814        ldr	r0, [pc, #80]	@ (0x2ead8)
@   0x0802ea86: 4684        mov	ip, r0
@   0x0802ea88: 4666        mov	r6, ip
@   0x0802ea8a: 2520        movs	r5, #32
@   0x0802ea8c: 6830        ldr	r0, [r6, #0]
@   0x0802ea8e: 1942        adds	r2, r0, r5
@   0x0802ea90: 1c11        adds	r1, r2, #0
@   0x0802ea92: 3114        adds	r1, #20
@   0x0802ea94: 884b        ldrh	r3, [r1, #2]
@   0x0802ea96: 2702        movs	r7, #2
@   0x0802ea98: 5fc8        ldrsh	r0, [r1, r7]
@   0x0802ea9a: 2800        cmp	r0, #0
@   0x0802ea9c: d016        beq.n	0x2eacc
@   0x0802ea9e: 8a97        ldrh	r7, [r2, #20]
@   0x0802eaa0: 19d8        adds	r0, r3, r7
@   0x0802eaa2: 8290        strh	r0, [r2, #20]
@   0x0802eaa4: 7908        ldrb	r0, [r1, #4]
@   0x0802eaa6: 3801        subs	r0, #1
@   0x0802eaa8: 7108        strb	r0, [r1, #4]
@   0x0802eaaa: 0600        lsls	r0, r0, #24
@   0x0802eaac: 0e00        lsrs	r0, r0, #24
@   0x0802eaae: 28ff        cmp	r0, #255	@ 0xff
@   0x0802eab0: d104        bne.n	0x2eabc
@   0x0802eab2: 7948        ldrb	r0, [r1, #5]
@   0x0802eab4: 7108        strb	r0, [r1, #4]
@   0x0802eab6: 884a        ldrh	r2, [r1, #2]
@   0x0802eab8: 4250        negs	r0, r2
@   0x0802eaba: 8048        strh	r0, [r1, #2]
@   0x0802eabc: 6832        ldr	r2, [r6, #0]
@   0x0802eabe: 00a0        lsls	r0, r4, #2
@   0x0802eac0: 3210        adds	r2, #16
@   0x0802eac2: 1812        adds	r2, r2, r0
@   0x0802eac4: 6810        ldr	r0, [r2, #0]
@   0x0802eac6: 2140        movs	r1, #64	@ 0x40
@   0x0802eac8: 4308        orrs	r0, r1
@   0x0802eaca: 6010        str	r0, [r2, #0]
@   0x0802eacc: 3524        adds	r5, #36	@ 0x24
@   0x0802eace: 3401        adds	r4, #1
@   0x0802ead0: 2c02        cmp	r4, #2
@   0x0802ead2: dddb        ble.n	0x2ea8c
@   0x0802ead4: 2400        movs	r4, #0
@   0x0802ead6: e024        b.n	0x2eb22
@   0x0802ead8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802eada: 0300        lsls	r0, r0, #12
@   0x0802eadc: 6808        ldr	r0, [r1, #0]
@   0x0802eade: 30cc        adds	r0, #204	@ 0xcc
@   0x0802eae0: 6801        ldr	r1, [r0, #0]
@   0x0802eae2: 00a0        lsls	r0, r4, #2
@   0x0802eae4: 1840        adds	r0, r0, r1
@   0x0802eae6: 6802        ldr	r2, [r0, #0]
@   0x0802eae8: 2a00        cmp	r2, #0
@   0x0802eaea: d019        beq.n	0x2eb20
@   0x0802eaec: 1c11        adds	r1, r2, #0
@   0x0802eaee: 3114        adds	r1, #20
@   0x0802eaf0: 884b        ldrh	r3, [r1, #2]
@   0x0802eaf2: 2502        movs	r5, #2
@   0x0802eaf4: 5f48        ldrsh	r0, [r1, r5]
@   0x0802eaf6: 2800        cmp	r0, #0
@   0x0802eaf8: d012        beq.n	0x2eb20
@   0x0802eafa: 8a97        ldrh	r7, [r2, #20]
@   0x0802eafc: 19d8        adds	r0, r3, r7
@   0x0802eafe: 8290        strh	r0, [r2, #20]
@   0x0802eb00: 7908        ldrb	r0, [r1, #4]
@   0x0802eb02: 3801        subs	r0, #1
@   0x0802eb04: 7108        strb	r0, [r1, #4]
@   0x0802eb06: 0600        lsls	r0, r0, #24
@   0x0802eb08: 0e00        lsrs	r0, r0, #24
@   0x0802eb0a: 28ff        cmp	r0, #255	@ 0xff
@   0x0802eb0c: d104        bne.n	0x2eb18
@   0x0802eb0e: 7948        ldrb	r0, [r1, #5]
@   0x0802eb10: 7108        strb	r0, [r1, #4]
@   0x0802eb12: 884b        ldrh	r3, [r1, #2]
@   0x0802eb14: 4258        negs	r0, r3
@   0x0802eb16: 8048        strh	r0, [r1, #2]
@   0x0802eb18: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802eb1a: 2140        movs	r1, #64	@ 0x40
@   0x0802eb1c: 4308        orrs	r0, r1
@   0x0802eb1e: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802eb20: 3401        adds	r4, #1
@   0x0802eb22: 4661        mov	r1, ip
@   0x0802eb24: 6808        ldr	r0, [r1, #0]
@   0x0802eb26: 7800        ldrb	r0, [r0, #0]
@   0x0802eb28: 4284        cmp	r4, r0
@   0x0802eb2a: dbd7        blt.n	0x2eadc
@   0x0802eb2c: bcf0        pop	{r4, r5, r6, r7}
@   0x0802eb2e: bc01        pop	{r0}
@   0x0802eb30: 4700        bx	r0

        thumb_func_start sub_0802EA80
sub_0802EA80: @ 0x0802ea80
        .incbin "frog_us_baserom.gba", 0x2ea80, 0xb4
        thumb_func_end sub_0802EA80
