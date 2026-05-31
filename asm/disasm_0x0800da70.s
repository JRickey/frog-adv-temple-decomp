@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800da70, 0x0800dab8)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800da70 --end 0x800dab8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800da70: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800da72: b081        sub	sp, #4
@   0x0800da74: 1c07        adds	r7, r0, #0
@   0x0800da76: 1c3e        adds	r6, r7, #0
@   0x0800da78: 2100        movs	r1, #0
@   0x0800da7a: 2201        movs	r2, #1
@   0x0800da7c: 1c30        adds	r0, r6, #0
@   0x0800da7e: 4010        ands	r0, r2
@   0x0800da80: 060d        lsls	r5, r1, #24
@   0x0800da82: 2800        cmp	r0, #0
@   0x0800da84: d00a        beq.n	0xda9c
@   0x0800da86: 162c        asrs	r4, r5, #24
@   0x0800da88: 1c20        adds	r0, r4, #0
@   0x0800da8a: 9200        str	r2, [sp, #0]
@   0x0800da8c: f000        f814 	bl	0xdab8
@   0x0800da90: 9a00        ldr	r2, [sp, #0]
@   0x0800da92: 2800        cmp	r0, #0
@   0x0800da94: d102        bne.n	0xda9c
@   0x0800da96: 1c10        adds	r0, r2, #0
@   0x0800da98: 40a0        lsls	r0, r4
@   0x0800da9a: 4387        bics	r7, r0
@   0x0800da9c: 0876        lsrs	r6, r6, #1
@   0x0800da9e: 2180        movs	r1, #128	@ 0x80
@   0x0800daa0: 0449        lsls	r1, r1, #17
@   0x0800daa2: 1868        adds	r0, r5, r1
@   0x0800daa4: 0e01        lsrs	r1, r0, #24
@   0x0800daa6: 1600        asrs	r0, r0, #24
@   0x0800daa8: 2818        cmp	r0, #24
@   0x0800daaa: dde7        ble.n	0xda7c
@   0x0800daac: 1c38        adds	r0, r7, #0
@   0x0800daae: b001        add	sp, #4
@   0x0800dab0: bcf0        pop	{r4, r5, r6, r7}
@   0x0800dab2: bc02        pop	{r1}
@   0x0800dab4: 4708        bx	r1

        thumb_func_start sub_0800DA70
sub_0800DA70: @ 0x0800da70
        .incbin "frog_us_baserom.gba", 0xda70, 0x48
        thumb_func_end sub_0800DA70
