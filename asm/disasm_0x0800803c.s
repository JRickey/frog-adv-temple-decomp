@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800803c, 0x08008174)  (312 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800803c --end 0x8008174 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800803c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800803e: 0400        lsls	r0, r0, #16
@   0x08008040: 0409        lsls	r1, r1, #16
@   0x08008042: 0c0c        lsrs	r4, r1, #16
@   0x08008044: 0412        lsls	r2, r2, #16
@   0x08008046: 041b        lsls	r3, r3, #16
@   0x08008048: 0c1f        lsrs	r7, r3, #16
@   0x0800804a: 0c06        lsrs	r6, r0, #16
@   0x0800804c: 1401        asrs	r1, r0, #16
@   0x0800804e: 0c13        lsrs	r3, r2, #16
@   0x08008050: 1410        asrs	r0, r2, #16
@   0x08008052: 4d06        ldr	r5, [pc, #24]	@ (0x806c)
@   0x08008054: 4281        cmp	r1, r0
@   0x08008056: dd1f        ble.n	0x8098
@   0x08008058: 1a08        subs	r0, r1, r0
@   0x0800805a: 0400        lsls	r0, r0, #16
@   0x0800805c: 1400        asrs	r0, r0, #16
@   0x0800805e: 2802        cmp	r0, #2
@   0x08008060: d00d        beq.n	0x807e
@   0x08008062: 2802        cmp	r0, #2
@   0x08008064: dc04        bgt.n	0x8070
@   0x08008066: 2801        cmp	r0, #1
@   0x08008068: d005        beq.n	0x8076
@   0x0800806a: e010        b.n	0x808e
@   0x0800806c: 3720        adds	r7, #32
@   0x0800806e: 0300        lsls	r0, r0, #12
@   0x08008070: 2803        cmp	r0, #3
@   0x08008072: d008        beq.n	0x8086
@   0x08008074: e00b        b.n	0x808e
@   0x08008076: 8868        ldrh	r0, [r5, #2]
@   0x08008078: 3801        subs	r0, #1
@   0x0800807a: 8068        strh	r0, [r5, #2]
@   0x0800807c: e00c        b.n	0x8098
@   0x0800807e: 8868        ldrh	r0, [r5, #2]
@   0x08008080: 3802        subs	r0, #2
@   0x08008082: 8068        strh	r0, [r5, #2]
@   0x08008084: e008        b.n	0x8098
@   0x08008086: 8868        ldrh	r0, [r5, #2]
@   0x08008088: 3803        subs	r0, #3
@   0x0800808a: 8068        strh	r0, [r5, #2]
@   0x0800808c: e004        b.n	0x8098
@   0x0800808e: 480b        ldr	r0, [pc, #44]	@ (0x80bc)
@   0x08008090: 8841        ldrh	r1, [r0, #2]
@   0x08008092: 3904        subs	r1, #4
@   0x08008094: 8041        strh	r1, [r0, #2]
@   0x08008096: 1c05        adds	r5, r0, #0
@   0x08008098: 0430        lsls	r0, r6, #16
@   0x0800809a: 1402        asrs	r2, r0, #16
@   0x0800809c: 0418        lsls	r0, r3, #16
@   0x0800809e: 1401        asrs	r1, r0, #16
@   0x080080a0: 4684        mov	ip, r0
@   0x080080a2: 428a        cmp	r2, r1
@   0x080080a4: da1b        bge.n	0x80de
@   0x080080a6: 1a88        subs	r0, r1, r2
@   0x080080a8: 0400        lsls	r0, r0, #16
@   0x080080aa: 1400        asrs	r0, r0, #16
@   0x080080ac: 2802        cmp	r0, #2
@   0x080080ae: d00d        beq.n	0x80cc
@   0x080080b0: 2802        cmp	r0, #2
@   0x080080b2: dc05        bgt.n	0x80c0
@   0x080080b4: 2801        cmp	r0, #1
@   0x080080b6: d006        beq.n	0x80c6
@   0x080080b8: e00e        b.n	0x80d8
@   0x080080ba: 0000        movs	r0, r0
@   0x080080bc: 3720        adds	r7, #32
@   0x080080be: 0300        lsls	r0, r0, #12
@   0x080080c0: 2803        cmp	r0, #3
@   0x080080c2: d006        beq.n	0x80d2
@   0x080080c4: e008        b.n	0x80d8
@   0x080080c6: 8868        ldrh	r0, [r5, #2]
@   0x080080c8: 3001        adds	r0, #1
@   0x080080ca: e007        b.n	0x80dc
@   0x080080cc: 8868        ldrh	r0, [r5, #2]
@   0x080080ce: 3002        adds	r0, #2
@   0x080080d0: e004        b.n	0x80dc
@   0x080080d2: 8868        ldrh	r0, [r5, #2]
@   0x080080d4: 3003        adds	r0, #3
@   0x080080d6: e001        b.n	0x80dc
@   0x080080d8: 8868        ldrh	r0, [r5, #2]
@   0x080080da: 3004        adds	r0, #4
@   0x080080dc: 8068        strh	r0, [r5, #2]
@   0x080080de: 0421        lsls	r1, r4, #16
@   0x080080e0: 140b        asrs	r3, r1, #16
@   0x080080e2: 0438        lsls	r0, r7, #16
@   0x080080e4: 1402        asrs	r2, r0, #16
@   0x080080e6: 1c06        adds	r6, r0, #0
@   0x080080e8: 4293        cmp	r3, r2
@   0x080080ea: dd18        ble.n	0x811e
@   0x080080ec: 1a98        subs	r0, r3, r2
@   0x080080ee: 0400        lsls	r0, r0, #16
@   0x080080f0: 1400        asrs	r0, r0, #16
@   0x080080f2: 2802        cmp	r0, #2
@   0x080080f4: d00a        beq.n	0x810c
@   0x080080f6: 2802        cmp	r0, #2
@   0x080080f8: dc02        bgt.n	0x8100
@   0x080080fa: 2801        cmp	r0, #1
@   0x080080fc: d003        beq.n	0x8106
@   0x080080fe: e00b        b.n	0x8118
@   0x08008100: 2803        cmp	r0, #3
@   0x08008102: d006        beq.n	0x8112
@   0x08008104: e008        b.n	0x8118
@   0x08008106: 88a8        ldrh	r0, [r5, #4]
@   0x08008108: 3801        subs	r0, #1
@   0x0800810a: e007        b.n	0x811c
@   0x0800810c: 88a8        ldrh	r0, [r5, #4]
@   0x0800810e: 3802        subs	r0, #2
@   0x08008110: e004        b.n	0x811c
@   0x08008112: 88a8        ldrh	r0, [r5, #4]
@   0x08008114: 3803        subs	r0, #3
@   0x08008116: e001        b.n	0x811c
@   0x08008118: 88a8        ldrh	r0, [r5, #4]
@   0x0800811a: 3804        subs	r0, #4
@   0x0800811c: 80a8        strh	r0, [r5, #4]
@   0x0800811e: 1409        asrs	r1, r1, #16
@   0x08008120: 1430        asrs	r0, r6, #16
@   0x08008122: 4281        cmp	r1, r0
@   0x08008124: da18        bge.n	0x8158
@   0x08008126: 1a40        subs	r0, r0, r1
@   0x08008128: 0400        lsls	r0, r0, #16
@   0x0800812a: 1400        asrs	r0, r0, #16
@   0x0800812c: 2802        cmp	r0, #2
@   0x0800812e: d00a        beq.n	0x8146
@   0x08008130: 2802        cmp	r0, #2
@   0x08008132: dc02        bgt.n	0x813a
@   0x08008134: 2801        cmp	r0, #1
@   0x08008136: d003        beq.n	0x8140
@   0x08008138: e00b        b.n	0x8152
@   0x0800813a: 2803        cmp	r0, #3
@   0x0800813c: d006        beq.n	0x814c
@   0x0800813e: e008        b.n	0x8152
@   0x08008140: 88a8        ldrh	r0, [r5, #4]
@   0x08008142: 3001        adds	r0, #1
@   0x08008144: e007        b.n	0x8156
@   0x08008146: 88a8        ldrh	r0, [r5, #4]
@   0x08008148: 3002        adds	r0, #2
@   0x0800814a: e004        b.n	0x8156
@   0x0800814c: 88a8        ldrh	r0, [r5, #4]
@   0x0800814e: 3003        adds	r0, #3
@   0x08008150: e001        b.n	0x8156
@   0x08008152: 88a8        ldrh	r0, [r5, #4]
@   0x08008154: 3004        adds	r0, #4
@   0x08008156: 80a8        strh	r0, [r5, #4]
@   0x08008158: 88ac        ldrh	r4, [r5, #4]
@   0x0800815a: 886d        ldrh	r5, [r5, #2]
@   0x0800815c: 0428        lsls	r0, r5, #16
@   0x0800815e: 4560        cmp	r0, ip
@   0x08008160: d102        bne.n	0x8168
@   0x08008162: 0420        lsls	r0, r4, #16
@   0x08008164: 42b0        cmp	r0, r6
@   0x08008166: d001        beq.n	0x816c
@   0x08008168: 2000        movs	r0, #0
@   0x0800816a: e000        b.n	0x816e
@   0x0800816c: 2001        movs	r0, #1
@   0x0800816e: bcf0        pop	{r4, r5, r6, r7}
@   0x08008170: bc02        pop	{r1}
@   0x08008172: 4708        bx	r1

        thumb_func_start sub_0800803C
sub_0800803C: @ 0x0800803c
        .incbin "frog_us_baserom.gba", 0x803c, 0x138
        thumb_func_end sub_0800803C
