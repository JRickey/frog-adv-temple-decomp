@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ec7c, 0x0802ed5c)  (224 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ec7c --end 0x802ed5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ec7c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ec7e: 464f        mov	r7, r9
@   0x0802ec80: 4646        mov	r6, r8
@   0x0802ec82: b4c0        push	{r6, r7}
@   0x0802ec84: 2500        movs	r5, #0
@   0x0802ec86: 480f        ldr	r0, [pc, #60]	@ (0x2ecc4)
@   0x0802ec88: 4680        mov	r8, r0
@   0x0802ec8a: 46c4        mov	ip, r8
@   0x0802ec8c: 2720        movs	r7, #32
@   0x0802ec8e: 4661        mov	r1, ip
@   0x0802ec90: 6808        ldr	r0, [r1, #0]
@   0x0802ec92: 19c3        adds	r3, r0, r7
@   0x0802ec94: 1c1a        adds	r2, r3, #0
@   0x0802ec96: 321c        adds	r2, #28
@   0x0802ec98: 8851        ldrh	r1, [r2, #2]
@   0x0802ec9a: 2402        movs	r4, #2
@   0x0802ec9c: 5f10        ldrsh	r0, [r2, r4]
@   0x0802ec9e: 2800        cmp	r0, #0
@   0x0802eca0: d022        beq.n	0x2ece8
@   0x0802eca2: 8b98        ldrh	r0, [r3, #28]
@   0x0802eca4: 1809        adds	r1, r1, r0
@   0x0802eca6: 2600        movs	r6, #0
@   0x0802eca8: 8399        strh	r1, [r3, #28]
@   0x0802ecaa: 2402        movs	r4, #2
@   0x0802ecac: 5f10        ldrsh	r0, [r2, r4]
@   0x0802ecae: 2800        cmp	r0, #0
@   0x0802ecb0: dd0a        ble.n	0x2ecc8
@   0x0802ecb2: 0409        lsls	r1, r1, #16
@   0x0802ecb4: 8890        ldrh	r0, [r2, #4]
@   0x0802ecb6: 4681        mov	r9, r0
@   0x0802ecb8: 0400        lsls	r0, r0, #16
@   0x0802ecba: 4281        cmp	r1, r0
@   0x0802ecbc: dd0b        ble.n	0x2ecd6
@   0x0802ecbe: 4649        mov	r1, r9
@   0x0802ecc0: 8399        strh	r1, [r3, #28]
@   0x0802ecc2: e007        b.n	0x2ecd4
@   0x0802ecc4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ecc6: 0300        lsls	r0, r0, #12
@   0x0802ecc8: 0409        lsls	r1, r1, #16
@   0x0802ecca: 8894        ldrh	r4, [r2, #4]
@   0x0802eccc: 0420        lsls	r0, r4, #16
@   0x0802ecce: 4281        cmp	r1, r0
@   0x0802ecd0: da01        bge.n	0x2ecd6
@   0x0802ecd2: 839c        strh	r4, [r3, #28]
@   0x0802ecd4: 8056        strh	r6, [r2, #2]
@   0x0802ecd6: 4660        mov	r0, ip
@   0x0802ecd8: 6802        ldr	r2, [r0, #0]
@   0x0802ecda: 00a8        lsls	r0, r5, #2
@   0x0802ecdc: 3210        adds	r2, #16
@   0x0802ecde: 1812        adds	r2, r2, r0
@   0x0802ece0: 6810        ldr	r0, [r2, #0]
@   0x0802ece2: 2140        movs	r1, #64	@ 0x40
@   0x0802ece4: 4308        orrs	r0, r1
@   0x0802ece6: 6010        str	r0, [r2, #0]
@   0x0802ece8: 3724        adds	r7, #36	@ 0x24
@   0x0802ecea: 3501        adds	r5, #1
@   0x0802ecec: 2d02        cmp	r5, #2
@   0x0802ecee: ddce        ble.n	0x2ec8e
@   0x0802ecf0: 2500        movs	r5, #0
@   0x0802ecf2: e028        b.n	0x2ed46
@   0x0802ecf4: 6808        ldr	r0, [r1, #0]
@   0x0802ecf6: 30cc        adds	r0, #204	@ 0xcc
@   0x0802ecf8: 6801        ldr	r1, [r0, #0]
@   0x0802ecfa: 00a8        lsls	r0, r5, #2
@   0x0802ecfc: 1840        adds	r0, r0, r1
@   0x0802ecfe: 6803        ldr	r3, [r0, #0]
@   0x0802ed00: 2b00        cmp	r3, #0
@   0x0802ed02: d01f        beq.n	0x2ed44
@   0x0802ed04: 1c1a        adds	r2, r3, #0
@   0x0802ed06: 321c        adds	r2, #28
@   0x0802ed08: 2102        movs	r1, #2
@   0x0802ed0a: 5e50        ldrsh	r0, [r2, r1]
@   0x0802ed0c: 2800        cmp	r0, #0
@   0x0802ed0e: d019        beq.n	0x2ed44
@   0x0802ed10: 6b98        ldr	r0, [r3, #56]	@ 0x38
@   0x0802ed12: 2140        movs	r1, #64	@ 0x40
@   0x0802ed14: 4308        orrs	r0, r1
@   0x0802ed16: 6398        str	r0, [r3, #56]	@ 0x38
@   0x0802ed18: 8b9c        ldrh	r4, [r3, #28]
@   0x0802ed1a: 8857        ldrh	r7, [r2, #2]
@   0x0802ed1c: 19e1        adds	r1, r4, r7
@   0x0802ed1e: 2600        movs	r6, #0
@   0x0802ed20: 8399        strh	r1, [r3, #28]
@   0x0802ed22: 2402        movs	r4, #2
@   0x0802ed24: 5f10        ldrsh	r0, [r2, r4]
@   0x0802ed26: 2800        cmp	r0, #0
@   0x0802ed28: dd05        ble.n	0x2ed36
@   0x0802ed2a: 0409        lsls	r1, r1, #16
@   0x0802ed2c: 8894        ldrh	r4, [r2, #4]
@   0x0802ed2e: 0420        lsls	r0, r4, #16
@   0x0802ed30: 4281        cmp	r1, r0
@   0x0802ed32: dd07        ble.n	0x2ed44
@   0x0802ed34: e004        b.n	0x2ed40
@   0x0802ed36: 0409        lsls	r1, r1, #16
@   0x0802ed38: 8894        ldrh	r4, [r2, #4]
@   0x0802ed3a: 0420        lsls	r0, r4, #16
@   0x0802ed3c: 4281        cmp	r1, r0
@   0x0802ed3e: da01        bge.n	0x2ed44
@   0x0802ed40: 839c        strh	r4, [r3, #28]
@   0x0802ed42: 8056        strh	r6, [r2, #2]
@   0x0802ed44: 3501        adds	r5, #1
@   0x0802ed46: 4641        mov	r1, r8
@   0x0802ed48: 6808        ldr	r0, [r1, #0]
@   0x0802ed4a: 7800        ldrb	r0, [r0, #0]
@   0x0802ed4c: 4285        cmp	r5, r0
@   0x0802ed4e: dbd1        blt.n	0x2ecf4
@   0x0802ed50: bc18        pop	{r3, r4}
@   0x0802ed52: 4698        mov	r8, r3
@   0x0802ed54: 46a1        mov	r9, r4
@   0x0802ed56: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ed58: bc01        pop	{r0}
@   0x0802ed5a: 4700        bx	r0

        thumb_func_start sub_0802EC7C
sub_0802EC7C: @ 0x0802ec7c
        .incbin "frog_us_baserom.gba", 0x2ec7c, 0xe0
        thumb_func_end sub_0802EC7C
