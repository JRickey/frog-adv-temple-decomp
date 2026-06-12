@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024fd0, 0x0802508c)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024fd0 --end 0x802508c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024fd0: b570        push	{r4, r5, r6, lr}
@   0x08024fd2: b084        sub	sp, #16
@   0x08024fd4: 2400        movs	r4, #0
@   0x08024fd6: 4e07        ldr	r6, [pc, #28]	@ (0x24ff4)
@   0x08024fd8: 2503        movs	r5, #3
@   0x08024fda: 4807        ldr	r0, [pc, #28]	@ (0x24ff8)
@   0x08024fdc: 2105        movs	r1, #5
@   0x08024fde: 1c22        adds	r2, r4, #0
@   0x08024fe0: f7e1        fbdc 	bl	0x679c
@   0x08024fe4: 0600        lsls	r0, r0, #24
@   0x08024fe6: 2800        cmp	r0, #0
@   0x08024fe8: d11a        bne.n	0x25020
@   0x08024fea: 2c00        cmp	r4, #0
@   0x08024fec: d106        bne.n	0x24ffc
@   0x08024fee: 6831        ldr	r1, [r6, #0]
@   0x08024ff0: e019        b.n	0x25026
@   0x08024ff2: 0000        movs	r0, r0
@   0x08024ff4: 3f78        subs	r7, #120	@ 0x78
@   0x08024ff6: 0831        lsrs	r1, r6, #32
@   0x08024ff8: 6110        str	r0, [r2, #16]
@   0x08024ffa: 0300        lsls	r0, r0, #12
@   0x08024ffc: 1c20        adds	r0, r4, #0
@   0x08024ffe: 305d        adds	r0, #93	@ 0x5d
@   0x08025000: 00a1        lsls	r1, r4, #2
@   0x08025002: 1989        adds	r1, r1, r6
@   0x08025004: 6809        ldr	r1, [r1, #0]
@   0x08025006: 4a05        ldr	r2, [pc, #20]	@ (0x2501c)
@   0x08025008: 9200        str	r2, [sp, #0]
@   0x0802500a: 220b        movs	r2, #11
@   0x0802500c: 9201        str	r2, [sp, #4]
@   0x0802500e: 9502        str	r5, [sp, #8]
@   0x08025010: 9503        str	r5, [sp, #12]
@   0x08025012: 2200        movs	r2, #0
@   0x08025014: 232b        movs	r3, #43	@ 0x2b
@   0x08025016: f7fc        f843 	bl	0x210a0
@   0x0802501a: e023        b.n	0x25064
@   0x0802501c: 02e1        lsls	r1, r4, #11
@   0x0802501e: 0000        movs	r0, r0
@   0x08025020: 2c00        cmp	r4, #0
@   0x08025022: d10f        bne.n	0x25044
@   0x08025024: 68b1        ldr	r1, [r6, #8]
@   0x08025026: 4806        ldr	r0, [pc, #24]	@ (0x25040)
@   0x08025028: 9000        str	r0, [sp, #0]
@   0x0802502a: 200a        movs	r0, #10
@   0x0802502c: 9001        str	r0, [sp, #4]
@   0x0802502e: 9502        str	r5, [sp, #8]
@   0x08025030: 9503        str	r5, [sp, #12]
@   0x08025032: 205d        movs	r0, #93	@ 0x5d
@   0x08025034: 2200        movs	r2, #0
@   0x08025036: 232a        movs	r3, #42	@ 0x2a
@   0x08025038: f7fc        f832 	bl	0x210a0
@   0x0802503c: e012        b.n	0x25064
@   0x0802503e: 0000        movs	r0, r0
@   0x08025040: 02d1        lsls	r1, r2, #11
@   0x08025042: 0000        movs	r0, r0
@   0x08025044: 1c20        adds	r0, r4, #0
@   0x08025046: 305d        adds	r0, #93	@ 0x5d
@   0x08025048: 1ca1        adds	r1, r4, #2
@   0x0802504a: 0089        lsls	r1, r1, #2
@   0x0802504c: 1989        adds	r1, r1, r6
@   0x0802504e: 6809        ldr	r1, [r1, #0]
@   0x08025050: 4a0b        ldr	r2, [pc, #44]	@ (0x25080)
@   0x08025052: 9200        str	r2, [sp, #0]
@   0x08025054: 220b        movs	r2, #11
@   0x08025056: 9201        str	r2, [sp, #4]
@   0x08025058: 9502        str	r5, [sp, #8]
@   0x0802505a: 9503        str	r5, [sp, #12]
@   0x0802505c: 2200        movs	r2, #0
@   0x0802505e: 232b        movs	r3, #43	@ 0x2b
@   0x08025060: f7fc        f81e 	bl	0x210a0
@   0x08025064: 1c60        adds	r0, r4, #1
@   0x08025066: 0600        lsls	r0, r0, #24
@   0x08025068: 0e04        lsrs	r4, r0, #24
@   0x0802506a: 2c01        cmp	r4, #1
@   0x0802506c: d9b5        bls.n	0x24fda
@   0x0802506e: 4805        ldr	r0, [pc, #20]	@ (0x25084)
@   0x08025070: 4905        ldr	r1, [pc, #20]	@ (0x25088)
@   0x08025072: 1840        adds	r0, r0, r1
@   0x08025074: 2102        movs	r1, #2
@   0x08025076: 7001        strb	r1, [r0, #0]
@   0x08025078: b004        add	sp, #16
@   0x0802507a: bc70        pop	{r4, r5, r6}
@   0x0802507c: bc01        pop	{r0}
@   0x0802507e: 4700        bx	r0
@   0x08025080: 02e1        lsls	r1, r4, #11
@   0x08025082: 0000        movs	r0, r0
@   0x08025084: 3720        adds	r7, #32
@   0x08025086: 0300        lsls	r0, r0, #12
@   0x08025088: 1496        asrs	r6, r2, #18

        thumb_func_start sub_08024FD0
sub_08024FD0: @ 0x08024fd0
        .incbin "baserom.gba", 0x24fd0, 0xbc
        thumb_func_end sub_08024FD0
