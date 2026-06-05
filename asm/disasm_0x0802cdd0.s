@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802cdd0, 0x0802ce60)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802cdd0 --end 0x802ce60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802cdd0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802cdd2: b082        sub	sp, #8
@   0x0802cdd4: 1c05        adds	r5, r0, #0
@   0x0802cdd6: 1c16        adds	r6, r2, #0
@   0x0802cdd8: 0609        lsls	r1, r1, #24
@   0x0802cdda: 0e0f        lsrs	r7, r1, #24
@   0x0802cddc: 206b        movs	r0, #107	@ 0x6b
@   0x0802cdde: f7f3        ff4b 	bl	0x20c78
@   0x0802cde2: ac01        add	r4, sp, #4
@   0x0802cde4: 1c30        adds	r0, r6, #0
@   0x0802cde6: 1c21        adds	r1, r4, #0
@   0x0802cde8: f7ff        fe88 	bl	0x2cafc
@   0x0802cdec: 0600        lsls	r0, r0, #24
@   0x0802cdee: 2800        cmp	r0, #0
@   0x0802cdf0: d02c        beq.n	0x2ce4c
@   0x0802cdf2: 4a18        ldr	r2, [pc, #96]	@ (0x2ce54)
@   0x0802cdf4: 2000        movs	r0, #0
@   0x0802cdf6: 5e21        ldrsh	r1, [r4, r0]
@   0x0802cdf8: 0048        lsls	r0, r1, #1
@   0x0802cdfa: 1840        adds	r0, r0, r1
@   0x0802cdfc: 00c0        lsls	r0, r0, #3
@   0x0802cdfe: 300b        adds	r0, #11
@   0x0802ce00: 4b15        ldr	r3, [pc, #84]	@ (0x2ce58)
@   0x0802ce02: 18d1        adds	r1, r2, r3
@   0x0802ce04: 8008        strh	r0, [r1, #0]
@   0x0802ce06: 2002        movs	r0, #2
@   0x0802ce08: 5e21        ldrsh	r1, [r4, r0]
@   0x0802ce0a: 0048        lsls	r0, r1, #1
@   0x0802ce0c: 1840        adds	r0, r0, r1
@   0x0802ce0e: 00c0        lsls	r0, r0, #3
@   0x0802ce10: 3803        subs	r0, #3
@   0x0802ce12: 4912        ldr	r1, [pc, #72]	@ (0x2ce5c)
@   0x0802ce14: 1852        adds	r2, r2, r1
@   0x0802ce16: 8010        strh	r0, [r2, #0]
@   0x0802ce18: 1c30        adds	r0, r6, #0
@   0x0802ce1a: 1c21        adds	r1, r4, #0
@   0x0802ce1c: f7f5        f850 	bl	0x21ec0
@   0x0802ce20: 76a8        strb	r0, [r5, #26]
@   0x0802ce22: 7ea8        ldrb	r0, [r5, #26]
@   0x0802ce24: 466c        mov	r4, sp
@   0x0802ce26: 3401        adds	r4, #1
@   0x0802ce28: 4669        mov	r1, sp
@   0x0802ce2a: 1c22        adds	r2, r4, #0
@   0x0802ce2c: f7f5        f876 	bl	0x21f1c
@   0x0802ce30: 0639        lsls	r1, r7, #24
@   0x0802ce32: 1609        asrs	r1, r1, #24
@   0x0802ce34: 4668        mov	r0, sp
@   0x0802ce36: 2200        movs	r2, #0
@   0x0802ce38: 5682        ldrsb	r2, [r0, r2]
@   0x0802ce3a: 2300        movs	r3, #0
@   0x0802ce3c: 56e3        ldrsb	r3, [r4, r3]
@   0x0802ce3e: 1c28        adds	r0, r5, #0
@   0x0802ce40: f7dd        fb9e 	bl	0xa580
@   0x0802ce44: 2002        movs	r0, #2
@   0x0802ce46: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x0802ce48: 4318        orrs	r0, r3
@   0x0802ce4a: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802ce4c: b002        add	sp, #8
@   0x0802ce4e: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ce50: bc01        pop	{r0}
@   0x0802ce52: 4700        bx	r0
@   0x0802ce54: 3720        adds	r7, #32
@   0x0802ce56: 0300        lsls	r0, r0, #12
@   0x0802ce58: 0af2        lsrs	r2, r6, #11
@   0x0802ce5a: 0000        movs	r0, r0
@   0x0802ce5c: 0af4        lsrs	r4, r6, #11

        thumb_func_start sub_0802CDD0
sub_0802CDD0: @ 0x0802cdd0
        .incbin "frog_us_baserom.gba", 0x2cdd0, 0x90
        thumb_func_end sub_0802CDD0
