@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800af50, 0x0800b07c)  (300 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800af50 --end 0x800b07c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800af50: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800af52: 4657        mov	r7, sl
@   0x0800af54: 464e        mov	r6, r9
@   0x0800af56: 4645        mov	r5, r8
@   0x0800af58: b4e0        push	{r5, r6, r7}
@   0x0800af5a: b082        sub	sp, #8
@   0x0800af5c: 9001        str	r0, [sp, #4]
@   0x0800af5e: 2518        movs	r5, #24
@   0x0800af60: 2000        movs	r0, #0
@   0x0800af62: 4681        mov	r9, r0
@   0x0800af64: 4649        mov	r1, r9
@   0x0800af66: 0408        lsls	r0, r1, #16
@   0x0800af68: 1340        asrs	r0, r0, #13
@   0x0800af6a: 9a01        ldr	r2, [sp, #4]
@   0x0800af6c: 1880        adds	r0, r0, r2
@   0x0800af6e: 2100        movs	r1, #0
@   0x0800af70: 7101        strb	r1, [r0, #4]
@   0x0800af72: 7141        strb	r1, [r0, #5]
@   0x0800af74: 7181        strb	r1, [r0, #6]
@   0x0800af76: 6001        str	r1, [r0, #0]
@   0x0800af78: 4688        mov	r8, r1
@   0x0800af7a: 062e        lsls	r6, r5, #24
@   0x0800af7c: 1631        asrs	r1, r6, #24
@   0x0800af7e: 0048        lsls	r0, r1, #1
@   0x0800af80: 1840        adds	r0, r0, r1
@   0x0800af82: 0080        lsls	r0, r0, #2
@   0x0800af84: 493a        ldr	r1, [pc, #232]	@ (0xb070)
@   0x0800af86: 1840        adds	r0, r0, r1
@   0x0800af88: 7800        ldrb	r0, [r0, #0]
@   0x0800af8a: 0600        lsls	r0, r0, #24
@   0x0800af8c: 1600        asrs	r0, r0, #24
@   0x0800af8e: 46b2        mov	sl, r6
@   0x0800af90: 4580        cmp	r8, r0
@   0x0800af92: da28        bge.n	0xafe6
@   0x0800af94: 1c0f        adds	r7, r1, #0
@   0x0800af96: 1635        asrs	r5, r6, #24
@   0x0800af98: 4836        ldr	r0, [pc, #216]	@ (0xb074)
@   0x0800af9a: 7e00        ldrb	r0, [r0, #24]
@   0x0800af9c: 4642        mov	r2, r8
@   0x0800af9e: 0613        lsls	r3, r2, #24
@   0x0800afa0: 006c        lsls	r4, r5, #1
@   0x0800afa2: 1964        adds	r4, r4, r5
@   0x0800afa4: 00a4        lsls	r4, r4, #2
@   0x0800afa6: 1d39        adds	r1, r7, #4
@   0x0800afa8: 1861        adds	r1, r4, r1
@   0x0800afaa: 6809        ldr	r1, [r1, #0]
@   0x0800afac: 0d9b        lsrs	r3, r3, #22
@   0x0800afae: 185b        adds	r3, r3, r1
@   0x0800afb0: 2100        movs	r1, #0
@   0x0800afb2: 5e5a        ldrsh	r2, [r3, r1]
@   0x0800afb4: 2102        movs	r1, #2
@   0x0800afb6: 5e5b        ldrsh	r3, [r3, r1]
@   0x0800afb8: 19e4        adds	r4, r4, r7
@   0x0800afba: 7a21        ldrb	r1, [r4, #8]
@   0x0800afbc: 9100        str	r1, [sp, #0]
@   0x0800afbe: 2100        movs	r1, #0
@   0x0800afc0: f001        fdde 	bl	0xcb80
@   0x0800afc4: 4642        mov	r2, r8
@   0x0800afc6: 0411        lsls	r1, r2, #16
@   0x0800afc8: 2080        movs	r0, #128	@ 0x80
@   0x0800afca: 0240        lsls	r0, r0, #9
@   0x0800afcc: 1809        adds	r1, r1, r0
@   0x0800afce: 0068        lsls	r0, r5, #1
@   0x0800afd0: 1940        adds	r0, r0, r5
@   0x0800afd2: 0080        lsls	r0, r0, #2
@   0x0800afd4: 19c0        adds	r0, r0, r7
@   0x0800afd6: 0c0a        lsrs	r2, r1, #16
@   0x0800afd8: 4690        mov	r8, r2
@   0x0800afda: 1409        asrs	r1, r1, #16
@   0x0800afdc: 7800        ldrb	r0, [r0, #0]
@   0x0800afde: 0600        lsls	r0, r0, #24
@   0x0800afe0: 1600        asrs	r0, r0, #24
@   0x0800afe2: 4281        cmp	r1, r0
@   0x0800afe4: dbd7        blt.n	0xaf96
@   0x0800afe6: 4648        mov	r0, r9
@   0x0800afe8: 0401        lsls	r1, r0, #16
@   0x0800afea: 2280        movs	r2, #128	@ 0x80
@   0x0800afec: 0252        lsls	r2, r2, #9
@   0x0800afee: 1889        adds	r1, r1, r2
@   0x0800aff0: 2080        movs	r0, #128	@ 0x80
@   0x0800aff2: 0440        lsls	r0, r0, #17
@   0x0800aff4: 4450        add	r0, sl
@   0x0800aff6: 0e05        lsrs	r5, r0, #24
@   0x0800aff8: 0c08        lsrs	r0, r1, #16
@   0x0800affa: 4681        mov	r9, r0
@   0x0800affc: 1409        asrs	r1, r1, #16
@   0x0800affe: 2903        cmp	r1, #3
@   0x0800b000: ddb0        ble.n	0xaf64
@   0x0800b002: 2100        movs	r1, #0
@   0x0800b004: 4689        mov	r9, r1
@   0x0800b006: 4b1c        ldr	r3, [pc, #112]	@ (0xb078)
@   0x0800b008: 2201        movs	r2, #1
@   0x0800b00a: 4649        mov	r1, r9
@   0x0800b00c: 0408        lsls	r0, r1, #16
@   0x0800b00e: 1400        asrs	r0, r0, #16
@   0x0800b010: 18c1        adds	r1, r0, r3
@   0x0800b012: 700a        strb	r2, [r1, #0]
@   0x0800b014: 3001        adds	r0, #1
@   0x0800b016: 0400        lsls	r0, r0, #16
@   0x0800b018: 0c01        lsrs	r1, r0, #16
@   0x0800b01a: 4689        mov	r9, r1
@   0x0800b01c: 1400        asrs	r0, r0, #16
@   0x0800b01e: 28fe        cmp	r0, #254	@ 0xfe
@   0x0800b020: ddf3        ble.n	0xb00a
@   0x0800b022: 2200        movs	r2, #0
@   0x0800b024: 4691        mov	r9, r2
@   0x0800b026: 4c14        ldr	r4, [pc, #80]	@ (0xb078)
@   0x0800b028: 2300        movs	r3, #0
@   0x0800b02a: 4648        mov	r0, r9
@   0x0800b02c: 0402        lsls	r2, r0, #16
@   0x0800b02e: 1412        asrs	r2, r2, #16
@   0x0800b030: 1c10        adds	r0, r2, #0
@   0x0800b032: 302a        adds	r0, #42	@ 0x2a
@   0x0800b034: 1900        adds	r0, r0, r4
@   0x0800b036: 7003        strb	r3, [r0, #0]
@   0x0800b038: 1c10        adds	r0, r2, #0
@   0x0800b03a: 309a        adds	r0, #154	@ 0x9a
@   0x0800b03c: 1900        adds	r0, r0, r4
@   0x0800b03e: 7003        strb	r3, [r0, #0]
@   0x0800b040: 00d1        lsls	r1, r2, #3
@   0x0800b042: 1a89        subs	r1, r1, r2
@   0x0800b044: 0049        lsls	r1, r1, #1
@   0x0800b046: 1c48        adds	r0, r1, #1
@   0x0800b048: 1900        adds	r0, r0, r4
@   0x0800b04a: 7003        strb	r3, [r0, #0]
@   0x0800b04c: 310c        adds	r1, #12
@   0x0800b04e: 1909        adds	r1, r1, r4
@   0x0800b050: 700b        strb	r3, [r1, #0]
@   0x0800b052: 3201        adds	r2, #1
@   0x0800b054: 0412        lsls	r2, r2, #16
@   0x0800b056: 0c11        lsrs	r1, r2, #16
@   0x0800b058: 4689        mov	r9, r1
@   0x0800b05a: 1412        asrs	r2, r2, #16
@   0x0800b05c: 2a0d        cmp	r2, #13
@   0x0800b05e: dde4        ble.n	0xb02a
@   0x0800b060: b002        add	sp, #8
@   0x0800b062: bc38        pop	{r3, r4, r5}
@   0x0800b064: 4698        mov	r8, r3
@   0x0800b066: 46a1        mov	r9, r4
@   0x0800b068: 46aa        mov	sl, r5
@   0x0800b06a: bcf0        pop	{r4, r5, r6, r7}
@   0x0800b06c: bc01        pop	{r0}
@   0x0800b06e: 4700        bx	r0
@   0x0800b070: 0b00        lsrs	r0, r0, #12
@   0x0800b072: 080c        lsrs	r4, r1, #32
@   0x0800b074: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b076: 0300        lsls	r0, r0, #12
@   0x0800b078: 3610        adds	r6, #16
@   0x0800b07a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800AF50
sub_0800AF50: @ 0x0800af50
        .incbin "frog_us_baserom.gba", 0xaf50, 0x12c
        thumb_func_end sub_0800AF50
