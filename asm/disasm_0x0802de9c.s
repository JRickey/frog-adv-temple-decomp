@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802de9c, 0x0802dfbc)  (288 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802de9c --end 0x802dfbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802de9c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802de9e: 4657        mov	r7, sl
@   0x0802dea0: 464e        mov	r6, r9
@   0x0802dea2: 4645        mov	r5, r8
@   0x0802dea4: b4e0        push	{r5, r6, r7}
@   0x0802dea6: b087        sub	sp, #28
@   0x0802dea8: 4680        mov	r8, r0
@   0x0802deaa: 9104        str	r1, [sp, #16]
@   0x0802deac: 9205        str	r2, [sp, #20]
@   0x0802deae: 9306        str	r3, [sp, #24]
@   0x0802deb0: 2803        cmp	r0, #3
@   0x0802deb2: dc7a        bgt.n	0x2dfaa
@   0x0802deb4: 0080        lsls	r0, r0, #2
@   0x0802deb6: 2192        movs	r1, #146	@ 0x92
@   0x0802deb8: 0049        lsls	r1, r1, #1
@   0x0802deba: 1840        adds	r0, r0, r1
@   0x0802debc: 4a2f        ldr	r2, [pc, #188]	@ (0x2df7c)
@   0x0802debe: 6811        ldr	r1, [r2, #0]
@   0x0802dec0: 180f        adds	r7, r1, r0
@   0x0802dec2: 6838        ldr	r0, [r7, #0]
@   0x0802dec4: 4681        mov	r9, r0
@   0x0802dec6: 2800        cmp	r0, #0
@   0x0802dec8: d16f        bne.n	0x2dfaa
@   0x0802deca: 2180        movs	r1, #128	@ 0x80
@   0x0802decc: 0149        lsls	r1, r1, #5
@   0x0802dece: 468a        mov	sl, r1
@   0x0802ded0: 2001        movs	r0, #1
@   0x0802ded2: 22ff        movs	r2, #255	@ 0xff
@   0x0802ded4: 23ff        movs	r3, #255	@ 0xff
@   0x0802ded6: f004        fe1f 	bl	0x32b18
@   0x0802deda: 1c06        adds	r6, r0, #0
@   0x0802dedc: 2e00        cmp	r6, #0
@   0x0802dede: db64        blt.n	0x2dfaa
@   0x0802dee0: 4a26        ldr	r2, [pc, #152]	@ (0x2df7c)
@   0x0802dee2: 6811        ldr	r1, [r2, #0]
@   0x0802dee4: 1c08        adds	r0, r1, #0
@   0x0802dee6: 30c4        adds	r0, #196	@ 0xc4
@   0x0802dee8: 6800        ldr	r0, [r0, #0]
@   0x0802deea: 00b5        lsls	r5, r6, #2
@   0x0802deec: 1828        adds	r0, r5, r0
@   0x0802deee: 464a        mov	r2, r9
@   0x0802def0: 6002        str	r2, [r0, #0]
@   0x0802def2: 31c8        adds	r1, #200	@ 0xc8
@   0x0802def4: 01b0        lsls	r0, r6, #6
@   0x0802def6: 680c        ldr	r4, [r1, #0]
@   0x0802def8: 1824        adds	r4, r4, r0
@   0x0802defa: 4650        mov	r0, sl
@   0x0802defc: 9000        str	r0, [sp, #0]
@   0x0802defe: 1c20        adds	r0, r4, #0
@   0x0802df00: 2100        movs	r1, #0
@   0x0802df02: 9a0f        ldr	r2, [sp, #60]	@ 0x3c
@   0x0802df04: 9b06        ldr	r3, [sp, #24]
@   0x0802df06: f004        fcc5 	bl	0x32894
@   0x0802df0a: 6ba0        ldr	r0, [r4, #56]	@ 0x38
@   0x0802df0c: 21c0        movs	r1, #192	@ 0xc0
@   0x0802df0e: 0289        lsls	r1, r1, #10
@   0x0802df10: 4308        orrs	r0, r1
@   0x0802df12: 63a0        str	r0, [r4, #56]	@ 0x38
@   0x0802df14: 1c20        adds	r0, r4, #0
@   0x0802df16: 303e        adds	r0, #62	@ 0x3e
@   0x0802df18: 4641        mov	r1, r8
@   0x0802df1a: 7001        strb	r1, [r0, #0]
@   0x0802df1c: 4a17        ldr	r2, [pc, #92]	@ (0x2df7c)
@   0x0802df1e: 6811        ldr	r1, [r2, #0]
@   0x0802df20: 1c08        adds	r0, r1, #0
@   0x0802df22: 30cc        adds	r0, #204	@ 0xcc
@   0x0802df24: 6800        ldr	r0, [r0, #0]
@   0x0802df26: 182d        adds	r5, r5, r0
@   0x0802df28: 602c        str	r4, [r5, #0]
@   0x0802df2a: 9804        ldr	r0, [sp, #16]
@   0x0802df2c: 6038        str	r0, [r7, #0]
@   0x0802df2e: 9a05        ldr	r2, [sp, #20]
@   0x0802df30: 0310        lsls	r0, r2, #12
@   0x0802df32: 8849        ldrh	r1, [r1, #2]
@   0x0802df34: f005        ffd6 	bl	0x33ee4
@   0x0802df38: 0400        lsls	r0, r0, #16
@   0x0802df3a: 0c05        lsrs	r5, r0, #16
@   0x0802df3c: 0d40        lsrs	r0, r0, #21
@   0x0802df3e: 3002        adds	r0, #2
@   0x0802df40: aa02        add	r2, sp, #8
@   0x0802df42: ab03        add	r3, sp, #12
@   0x0802df44: 4641        mov	r1, r8
@   0x0802df46: 9100        str	r1, [sp, #0]
@   0x0802df48: 683c        ldr	r4, [r7, #0]
@   0x0802df4a: a901        add	r1, sp, #4
@   0x0802df4c: f005        fecc 	bl	0x33ce8
@   0x0802df50: 1c04        adds	r4, r0, #0
@   0x0802df52: 4a0a        ldr	r2, [pc, #40]	@ (0x2df7c)
@   0x0802df54: 6813        ldr	r3, [r2, #0]
@   0x0802df56: 1c19        adds	r1, r3, #0
@   0x0802df58: 31c0        adds	r1, #192	@ 0xc0
@   0x0802df5a: 00f0        lsls	r0, r6, #3
@   0x0802df5c: 1b80        subs	r0, r0, r6
@   0x0802df5e: 0080        lsls	r0, r0, #2
@   0x0802df60: 6809        ldr	r1, [r1, #0]
@   0x0802df62: 180a        adds	r2, r1, r0
@   0x0802df64: 8295        strh	r5, [r2, #20]
@   0x0802df66: 4648        mov	r0, r9
@   0x0802df68: 82d0        strh	r0, [r2, #22]
@   0x0802df6a: 9810        ldr	r0, [sp, #64]	@ 0x40
@   0x0802df6c: 2800        cmp	r0, #0
@   0x0802df6e: d007        beq.n	0x2df80
@   0x0802df70: 2187        movs	r1, #135	@ 0x87
@   0x0802df72: 0049        lsls	r1, r1, #1
@   0x0802df74: 1858        adds	r0, r3, r1
@   0x0802df76: 7800        ldrb	r0, [r0, #0]
@   0x0802df78: e003        b.n	0x2df82
@   0x0802df7a: 0000        movs	r0, r0
@   0x0802df7c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802df7e: 0300        lsls	r0, r0, #12
@   0x0802df80: 2000        movs	r0, #0
@   0x0802df82: 2100        movs	r1, #0
@   0x0802df84: 76d0        strb	r0, [r2, #27]
@   0x0802df86: 6011        str	r1, [r2, #0]
@   0x0802df88: 9801        ldr	r0, [sp, #4]
@   0x0802df8a: 6050        str	r0, [r2, #4]
@   0x0802df8c: 9801        ldr	r0, [sp, #4]
@   0x0802df8e: 1900        adds	r0, r0, r4
@   0x0802df90: 6090        str	r0, [r2, #8]
@   0x0802df92: 60d1        str	r1, [r2, #12]
@   0x0802df94: 6111        str	r1, [r2, #16]
@   0x0802df96: 1c30        adds	r0, r6, #0
@   0x0802df98: f001        f9fe 	bl	0x2f398
@   0x0802df9c: 0431        lsls	r1, r6, #16
@   0x0802df9e: 4642        mov	r2, r8
@   0x0802dfa0: 4311        orrs	r1, r2
@   0x0802dfa2: 2080        movs	r0, #128	@ 0x80
@   0x0802dfa4: 0600        lsls	r0, r0, #24
@   0x0802dfa6: 4308        orrs	r0, r1
@   0x0802dfa8: e000        b.n	0x2dfac
@   0x0802dfaa: 2000        movs	r0, #0
@   0x0802dfac: b007        add	sp, #28
@   0x0802dfae: bc38        pop	{r3, r4, r5}
@   0x0802dfb0: 4698        mov	r8, r3
@   0x0802dfb2: 46a1        mov	r9, r4
@   0x0802dfb4: 46aa        mov	sl, r5
@   0x0802dfb6: bcf0        pop	{r4, r5, r6, r7}
@   0x0802dfb8: bc02        pop	{r1}
@   0x0802dfba: 4708        bx	r1

        thumb_func_start sub_0802DE9C
sub_0802DE9C: @ 0x0802de9c
        .incbin "frog_us_baserom.gba", 0x2de9c, 0x120
        thumb_func_end sub_0802DE9C
