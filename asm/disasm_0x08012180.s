@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012180, 0x0801223c)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012180 --end 0x801223c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012180: b570        push	{r4, r5, r6, lr}
@   0x08012182: 4a09        ldr	r2, [pc, #36]	@ (0x121a8)
@   0x08012184: 4b09        ldr	r3, [pc, #36]	@ (0x121ac)
@   0x08012186: 6811        ldr	r1, [r2, #0]
@   0x08012188: 6898        ldr	r0, [r3, #8]
@   0x0801218a: 1a09        subs	r1, r1, r0
@   0x0801218c: 1c16        adds	r6, r2, #0
@   0x0801218e: 1c1d        adds	r5, r3, #0
@   0x08012190: 7b28        ldrb	r0, [r5, #12]
@   0x08012192: 4281        cmp	r1, r0
@   0x08012194: d31e        bcc.n	0x121d4
@   0x08012196: 7828        ldrb	r0, [r5, #0]
@   0x08012198: 2801        cmp	r0, #1
@   0x0801219a: d00d        beq.n	0x121b8
@   0x0801219c: 2801        cmp	r0, #1
@   0x0801219e: dc07        bgt.n	0x121b0
@   0x080121a0: 2800        cmp	r0, #0
@   0x080121a2: d00c        beq.n	0x121be
@   0x080121a4: e014        b.n	0x121d0
@   0x080121a6: 0000        movs	r0, r0
@   0x080121a8: 5330        strh	r0, [r6, r4]
@   0x080121aa: 0300        lsls	r0, r0, #12
@   0x080121ac: 6150        str	r0, [r2, #20]
@   0x080121ae: 0300        lsls	r0, r0, #12
@   0x080121b0: 2802        cmp	r0, #2
@   0x080121b2: d10d        bne.n	0x121d0
@   0x080121b4: 6868        ldr	r0, [r5, #4]
@   0x080121b6: e009        b.n	0x121cc
@   0x080121b8: 6868        ldr	r0, [r5, #4]
@   0x080121ba: 3802        subs	r0, #2
@   0x080121bc: e007        b.n	0x121ce
@   0x080121be: 6868        ldr	r0, [r5, #4]
@   0x080121c0: 2800        cmp	r0, #0
@   0x080121c2: d005        beq.n	0x121d0
@   0x080121c4: 2800        cmp	r0, #0
@   0x080121c6: dd01        ble.n	0x121cc
@   0x080121c8: 3802        subs	r0, #2
@   0x080121ca: e000        b.n	0x121ce
@   0x080121cc: 3002        adds	r0, #2
@   0x080121ce: 6068        str	r0, [r5, #4]
@   0x080121d0: 6830        ldr	r0, [r6, #0]
@   0x080121d2: 60a8        str	r0, [r5, #8]
@   0x080121d4: 4807        ldr	r0, [pc, #28]	@ (0x121f4)
@   0x080121d6: 6831        ldr	r1, [r6, #0]
@   0x080121d8: 6882        ldr	r2, [r0, #8]
@   0x080121da: 1a89        subs	r1, r1, r2
@   0x080121dc: 1c04        adds	r4, r0, #0
@   0x080121de: 7b20        ldrb	r0, [r4, #12]
@   0x080121e0: 4281        cmp	r1, r0
@   0x080121e2: d31b        bcc.n	0x1221c
@   0x080121e4: 7820        ldrb	r0, [r4, #0]
@   0x080121e6: 2803        cmp	r0, #3
@   0x080121e8: d00a        beq.n	0x12200
@   0x080121ea: 2803        cmp	r0, #3
@   0x080121ec: dc04        bgt.n	0x121f8
@   0x080121ee: 2800        cmp	r0, #0
@   0x080121f0: d009        beq.n	0x12206
@   0x080121f2: e011        b.n	0x12218
@   0x080121f4: 5360        strh	r0, [r4, r5]
@   0x080121f6: 0300        lsls	r0, r0, #12
@   0x080121f8: 2804        cmp	r0, #4
@   0x080121fa: d10d        bne.n	0x12218
@   0x080121fc: 6860        ldr	r0, [r4, #4]
@   0x080121fe: e009        b.n	0x12214
@   0x08012200: 6860        ldr	r0, [r4, #4]
@   0x08012202: 3802        subs	r0, #2
@   0x08012204: e007        b.n	0x12216
@   0x08012206: 6860        ldr	r0, [r4, #4]
@   0x08012208: 2800        cmp	r0, #0
@   0x0801220a: d005        beq.n	0x12218
@   0x0801220c: 2800        cmp	r0, #0
@   0x0801220e: dd01        ble.n	0x12214
@   0x08012210: 3802        subs	r0, #2
@   0x08012212: e000        b.n	0x12216
@   0x08012214: 3002        adds	r0, #2
@   0x08012216: 6060        str	r0, [r4, #4]
@   0x08012218: 6830        ldr	r0, [r6, #0]
@   0x0801221a: 60a0        str	r0, [r4, #8]
@   0x0801221c: 4a06        ldr	r2, [pc, #24]	@ (0x12238)
@   0x0801221e: 68d3        ldr	r3, [r2, #12]
@   0x08012220: 6860        ldr	r0, [r4, #4]
@   0x08012222: 181b        adds	r3, r3, r0
@   0x08012224: 60d3        str	r3, [r2, #12]
@   0x08012226: 6910        ldr	r0, [r2, #16]
@   0x08012228: 6869        ldr	r1, [r5, #4]
@   0x0801222a: 1840        adds	r0, r0, r1
@   0x0801222c: 6110        str	r0, [r2, #16]
@   0x0801222e: 62d3        str	r3, [r2, #44]	@ 0x2c
@   0x08012230: 6310        str	r0, [r2, #48]	@ 0x30
@   0x08012232: bc70        pop	{r4, r5, r6}
@   0x08012234: bc01        pop	{r0}
@   0x08012236: 4700        bx	r0
@   0x08012238: 60a0        str	r0, [r4, #8]
@   0x0801223a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012180
sub_08012180: @ 0x08012180
        .incbin "frog_us_baserom.gba", 0x12180, 0xbc
        thumb_func_end sub_08012180
