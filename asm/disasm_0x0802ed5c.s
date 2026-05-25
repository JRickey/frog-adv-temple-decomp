@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ed5c, 0x0802edf0)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ed5c --end 0x802edf0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ed5c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ed5e: 4a13        ldr	r2, [pc, #76]	@ (0x2edac)
@   0x0802ed60: 6811        ldr	r1, [r2, #0]
@   0x0802ed62: 1c08        adds	r0, r1, #0
@   0x0802ed64: 30cc        adds	r0, #204	@ 0xcc
@   0x0802ed66: 6805        ldr	r5, [r0, #0]
@   0x0802ed68: 2600        movs	r6, #0
@   0x0802ed6a: 7809        ldrb	r1, [r1, #0]
@   0x0802ed6c: 428e        cmp	r6, r1
@   0x0802ed6e: da3b        bge.n	0x2ede8
@   0x0802ed70: 4694        mov	ip, r2
@   0x0802ed72: 2700        movs	r7, #0
@   0x0802ed74: 682a        ldr	r2, [r5, #0]
@   0x0802ed76: 2a00        cmp	r2, #0
@   0x0802ed78: d02e        beq.n	0x2edd8
@   0x0802ed7a: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802ed7c: 2180        movs	r1, #128	@ 0x80
@   0x0802ed7e: 00c9        lsls	r1, r1, #3
@   0x0802ed80: 4008        ands	r0, r1
@   0x0802ed82: 2800        cmp	r0, #0
@   0x0802ed84: d028        beq.n	0x2edd8
@   0x0802ed86: 1c13        adds	r3, r2, #0
@   0x0802ed88: 332c        adds	r3, #44	@ 0x2c
@   0x0802ed8a: 212c        movs	r1, #44	@ 0x2c
@   0x0802ed8c: 5e50        ldrsh	r0, [r2, r1]
@   0x0802ed8e: 2202        movs	r2, #2
@   0x0802ed90: 5e99        ldrsh	r1, [r3, r2]
@   0x0802ed92: 1841        adds	r1, r0, r1
@   0x0802ed94: 885c        ldrh	r4, [r3, #2]
@   0x0802ed96: 2202        movs	r2, #2
@   0x0802ed98: 5e98        ldrsh	r0, [r3, r2]
@   0x0802ed9a: 2800        cmp	r0, #0
@   0x0802ed9c: db08        blt.n	0x2edb0
@   0x0802ed9e: 2005        movs	r0, #5
@   0x0802eda0: 5618        ldrsb	r0, [r3, r0]
@   0x0802eda2: 0202        lsls	r2, r0, #8
@   0x0802eda4: 4291        cmp	r1, r2
@   0x0802eda6: db0c        blt.n	0x2edc2
@   0x0802eda8: e007        b.n	0x2edba
@   0x0802edaa: 0000        movs	r0, r0
@   0x0802edac: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802edae: 0300        lsls	r0, r0, #12
@   0x0802edb0: 2004        movs	r0, #4
@   0x0802edb2: 5618        ldrsb	r0, [r3, r0]
@   0x0802edb4: 0202        lsls	r2, r0, #8
@   0x0802edb6: 4291        cmp	r1, r2
@   0x0802edb8: dc03        bgt.n	0x2edc2
@   0x0802edba: 0240        lsls	r0, r0, #9
@   0x0802edbc: 1a41        subs	r1, r0, r1
@   0x0802edbe: 4260        negs	r0, r4
@   0x0802edc0: 8058        strh	r0, [r3, #2]
@   0x0802edc2: 8019        strh	r1, [r3, #0]
@   0x0802edc4: 4662        mov	r2, ip
@   0x0802edc6: 6810        ldr	r0, [r2, #0]
@   0x0802edc8: 30c0        adds	r0, #192	@ 0xc0
@   0x0802edca: 6802        ldr	r2, [r0, #0]
@   0x0802edcc: 19d2        adds	r2, r2, r7
@   0x0802edce: 0a09        lsrs	r1, r1, #8
@   0x0802edd0: 3110        adds	r1, #16
@   0x0802edd2: 6810        ldr	r0, [r2, #0]
@   0x0802edd4: 1840        adds	r0, r0, r1
@   0x0802edd6: 60d0        str	r0, [r2, #12]
@   0x0802edd8: 371c        adds	r7, #28
@   0x0802edda: 3601        adds	r6, #1
@   0x0802eddc: 3504        adds	r5, #4
@   0x0802edde: 4661        mov	r1, ip
@   0x0802ede0: 6808        ldr	r0, [r1, #0]
@   0x0802ede2: 7800        ldrb	r0, [r0, #0]
@   0x0802ede4: 4286        cmp	r6, r0
@   0x0802ede6: dbc5        blt.n	0x2ed74
@   0x0802ede8: bcf0        pop	{r4, r5, r6, r7}
@   0x0802edea: bc01        pop	{r0}
@   0x0802edec: 4700        bx	r0

        thumb_func_start sub_0802ED5C
sub_0802ED5C: @ 0x0802ed5c
        .incbin "frog_us_baserom.gba", 0x2ed5c, 0x94
        thumb_func_end sub_0802ED5C
