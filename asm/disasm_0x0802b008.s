@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802b008, 0x0802b2ec)  (740 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802b008 --end 0x802b2ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802b008: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802b00a: 4657        mov	r7, sl
@   0x0802b00c: 464e        mov	r6, r9
@   0x0802b00e: 4645        mov	r5, r8
@   0x0802b010: b4e0        push	{r5, r6, r7}
@   0x0802b012: b082        sub	sp, #8
@   0x0802b014: 9301        str	r3, [sp, #4]
@   0x0802b016: 0400        lsls	r0, r0, #16
@   0x0802b018: 0409        lsls	r1, r1, #16
@   0x0802b01a: 0612        lsls	r2, r2, #24
@   0x0802b01c: 0e12        lsrs	r2, r2, #24
@   0x0802b01e: 4692        mov	sl, r2
@   0x0802b020: 0c02        lsrs	r2, r0, #16
@   0x0802b022: 4690        mov	r8, r2
@   0x0802b024: 1404        asrs	r4, r0, #16
@   0x0802b026: 0c0b        lsrs	r3, r1, #16
@   0x0802b028: 4699        mov	r9, r3
@   0x0802b02a: 140d        asrs	r5, r1, #16
@   0x0802b02c: 1c20        adds	r0, r4, #0
@   0x0802b02e: 1c29        adds	r1, r5, #0
@   0x0802b030: f7e2        f91e 	bl	0xd270
@   0x0802b034: 0600        lsls	r0, r0, #24
@   0x0802b036: 0e00        lsrs	r0, r0, #24
@   0x0802b038: 2801        cmp	r0, #1
@   0x0802b03a: d125        bne.n	0x2b088
@   0x0802b03c: 0060        lsls	r0, r4, #1
@   0x0802b03e: 1900        adds	r0, r0, r4
@   0x0802b040: 04c0        lsls	r0, r0, #19
@   0x0802b042: 21b0        movs	r1, #176	@ 0xb0
@   0x0802b044: 0309        lsls	r1, r1, #12
@   0x0802b046: 1840        adds	r0, r0, r1
@   0x0802b048: 0069        lsls	r1, r5, #1
@   0x0802b04a: 1949        adds	r1, r1, r5
@   0x0802b04c: 04c9        lsls	r1, r1, #19
@   0x0802b04e: 4a06        ldr	r2, [pc, #24]	@ (0x2b068)
@   0x0802b050: 1889        adds	r1, r1, r2
@   0x0802b052: 0c00        lsrs	r0, r0, #16
@   0x0802b054: 4308        orrs	r0, r1
@   0x0802b056: 9000        str	r0, [sp, #0]
@   0x0802b058: 466a        mov	r2, sp
@   0x0802b05a: 4668        mov	r0, sp
@   0x0802b05c: 2300        movs	r3, #0
@   0x0802b05e: 5ec0        ldrsh	r0, [r0, r3]
@   0x0802b060: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b062: dc03        bgt.n	0x2b06c
@   0x0802b064: 213b        movs	r1, #59	@ 0x3b
@   0x0802b066: e004        b.n	0x2b072
@   0x0802b068: 0000        movs	r0, r0
@   0x0802b06a: fff9        4905 	vtbl.8	d20, {d9-d10}, d5
@   0x0802b06e: 4288        cmp	r0, r1
@   0x0802b070: dd01        ble.n	0x2b076
@   0x0802b072: 4668        mov	r0, sp
@   0x0802b074: 8001        strh	r1, [r0, #0]
@   0x0802b076: 8850        ldrh	r0, [r2, #2]
@   0x0802b078: 0400        lsls	r0, r0, #16
@   0x0802b07a: 1400        asrs	r0, r0, #16
@   0x0802b07c: 2858        cmp	r0, #88	@ 0x58
@   0x0802b07e: dc00        bgt.n	0x2b082
@   0x0802b080: e11d        b.n	0x2b2be
@   0x0802b082: e121        b.n	0x2b2c8
@   0x0802b084: 012b        lsls	r3, r5, #4
@   0x0802b086: 0000        movs	r0, r0
@   0x0802b088: 2701        movs	r7, #1
@   0x0802b08a: 4557        cmp	r7, sl
@   0x0802b08c: d300        bcc.n	0x2b090
@   0x0802b08e: e0cf        b.n	0x2b230
@   0x0802b090: 1c2e        adds	r6, r5, #0
@   0x0802b092: 466d        mov	r5, sp
@   0x0802b094: 4642        mov	r2, r8
@   0x0802b096: 1bd0        subs	r0, r2, r7
@   0x0802b098: 0400        lsls	r0, r0, #16
@   0x0802b09a: 1400        asrs	r0, r0, #16
@   0x0802b09c: 1c31        adds	r1, r6, #0
@   0x0802b09e: f7e2        f8e7 	bl	0xd270
@   0x0802b0a2: 0600        lsls	r0, r0, #24
@   0x0802b0a4: 0e00        lsrs	r0, r0, #24
@   0x0802b0a6: 2801        cmp	r0, #1
@   0x0802b0a8: d128        bne.n	0x2b0fc
@   0x0802b0aa: 4643        mov	r3, r8
@   0x0802b0ac: 0418        lsls	r0, r3, #16
@   0x0802b0ae: 1400        asrs	r0, r0, #16
@   0x0802b0b0: 1bc0        subs	r0, r0, r7
@   0x0802b0b2: 0041        lsls	r1, r0, #1
@   0x0802b0b4: 1809        adds	r1, r1, r0
@   0x0802b0b6: 00c9        lsls	r1, r1, #3
@   0x0802b0b8: 310b        adds	r1, #11
@   0x0802b0ba: 8029        strh	r1, [r5, #0]
@   0x0802b0bc: 0070        lsls	r0, r6, #1
@   0x0802b0be: 1980        adds	r0, r0, r6
@   0x0802b0c0: 00c0        lsls	r0, r0, #3
@   0x0802b0c2: 3807        subs	r0, #7
@   0x0802b0c4: 8068        strh	r0, [r5, #2]
@   0x0802b0c6: 466a        mov	r2, sp
@   0x0802b0c8: 0409        lsls	r1, r1, #16
@   0x0802b0ca: 1408        asrs	r0, r1, #16
@   0x0802b0cc: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b0ce: dc02        bgt.n	0x2b0d6
@   0x0802b0d0: 203b        movs	r0, #59	@ 0x3b
@   0x0802b0d2: 8028        strh	r0, [r5, #0]
@   0x0802b0d4: e004        b.n	0x2b0e0
@   0x0802b0d6: 4b07        ldr	r3, [pc, #28]	@ (0x2b0f4)
@   0x0802b0d8: 1419        asrs	r1, r3, #16
@   0x0802b0da: 4288        cmp	r0, r1
@   0x0802b0dc: dd00        ble.n	0x2b0e0
@   0x0802b0de: 8029        strh	r1, [r5, #0]
@   0x0802b0e0: 8850        ldrh	r0, [r2, #2]
@   0x0802b0e2: 0400        lsls	r0, r0, #16
@   0x0802b0e4: 1400        asrs	r0, r0, #16
@   0x0802b0e6: 2858        cmp	r0, #88	@ 0x58
@   0x0802b0e8: dc00        bgt.n	0x2b0ec
@   0x0802b0ea: e0e8        b.n	0x2b2be
@   0x0802b0ec: 4b02        ldr	r3, [pc, #8]	@ (0x2b0f8)
@   0x0802b0ee: 1419        asrs	r1, r3, #16
@   0x0802b0f0: e0eb        b.n	0x2b2ca
@   0x0802b0f2: 0000        movs	r0, r0
@   0x0802b0f4: 0000        movs	r0, r0
@   0x0802b0f6: 012b        lsls	r3, r5, #4
@   0x0802b0f8: 0000        movs	r0, r0
@   0x0802b0fa: 0149        lsls	r1, r1, #5
@   0x0802b0fc: 4642        mov	r2, r8
@   0x0802b0fe: 0410        lsls	r0, r2, #16
@   0x0802b100: 1404        asrs	r4, r0, #16
@   0x0802b102: 464b        mov	r3, r9
@   0x0802b104: 1bd9        subs	r1, r3, r7
@   0x0802b106: 0409        lsls	r1, r1, #16
@   0x0802b108: 1409        asrs	r1, r1, #16
@   0x0802b10a: 1c20        adds	r0, r4, #0
@   0x0802b10c: f7e2        f8b0 	bl	0xd270
@   0x0802b110: 0600        lsls	r0, r0, #24
@   0x0802b112: 0e00        lsrs	r0, r0, #24
@   0x0802b114: 2801        cmp	r0, #1
@   0x0802b116: d125        bne.n	0x2b164
@   0x0802b118: 0060        lsls	r0, r4, #1
@   0x0802b11a: 1900        adds	r0, r0, r4
@   0x0802b11c: 00c0        lsls	r0, r0, #3
@   0x0802b11e: 300b        adds	r0, #11
@   0x0802b120: 8028        strh	r0, [r5, #0]
@   0x0802b122: 1bf2        subs	r2, r6, r7
@   0x0802b124: 0051        lsls	r1, r2, #1
@   0x0802b126: 1889        adds	r1, r1, r2
@   0x0802b128: 00c9        lsls	r1, r1, #3
@   0x0802b12a: 3907        subs	r1, #7
@   0x0802b12c: 8069        strh	r1, [r5, #2]
@   0x0802b12e: 466a        mov	r2, sp
@   0x0802b130: 0400        lsls	r0, r0, #16
@   0x0802b132: 1400        asrs	r0, r0, #16
@   0x0802b134: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b136: dc02        bgt.n	0x2b13e
@   0x0802b138: 203b        movs	r0, #59	@ 0x3b
@   0x0802b13a: 8028        strh	r0, [r5, #0]
@   0x0802b13c: e004        b.n	0x2b148
@   0x0802b13e: 4b07        ldr	r3, [pc, #28]	@ (0x2b15c)
@   0x0802b140: 1419        asrs	r1, r3, #16
@   0x0802b142: 4288        cmp	r0, r1
@   0x0802b144: dd00        ble.n	0x2b148
@   0x0802b146: 8029        strh	r1, [r5, #0]
@   0x0802b148: 8850        ldrh	r0, [r2, #2]
@   0x0802b14a: 0400        lsls	r0, r0, #16
@   0x0802b14c: 1400        asrs	r0, r0, #16
@   0x0802b14e: 2858        cmp	r0, #88	@ 0x58
@   0x0802b150: dc00        bgt.n	0x2b154
@   0x0802b152: e0b4        b.n	0x2b2be
@   0x0802b154: 4b02        ldr	r3, [pc, #8]	@ (0x2b160)
@   0x0802b156: 1419        asrs	r1, r3, #16
@   0x0802b158: e0b7        b.n	0x2b2ca
@   0x0802b15a: 0000        movs	r0, r0
@   0x0802b15c: 0000        movs	r0, r0
@   0x0802b15e: 012b        lsls	r3, r5, #4
@   0x0802b160: 0000        movs	r0, r0
@   0x0802b162: 0149        lsls	r1, r1, #5
@   0x0802b164: 4642        mov	r2, r8
@   0x0802b166: 19d0        adds	r0, r2, r7
@   0x0802b168: 0400        lsls	r0, r0, #16
@   0x0802b16a: 1400        asrs	r0, r0, #16
@   0x0802b16c: 1c31        adds	r1, r6, #0
@   0x0802b16e: f7e2        f87f 	bl	0xd270
@   0x0802b172: 0600        lsls	r0, r0, #24
@   0x0802b174: 0e00        lsrs	r0, r0, #24
@   0x0802b176: 2801        cmp	r0, #1
@   0x0802b178: d124        bne.n	0x2b1c4
@   0x0802b17a: 19e0        adds	r0, r4, r7
@   0x0802b17c: 0041        lsls	r1, r0, #1
@   0x0802b17e: 1809        adds	r1, r1, r0
@   0x0802b180: 00c9        lsls	r1, r1, #3
@   0x0802b182: 310b        adds	r1, #11
@   0x0802b184: 8029        strh	r1, [r5, #0]
@   0x0802b186: 0070        lsls	r0, r6, #1
@   0x0802b188: 1980        adds	r0, r0, r6
@   0x0802b18a: 00c0        lsls	r0, r0, #3
@   0x0802b18c: 3807        subs	r0, #7
@   0x0802b18e: 8068        strh	r0, [r5, #2]
@   0x0802b190: 466a        mov	r2, sp
@   0x0802b192: 0409        lsls	r1, r1, #16
@   0x0802b194: 1408        asrs	r0, r1, #16
@   0x0802b196: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b198: dc02        bgt.n	0x2b1a0
@   0x0802b19a: 203b        movs	r0, #59	@ 0x3b
@   0x0802b19c: 8028        strh	r0, [r5, #0]
@   0x0802b19e: e004        b.n	0x2b1aa
@   0x0802b1a0: 4b06        ldr	r3, [pc, #24]	@ (0x2b1bc)
@   0x0802b1a2: 1419        asrs	r1, r3, #16
@   0x0802b1a4: 4288        cmp	r0, r1
@   0x0802b1a6: dd00        ble.n	0x2b1aa
@   0x0802b1a8: 8029        strh	r1, [r5, #0]
@   0x0802b1aa: 8850        ldrh	r0, [r2, #2]
@   0x0802b1ac: 0400        lsls	r0, r0, #16
@   0x0802b1ae: 1400        asrs	r0, r0, #16
@   0x0802b1b0: 2858        cmp	r0, #88	@ 0x58
@   0x0802b1b2: dc00        bgt.n	0x2b1b6
@   0x0802b1b4: e083        b.n	0x2b2be
@   0x0802b1b6: 4b02        ldr	r3, [pc, #8]	@ (0x2b1c0)
@   0x0802b1b8: 1419        asrs	r1, r3, #16
@   0x0802b1ba: e086        b.n	0x2b2ca
@   0x0802b1bc: 0000        movs	r0, r0
@   0x0802b1be: 012b        lsls	r3, r5, #4
@   0x0802b1c0: 0000        movs	r0, r0
@   0x0802b1c2: 0149        lsls	r1, r1, #5
@   0x0802b1c4: 464a        mov	r2, r9
@   0x0802b1c6: 19d1        adds	r1, r2, r7
@   0x0802b1c8: 0409        lsls	r1, r1, #16
@   0x0802b1ca: 1409        asrs	r1, r1, #16
@   0x0802b1cc: 1c20        adds	r0, r4, #0
@   0x0802b1ce: f7e2        f84f 	bl	0xd270
@   0x0802b1d2: 0600        lsls	r0, r0, #24
@   0x0802b1d4: 0e00        lsrs	r0, r0, #24
@   0x0802b1d6: 2801        cmp	r0, #1
@   0x0802b1d8: d124        bne.n	0x2b224
@   0x0802b1da: 0060        lsls	r0, r4, #1
@   0x0802b1dc: 1900        adds	r0, r0, r4
@   0x0802b1de: 00c0        lsls	r0, r0, #3
@   0x0802b1e0: 300b        adds	r0, #11
@   0x0802b1e2: 8028        strh	r0, [r5, #0]
@   0x0802b1e4: 19f2        adds	r2, r6, r7
@   0x0802b1e6: 0051        lsls	r1, r2, #1
@   0x0802b1e8: 1889        adds	r1, r1, r2
@   0x0802b1ea: 00c9        lsls	r1, r1, #3
@   0x0802b1ec: 3907        subs	r1, #7
@   0x0802b1ee: 8069        strh	r1, [r5, #2]
@   0x0802b1f0: 466a        mov	r2, sp
@   0x0802b1f2: 0400        lsls	r0, r0, #16
@   0x0802b1f4: 1400        asrs	r0, r0, #16
@   0x0802b1f6: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b1f8: dc02        bgt.n	0x2b200
@   0x0802b1fa: 203b        movs	r0, #59	@ 0x3b
@   0x0802b1fc: 8028        strh	r0, [r5, #0]
@   0x0802b1fe: e004        b.n	0x2b20a
@   0x0802b200: 4b06        ldr	r3, [pc, #24]	@ (0x2b21c)
@   0x0802b202: 1419        asrs	r1, r3, #16
@   0x0802b204: 4288        cmp	r0, r1
@   0x0802b206: dd00        ble.n	0x2b20a
@   0x0802b208: 8029        strh	r1, [r5, #0]
@   0x0802b20a: 8850        ldrh	r0, [r2, #2]
@   0x0802b20c: 0400        lsls	r0, r0, #16
@   0x0802b20e: 1400        asrs	r0, r0, #16
@   0x0802b210: 2858        cmp	r0, #88	@ 0x58
@   0x0802b212: dd54        ble.n	0x2b2be
@   0x0802b214: 4b02        ldr	r3, [pc, #8]	@ (0x2b220)
@   0x0802b216: 1419        asrs	r1, r3, #16
@   0x0802b218: e057        b.n	0x2b2ca
@   0x0802b21a: 0000        movs	r0, r0
@   0x0802b21c: 0000        movs	r0, r0
@   0x0802b21e: 012b        lsls	r3, r5, #4
@   0x0802b220: 0000        movs	r0, r0
@   0x0802b222: 0149        lsls	r1, r1, #5
@   0x0802b224: 1c78        adds	r0, r7, #1
@   0x0802b226: 0600        lsls	r0, r0, #24
@   0x0802b228: 0e07        lsrs	r7, r0, #24
@   0x0802b22a: 4557        cmp	r7, sl
@   0x0802b22c: d200        bcs.n	0x2b230
@   0x0802b22e: e731        b.n	0x2b094
@   0x0802b230: 4652        mov	r2, sl
@   0x0802b232: 2a01        cmp	r2, #1
@   0x0802b234: d101        bne.n	0x2b23a
@   0x0802b236: 2000        movs	r0, #0
@   0x0802b238: e04e        b.n	0x2b2d8
@   0x0802b23a: 4643        mov	r3, r8
@   0x0802b23c: 0418        lsls	r0, r3, #16
@   0x0802b23e: 1404        asrs	r4, r0, #16
@   0x0802b240: 464a        mov	r2, r9
@   0x0802b242: 0411        lsls	r1, r2, #16
@   0x0802b244: 140b        asrs	r3, r1, #16
@   0x0802b246: 1c9a        adds	r2, r3, #2
@   0x0802b248: 1c06        adds	r6, r0, #0
@   0x0802b24a: 1c0d        adds	r5, r1, #0
@   0x0802b24c: 4294        cmp	r4, r2
@   0x0802b24e: dd12        ble.n	0x2b276
@   0x0802b250: 2c05        cmp	r4, #5
@   0x0802b252: dc01        bgt.n	0x2b258
@   0x0802b254: 1d20        adds	r0, r4, #4
@   0x0802b256: e000        b.n	0x2b25a
@   0x0802b258: 1ee0        subs	r0, r4, #3
@   0x0802b25a: 0041        lsls	r1, r0, #1
@   0x0802b25c: 1809        adds	r1, r1, r0
@   0x0802b25e: 00c9        lsls	r1, r1, #3
@   0x0802b260: 310b        adds	r1, #11
@   0x0802b262: 4668        mov	r0, sp
@   0x0802b264: 8001        strh	r1, [r0, #0]
@   0x0802b266: 1428        asrs	r0, r5, #16
@   0x0802b268: 0041        lsls	r1, r0, #1
@   0x0802b26a: 1809        adds	r1, r1, r0
@   0x0802b26c: 00c9        lsls	r1, r1, #3
@   0x0802b26e: 3907        subs	r1, #7
@   0x0802b270: 4668        mov	r0, sp
@   0x0802b272: 8041        strh	r1, [r0, #2]
@   0x0802b274: e011        b.n	0x2b29a
@   0x0802b276: 2b07        cmp	r3, #7
@   0x0802b278: dc01        bgt.n	0x2b27e
@   0x0802b27a: 1d18        adds	r0, r3, #4
@   0x0802b27c: e000        b.n	0x2b280
@   0x0802b27e: 1ed8        subs	r0, r3, #3
@   0x0802b280: 0041        lsls	r1, r0, #1
@   0x0802b282: 1809        adds	r1, r1, r0
@   0x0802b284: 00c9        lsls	r1, r1, #3
@   0x0802b286: 3907        subs	r1, #7
@   0x0802b288: 4668        mov	r0, sp
@   0x0802b28a: 8041        strh	r1, [r0, #2]
@   0x0802b28c: 1430        asrs	r0, r6, #16
@   0x0802b28e: 0041        lsls	r1, r0, #1
@   0x0802b290: 1809        adds	r1, r1, r0
@   0x0802b292: 00c9        lsls	r1, r1, #3
@   0x0802b294: 310b        adds	r1, #11
@   0x0802b296: 4668        mov	r0, sp
@   0x0802b298: 8001        strh	r1, [r0, #0]
@   0x0802b29a: 466a        mov	r2, sp
@   0x0802b29c: 4668        mov	r0, sp
@   0x0802b29e: 2300        movs	r3, #0
@   0x0802b2a0: 5ec0        ldrsh	r0, [r0, r3]
@   0x0802b2a2: 283a        cmp	r0, #58	@ 0x3a
@   0x0802b2a4: dc01        bgt.n	0x2b2aa
@   0x0802b2a6: 213b        movs	r1, #59	@ 0x3b
@   0x0802b2a8: e002        b.n	0x2b2b0
@   0x0802b2aa: 4906        ldr	r1, [pc, #24]	@ (0x2b2c4)
@   0x0802b2ac: 4288        cmp	r0, r1
@   0x0802b2ae: dd01        ble.n	0x2b2b4
@   0x0802b2b0: 4668        mov	r0, sp
@   0x0802b2b2: 8001        strh	r1, [r0, #0]
@   0x0802b2b4: 8850        ldrh	r0, [r2, #2]
@   0x0802b2b6: 0400        lsls	r0, r0, #16
@   0x0802b2b8: 1400        asrs	r0, r0, #16
@   0x0802b2ba: 2858        cmp	r0, #88	@ 0x58
@   0x0802b2bc: dc04        bgt.n	0x2b2c8
@   0x0802b2be: 2059        movs	r0, #89	@ 0x59
@   0x0802b2c0: 8050        strh	r0, [r2, #2]
@   0x0802b2c2: e005        b.n	0x2b2d0
@   0x0802b2c4: 012b        lsls	r3, r5, #4
@   0x0802b2c6: 0000        movs	r0, r0
@   0x0802b2c8: 4907        ldr	r1, [pc, #28]	@ (0x2b2e8)
@   0x0802b2ca: 4288        cmp	r0, r1
@   0x0802b2cc: dd00        ble.n	0x2b2d0
@   0x0802b2ce: 8051        strh	r1, [r2, #2]
@   0x0802b2d0: 9800        ldr	r0, [sp, #0]
@   0x0802b2d2: 9901        ldr	r1, [sp, #4]
@   0x0802b2d4: 6008        str	r0, [r1, #0]
@   0x0802b2d6: 2001        movs	r0, #1
@   0x0802b2d8: b002        add	sp, #8
@   0x0802b2da: bc38        pop	{r3, r4, r5}
@   0x0802b2dc: 4698        mov	r8, r3
@   0x0802b2de: 46a1        mov	r9, r4
@   0x0802b2e0: 46aa        mov	sl, r5
@   0x0802b2e2: bcf0        pop	{r4, r5, r6, r7}
@   0x0802b2e4: bc02        pop	{r1}
@   0x0802b2e6: 4708        bx	r1
@   0x0802b2e8: 0149        lsls	r1, r1, #5

        thumb_func_start sub_0802B008
sub_0802B008: @ 0x0802b008
        .incbin "baserom.gba", 0x2b008, 0x2e4
        thumb_func_end sub_0802B008
