@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802dcbc, 0x0802de24)  (360 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802dcbc --end 0x802de24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802dcbc: b570        push	{r4, r5, r6, lr}
@   0x0802dcbe: 1c04        adds	r4, r0, #0
@   0x0802dcc0: 1c0b        adds	r3, r1, #0
@   0x0802dcc2: 2c00        cmp	r4, #0
@   0x0802dcc4: d00e        beq.n	0x2dce4
@   0x0802dcc6: 0c25        lsrs	r5, r4, #16
@   0x0802dcc8: 20ff        movs	r0, #255	@ 0xff
@   0x0802dcca: 4005        ands	r5, r0
@   0x0802dccc: 4a07        ldr	r2, [pc, #28]	@ (0x2dcec)
@   0x0802dcce: 6810        ldr	r0, [r2, #0]
@   0x0802dcd0: 2190        movs	r1, #144	@ 0x90
@   0x0802dcd2: 0049        lsls	r1, r1, #1
@   0x0802dcd4: 1840        adds	r0, r0, r1
@   0x0802dcd6: 6801        ldr	r1, [r0, #0]
@   0x0802dcd8: 00a8        lsls	r0, r5, #2
@   0x0802dcda: 1840        adds	r0, r0, r1
@   0x0802dcdc: 6800        ldr	r0, [r0, #0]
@   0x0802dcde: 1c16        adds	r6, r2, #0
@   0x0802dce0: 42a0        cmp	r0, r4
@   0x0802dce2: d005        beq.n	0x2dcf0
@   0x0802dce4: 2001        movs	r0, #1
@   0x0802dce6: 4240        negs	r0, r0
@   0x0802dce8: e05d        b.n	0x2dda6
@   0x0802dcea: 0000        movs	r0, r0
@   0x0802dcec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802dcee: 0300        lsls	r0, r0, #12
@   0x0802dcf0: 2b80        cmp	r3, #128	@ 0x80
@   0x0802dcf2: d101        bne.n	0x2dcf8
@   0x0802dcf4: 23ff        movs	r3, #255	@ 0xff
@   0x0802dcf6: e006        b.n	0x2dd06
@   0x0802dcf8: 2b00        cmp	r3, #0
@   0x0802dcfa: da01        bge.n	0x2dd00
@   0x0802dcfc: 2300        movs	r3, #0
@   0x0802dcfe: e002        b.n	0x2dd06
@   0x0802dd00: 2b7f        cmp	r3, #127	@ 0x7f
@   0x0802dd02: dd00        ble.n	0x2dd06
@   0x0802dd04: 237f        movs	r3, #127	@ 0x7f
@   0x0802dd06: 2d03        cmp	r5, #3
@   0x0802dd08: dc36        bgt.n	0x2dd78
@   0x0802dd0a: 2088        movs	r0, #136	@ 0x88
@   0x0802dd0c: 0540        lsls	r0, r0, #21
@   0x0802dd0e: 40a8        lsls	r0, r5
@   0x0802dd10: 0e02        lsrs	r2, r0, #24
@   0x0802dd12: 6831        ldr	r1, [r6, #0]
@   0x0802dd14: 31ba        adds	r1, #186	@ 0xba
@   0x0802dd16: 1c10        adds	r0, r2, #0
@   0x0802dd18: 7809        ldrb	r1, [r1, #0]
@   0x0802dd1a: 4008        ands	r0, r1
@   0x0802dd1c: 4128        asrs	r0, r5
@   0x0802dd1e: 0600        lsls	r0, r0, #24
@   0x0802dd20: 0e00        lsrs	r0, r0, #24
@   0x0802dd22: 242a        movs	r4, #42	@ 0x2a
@   0x0802dd24: 2810        cmp	r0, #16
@   0x0802dd26: d003        beq.n	0x2dd30
@   0x0802dd28: 2440        movs	r4, #64	@ 0x40
@   0x0802dd2a: 2801        cmp	r0, #1
@   0x0802dd2c: d100        bne.n	0x2dd30
@   0x0802dd2e: 2455        movs	r4, #85	@ 0x55
@   0x0802dd30: 6830        ldr	r0, [r6, #0]
@   0x0802dd32: 30ba        adds	r0, #186	@ 0xba
@   0x0802dd34: 7801        ldrb	r1, [r0, #0]
@   0x0802dd36: 4391        bics	r1, r2
@   0x0802dd38: 7001        strb	r1, [r0, #0]
@   0x0802dd3a: 2bff        cmp	r3, #255	@ 0xff
@   0x0802dd3c: d00a        beq.n	0x2dd54
@   0x0802dd3e: 2b29        cmp	r3, #41	@ 0x29
@   0x0802dd40: dc02        bgt.n	0x2dd48
@   0x0802dd42: 2080        movs	r0, #128	@ 0x80
@   0x0802dd44: 0540        lsls	r0, r0, #21
@   0x0802dd46: e003        b.n	0x2dd50
@   0x0802dd48: 2b55        cmp	r3, #85	@ 0x55
@   0x0802dd4a: dd03        ble.n	0x2dd54
@   0x0802dd4c: 2080        movs	r0, #128	@ 0x80
@   0x0802dd4e: 0440        lsls	r0, r0, #17
@   0x0802dd50: 40a8        lsls	r0, r5
@   0x0802dd52: 0e02        lsrs	r2, r0, #24
@   0x0802dd54: 6830        ldr	r0, [r6, #0]
@   0x0802dd56: 30ba        adds	r0, #186	@ 0xba
@   0x0802dd58: 7801        ldrb	r1, [r0, #0]
@   0x0802dd5a: 430a        orrs	r2, r1
@   0x0802dd5c: 7002        strb	r2, [r0, #0]
@   0x0802dd5e: 4a05        ldr	r2, [pc, #20]	@ (0x2dd74)
@   0x0802dd60: 8810        ldrh	r0, [r2, #0]
@   0x0802dd62: 21ff        movs	r1, #255	@ 0xff
@   0x0802dd64: 4001        ands	r1, r0
@   0x0802dd66: 6830        ldr	r0, [r6, #0]
@   0x0802dd68: 30ba        adds	r0, #186	@ 0xba
@   0x0802dd6a: 7800        ldrb	r0, [r0, #0]
@   0x0802dd6c: 0200        lsls	r0, r0, #8
@   0x0802dd6e: 4301        orrs	r1, r0
@   0x0802dd70: 8011        strh	r1, [r2, #0]
@   0x0802dd72: e014        b.n	0x2dd9e
@   0x0802dd74: 0080        lsls	r0, r0, #2
@   0x0802dd76: 0400        lsls	r0, r0, #16
@   0x0802dd78: 6831        ldr	r1, [r6, #0]
@   0x0802dd7a: 31c8        adds	r1, #200	@ 0xc8
@   0x0802dd7c: 01a8        lsls	r0, r5, #6
@   0x0802dd7e: 4a0b        ldr	r2, [pc, #44]	@ (0x2ddac)
@   0x0802dd80: 1880        adds	r0, r0, r2
@   0x0802dd82: 6809        ldr	r1, [r1, #0]
@   0x0802dd84: 180a        adds	r2, r1, r0
@   0x0802dd86: 1c10        adds	r0, r2, #0
@   0x0802dd88: 303c        adds	r0, #60	@ 0x3c
@   0x0802dd8a: 7804        ldrb	r4, [r0, #0]
@   0x0802dd8c: 7003        strb	r3, [r0, #0]
@   0x0802dd8e: 0618        lsls	r0, r3, #24
@   0x0802dd90: 0e00        lsrs	r0, r0, #24
@   0x0802dd92: 42a0        cmp	r0, r4
@   0x0802dd94: d003        beq.n	0x2dd9e
@   0x0802dd96: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802dd98: 2180        movs	r1, #128	@ 0x80
@   0x0802dd9a: 4308        orrs	r0, r1
@   0x0802dd9c: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802dd9e: 2c7f        cmp	r4, #127	@ 0x7f
@   0x0802dda0: dd00        ble.n	0x2dda4
@   0x0802dda2: 2480        movs	r4, #128	@ 0x80
@   0x0802dda4: 1c20        adds	r0, r4, #0
@   0x0802dda6: bc70        pop	{r4, r5, r6}
@   0x0802dda8: bc02        pop	{r1}
@   0x0802ddaa: 4708        bx	r1
@   0x0802ddac: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802ddb0: b510        push	{r4, lr}
@   0x0802ddb2: 1c03        adds	r3, r0, #0
@   0x0802ddb4: 2b00        cmp	r3, #0
@   0x0802ddb6: d00d        beq.n	0x2ddd4
@   0x0802ddb8: 0c1a        lsrs	r2, r3, #16
@   0x0802ddba: 20ff        movs	r0, #255	@ 0xff
@   0x0802ddbc: 4002        ands	r2, r0
@   0x0802ddbe: 4807        ldr	r0, [pc, #28]	@ (0x2dddc)
@   0x0802ddc0: 6804        ldr	r4, [r0, #0]
@   0x0802ddc2: 2190        movs	r1, #144	@ 0x90
@   0x0802ddc4: 0049        lsls	r1, r1, #1
@   0x0802ddc6: 1860        adds	r0, r4, r1
@   0x0802ddc8: 6801        ldr	r1, [r0, #0]
@   0x0802ddca: 0090        lsls	r0, r2, #2
@   0x0802ddcc: 1840        adds	r0, r0, r1
@   0x0802ddce: 6800        ldr	r0, [r0, #0]
@   0x0802ddd0: 4298        cmp	r0, r3
@   0x0802ddd2: d005        beq.n	0x2dde0
@   0x0802ddd4: 2001        movs	r0, #1
@   0x0802ddd6: 4240        negs	r0, r0
@   0x0802ddd8: e021        b.n	0x2de1e
@   0x0802ddda: 0000        movs	r0, r0
@   0x0802dddc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ddde: 0300        lsls	r0, r0, #12
@   0x0802dde0: 2a03        cmp	r2, #3
@   0x0802dde2: dc12        bgt.n	0x2de0a
@   0x0802dde4: 2088        movs	r0, #136	@ 0x88
@   0x0802dde6: 0540        lsls	r0, r0, #21
@   0x0802dde8: 4090        lsls	r0, r2
@   0x0802ddea: 0e00        lsrs	r0, r0, #24
@   0x0802ddec: 1c21        adds	r1, r4, #0
@   0x0802ddee: 31ba        adds	r1, #186	@ 0xba
@   0x0802ddf0: 7809        ldrb	r1, [r1, #0]
@   0x0802ddf2: 4008        ands	r0, r1
@   0x0802ddf4: 4110        asrs	r0, r2
@   0x0802ddf6: 0600        lsls	r0, r0, #24
@   0x0802ddf8: 0e01        lsrs	r1, r0, #24
@   0x0802ddfa: 202a        movs	r0, #42	@ 0x2a
@   0x0802ddfc: 2910        cmp	r1, #16
@   0x0802ddfe: d00b        beq.n	0x2de18
@   0x0802de00: 2040        movs	r0, #64	@ 0x40
@   0x0802de02: 2901        cmp	r1, #1
@   0x0802de04: d108        bne.n	0x2de18
@   0x0802de06: 2055        movs	r0, #85	@ 0x55
@   0x0802de08: e006        b.n	0x2de18
@   0x0802de0a: 1c20        adds	r0, r4, #0
@   0x0802de0c: 30c8        adds	r0, #200	@ 0xc8
@   0x0802de0e: 0191        lsls	r1, r2, #6
@   0x0802de10: 6800        ldr	r0, [r0, #0]
@   0x0802de12: 1809        adds	r1, r1, r0
@   0x0802de14: 39c4        subs	r1, #196	@ 0xc4
@   0x0802de16: 7808        ldrb	r0, [r1, #0]
@   0x0802de18: 287f        cmp	r0, #127	@ 0x7f
@   0x0802de1a: dd00        ble.n	0x2de1e
@   0x0802de1c: 2080        movs	r0, #128	@ 0x80
@   0x0802de1e: bc10        pop	{r4}
@   0x0802de20: bc02        pop	{r1}
@   0x0802de22: 4708        bx	r1

        thumb_func_start sub_0802DCBC
sub_0802DCBC: @ 0x0802dcbc
        .incbin "frog_us_baserom.gba", 0x2dcbc, 0x168
        thumb_func_end sub_0802DCBC
