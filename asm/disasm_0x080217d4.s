@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080217d4, 0x08021838)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80217d4 --end 0x8021838 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080217d4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080217d6: 1c04        adds	r4, r0, #0
@   0x080217d8: 0609        lsls	r1, r1, #24
@   0x080217da: 0e09        lsrs	r1, r1, #24
@   0x080217dc: 0612        lsls	r2, r2, #24
@   0x080217de: 0e15        lsrs	r5, r2, #24
@   0x080217e0: 2200        movs	r2, #0
@   0x080217e2: 00c8        lsls	r0, r1, #3
@   0x080217e4: 1903        adds	r3, r0, r4
@   0x080217e6: 00e8        lsls	r0, r5, #3
@   0x080217e8: 1900        adds	r0, r0, r4
@   0x080217ea: 881e        ldrh	r6, [r3, #0]
@   0x080217ec: 8807        ldrh	r7, [r0, #0]
@   0x080217ee: 42be        cmp	r6, r7
@   0x080217f0: d10a        bne.n	0x21808
@   0x080217f2: 2602        movs	r6, #2
@   0x080217f4: 5f9b        ldrsh	r3, [r3, r6]
@   0x080217f6: 2702        movs	r7, #2
@   0x080217f8: 5fc0        ldrsh	r0, [r0, r7]
@   0x080217fa: 4283        cmp	r3, r0
@   0x080217fc: da01        bge.n	0x21802
@   0x080217fe: 2202        movs	r2, #2
@   0x08021800: e002        b.n	0x21808
@   0x08021802: 4283        cmp	r3, r0
@   0x08021804: dd00        ble.n	0x21808
@   0x08021806: 2201        movs	r2, #1
@   0x08021808: 00c8        lsls	r0, r1, #3
@   0x0802180a: 1901        adds	r1, r0, r4
@   0x0802180c: 00e8        lsls	r0, r5, #3
@   0x0802180e: 1900        adds	r0, r0, r4
@   0x08021810: 884b        ldrh	r3, [r1, #2]
@   0x08021812: 8844        ldrh	r4, [r0, #2]
@   0x08021814: 42a3        cmp	r3, r4
@   0x08021816: d10a        bne.n	0x2182e
@   0x08021818: 2600        movs	r6, #0
@   0x0802181a: 5f89        ldrsh	r1, [r1, r6]
@   0x0802181c: 2700        movs	r7, #0
@   0x0802181e: 5fc0        ldrsh	r0, [r0, r7]
@   0x08021820: 4281        cmp	r1, r0
@   0x08021822: da01        bge.n	0x21828
@   0x08021824: 2204        movs	r2, #4
@   0x08021826: e002        b.n	0x2182e
@   0x08021828: 4281        cmp	r1, r0
@   0x0802182a: dd00        ble.n	0x2182e
@   0x0802182c: 2203        movs	r2, #3
@   0x0802182e: 1c10        adds	r0, r2, #0
@   0x08021830: bcf0        pop	{r4, r5, r6, r7}
@   0x08021832: bc02        pop	{r1}
@   0x08021834: 4708        bx	r1

        thumb_func_start sub_080217D4
sub_080217D4: @ 0x080217d4
        .incbin "frog_us_baserom.gba", 0x217d4, 0x64
        thumb_func_end sub_080217D4
