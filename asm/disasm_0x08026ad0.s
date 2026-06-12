@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026ad0, 0x08026b14)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026ad0 --end 0x8026b14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026ad0: b510        push	{r4, lr}
@   0x08026ad2: b084        sub	sp, #16
@   0x08026ad4: 2400        movs	r4, #0
@   0x08026ad6: 1c20        adds	r0, r4, #0
@   0x08026ad8: 302e        adds	r0, #46	@ 0x2e
@   0x08026ada: 4a0d        ldr	r2, [pc, #52]	@ (0x26b10)
@   0x08026adc: 00a1        lsls	r1, r4, #2
@   0x08026ade: 1889        adds	r1, r1, r2
@   0x08026ae0: 6809        ldr	r1, [r1, #0]
@   0x08026ae2: 2201        movs	r2, #1
@   0x08026ae4: 4022        ands	r2, r4
@   0x08026ae6: 00d2        lsls	r2, r2, #3
@   0x08026ae8: 3281        adds	r2, #129	@ 0x81
@   0x08026aea: 9200        str	r2, [sp, #0]
@   0x08026aec: 2206        movs	r2, #6
@   0x08026aee: 9201        str	r2, [sp, #4]
@   0x08026af0: 2203        movs	r2, #3
@   0x08026af2: 9202        str	r2, [sp, #8]
@   0x08026af4: 9203        str	r2, [sp, #12]
@   0x08026af6: 2210        movs	r2, #16
@   0x08026af8: 2332        movs	r3, #50	@ 0x32
@   0x08026afa: f7fa        fad1 	bl	0x210a0
@   0x08026afe: 1c60        adds	r0, r4, #1
@   0x08026b00: 0600        lsls	r0, r0, #24
@   0x08026b02: 0e04        lsrs	r4, r0, #24
@   0x08026b04: 2c01        cmp	r4, #1
@   0x08026b06: d9e6        bls.n	0x26ad6
@   0x08026b08: b004        add	sp, #16
@   0x08026b0a: bc10        pop	{r4}
@   0x08026b0c: bc01        pop	{r0}
@   0x08026b0e: 4700        bx	r0
@   0x08026b10: 5ba8        ldrh	r0, [r5, r6]
@   0x08026b12: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026AD0
sub_08026AD0: @ 0x08026ad0
        .incbin "baserom.gba", 0x26ad0, 0x44
        thumb_func_end sub_08026AD0
