@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802edf0, 0x0802eef8)  (264 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802edf0 --end 0x802eef8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802edf0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802edf2: 4657        mov	r7, sl
@   0x0802edf4: 464e        mov	r6, r9
@   0x0802edf6: 4645        mov	r5, r8
@   0x0802edf8: b4e0        push	{r5, r6, r7}
@   0x0802edfa: 2000        movs	r0, #0
@   0x0802edfc: 4681        mov	r9, r0
@   0x0802edfe: 4902        ldr	r1, [pc, #8]	@ (0x2ee08)
@   0x0802ee00: 6808        ldr	r0, [r1, #0]
@   0x0802ee02: 468a        mov	sl, r1
@   0x0802ee04: e06e        b.n	0x2eee4
@   0x0802ee06: 0000        movs	r0, r0
@   0x0802ee08: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ee0a: 0300        lsls	r0, r0, #12
@   0x0802ee0c: 680c        ldr	r4, [r1, #0]
@   0x0802ee0e: 1c20        adds	r0, r4, #0
@   0x0802ee10: 30cc        adds	r0, #204	@ 0xcc
@   0x0802ee12: 6800        ldr	r0, [r0, #0]
@   0x0802ee14: 4649        mov	r1, r9
@   0x0802ee16: 008b        lsls	r3, r1, #2
@   0x0802ee18: 1818        adds	r0, r3, r0
@   0x0802ee1a: 6802        ldr	r2, [r0, #0]
@   0x0802ee1c: 2a00        cmp	r2, #0
@   0x0802ee1e: d05d        beq.n	0x2eedc
@   0x0802ee20: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802ee22: 2180        movs	r1, #128	@ 0x80
@   0x0802ee24: 0109        lsls	r1, r1, #4
@   0x0802ee26: 4008        ands	r0, r1
@   0x0802ee28: 2800        cmp	r0, #0
@   0x0802ee2a: d057        beq.n	0x2eedc
@   0x0802ee2c: 1c20        adds	r0, r4, #0
@   0x0802ee2e: 30c4        adds	r0, #196	@ 0xc4
@   0x0802ee30: 6800        ldr	r0, [r0, #0]
@   0x0802ee32: 1818        adds	r0, r3, r0
@   0x0802ee34: 6807        ldr	r7, [r0, #0]
@   0x0802ee36: 2f00        cmp	r7, #0
@   0x0802ee38: d050        beq.n	0x2eedc
@   0x0802ee3a: 1c13        adds	r3, r2, #0
@   0x0802ee3c: 332c        adds	r3, #44	@ 0x2c
@   0x0802ee3e: 79d8        ldrb	r0, [r3, #7]
@   0x0802ee40: 2800        cmp	r0, #0
@   0x0802ee42: d149        bne.n	0x2eed8
@   0x0802ee44: 7998        ldrb	r0, [r3, #6]
@   0x0802ee46: 71d8        strb	r0, [r3, #7]
@   0x0802ee48: 8898        ldrh	r0, [r3, #4]
@   0x0802ee4a: 1c06        adds	r6, r0, #0
@   0x0802ee4c: 2e00        cmp	r6, #0
@   0x0802ee4e: d112        bne.n	0x2ee76
@   0x0802ee50: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802ee52: 2080        movs	r0, #128	@ 0x80
@   0x0802ee54: 01c0        lsls	r0, r0, #7
@   0x0802ee56: 4008        ands	r0, r1
@   0x0802ee58: 2800        cmp	r0, #0
@   0x0802ee5a: d005        beq.n	0x2ee68
@   0x0802ee5c: 8858        ldrh	r0, [r3, #2]
@   0x0802ee5e: 8098        strh	r0, [r3, #4]
@   0x0802ee60: 8d91        ldrh	r1, [r2, #44]	@ 0x2c
@   0x0802ee62: 4248        negs	r0, r1
@   0x0802ee64: 8590        strh	r0, [r2, #44]	@ 0x2c
@   0x0802ee66: e002        b.n	0x2ee6e
@   0x0802ee68: 480e        ldr	r0, [pc, #56]	@ (0x2eea4)
@   0x0802ee6a: 4001        ands	r1, r0
@   0x0802ee6c: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802ee6e: 8898        ldrh	r0, [r3, #4]
@   0x0802ee70: 1c06        adds	r6, r0, #0
@   0x0802ee72: 2e00        cmp	r6, #0
@   0x0802ee74: d032        beq.n	0x2eedc
@   0x0802ee76: 2100        movs	r1, #0
@   0x0802ee78: 5e58        ldrsh	r0, [r3, r1]
@   0x0802ee7a: 68f9        ldr	r1, [r7, #12]
@   0x0802ee7c: 180d        adds	r5, r1, r0
@   0x0802ee7e: 2000        movs	r0, #0
@   0x0802ee80: 4680        mov	r8, r0
@   0x0802ee82: 683c        ldr	r4, [r7, #0]
@   0x0802ee84: 1c22        adds	r2, r4, #0
@   0x0802ee86: 3210        adds	r2, #16
@   0x0802ee88: 68b8        ldr	r0, [r7, #8]
@   0x0802ee8a: 468c        mov	ip, r1
@   0x0802ee8c: 4584        cmp	ip, r0
@   0x0802ee8e: d80b        bhi.n	0x2eea8
@   0x0802ee90: 4295        cmp	r5, r2
@   0x0802ee92: d316        bcc.n	0x2eec2
@   0x0802ee94: 6939        ldr	r1, [r7, #16]
@   0x0802ee96: 1869        adds	r1, r5, r1
@   0x0802ee98: 6820        ldr	r0, [r4, #0]
@   0x0802ee9a: 1810        adds	r0, r2, r0
@   0x0802ee9c: 4281        cmp	r1, r0
@   0x0802ee9e: d90d        bls.n	0x2eebc
@   0x0802eea0: e00f        b.n	0x2eec2
@   0x0802eea2: 0000        movs	r0, r0
@   0x0802eea4: b7ff        @ <UNDEFINED> instruction: 0xb7ff
@   0x0802eea6: ffff        6938 	vqshrn.u64	d22, q12, #1
@   0x0802eeaa: 1a28        subs	r0, r5, r0
@   0x0802eeac: 4290        cmp	r0, r2
@   0x0802eeae: d303        bcc.n	0x2eeb8
@   0x0802eeb0: 6820        ldr	r0, [r4, #0]
@   0x0802eeb2: 1810        adds	r0, r2, r0
@   0x0802eeb4: 4285        cmp	r5, r0
@   0x0802eeb6: d901        bls.n	0x2eebc
@   0x0802eeb8: 2101        movs	r1, #1
@   0x0802eeba: 4688        mov	r8, r1
@   0x0802eebc: 4640        mov	r0, r8
@   0x0802eebe: 2800        cmp	r0, #0
@   0x0802eec0: d006        beq.n	0x2eed0
@   0x0802eec2: 4665        mov	r5, ip
@   0x0802eec4: 8859        ldrh	r1, [r3, #2]
@   0x0802eec6: 1b88        subs	r0, r1, r6
@   0x0802eec8: 2100        movs	r1, #0
@   0x0802eeca: 8058        strh	r0, [r3, #2]
@   0x0802eecc: 8099        strh	r1, [r3, #4]
@   0x0802eece: e001        b.n	0x2eed4
@   0x0802eed0: 1e70        subs	r0, r6, #1
@   0x0802eed2: 8098        strh	r0, [r3, #4]
@   0x0802eed4: 60fd        str	r5, [r7, #12]
@   0x0802eed6: e001        b.n	0x2eedc
@   0x0802eed8: 3801        subs	r0, #1
@   0x0802eeda: 71d8        strb	r0, [r3, #7]
@   0x0802eedc: 2001        movs	r0, #1
@   0x0802eede: 4481        add	r9, r0
@   0x0802eee0: 4651        mov	r1, sl
@   0x0802eee2: 6808        ldr	r0, [r1, #0]
@   0x0802eee4: 7800        ldrb	r0, [r0, #0]
@   0x0802eee6: 4581        cmp	r9, r0
@   0x0802eee8: db90        blt.n	0x2ee0c
@   0x0802eeea: bc38        pop	{r3, r4, r5}
@   0x0802eeec: 4698        mov	r8, r3
@   0x0802eeee: 46a1        mov	r9, r4
@   0x0802eef0: 46aa        mov	sl, r5
@   0x0802eef2: bcf0        pop	{r4, r5, r6, r7}
@   0x0802eef4: bc01        pop	{r0}
@   0x0802eef6: 4700        bx	r0

        thumb_func_start sub_0802EDF0
sub_0802EDF0: @ 0x0802edf0
        .incbin "frog_us_baserom.gba", 0x2edf0, 0x108
        thumb_func_end sub_0802EDF0
