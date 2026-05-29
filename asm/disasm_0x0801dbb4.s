@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801dbb4, 0x0801dea0)  (748 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801dbb4 --end 0x801dea0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801dbb4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801dbb6: 4657        mov	r7, sl
@   0x0801dbb8: 464e        mov	r6, r9
@   0x0801dbba: 4645        mov	r5, r8
@   0x0801dbbc: b4e0        push	{r5, r6, r7}
@   0x0801dbbe: b087        sub	sp, #28
@   0x0801dbc0: 9003        str	r0, [sp, #12]
@   0x0801dbc2: 0612        lsls	r2, r2, #24
@   0x0801dbc4: 0e12        lsrs	r2, r2, #24
@   0x0801dbc6: 061b        lsls	r3, r3, #24
@   0x0801dbc8: 0e1f        lsrs	r7, r3, #24
@   0x0801dbca: 2000        movs	r0, #0
@   0x0801dbcc: 4681        mov	r9, r0
@   0x0801dbce: 2300        movs	r3, #0
@   0x0801dbd0: 9305        str	r3, [sp, #20]
@   0x0801dbd2: 2401        movs	r4, #1
@   0x0801dbd4: 46a0        mov	r8, r4
@   0x0801dbd6: 9803        ldr	r0, [sp, #12]
@   0x0801dbd8: e006        b.n	0x1dbe8
@   0x0801dbda: 9805        ldr	r0, [sp, #20]
@   0x0801dbdc: 3001        adds	r0, #1
@   0x0801dbde: 0600        lsls	r0, r0, #24
@   0x0801dbe0: 0e00        lsrs	r0, r0, #24
@   0x0801dbe2: 9005        str	r0, [sp, #20]
@   0x0801dbe4: 9b03        ldr	r3, [sp, #12]
@   0x0801dbe6: 1818        adds	r0, r3, r0
@   0x0801dbe8: 7800        ldrb	r0, [r0, #0]
@   0x0801dbea: 287c        cmp	r0, #124	@ 0x7c
@   0x0801dbec: d1f5        bne.n	0x1dbda
@   0x0801dbee: 9c03        ldr	r4, [sp, #12]
@   0x0801dbf0: 7820        ldrb	r0, [r4, #0]
@   0x0801dbf2: 2832        cmp	r0, #50	@ 0x32
@   0x0801dbf4: d00c        beq.n	0x1dc10
@   0x0801dbf6: 2832        cmp	r0, #50	@ 0x32
@   0x0801dbf8: dc02        bgt.n	0x1dc00
@   0x0801dbfa: 2831        cmp	r0, #49	@ 0x31
@   0x0801dbfc: d003        beq.n	0x1dc06
@   0x0801dbfe: e015        b.n	0x1dc2c
@   0x0801dc00: 2833        cmp	r0, #51	@ 0x33
@   0x0801dc02: d00c        beq.n	0x1dc1e
@   0x0801dc04: e012        b.n	0x1dc2c
@   0x0801dc06: 2001        movs	r0, #1
@   0x0801dc08: 2301        movs	r3, #1
@   0x0801dc0a: 248b        movs	r4, #139	@ 0x8b
@   0x0801dc0c: 0064        lsls	r4, r4, #1
@   0x0801dc0e: e010        b.n	0x1dc32
@   0x0801dc10: 2001        movs	r0, #1
@   0x0801dc12: 2302        movs	r3, #2
@   0x0801dc14: 24a0        movs	r4, #160	@ 0xa0
@   0x0801dc16: 9406        str	r4, [sp, #24]
@   0x0801dc18: 24f0        movs	r4, #240	@ 0xf0
@   0x0801dc1a: 0224        lsls	r4, r4, #8
@   0x0801dc1c: e00c        b.n	0x1dc38
@   0x0801dc1e: 2001        movs	r0, #1
@   0x0801dc20: 2303        movs	r3, #3
@   0x0801dc22: 2401        movs	r4, #1
@   0x0801dc24: 9406        str	r4, [sp, #24]
@   0x0801dc26: 24f0        movs	r4, #240	@ 0xf0
@   0x0801dc28: 0224        lsls	r4, r4, #8
@   0x0801dc2a: e005        b.n	0x1dc38
@   0x0801dc2c: 2000        movs	r0, #0
@   0x0801dc2e: 2304        movs	r3, #4
@   0x0801dc30: 2401        movs	r4, #1
@   0x0801dc32: 9406        str	r4, [sp, #24]
@   0x0801dc34: 24e0        movs	r4, #224	@ 0xe0
@   0x0801dc36: 0224        lsls	r4, r4, #8
@   0x0801dc38: 46a2        mov	sl, r4
@   0x0801dc3a: 2b01        cmp	r3, #1
@   0x0801dc3c: d112        bne.n	0x1dc64
@   0x0801dc3e: 9803        ldr	r0, [sp, #12]
@   0x0801dc40: 3001        adds	r0, #1
@   0x0801dc42: 9905        ldr	r1, [sp, #20]
@   0x0801dc44: 3901        subs	r1, #1
@   0x0801dc46: 0609        lsls	r1, r1, #24
@   0x0801dc48: 0e09        lsrs	r1, r1, #24
@   0x0801dc4a: 3201        adds	r2, #1
@   0x0801dc4c: 0612        lsls	r2, r2, #24
@   0x0801dc4e: 0e12        lsrs	r2, r2, #24
@   0x0801dc50: 9b06        ldr	r3, [sp, #24]
@   0x0801dc52: 9300        str	r3, [sp, #0]
@   0x0801dc54: 230e        movs	r3, #14
@   0x0801dc56: 9301        str	r3, [sp, #4]
@   0x0801dc58: 2300        movs	r3, #0
@   0x0801dc5a: 9302        str	r3, [sp, #8]
@   0x0801dc5c: 1c3b        adds	r3, r7, #0
@   0x0801dc5e: f000        f91f 	bl	0x1dea0
@   0x0801dc62: e114        b.n	0x1de8e
@   0x0801dc64: 9004        str	r0, [sp, #16]
@   0x0801dc66: 9c05        ldr	r4, [sp, #20]
@   0x0801dc68: 42a0        cmp	r0, r4
@   0x0801dc6a: d300        bcc.n	0x1dc6e
@   0x0801dc6c: e10f        b.n	0x1de8e
@   0x0801dc6e: 0050        lsls	r0, r2, #1
@   0x0801dc70: 1846        adds	r6, r0, r1
@   0x0801dc72: 9803        ldr	r0, [sp, #12]
@   0x0801dc74: 9904        ldr	r1, [sp, #16]
@   0x0801dc76: 1842        adds	r2, r0, r1
@   0x0801dc78: 7815        ldrb	r5, [r2, #0]
@   0x0801dc7a: 1c28        adds	r0, r5, #0
@   0x0801dc7c: 3830        subs	r0, #48	@ 0x30
@   0x0801dc7e: 0600        lsls	r0, r0, #24
@   0x0801dc80: 0e00        lsrs	r0, r0, #24
@   0x0801dc82: 2809        cmp	r0, #9
@   0x0801dc84: d815        bhi.n	0x1dcb2
@   0x0801dc86: 2d30        cmp	r5, #48	@ 0x30
@   0x0801dc88: d101        bne.n	0x1dc8e
@   0x0801dc8a: 2209        movs	r2, #9
@   0x0801dc8c: e003        b.n	0x1dc96
@   0x0801dc8e: 1c28        adds	r0, r5, #0
@   0x0801dc90: 3831        subs	r0, #49	@ 0x31
@   0x0801dc92: 0400        lsls	r0, r0, #16
@   0x0801dc94: 0c02        lsrs	r2, r0, #16
@   0x0801dc96: 464b        mov	r3, r9
@   0x0801dc98: 0058        lsls	r0, r3, #1
@   0x0801dc9a: 19c0        adds	r0, r0, r7
@   0x0801dc9c: 0180        lsls	r0, r0, #6
@   0x0801dc9e: 4644        mov	r4, r8
@   0x0801dca0: 0061        lsls	r1, r4, #1
@   0x0801dca2: 1989        adds	r1, r1, r6
@   0x0801dca4: 1840        adds	r0, r0, r1
@   0x0801dca6: 3040        adds	r0, #64	@ 0x40
@   0x0801dca8: 1c11        adds	r1, r2, #0
@   0x0801dcaa: 313a        adds	r1, #58	@ 0x3a
@   0x0801dcac: 9a06        ldr	r2, [sp, #24]
@   0x0801dcae: 1851        adds	r1, r2, r1
@   0x0801dcb0: e0ce        b.n	0x1de50
@   0x0801dcb2: 1c29        adds	r1, r5, #0
@   0x0801dcb4: 3941        subs	r1, #65	@ 0x41
@   0x0801dcb6: 0608        lsls	r0, r1, #24
@   0x0801dcb8: 0e00        lsrs	r0, r0, #24
@   0x0801dcba: 2819        cmp	r0, #25
@   0x0801dcbc: d80d        bhi.n	0x1dcda
@   0x0801dcbe: 0408        lsls	r0, r1, #16
@   0x0801dcc0: 0c02        lsrs	r2, r0, #16
@   0x0801dcc2: 464b        mov	r3, r9
@   0x0801dcc4: 0059        lsls	r1, r3, #1
@   0x0801dcc6: 19c9        adds	r1, r1, r7
@   0x0801dcc8: 0189        lsls	r1, r1, #6
@   0x0801dcca: 4644        mov	r4, r8
@   0x0801dccc: 0060        lsls	r0, r4, #1
@   0x0801dcce: 1980        adds	r0, r0, r6
@   0x0801dcd0: 1809        adds	r1, r1, r0
@   0x0801dcd2: 3140        adds	r1, #64	@ 0x40
@   0x0801dcd4: 9b06        ldr	r3, [sp, #24]
@   0x0801dcd6: 1898        adds	r0, r3, r2
@   0x0801dcd8: e014        b.n	0x1dd04
@   0x0801dcda: 1c29        adds	r1, r5, #0
@   0x0801dcdc: 3961        subs	r1, #97	@ 0x61
@   0x0801dcde: 0608        lsls	r0, r1, #24
@   0x0801dce0: 0e00        lsrs	r0, r0, #24
@   0x0801dce2: 2819        cmp	r0, #25
@   0x0801dce4: d811        bhi.n	0x1dd0a
@   0x0801dce6: 0408        lsls	r0, r1, #16
@   0x0801dce8: 0c02        lsrs	r2, r0, #16
@   0x0801dcea: 464c        mov	r4, r9
@   0x0801dcec: 0061        lsls	r1, r4, #1
@   0x0801dcee: 19c9        adds	r1, r1, r7
@   0x0801dcf0: 0189        lsls	r1, r1, #6
@   0x0801dcf2: 4643        mov	r3, r8
@   0x0801dcf4: 0058        lsls	r0, r3, #1
@   0x0801dcf6: 1980        adds	r0, r0, r6
@   0x0801dcf8: 1809        adds	r1, r1, r0
@   0x0801dcfa: 3140        adds	r1, #64	@ 0x40
@   0x0801dcfc: 1c10        adds	r0, r2, #0
@   0x0801dcfe: 301a        adds	r0, #26
@   0x0801dd00: 9c06        ldr	r4, [sp, #24]
@   0x0801dd02: 1820        adds	r0, r4, r0
@   0x0801dd04: 4450        add	r0, sl
@   0x0801dd06: 8008        strh	r0, [r1, #0]
@   0x0801dd08: e0aa        b.n	0x1de60
@   0x0801dd0a: 2d5b        cmp	r5, #91	@ 0x5b
@   0x0801dd0c: d128        bne.n	0x1dd60
@   0x0801dd0e: 7910        ldrb	r0, [r2, #4]
@   0x0801dd10: 285d        cmp	r0, #93	@ 0x5d
@   0x0801dd12: d125        bne.n	0x1dd60
@   0x0801dd14: 1c50        adds	r0, r2, #1
@   0x0801dd16: 2103        movs	r1, #3
@   0x0801dd18: f7ff        f8d2 	bl	0x1cec0
@   0x0801dd1c: 1c04        adds	r4, r0, #0
@   0x0801dd1e: 3cc0        subs	r4, #192	@ 0xc0
@   0x0801dd20: 2c3f        cmp	r4, #63	@ 0x3f
@   0x0801dd22: d815        bhi.n	0x1dd50
@   0x0801dd24: 4649        mov	r1, r9
@   0x0801dd26: 004a        lsls	r2, r1, #1
@   0x0801dd28: 19d2        adds	r2, r2, r7
@   0x0801dd2a: 0192        lsls	r2, r2, #6
@   0x0801dd2c: 4643        mov	r3, r8
@   0x0801dd2e: 0058        lsls	r0, r3, #1
@   0x0801dd30: 1980        adds	r0, r0, r6
@   0x0801dd32: 1812        adds	r2, r2, r0
@   0x0801dd34: 4b09        ldr	r3, [pc, #36]	@ (0x1dd5c)
@   0x0801dd36: 0061        lsls	r1, r4, #1
@   0x0801dd38: 1909        adds	r1, r1, r4
@   0x0801dd3a: 1c48        adds	r0, r1, #1
@   0x0801dd3c: 0040        lsls	r0, r0, #1
@   0x0801dd3e: 18c0        adds	r0, r0, r3
@   0x0801dd40: 8800        ldrh	r0, [r0, #0]
@   0x0801dd42: 8010        strh	r0, [r2, #0]
@   0x0801dd44: 3240        adds	r2, #64	@ 0x40
@   0x0801dd46: 3102        adds	r1, #2
@   0x0801dd48: 0049        lsls	r1, r1, #1
@   0x0801dd4a: 18c9        adds	r1, r1, r3
@   0x0801dd4c: 8808        ldrh	r0, [r1, #0]
@   0x0801dd4e: 8010        strh	r0, [r2, #0]
@   0x0801dd50: 9804        ldr	r0, [sp, #16]
@   0x0801dd52: 3004        adds	r0, #4
@   0x0801dd54: 0600        lsls	r0, r0, #24
@   0x0801dd56: 0e00        lsrs	r0, r0, #24
@   0x0801dd58: 9004        str	r0, [sp, #16]
@   0x0801dd5a: e081        b.n	0x1de60
@   0x0801dd5c: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0801dd60: 2d2e        cmp	r5, #46	@ 0x2e
@   0x0801dd62: d10c        bne.n	0x1dd7e
@   0x0801dd64: 464c        mov	r4, r9
@   0x0801dd66: 0060        lsls	r0, r4, #1
@   0x0801dd68: 19c0        adds	r0, r0, r7
@   0x0801dd6a: 0180        lsls	r0, r0, #6
@   0x0801dd6c: 4642        mov	r2, r8
@   0x0801dd6e: 0051        lsls	r1, r2, #1
@   0x0801dd70: 1989        adds	r1, r1, r6
@   0x0801dd72: 1840        adds	r0, r0, r1
@   0x0801dd74: 3040        adds	r0, #64	@ 0x40
@   0x0801dd76: 4651        mov	r1, sl
@   0x0801dd78: 31d5        adds	r1, #213	@ 0xd5
@   0x0801dd7a: 8001        strh	r1, [r0, #0]
@   0x0801dd7c: e070        b.n	0x1de60
@   0x0801dd7e: 2d2c        cmp	r5, #44	@ 0x2c
@   0x0801dd80: d10c        bne.n	0x1dd9c
@   0x0801dd82: 464b        mov	r3, r9
@   0x0801dd84: 0058        lsls	r0, r3, #1
@   0x0801dd86: 19c0        adds	r0, r0, r7
@   0x0801dd88: 0180        lsls	r0, r0, #6
@   0x0801dd8a: 4644        mov	r4, r8
@   0x0801dd8c: 0061        lsls	r1, r4, #1
@   0x0801dd8e: 1989        adds	r1, r1, r6
@   0x0801dd90: 1840        adds	r0, r0, r1
@   0x0801dd92: 3040        adds	r0, #64	@ 0x40
@   0x0801dd94: 4651        mov	r1, sl
@   0x0801dd96: 31d4        adds	r1, #212	@ 0xd4
@   0x0801dd98: 8001        strh	r1, [r0, #0]
@   0x0801dd9a: e061        b.n	0x1de60
@   0x0801dd9c: 2d20        cmp	r5, #32
@   0x0801dd9e: d10b        bne.n	0x1ddb8
@   0x0801dda0: 4649        mov	r1, r9
@   0x0801dda2: 0048        lsls	r0, r1, #1
@   0x0801dda4: 19c0        adds	r0, r0, r7
@   0x0801dda6: 0180        lsls	r0, r0, #6
@   0x0801dda8: 4642        mov	r2, r8
@   0x0801ddaa: 0051        lsls	r1, r2, #1
@   0x0801ddac: 1989        adds	r1, r1, r6
@   0x0801ddae: 1840        adds	r0, r0, r1
@   0x0801ddb0: 3040        adds	r0, #64	@ 0x40
@   0x0801ddb2: 2100        movs	r1, #0
@   0x0801ddb4: 8001        strh	r1, [r0, #0]
@   0x0801ddb6: e053        b.n	0x1de60
@   0x0801ddb8: 2d2a        cmp	r5, #42	@ 0x2a
@   0x0801ddba: d10e        bne.n	0x1ddda
@   0x0801ddbc: 464b        mov	r3, r9
@   0x0801ddbe: 0059        lsls	r1, r3, #1
@   0x0801ddc0: 19c9        adds	r1, r1, r7
@   0x0801ddc2: 0189        lsls	r1, r1, #6
@   0x0801ddc4: 4644        mov	r4, r8
@   0x0801ddc6: 0060        lsls	r0, r4, #1
@   0x0801ddc8: 1980        adds	r0, r0, r6
@   0x0801ddca: 1809        adds	r1, r1, r0
@   0x0801ddcc: 4650        mov	r0, sl
@   0x0801ddce: 3024        adds	r0, #36	@ 0x24
@   0x0801ddd0: 8008        strh	r0, [r1, #0]
@   0x0801ddd2: 3140        adds	r1, #64	@ 0x40
@   0x0801ddd4: 381b        subs	r0, #27
@   0x0801ddd6: 8008        strh	r0, [r1, #0]
@   0x0801ddd8: e042        b.n	0x1de60
@   0x0801ddda: 2d27        cmp	r5, #39	@ 0x27
@   0x0801dddc: d10c        bne.n	0x1ddf8
@   0x0801ddde: 4649        mov	r1, r9
@   0x0801dde0: 0048        lsls	r0, r1, #1
@   0x0801dde2: 19c0        adds	r0, r0, r7
@   0x0801dde4: 0180        lsls	r0, r0, #6
@   0x0801dde6: 4642        mov	r2, r8
@   0x0801dde8: 0051        lsls	r1, r2, #1
@   0x0801ddea: 1989        adds	r1, r1, r6
@   0x0801ddec: 1840        adds	r0, r0, r1
@   0x0801ddee: 3040        adds	r0, #64	@ 0x40
@   0x0801ddf0: 4651        mov	r1, sl
@   0x0801ddf2: 31f8        adds	r1, #248	@ 0xf8
@   0x0801ddf4: 8001        strh	r1, [r0, #0]
@   0x0801ddf6: e033        b.n	0x1de60
@   0x0801ddf8: 2d3a        cmp	r5, #58	@ 0x3a
@   0x0801ddfa: d10c        bne.n	0x1de16
@   0x0801ddfc: 464b        mov	r3, r9
@   0x0801ddfe: 0058        lsls	r0, r3, #1
@   0x0801de00: 19c0        adds	r0, r0, r7
@   0x0801de02: 0180        lsls	r0, r0, #6
@   0x0801de04: 4644        mov	r4, r8
@   0x0801de06: 0061        lsls	r1, r4, #1
@   0x0801de08: 1989        adds	r1, r1, r6
@   0x0801de0a: 1840        adds	r0, r0, r1
@   0x0801de0c: 3040        adds	r0, #64	@ 0x40
@   0x0801de0e: 4651        mov	r1, sl
@   0x0801de10: 31fa        adds	r1, #250	@ 0xfa
@   0x0801de12: 8001        strh	r1, [r0, #0]
@   0x0801de14: e024        b.n	0x1de60
@   0x0801de16: 2d3f        cmp	r5, #63	@ 0x3f
@   0x0801de18: d10e        bne.n	0x1de38
@   0x0801de1a: 4649        mov	r1, r9
@   0x0801de1c: 0048        lsls	r0, r1, #1
@   0x0801de1e: 19c0        adds	r0, r0, r7
@   0x0801de20: 0180        lsls	r0, r0, #6
@   0x0801de22: 4642        mov	r2, r8
@   0x0801de24: 0051        lsls	r1, r2, #1
@   0x0801de26: 1989        adds	r1, r1, r6
@   0x0801de28: 1840        adds	r0, r0, r1
@   0x0801de2a: 3040        adds	r0, #64	@ 0x40
@   0x0801de2c: 4b01        ldr	r3, [pc, #4]	@ (0x1de34)
@   0x0801de2e: 1c19        adds	r1, r3, #0
@   0x0801de30: 8001        strh	r1, [r0, #0]
@   0x0801de32: e015        b.n	0x1de60
@   0x0801de34: e0d6        b.n	0x1dfe4
@   0x0801de36: 0000        movs	r0, r0
@   0x0801de38: 2d7e        cmp	r5, #126	@ 0x7e
@   0x0801de3a: d10f        bne.n	0x1de5c
@   0x0801de3c: 464c        mov	r4, r9
@   0x0801de3e: 0060        lsls	r0, r4, #1
@   0x0801de40: 19c0        adds	r0, r0, r7
@   0x0801de42: 0180        lsls	r0, r0, #6
@   0x0801de44: 4642        mov	r2, r8
@   0x0801de46: 0051        lsls	r1, r2, #1
@   0x0801de48: 1989        adds	r1, r1, r6
@   0x0801de4a: 1840        adds	r0, r0, r1
@   0x0801de4c: 3040        adds	r0, #64	@ 0x40
@   0x0801de4e: 4902        ldr	r1, [pc, #8]	@ (0x1de58)
@   0x0801de50: 4451        add	r1, sl
@   0x0801de52: 8001        strh	r1, [r0, #0]
@   0x0801de54: e004        b.n	0x1de60
@   0x0801de56: 0000        movs	r0, r0
@   0x0801de58: e0ea        b.n	0x1e030
@   0x0801de5a: 0000        movs	r0, r0
@   0x0801de5c: 2d7c        cmp	r5, #124	@ 0x7c
@   0x0801de5e: d016        beq.n	0x1de8e
@   0x0801de60: 4640        mov	r0, r8
@   0x0801de62: 3001        adds	r0, #1
@   0x0801de64: 0600        lsls	r0, r0, #24
@   0x0801de66: 0e00        lsrs	r0, r0, #24
@   0x0801de68: 4680        mov	r8, r0
@   0x0801de6a: 2d0a        cmp	r5, #10
@   0x0801de6c: d106        bne.n	0x1de7c
@   0x0801de6e: 2300        movs	r3, #0
@   0x0801de70: 4698        mov	r8, r3
@   0x0801de72: 4648        mov	r0, r9
@   0x0801de74: 3001        adds	r0, #1
@   0x0801de76: 0600        lsls	r0, r0, #24
@   0x0801de78: 0e00        lsrs	r0, r0, #24
@   0x0801de7a: 4681        mov	r9, r0
@   0x0801de7c: 9804        ldr	r0, [sp, #16]
@   0x0801de7e: 3001        adds	r0, #1
@   0x0801de80: 0600        lsls	r0, r0, #24
@   0x0801de82: 0e00        lsrs	r0, r0, #24
@   0x0801de84: 9004        str	r0, [sp, #16]
@   0x0801de86: 9c05        ldr	r4, [sp, #20]
@   0x0801de88: 42a0        cmp	r0, r4
@   0x0801de8a: d200        bcs.n	0x1de8e
@   0x0801de8c: e6f1        b.n	0x1dc72
@   0x0801de8e: b007        add	sp, #28
@   0x0801de90: bc38        pop	{r3, r4, r5}
@   0x0801de92: 4698        mov	r8, r3
@   0x0801de94: 46a1        mov	r9, r4
@   0x0801de96: 46aa        mov	sl, r5
@   0x0801de98: bcf0        pop	{r4, r5, r6, r7}
@   0x0801de9a: bc01        pop	{r0}
@   0x0801de9c: 4700        bx	r0

        thumb_func_start sub_0801DBB4
sub_0801DBB4: @ 0x0801dbb4
        .incbin "frog_us_baserom.gba", 0x1dbb4, 0x2ec
        thumb_func_end sub_0801DBB4
