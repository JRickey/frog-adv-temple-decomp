@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080100e4, 0x0801025c)  (376 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80100e4 --end 0x801025c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080100e4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080100e6: 4657        mov	r7, sl
@   0x080100e8: 464e        mov	r6, r9
@   0x080100ea: 4645        mov	r5, r8
@   0x080100ec: b4e0        push	{r5, r6, r7}
@   0x080100ee: 1c0d        adds	r5, r1, #0
@   0x080100f0: 1c13        adds	r3, r2, #0
@   0x080100f2: 0600        lsls	r0, r0, #24
@   0x080100f4: 0e00        lsrs	r0, r0, #24
@   0x080100f6: 4684        mov	ip, r0
@   0x080100f8: 1c1c        adds	r4, r3, #0
@   0x080100fa: 2700        movs	r7, #0
@   0x080100fc: 2000        movs	r0, #0
@   0x080100fe: 4681        mov	r9, r0
@   0x08010100: 493c        ldr	r1, [pc, #240]	@ (0x101f4)
@   0x08010102: 4662        mov	r2, ip
@   0x08010104: 0152        lsls	r2, r2, #5
@   0x08010106: 4692        mov	sl, r2
@   0x08010108: 1c08        adds	r0, r1, #0
@   0x0801010a: 3008        adds	r0, #8
@   0x0801010c: 4450        add	r0, sl
@   0x0801010e: 6802        ldr	r2, [r0, #0]
@   0x08010110: 4688        mov	r8, r1
@   0x08010112: 2a2f        cmp	r2, #47	@ 0x2f
@   0x08010114: dd0e        ble.n	0x10134
@   0x08010116: 8b0e        ldrh	r6, [r1, #24]
@   0x08010118: 00f0        lsls	r0, r6, #3
@   0x0801011a: 38d0        subs	r0, #208	@ 0xd0
@   0x0801011c: 4656        mov	r6, sl
@   0x0801011e: 4282        cmp	r2, r0
@   0x08010120: dc17        bgt.n	0x10152
@   0x08010122: 1c10        adds	r0, r2, #0
@   0x08010124: 3830        subs	r0, #48	@ 0x30
@   0x08010126: 2800        cmp	r0, #0
@   0x08010128: da00        bge.n	0x1012c
@   0x0801012a: 3007        adds	r0, #7
@   0x0801012c: 10c0        asrs	r0, r0, #3
@   0x0801012e: 0600        lsls	r0, r0, #24
@   0x08010130: 0e00        lsrs	r0, r0, #24
@   0x08010132: 4681        mov	r9, r0
@   0x08010134: 4660        mov	r0, ip
@   0x08010136: 0142        lsls	r2, r0, #5
@   0x08010138: 4640        mov	r0, r8
@   0x0801013a: 3008        adds	r0, #8
@   0x0801013c: 1810        adds	r0, r2, r0
@   0x0801013e: 4641        mov	r1, r8
@   0x08010140: 8b0e        ldrh	r6, [r1, #24]
@   0x08010142: 00f6        lsls	r6, r6, #3
@   0x08010144: 46b2        mov	sl, r6
@   0x08010146: 4651        mov	r1, sl
@   0x08010148: 39d0        subs	r1, #208	@ 0xd0
@   0x0801014a: 6800        ldr	r0, [r0, #0]
@   0x0801014c: 1c16        adds	r6, r2, #0
@   0x0801014e: 4288        cmp	r0, r1
@   0x08010150: dd05        ble.n	0x1015e
@   0x08010152: 4641        mov	r1, r8
@   0x08010154: 7e08        ldrb	r0, [r1, #24]
@   0x08010156: 3820        subs	r0, #32
@   0x08010158: 0600        lsls	r0, r0, #24
@   0x0801015a: 0e00        lsrs	r0, r0, #24
@   0x0801015c: 4681        mov	r9, r0
@   0x0801015e: 4640        mov	r0, r8
@   0x08010160: 3004        adds	r0, #4
@   0x08010162: 1830        adds	r0, r6, r0
@   0x08010164: 6801        ldr	r1, [r0, #0]
@   0x08010166: 2907        cmp	r1, #7
@   0x08010168: dd0d        ble.n	0x10186
@   0x0801016a: 4642        mov	r2, r8
@   0x0801016c: 8b52        ldrh	r2, [r2, #26]
@   0x0801016e: 00d0        lsls	r0, r2, #3
@   0x08010170: 38f8        subs	r0, #248	@ 0xf8
@   0x08010172: 4281        cmp	r1, r0
@   0x08010174: dc11        bgt.n	0x1019a
@   0x08010176: 1c08        adds	r0, r1, #0
@   0x08010178: 3808        subs	r0, #8
@   0x0801017a: 2800        cmp	r0, #0
@   0x0801017c: da00        bge.n	0x10180
@   0x0801017e: 1e48        subs	r0, r1, #1
@   0x08010180: 10c0        asrs	r0, r0, #3
@   0x08010182: 0600        lsls	r0, r0, #24
@   0x08010184: 0e07        lsrs	r7, r0, #24
@   0x08010186: 4640        mov	r0, r8
@   0x08010188: 3004        adds	r0, #4
@   0x0801018a: 1830        adds	r0, r6, r0
@   0x0801018c: 4646        mov	r6, r8
@   0x0801018e: 8b76        ldrh	r6, [r6, #26]
@   0x08010190: 00f1        lsls	r1, r6, #3
@   0x08010192: 39f8        subs	r1, #248	@ 0xf8
@   0x08010194: 6800        ldr	r0, [r0, #0]
@   0x08010196: 4288        cmp	r0, r1
@   0x08010198: dd04        ble.n	0x101a4
@   0x0801019a: 4647        mov	r7, r8
@   0x0801019c: 7eb8        ldrb	r0, [r7, #26]
@   0x0801019e: 3820        subs	r0, #32
@   0x080101a0: 0600        lsls	r0, r0, #24
@   0x080101a2: 0e07        lsrs	r7, r0, #24
@   0x080101a4: 4641        mov	r1, r8
@   0x080101a6: 8b49        ldrh	r1, [r1, #26]
@   0x080101a8: 4648        mov	r0, r9
@   0x080101aa: 4348        muls	r0, r1
@   0x080101ac: 0040        lsls	r0, r0, #1
@   0x080101ae: 182d        adds	r5, r5, r0
@   0x080101b0: 0078        lsls	r0, r7, #1
@   0x080101b2: 182d        adds	r5, r5, r0
@   0x080101b4: 201f        movs	r0, #31
@   0x080101b6: 464a        mov	r2, r9
@   0x080101b8: 4002        ands	r2, r0
@   0x080101ba: 4007        ands	r7, r0
@   0x080101bc: 2020        movs	r0, #32
@   0x080101be: 1bc0        subs	r0, r0, r7
@   0x080101c0: 0600        lsls	r0, r0, #24
@   0x080101c2: 0e00        lsrs	r0, r0, #24
@   0x080101c4: 4684        mov	ip, r0
@   0x080101c6: 0190        lsls	r0, r2, #6
@   0x080101c8: 181b        adds	r3, r3, r0
@   0x080101ca: 0078        lsls	r0, r7, #1
@   0x080101cc: 181b        adds	r3, r3, r0
@   0x080101ce: 2000        movs	r0, #0
@   0x080101d0: 2780        movs	r7, #128	@ 0x80
@   0x080101d2: 013f        lsls	r7, r7, #4
@   0x080101d4: 19e6        adds	r6, r4, r7
@   0x080101d6: 4661        mov	r1, ip
@   0x080101d8: 2200        movs	r2, #0
@   0x080101da: 3001        adds	r0, #1
@   0x080101dc: 4681        mov	r9, r0
@   0x080101de: 1c18        adds	r0, r3, #0
@   0x080101e0: 42b3        cmp	r3, r6
@   0x080101e2: d30b        bcc.n	0x101fc
@   0x080101e4: 4f04        ldr	r7, [pc, #16]	@ (0x101f8)
@   0x080101e6: 19d8        adds	r0, r3, r7
@   0x080101e8: 1b00        subs	r0, r0, r4
@   0x080101ea: 1040        asrs	r0, r0, #1
@   0x080101ec: 0040        lsls	r0, r0, #1
@   0x080101ee: 1820        adds	r0, r4, r0
@   0x080101f0: e00a        b.n	0x10208
@   0x080101f2: 0000        movs	r0, r0
@   0x080101f4: 60a0        str	r0, [r4, #8]
@   0x080101f6: 0300        lsls	r0, r0, #12
@   0x080101f8: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x080101fc: 42a3        cmp	r3, r4
@   0x080101fe: d203        bcs.n	0x10208
@   0x08010200: 1ae0        subs	r0, r4, r3
@   0x08010202: 1040        asrs	r0, r0, #1
@   0x08010204: 0040        lsls	r0, r0, #1
@   0x08010206: 1a30        subs	r0, r6, r0
@   0x08010208: 1c03        adds	r3, r0, #0
@   0x0801020a: 2900        cmp	r1, #0
@   0x0801020c: d105        bne.n	0x1021a
@   0x0801020e: 3b40        subs	r3, #64	@ 0x40
@   0x08010210: 42a3        cmp	r3, r4
@   0x08010212: d202        bcs.n	0x1021a
@   0x08010214: 20f8        movs	r0, #248	@ 0xf8
@   0x08010216: 00c0        lsls	r0, r0, #3
@   0x08010218: 1823        adds	r3, r4, r0
@   0x0801021a: 8828        ldrh	r0, [r5, #0]
@   0x0801021c: 8018        strh	r0, [r3, #0]
@   0x0801021e: 3302        adds	r3, #2
@   0x08010220: 3502        adds	r5, #2
@   0x08010222: 1e48        subs	r0, r1, #1
@   0x08010224: 0600        lsls	r0, r0, #24
@   0x08010226: 0e01        lsrs	r1, r0, #24
@   0x08010228: 1c50        adds	r0, r2, #1
@   0x0801022a: 0600        lsls	r0, r0, #24
@   0x0801022c: 0e02        lsrs	r2, r0, #24
@   0x0801022e: 2a1f        cmp	r2, #31
@   0x08010230: d9d5        bls.n	0x101de
@   0x08010232: 4641        mov	r1, r8
@   0x08010234: 8b49        ldrh	r1, [r1, #26]
@   0x08010236: 0048        lsls	r0, r1, #1
@   0x08010238: 3840        subs	r0, #64	@ 0x40
@   0x0801023a: 182d        adds	r5, r5, r0
@   0x0801023c: 4662        mov	r2, ip
@   0x0801023e: 2a20        cmp	r2, #32
@   0x08010240: d000        beq.n	0x10244
@   0x08010242: 3340        adds	r3, #64	@ 0x40
@   0x08010244: 464f        mov	r7, r9
@   0x08010246: 0638        lsls	r0, r7, #24
@   0x08010248: 0e00        lsrs	r0, r0, #24
@   0x0801024a: 281f        cmp	r0, #31
@   0x0801024c: d9c3        bls.n	0x101d6
@   0x0801024e: bc38        pop	{r3, r4, r5}
@   0x08010250: 4698        mov	r8, r3
@   0x08010252: 46a1        mov	r9, r4
@   0x08010254: 46aa        mov	sl, r5
@   0x08010256: bcf0        pop	{r4, r5, r6, r7}
@   0x08010258: bc01        pop	{r0}
@   0x0801025a: 4700        bx	r0

        thumb_func_start sub_080100E4
sub_080100E4: @ 0x080100e4
        .incbin "frog_us_baserom.gba", 0x100e4, 0x178
        thumb_func_end sub_080100E4
