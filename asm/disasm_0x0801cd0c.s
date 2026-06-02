@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801cd0c, 0x0801cec0)  (436 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801cd0c --end 0x801cec0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801cd0c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801cd0e: 4657        mov	r7, sl
@   0x0801cd10: 464e        mov	r6, r9
@   0x0801cd12: 4645        mov	r5, r8
@   0x0801cd14: b4e0        push	{r5, r6, r7}
@   0x0801cd16: b08b        sub	sp, #44	@ 0x2c
@   0x0801cd18: 9203        str	r2, [sp, #12]
@   0x0801cd1a: 9a13        ldr	r2, [sp, #76]	@ 0x4c
@   0x0801cd1c: 9d14        ldr	r5, [sp, #80]	@ 0x50
@   0x0801cd1e: 9c15        ldr	r4, [sp, #84]	@ 0x54
@   0x0801cd20: 0600        lsls	r0, r0, #24
@   0x0801cd22: 0e00        lsrs	r0, r0, #24
@   0x0801cd24: 4681        mov	r9, r0
@   0x0801cd26: 0609        lsls	r1, r1, #24
@   0x0801cd28: 0e09        lsrs	r1, r1, #24
@   0x0801cd2a: 4688        mov	r8, r1
@   0x0801cd2c: 0612        lsls	r2, r2, #24
@   0x0801cd2e: 0e12        lsrs	r2, r2, #24
@   0x0801cd30: 9204        str	r2, [sp, #16]
@   0x0801cd32: 0424        lsls	r4, r4, #16
@   0x0801cd34: 0c24        lsrs	r4, r4, #16
@   0x0801cd36: 9405        str	r4, [sp, #20]
@   0x0801cd38: 20a0        movs	r0, #160	@ 0xa0
@   0x0801cd3a: 04c0        lsls	r0, r0, #19
@   0x0801cd3c: 8005        strh	r5, [r0, #0]
@   0x0801cd3e: 065b        lsls	r3, r3, #25
@   0x0801cd40: 0e1f        lsrs	r7, r3, #24
@   0x0801cd42: 0189        lsls	r1, r1, #6
@   0x0801cd44: 464a        mov	r2, r9
@   0x0801cd46: 0050        lsls	r0, r2, #1
@   0x0801cd48: 180b        adds	r3, r1, r0
@   0x0801cd4a: 4e2e        ldr	r6, [pc, #184]	@ (0x1ce04)
@   0x0801cd4c: 199a        adds	r2, r3, r6
@   0x0801cd4e: 492e        ldr	r1, [pc, #184]	@ (0x1ce08)
@   0x0801cd50: 8808        ldrh	r0, [r1, #0]
@   0x0801cd52: 8010        strh	r0, [r2, #0]
@   0x0801cd54: 2500        movs	r5, #0
@   0x0801cd56: 42bd        cmp	r5, r7
@   0x0801cd58: d20c        bcs.n	0x1cd74
@   0x0801cd5a: 1c19        adds	r1, r3, #0
@   0x0801cd5c: 4a2b        ldr	r2, [pc, #172]	@ (0x1ce0c)
@   0x0801cd5e: 482a        ldr	r0, [pc, #168]	@ (0x1ce08)
@   0x0801cd60: 8843        ldrh	r3, [r0, #2]
@   0x0801cd62: 01a8        lsls	r0, r5, #6
@   0x0801cd64: 1840        adds	r0, r0, r1
@   0x0801cd66: 1880        adds	r0, r0, r2
@   0x0801cd68: 8003        strh	r3, [r0, #0]
@   0x0801cd6a: 1c68        adds	r0, r5, #1
@   0x0801cd6c: 0600        lsls	r0, r0, #24
@   0x0801cd6e: 0e05        lsrs	r5, r0, #24
@   0x0801cd70: 42bd        cmp	r5, r7
@   0x0801cd72: d3f6        bcc.n	0x1cd62
@   0x0801cd74: 01bc        lsls	r4, r7, #6
@   0x0801cd76: 4641        mov	r1, r8
@   0x0801cd78: 018a        lsls	r2, r1, #6
@   0x0801cd7a: 464e        mov	r6, r9
@   0x0801cd7c: 0073        lsls	r3, r6, #1
@   0x0801cd7e: 18d5        adds	r5, r2, r3
@   0x0801cd80: 1960        adds	r0, r4, r5
@   0x0801cd82: 4684        mov	ip, r0
@   0x0801cd84: 4921        ldr	r1, [pc, #132]	@ (0x1ce0c)
@   0x0801cd86: 4461        add	r1, ip
@   0x0801cd88: 4e1f        ldr	r6, [pc, #124]	@ (0x1ce08)
@   0x0801cd8a: 88b0        ldrh	r0, [r6, #4]
@   0x0801cd8c: 8008        strh	r0, [r1, #0]
@   0x0801cd8e: 2601        movs	r6, #1
@   0x0801cd90: 9208        str	r2, [sp, #32]
@   0x0801cd92: 469a        mov	sl, r3
@   0x0801cd94: 9409        str	r4, [sp, #36]	@ 0x24
@   0x0801cd96: 9804        ldr	r0, [sp, #16]
@   0x0801cd98: 0040        lsls	r0, r0, #1
@   0x0801cd9a: 900a        str	r0, [sp, #40]	@ 0x28
@   0x0801cd9c: 4649        mov	r1, r9
@   0x0801cd9e: 3101        adds	r1, #1
@   0x0801cda0: 9106        str	r1, [sp, #24]
@   0x0801cda2: 4642        mov	r2, r8
@   0x0801cda4: 3201        adds	r2, #1
@   0x0801cda6: 9207        str	r2, [sp, #28]
@   0x0801cda8: 9b04        ldr	r3, [sp, #16]
@   0x0801cdaa: 429e        cmp	r6, r3
@   0x0801cdac: d839        bhi.n	0x1ce22
@   0x0801cdae: 46a9        mov	r9, r5
@   0x0801cdb0: 46e0        mov	r8, ip
@   0x0801cdb2: 0070        lsls	r0, r6, #1
@   0x0801cdb4: 464a        mov	r2, r9
@   0x0801cdb6: 1881        adds	r1, r0, r2
@   0x0801cdb8: 4b12        ldr	r3, [pc, #72]	@ (0x1ce04)
@   0x0801cdba: 18c9        adds	r1, r1, r3
@   0x0801cdbc: 4b12        ldr	r3, [pc, #72]	@ (0x1ce08)
@   0x0801cdbe: 88da        ldrh	r2, [r3, #6]
@   0x0801cdc0: 800a        strh	r2, [r1, #0]
@   0x0801cdc2: 2500        movs	r5, #0
@   0x0801cdc4: 1c04        adds	r4, r0, #0
@   0x0801cdc6: 3601        adds	r6, #1
@   0x0801cdc8: 46b4        mov	ip, r6
@   0x0801cdca: 42bd        cmp	r5, r7
@   0x0801cdcc: d20f        bcs.n	0x1cdee
@   0x0801cdce: 9b08        ldr	r3, [sp, #32]
@   0x0801cdd0: 4453        add	r3, sl
@   0x0801cdd2: 1c22        adds	r2, r4, #0
@   0x0801cdd4: 480c        ldr	r0, [pc, #48]	@ (0x1ce08)
@   0x0801cdd6: 8901        ldrh	r1, [r0, #8]
@   0x0801cdd8: 01a8        lsls	r0, r5, #6
@   0x0801cdda: 18c0        adds	r0, r0, r3
@   0x0801cddc: 1880        adds	r0, r0, r2
@   0x0801cdde: 4e0b        ldr	r6, [pc, #44]	@ (0x1ce0c)
@   0x0801cde0: 1980        adds	r0, r0, r6
@   0x0801cde2: 8001        strh	r1, [r0, #0]
@   0x0801cde4: 1c68        adds	r0, r5, #1
@   0x0801cde6: 0600        lsls	r0, r0, #24
@   0x0801cde8: 0e05        lsrs	r5, r0, #24
@   0x0801cdea: 42bd        cmp	r5, r7
@   0x0801cdec: d3f4        bcc.n	0x1cdd8
@   0x0801cdee: 4641        mov	r1, r8
@   0x0801cdf0: 1908        adds	r0, r1, r4
@   0x0801cdf2: 4a06        ldr	r2, [pc, #24]	@ (0x1ce0c)
@   0x0801cdf4: 1880        adds	r0, r0, r2
@   0x0801cdf6: 4b04        ldr	r3, [pc, #16]	@ (0x1ce08)
@   0x0801cdf8: 8959        ldrh	r1, [r3, #10]
@   0x0801cdfa: 8001        strh	r1, [r0, #0]
@   0x0801cdfc: 4666        mov	r6, ip
@   0x0801cdfe: 0630        lsls	r0, r6, #24
@   0x0801ce00: 0e06        lsrs	r6, r0, #24
@   0x0801ce02: e00b        b.n	0x1ce1c
@   0x0801ce04: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801ce08: df70        svc	112	@ 0x70
@   0x0801ce0a: 081b        lsrs	r3, r3, #32
@   0x0801ce0c: f840        0600 	str.w	r0, [r0, <undefined>]
@   0x0801ce10: f7e3        fd64 	bl	0x8dc
@   0x0801ce14: 3501        adds	r5, #1
@   0x0801ce16: 9805        ldr	r0, [sp, #20]
@   0x0801ce18: 4285        cmp	r5, r0
@   0x0801ce1a: d8f9        bhi.n	0x1ce10
@   0x0801ce1c: 9904        ldr	r1, [sp, #16]
@   0x0801ce1e: 428e        cmp	r6, r1
@   0x0801ce20: d9c7        bls.n	0x1cdb2
@   0x0801ce22: 9a08        ldr	r2, [sp, #32]
@   0x0801ce24: 4452        add	r2, sl
@   0x0801ce26: 9b0a        ldr	r3, [sp, #40]	@ 0x28
@   0x0801ce28: 1898        adds	r0, r3, r2
@   0x0801ce2a: 4e12        ldr	r6, [pc, #72]	@ (0x1ce74)
@   0x0801ce2c: 1980        adds	r0, r0, r6
@   0x0801ce2e: 4b12        ldr	r3, [pc, #72]	@ (0x1ce78)
@   0x0801ce30: 8999        ldrh	r1, [r3, #12]
@   0x0801ce32: 8001        strh	r1, [r0, #0]
@   0x0801ce34: 2500        movs	r5, #0
@   0x0801ce36: 42bd        cmp	r5, r7
@   0x0801ce38: d20e        bcs.n	0x1ce58
@   0x0801ce3a: 1c13        adds	r3, r2, #0
@   0x0801ce3c: 9a0a        ldr	r2, [sp, #40]	@ 0x28
@   0x0801ce3e: 4e0e        ldr	r6, [pc, #56]	@ (0x1ce78)
@   0x0801ce40: 89f1        ldrh	r1, [r6, #14]
@   0x0801ce42: 4e0e        ldr	r6, [pc, #56]	@ (0x1ce7c)
@   0x0801ce44: 01a8        lsls	r0, r5, #6
@   0x0801ce46: 18c0        adds	r0, r0, r3
@   0x0801ce48: 1880        adds	r0, r0, r2
@   0x0801ce4a: 1980        adds	r0, r0, r6
@   0x0801ce4c: 8001        strh	r1, [r0, #0]
@   0x0801ce4e: 1c68        adds	r0, r5, #1
@   0x0801ce50: 0600        lsls	r0, r0, #24
@   0x0801ce52: 0e05        lsrs	r5, r0, #24
@   0x0801ce54: 42bd        cmp	r5, r7
@   0x0801ce56: d3f5        bcc.n	0x1ce44
@   0x0801ce58: 9808        ldr	r0, [sp, #32]
@   0x0801ce5a: 4450        add	r0, sl
@   0x0801ce5c: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x0801ce5e: 1808        adds	r0, r1, r0
@   0x0801ce60: 9a0a        ldr	r2, [sp, #40]	@ 0x28
@   0x0801ce62: 1880        adds	r0, r0, r2
@   0x0801ce64: 4b05        ldr	r3, [pc, #20]	@ (0x1ce7c)
@   0x0801ce66: 18c0        adds	r0, r0, r3
@   0x0801ce68: 4e03        ldr	r6, [pc, #12]	@ (0x1ce78)
@   0x0801ce6a: 8a31        ldrh	r1, [r6, #16]
@   0x0801ce6c: 8001        strh	r1, [r0, #0]
@   0x0801ce6e: 2500        movs	r5, #0
@   0x0801ce70: 9803        ldr	r0, [sp, #12]
@   0x0801ce72: e00a        b.n	0x1ce8a
@   0x0801ce74: f802        0600 	strb.w	r0, [r2, <undefined>]
@   0x0801ce78: df70        svc	112	@ 0x70
@   0x0801ce7a: 081b        lsrs	r3, r3, #32
@   0x0801ce7c: f842        0600 	str.w	r0, [r2, <undefined>]
@   0x0801ce80: 1c68        adds	r0, r5, #1
@   0x0801ce82: 0600        lsls	r0, r0, #24
@   0x0801ce84: 0e05        lsrs	r5, r0, #24
@   0x0801ce86: 9903        ldr	r1, [sp, #12]
@   0x0801ce88: 1948        adds	r0, r1, r5
@   0x0801ce8a: 7800        ldrb	r0, [r0, #0]
@   0x0801ce8c: 287c        cmp	r0, #124	@ 0x7c
@   0x0801ce8e: d1f7        bne.n	0x1ce80
@   0x0801ce90: 9b06        ldr	r3, [sp, #24]
@   0x0801ce92: 061a        lsls	r2, r3, #24
@   0x0801ce94: 0e12        lsrs	r2, r2, #24
@   0x0801ce96: 9e07        ldr	r6, [sp, #28]
@   0x0801ce98: 0633        lsls	r3, r6, #24
@   0x0801ce9a: 0e1b        lsrs	r3, r3, #24
@   0x0801ce9c: 20a0        movs	r0, #160	@ 0xa0
@   0x0801ce9e: 9000        str	r0, [sp, #0]
@   0x0801cea0: 200e        movs	r0, #14
@   0x0801cea2: 9001        str	r0, [sp, #4]
@   0x0801cea4: 2003        movs	r0, #3
@   0x0801cea6: 9002        str	r0, [sp, #8]
@   0x0801cea8: 9803        ldr	r0, [sp, #12]
@   0x0801ceaa: 1c29        adds	r1, r5, #0
@   0x0801ceac: f7ff        f8e4 	bl	0x1c078
@   0x0801ceb0: b00b        add	sp, #44	@ 0x2c
@   0x0801ceb2: bc38        pop	{r3, r4, r5}
@   0x0801ceb4: 4698        mov	r8, r3
@   0x0801ceb6: 46a1        mov	r9, r4
@   0x0801ceb8: 46aa        mov	sl, r5
@   0x0801ceba: bcf0        pop	{r4, r5, r6, r7}
@   0x0801cebc: bc01        pop	{r0}
@   0x0801cebe: 4700        bx	r0

        thumb_func_start sub_0801CD0C
sub_0801CD0C: @ 0x0801cd0c
        .incbin "frog_us_baserom.gba", 0x1cd0c, 0x1b4
        thumb_func_end sub_0801CD0C
