@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08008e84, 0x08008f98)  (276 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8008e84 --end 0x8008f98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08008e84: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08008e86: 4647        mov	r7, r8
@   0x08008e88: b480        push	{r7}
@   0x08008e8a: 0600        lsls	r0, r0, #24
@   0x08008e8c: 0e00        lsrs	r0, r0, #24
@   0x08008e8e: 1c01        adds	r1, r0, #0
@   0x08008e90: 2802        cmp	r0, #2
@   0x08008e92: d011        beq.n	0x8eb8
@   0x08008e94: 2802        cmp	r0, #2
@   0x08008e96: dc02        bgt.n	0x8e9e
@   0x08008e98: 2801        cmp	r0, #1
@   0x08008e9a: d005        beq.n	0x8ea8
@   0x08008e9c: e025        b.n	0x8eea
@   0x08008e9e: 2904        cmp	r1, #4
@   0x08008ea0: d014        beq.n	0x8ecc
@   0x08008ea2: 2908        cmp	r1, #8
@   0x08008ea4: d01a        beq.n	0x8edc
@   0x08008ea6: e020        b.n	0x8eea
@   0x08008ea8: 4802        ldr	r0, [pc, #8]	@ (0x8eb4)
@   0x08008eaa: 8841        ldrh	r1, [r0, #2]
@   0x08008eac: 468c        mov	ip, r1
@   0x08008eae: 8880        ldrh	r0, [r0, #4]
@   0x08008eb0: 3818        subs	r0, #24
@   0x08008eb2: e006        b.n	0x8ec2
@   0x08008eb4: 3720        adds	r7, #32
@   0x08008eb6: 0300        lsls	r0, r0, #12
@   0x08008eb8: 4803        ldr	r0, [pc, #12]	@ (0x8ec8)
@   0x08008eba: 8842        ldrh	r2, [r0, #2]
@   0x08008ebc: 4694        mov	ip, r2
@   0x08008ebe: 8880        ldrh	r0, [r0, #4]
@   0x08008ec0: 3018        adds	r0, #24
@   0x08008ec2: 0400        lsls	r0, r0, #16
@   0x08008ec4: 0c07        lsrs	r7, r0, #16
@   0x08008ec6: e010        b.n	0x8eea
@   0x08008ec8: 3720        adds	r7, #32
@   0x08008eca: 0300        lsls	r0, r0, #12
@   0x08008ecc: 4901        ldr	r1, [pc, #4]	@ (0x8ed4)
@   0x08008ece: 8848        ldrh	r0, [r1, #2]
@   0x08008ed0: 3818        subs	r0, #24
@   0x08008ed2: e006        b.n	0x8ee2
@   0x08008ed4: 3720        adds	r7, #32
@   0x08008ed6: 0300        lsls	r0, r0, #12
@   0x08008ed8: 2001        movs	r0, #1
@   0x08008eda: e051        b.n	0x8f80
@   0x08008edc: 492b        ldr	r1, [pc, #172]	@ (0x8f8c)
@   0x08008ede: 8848        ldrh	r0, [r1, #2]
@   0x08008ee0: 3018        adds	r0, #24
@   0x08008ee2: 0400        lsls	r0, r0, #16
@   0x08008ee4: 0c00        lsrs	r0, r0, #16
@   0x08008ee6: 4684        mov	ip, r0
@   0x08008ee8: 888f        ldrh	r7, [r1, #4]
@   0x08008eea: 2600        movs	r6, #0
@   0x08008eec: 4828        ldr	r0, [pc, #160]	@ (0x8f90)
@   0x08008eee: 3031        adds	r0, #49	@ 0x31
@   0x08008ef0: 7800        ldrb	r0, [r0, #0]
@   0x08008ef2: 4286        cmp	r6, r0
@   0x08008ef4: da43        bge.n	0x8f7e
@   0x08008ef6: 4680        mov	r8, r0
@   0x08008ef8: 4926        ldr	r1, [pc, #152]	@ (0x8f94)
@   0x08008efa: 00f0        lsls	r0, r6, #3
@   0x08008efc: 1840        adds	r0, r0, r1
@   0x08008efe: 7801        ldrb	r1, [r0, #0]
@   0x08008f00: 2900        cmp	r1, #0
@   0x08008f02: d039        beq.n	0x8f78
@   0x08008f04: 4a21        ldr	r2, [pc, #132]	@ (0x8f8c)
@   0x08008f06: 00c8        lsls	r0, r1, #3
@   0x08008f08: 1a40        subs	r0, r0, r1
@   0x08008f0a: 00c0        lsls	r0, r0, #3
@   0x08008f0c: 1883        adds	r3, r0, r2
@   0x08008f0e: 2004        movs	r0, #4
@   0x08008f10: 8e99        ldrh	r1, [r3, #52]	@ 0x34
@   0x08008f12: 4008        ands	r0, r1
@   0x08008f14: 2800        cmp	r0, #0
@   0x08008f16: d12f        bne.n	0x8f78
@   0x08008f18: 7992        ldrb	r2, [r2, #6]
@   0x08008f1a: 7998        ldrb	r0, [r3, #6]
@   0x08008f1c: 4282        cmp	r2, r0
@   0x08008f1e: d12b        bne.n	0x8f78
@   0x08008f20: 7859        ldrb	r1, [r3, #1]
@   0x08008f22: 2903        cmp	r1, #3
@   0x08008f24: d128        bne.n	0x8f78
@   0x08008f26: 889a        ldrh	r2, [r3, #4]
@   0x08008f28: 8cd8        ldrh	r0, [r3, #38]	@ 0x26
@   0x08008f2a: 1811        adds	r1, r2, r0
@   0x08008f2c: 1c18        adds	r0, r3, #0
@   0x08008f2e: 3029        adds	r0, #41	@ 0x29
@   0x08008f30: 7800        ldrb	r0, [r0, #0]
@   0x08008f32: 1a08        subs	r0, r1, r0
@   0x08008f34: 0400        lsls	r0, r0, #16
@   0x08008f36: 0c04        lsrs	r4, r0, #16
@   0x08008f38: 0409        lsls	r1, r1, #16
@   0x08008f3a: 0c0d        lsrs	r5, r1, #16
@   0x08008f3c: 8859        ldrh	r1, [r3, #2]
@   0x08008f3e: 8c98        ldrh	r0, [r3, #36]	@ 0x24
@   0x08008f40: 180a        adds	r2, r1, r0
@   0x08008f42: 1c18        adds	r0, r3, #0
@   0x08008f44: 3028        adds	r0, #40	@ 0x28
@   0x08008f46: 7800        ldrb	r0, [r0, #0]
@   0x08008f48: 0840        lsrs	r0, r0, #1
@   0x08008f4a: 1a11        subs	r1, r2, r0
@   0x08008f4c: 1880        adds	r0, r0, r2
@   0x08008f4e: 0400        lsls	r0, r0, #16
@   0x08008f50: 0c02        lsrs	r2, r0, #16
@   0x08008f52: 4663        mov	r3, ip
@   0x08008f54: 0418        lsls	r0, r3, #16
@   0x08008f56: 0409        lsls	r1, r1, #16
@   0x08008f58: 1403        asrs	r3, r0, #16
@   0x08008f5a: 4288        cmp	r0, r1
@   0x08008f5c: dd0c        ble.n	0x8f78
@   0x08008f5e: 0410        lsls	r0, r2, #16
@   0x08008f60: 1400        asrs	r0, r0, #16
@   0x08008f62: 4283        cmp	r3, r0
@   0x08008f64: da08        bge.n	0x8f78
@   0x08008f66: 0438        lsls	r0, r7, #16
@   0x08008f68: 0421        lsls	r1, r4, #16
@   0x08008f6a: 1402        asrs	r2, r0, #16
@   0x08008f6c: 4288        cmp	r0, r1
@   0x08008f6e: dd03        ble.n	0x8f78
@   0x08008f70: 0428        lsls	r0, r5, #16
@   0x08008f72: 1400        asrs	r0, r0, #16
@   0x08008f74: 4282        cmp	r2, r0
@   0x08008f76: dbaf        blt.n	0x8ed8
@   0x08008f78: 3601        adds	r6, #1
@   0x08008f7a: 4546        cmp	r6, r8
@   0x08008f7c: dbbc        blt.n	0x8ef8
@   0x08008f7e: 2000        movs	r0, #0
@   0x08008f80: bc08        pop	{r3}
@   0x08008f82: 4698        mov	r8, r3
@   0x08008f84: bcf0        pop	{r4, r5, r6, r7}
@   0x08008f86: bc02        pop	{r1}
@   0x08008f88: 4708        bx	r1
@   0x08008f8a: 0000        movs	r0, r0
@   0x08008f8c: 3720        adds	r7, #32
@   0x08008f8e: 0300        lsls	r0, r0, #12
@   0x08008f90: 6110        str	r0, [r2, #16]
@   0x08008f92: 0300        lsls	r0, r0, #12
@   0x08008f94: 6160        str	r0, [r4, #20]
@   0x08008f96: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08008E84
sub_08008E84: @ 0x08008e84
        .incbin "frog_us_baserom.gba", 0x8e84, 0x114
        thumb_func_end sub_08008E84
