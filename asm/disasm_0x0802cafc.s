@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802cafc, 0x0802cdd0)  (724 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802cafc --end 0x802cdd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802cafc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802cafe: 1c07        adds	r7, r0, #0
@   0x0802cb00: 1c0b        adds	r3, r1, #0
@   0x0802cb02: 4827        ldr	r0, [pc, #156]	@ (0x2cba0)
@   0x0802cb04: 1c02        adds	r2, r0, #0
@   0x0802cb06: 3a70        subs	r2, #112	@ 0x70
@   0x0802cb08: 8854        ldrh	r4, [r2, #2]
@   0x0802cb0a: 8845        ldrh	r5, [r0, #2]
@   0x0802cb0c: 1b61        subs	r1, r4, r5
@   0x0802cb0e: 8892        ldrh	r2, [r2, #4]
@   0x0802cb10: 8880        ldrh	r0, [r0, #4]
@   0x0802cb12: 1a10        subs	r0, r2, r0
@   0x0802cb14: 0400        lsls	r0, r0, #16
@   0x0802cb16: 0c02        lsrs	r2, r0, #16
@   0x0802cb18: 0409        lsls	r1, r1, #16
@   0x0802cb1a: 140c        asrs	r4, r1, #16
@   0x0802cb1c: 1c20        adds	r0, r4, #0
@   0x0802cb1e: 2c00        cmp	r4, #0
@   0x0802cb20: da00        bge.n	0x2cb24
@   0x0802cb22: 4260        negs	r0, r4
@   0x0802cb24: 0600        lsls	r0, r0, #24
@   0x0802cb26: 0e06        lsrs	r6, r0, #24
@   0x0802cb28: 0410        lsls	r0, r2, #16
@   0x0802cb2a: 1402        asrs	r2, r0, #16
@   0x0802cb2c: 1c10        adds	r0, r2, #0
@   0x0802cb2e: 2a00        cmp	r2, #0
@   0x0802cb30: da00        bge.n	0x2cb34
@   0x0802cb32: 4250        negs	r0, r2
@   0x0802cb34: 0600        lsls	r0, r0, #24
@   0x0802cb36: 0e00        lsrs	r0, r0, #24
@   0x0802cb38: 783d        ldrb	r5, [r7, #0]
@   0x0802cb3a: 78b9        ldrb	r1, [r7, #2]
@   0x0802cb3c: 4286        cmp	r6, r0
@   0x0802cb3e: d300        bcc.n	0x2cb42
@   0x0802cb40: e0a1        b.n	0x2cc86
@   0x0802cb42: 2a00        cmp	r2, #0
@   0x0802cb44: da54        bge.n	0x2cbf0
@   0x0802cb46: 2c00        cmp	r4, #0
@   0x0802cb48: da2e        bge.n	0x2cba8
@   0x0802cb4a: 4e16        ldr	r6, [pc, #88]	@ (0x2cba4)
@   0x0802cb4c: 0608        lsls	r0, r1, #24
@   0x0802cb4e: 1604        asrs	r4, r0, #24
@   0x0802cb50: 1e62        subs	r2, r4, #1
@   0x0802cb52: 00d0        lsls	r0, r2, #3
@   0x0802cb54: 1a80        subs	r0, r0, r2
@   0x0802cb56: 0040        lsls	r0, r0, #1
@   0x0802cb58: 0629        lsls	r1, r5, #24
@   0x0802cb5a: 1609        asrs	r1, r1, #24
@   0x0802cb5c: 1840        adds	r0, r0, r1
@   0x0802cb5e: 1980        adds	r0, r0, r6
@   0x0802cb60: 7800        ldrb	r0, [r0, #0]
@   0x0802cb62: 2800        cmp	r0, #0
@   0x0802cb64: d000        beq.n	0x2cb68
@   0x0802cb66: e12b        b.n	0x2cdc0
@   0x0802cb68: 00e0        lsls	r0, r4, #3
@   0x0802cb6a: 1b00        subs	r0, r0, r4
@   0x0802cb6c: 0040        lsls	r0, r0, #1
@   0x0802cb6e: 1845        adds	r5, r0, r1
@   0x0802cb70: 1e68        subs	r0, r5, #1
@   0x0802cb72: 1980        adds	r0, r0, r6
@   0x0802cb74: 7800        ldrb	r0, [r0, #0]
@   0x0802cb76: 2800        cmp	r0, #0
@   0x0802cb78: d000        beq.n	0x2cb7c
@   0x0802cb7a: e113        b.n	0x2cda4
@   0x0802cb7c: 1c62        adds	r2, r4, #1
@   0x0802cb7e: 00d0        lsls	r0, r2, #3
@   0x0802cb80: 1a80        subs	r0, r0, r2
@   0x0802cb82: 0040        lsls	r0, r0, #1
@   0x0802cb84: 1840        adds	r0, r0, r1
@   0x0802cb86: 1980        adds	r0, r0, r6
@   0x0802cb88: 7800        ldrb	r0, [r0, #0]
@   0x0802cb8a: 2800        cmp	r0, #0
@   0x0802cb8c: d000        beq.n	0x2cb90
@   0x0802cb8e: e117        b.n	0x2cdc0
@   0x0802cb90: 1c68        adds	r0, r5, #1
@   0x0802cb92: 1980        adds	r0, r0, r6
@   0x0802cb94: 7800        ldrb	r0, [r0, #0]
@   0x0802cb96: 2800        cmp	r0, #0
@   0x0802cb98: d100        bne.n	0x2cb9c
@   0x0802cb9a: e115        b.n	0x2cdc8
@   0x0802cb9c: 1c48        adds	r0, r1, #1
@   0x0802cb9e: e102        b.n	0x2cda6
@   0x0802cba0: 3790        adds	r7, #144	@ 0x90
@   0x0802cba2: 0300        lsls	r0, r0, #12
@   0x0802cba4: 3610        adds	r6, #16
@   0x0802cba6: 0300        lsls	r0, r0, #12
@   0x0802cba8: 4e0c        ldr	r6, [pc, #48]	@ (0x2cbdc)
@   0x0802cbaa: 0608        lsls	r0, r1, #24
@   0x0802cbac: 1604        asrs	r4, r0, #24
@   0x0802cbae: 1e62        subs	r2, r4, #1
@   0x0802cbb0: 00d0        lsls	r0, r2, #3
@   0x0802cbb2: 1a80        subs	r0, r0, r2
@   0x0802cbb4: 0040        lsls	r0, r0, #1
@   0x0802cbb6: 0629        lsls	r1, r5, #24
@   0x0802cbb8: 1609        asrs	r1, r1, #24
@   0x0802cbba: 1840        adds	r0, r0, r1
@   0x0802cbbc: 1980        adds	r0, r0, r6
@   0x0802cbbe: 7800        ldrb	r0, [r0, #0]
@   0x0802cbc0: 2800        cmp	r0, #0
@   0x0802cbc2: d000        beq.n	0x2cbc6
@   0x0802cbc4: e0fc        b.n	0x2cdc0
@   0x0802cbc6: 00e0        lsls	r0, r4, #3
@   0x0802cbc8: 1b00        subs	r0, r0, r4
@   0x0802cbca: 0040        lsls	r0, r0, #1
@   0x0802cbcc: 1842        adds	r2, r0, r1
@   0x0802cbce: 1c50        adds	r0, r2, #1
@   0x0802cbd0: 1980        adds	r0, r0, r6
@   0x0802cbd2: 7800        ldrb	r0, [r0, #0]
@   0x0802cbd4: 2800        cmp	r0, #0
@   0x0802cbd6: d003        beq.n	0x2cbe0
@   0x0802cbd8: 1c48        adds	r0, r1, #1
@   0x0802cbda: e0e4        b.n	0x2cda6
@   0x0802cbdc: 3610        adds	r6, #16
@   0x0802cbde: 0300        lsls	r0, r0, #12
@   0x0802cbe0: 1e50        subs	r0, r2, #1
@   0x0802cbe2: 1980        adds	r0, r0, r6
@   0x0802cbe4: 7800        ldrb	r0, [r0, #0]
@   0x0802cbe6: 2800        cmp	r0, #0
@   0x0802cbe8: d000        beq.n	0x2cbec
@   0x0802cbea: e0db        b.n	0x2cda4
@   0x0802cbec: 1c62        adds	r2, r4, #1
@   0x0802cbee: e0df        b.n	0x2cdb0
@   0x0802cbf0: 2a00        cmp	r2, #0
@   0x0802cbf2: dc00        bgt.n	0x2cbf6
@   0x0802cbf4: e0e8        b.n	0x2cdc8
@   0x0802cbf6: 2c00        cmp	r4, #0
@   0x0802cbf8: da22        bge.n	0x2cc40
@   0x0802cbfa: 4e10        ldr	r6, [pc, #64]	@ (0x2cc3c)
@   0x0802cbfc: 0608        lsls	r0, r1, #24
@   0x0802cbfe: 1604        asrs	r4, r0, #24
@   0x0802cc00: 1c62        adds	r2, r4, #1
@   0x0802cc02: 00d0        lsls	r0, r2, #3
@   0x0802cc04: 1a80        subs	r0, r0, r2
@   0x0802cc06: 0040        lsls	r0, r0, #1
@   0x0802cc08: 0629        lsls	r1, r5, #24
@   0x0802cc0a: 1609        asrs	r1, r1, #24
@   0x0802cc0c: 1840        adds	r0, r0, r1
@   0x0802cc0e: 1980        adds	r0, r0, r6
@   0x0802cc10: 7800        ldrb	r0, [r0, #0]
@   0x0802cc12: 2800        cmp	r0, #0
@   0x0802cc14: d000        beq.n	0x2cc18
@   0x0802cc16: e0d3        b.n	0x2cdc0
@   0x0802cc18: 00e0        lsls	r0, r4, #3
@   0x0802cc1a: 1b00        subs	r0, r0, r4
@   0x0802cc1c: 0040        lsls	r0, r0, #1
@   0x0802cc1e: 1842        adds	r2, r0, r1
@   0x0802cc20: 1e50        subs	r0, r2, #1
@   0x0802cc22: 1980        adds	r0, r0, r6
@   0x0802cc24: 7800        ldrb	r0, [r0, #0]
@   0x0802cc26: 2800        cmp	r0, #0
@   0x0802cc28: d000        beq.n	0x2cc2c
@   0x0802cc2a: e0bb        b.n	0x2cda4
@   0x0802cc2c: 1c50        adds	r0, r2, #1
@   0x0802cc2e: 1980        adds	r0, r0, r6
@   0x0802cc30: 7800        ldrb	r0, [r0, #0]
@   0x0802cc32: 2800        cmp	r0, #0
@   0x0802cc34: d100        bne.n	0x2cc38
@   0x0802cc36: e0ba        b.n	0x2cdae
@   0x0802cc38: 1c48        adds	r0, r1, #1
@   0x0802cc3a: e0b4        b.n	0x2cda6
@   0x0802cc3c: 3610        adds	r6, #16
@   0x0802cc3e: 0300        lsls	r0, r0, #12
@   0x0802cc40: 4e0c        ldr	r6, [pc, #48]	@ (0x2cc74)
@   0x0802cc42: 0608        lsls	r0, r1, #24
@   0x0802cc44: 1604        asrs	r4, r0, #24
@   0x0802cc46: 1c62        adds	r2, r4, #1
@   0x0802cc48: 00d0        lsls	r0, r2, #3
@   0x0802cc4a: 1a80        subs	r0, r0, r2
@   0x0802cc4c: 0040        lsls	r0, r0, #1
@   0x0802cc4e: 0629        lsls	r1, r5, #24
@   0x0802cc50: 1609        asrs	r1, r1, #24
@   0x0802cc52: 1840        adds	r0, r0, r1
@   0x0802cc54: 1980        adds	r0, r0, r6
@   0x0802cc56: 7800        ldrb	r0, [r0, #0]
@   0x0802cc58: 2800        cmp	r0, #0
@   0x0802cc5a: d000        beq.n	0x2cc5e
@   0x0802cc5c: e0b0        b.n	0x2cdc0
@   0x0802cc5e: 00e0        lsls	r0, r4, #3
@   0x0802cc60: 1b00        subs	r0, r0, r4
@   0x0802cc62: 0040        lsls	r0, r0, #1
@   0x0802cc64: 1842        adds	r2, r0, r1
@   0x0802cc66: 1c50        adds	r0, r2, #1
@   0x0802cc68: 1980        adds	r0, r0, r6
@   0x0802cc6a: 7800        ldrb	r0, [r0, #0]
@   0x0802cc6c: 2800        cmp	r0, #0
@   0x0802cc6e: d003        beq.n	0x2cc78
@   0x0802cc70: 1c48        adds	r0, r1, #1
@   0x0802cc72: e098        b.n	0x2cda6
@   0x0802cc74: 3610        adds	r6, #16
@   0x0802cc76: 0300        lsls	r0, r0, #12
@   0x0802cc78: 1e50        subs	r0, r2, #1
@   0x0802cc7a: 1980        adds	r0, r0, r6
@   0x0802cc7c: 7800        ldrb	r0, [r0, #0]
@   0x0802cc7e: 2800        cmp	r0, #0
@   0x0802cc80: d000        beq.n	0x2cc84
@   0x0802cc82: e08f        b.n	0x2cda4
@   0x0802cc84: e093        b.n	0x2cdae
@   0x0802cc86: 2a00        cmp	r2, #0
@   0x0802cc88: da48        bge.n	0x2cd1c
@   0x0802cc8a: 2c00        cmp	r4, #0
@   0x0802cc8c: da24        bge.n	0x2ccd8
@   0x0802cc8e: 4e10        ldr	r6, [pc, #64]	@ (0x2ccd0)
@   0x0802cc90: 0608        lsls	r0, r1, #24
@   0x0802cc92: 1604        asrs	r4, r0, #24
@   0x0802cc94: 00e0        lsls	r0, r4, #3
@   0x0802cc96: 1b00        subs	r0, r0, r4
@   0x0802cc98: 0040        lsls	r0, r0, #1
@   0x0802cc9a: 0629        lsls	r1, r5, #24
@   0x0802cc9c: 1609        asrs	r1, r1, #24
@   0x0802cc9e: 1845        adds	r5, r0, r1
@   0x0802cca0: 1e68        subs	r0, r5, #1
@   0x0802cca2: 1980        adds	r0, r0, r6
@   0x0802cca4: 7800        ldrb	r0, [r0, #0]
@   0x0802cca6: 2800        cmp	r0, #0
@   0x0802cca8: d000        beq.n	0x2ccac
@   0x0802ccaa: e07b        b.n	0x2cda4
@   0x0802ccac: 1e62        subs	r2, r4, #1
@   0x0802ccae: 00d0        lsls	r0, r2, #3
@   0x0802ccb0: 1a80        subs	r0, r0, r2
@   0x0802ccb2: 0040        lsls	r0, r0, #1
@   0x0802ccb4: 1840        adds	r0, r0, r1
@   0x0802ccb6: 1980        adds	r0, r0, r6
@   0x0802ccb8: 7800        ldrb	r0, [r0, #0]
@   0x0802ccba: 2800        cmp	r0, #0
@   0x0802ccbc: d000        beq.n	0x2ccc0
@   0x0802ccbe: e07f        b.n	0x2cdc0
@   0x0802ccc0: 1c68        adds	r0, r5, #1
@   0x0802ccc2: 1980        adds	r0, r0, r6
@   0x0802ccc4: 7800        ldrb	r0, [r0, #0]
@   0x0802ccc6: 2800        cmp	r0, #0
@   0x0802ccc8: d004        beq.n	0x2ccd4
@   0x0802ccca: 1c48        adds	r0, r1, #1
@   0x0802cccc: e06b        b.n	0x2cda6
@   0x0802ccce: 0000        movs	r0, r0
@   0x0802ccd0: 3610        adds	r6, #16
@   0x0802ccd2: 0300        lsls	r0, r0, #12
@   0x0802ccd4: 1c62        adds	r2, r4, #1
@   0x0802ccd6: e06b        b.n	0x2cdb0
@   0x0802ccd8: 4e07        ldr	r6, [pc, #28]	@ (0x2ccf8)
@   0x0802ccda: 0608        lsls	r0, r1, #24
@   0x0802ccdc: 1604        asrs	r4, r0, #24
@   0x0802ccde: 00e0        lsls	r0, r4, #3
@   0x0802cce0: 1b00        subs	r0, r0, r4
@   0x0802cce2: 0040        lsls	r0, r0, #1
@   0x0802cce4: 0629        lsls	r1, r5, #24
@   0x0802cce6: 1609        asrs	r1, r1, #24
@   0x0802cce8: 1845        adds	r5, r0, r1
@   0x0802ccea: 1c68        adds	r0, r5, #1
@   0x0802ccec: 1980        adds	r0, r0, r6
@   0x0802ccee: 7800        ldrb	r0, [r0, #0]
@   0x0802ccf0: 2800        cmp	r0, #0
@   0x0802ccf2: d003        beq.n	0x2ccfc
@   0x0802ccf4: 1c48        adds	r0, r1, #1
@   0x0802ccf6: e056        b.n	0x2cda6
@   0x0802ccf8: 3610        adds	r6, #16
@   0x0802ccfa: 0300        lsls	r0, r0, #12
@   0x0802ccfc: 1e62        subs	r2, r4, #1
@   0x0802ccfe: 00d0        lsls	r0, r2, #3
@   0x0802cd00: 1a80        subs	r0, r0, r2
@   0x0802cd02: 0040        lsls	r0, r0, #1
@   0x0802cd04: 1840        adds	r0, r0, r1
@   0x0802cd06: 1980        adds	r0, r0, r6
@   0x0802cd08: 7800        ldrb	r0, [r0, #0]
@   0x0802cd0a: 2800        cmp	r0, #0
@   0x0802cd0c: d158        bne.n	0x2cdc0
@   0x0802cd0e: 1e68        subs	r0, r5, #1
@   0x0802cd10: 1980        adds	r0, r0, r6
@   0x0802cd12: 7800        ldrb	r0, [r0, #0]
@   0x0802cd14: 2800        cmp	r0, #0
@   0x0802cd16: d145        bne.n	0x2cda4
@   0x0802cd18: 1c62        adds	r2, r4, #1
@   0x0802cd1a: e049        b.n	0x2cdb0
@   0x0802cd1c: 2a00        cmp	r2, #0
@   0x0802cd1e: dd53        ble.n	0x2cdc8
@   0x0802cd20: 2c00        cmp	r4, #0
@   0x0802cd22: da1f        bge.n	0x2cd64
@   0x0802cd24: 4e0e        ldr	r6, [pc, #56]	@ (0x2cd60)
@   0x0802cd26: 0608        lsls	r0, r1, #24
@   0x0802cd28: 1604        asrs	r4, r0, #24
@   0x0802cd2a: 00e0        lsls	r0, r4, #3
@   0x0802cd2c: 1b00        subs	r0, r0, r4
@   0x0802cd2e: 0040        lsls	r0, r0, #1
@   0x0802cd30: 0629        lsls	r1, r5, #24
@   0x0802cd32: 1609        asrs	r1, r1, #24
@   0x0802cd34: 1845        adds	r5, r0, r1
@   0x0802cd36: 1e68        subs	r0, r5, #1
@   0x0802cd38: 1980        adds	r0, r0, r6
@   0x0802cd3a: 7800        ldrb	r0, [r0, #0]
@   0x0802cd3c: 2800        cmp	r0, #0
@   0x0802cd3e: d131        bne.n	0x2cda4
@   0x0802cd40: 1c62        adds	r2, r4, #1
@   0x0802cd42: 00d0        lsls	r0, r2, #3
@   0x0802cd44: 1a80        subs	r0, r0, r2
@   0x0802cd46: 0040        lsls	r0, r0, #1
@   0x0802cd48: 1840        adds	r0, r0, r1
@   0x0802cd4a: 1980        adds	r0, r0, r6
@   0x0802cd4c: 7800        ldrb	r0, [r0, #0]
@   0x0802cd4e: 2800        cmp	r0, #0
@   0x0802cd50: d136        bne.n	0x2cdc0
@   0x0802cd52: 1c68        adds	r0, r5, #1
@   0x0802cd54: 1980        adds	r0, r0, r6
@   0x0802cd56: 7800        ldrb	r0, [r0, #0]
@   0x0802cd58: 2800        cmp	r0, #0
@   0x0802cd5a: d028        beq.n	0x2cdae
@   0x0802cd5c: 1c48        adds	r0, r1, #1
@   0x0802cd5e: e022        b.n	0x2cda6
@   0x0802cd60: 3610        adds	r6, #16
@   0x0802cd62: 0300        lsls	r0, r0, #12
@   0x0802cd64: 4e07        ldr	r6, [pc, #28]	@ (0x2cd84)
@   0x0802cd66: 0608        lsls	r0, r1, #24
@   0x0802cd68: 1604        asrs	r4, r0, #24
@   0x0802cd6a: 00e0        lsls	r0, r4, #3
@   0x0802cd6c: 1b00        subs	r0, r0, r4
@   0x0802cd6e: 0040        lsls	r0, r0, #1
@   0x0802cd70: 0629        lsls	r1, r5, #24
@   0x0802cd72: 1609        asrs	r1, r1, #24
@   0x0802cd74: 1845        adds	r5, r0, r1
@   0x0802cd76: 1c68        adds	r0, r5, #1
@   0x0802cd78: 1980        adds	r0, r0, r6
@   0x0802cd7a: 7800        ldrb	r0, [r0, #0]
@   0x0802cd7c: 2800        cmp	r0, #0
@   0x0802cd7e: d003        beq.n	0x2cd88
@   0x0802cd80: 1c48        adds	r0, r1, #1
@   0x0802cd82: e010        b.n	0x2cda6
@   0x0802cd84: 3610        adds	r6, #16
@   0x0802cd86: 0300        lsls	r0, r0, #12
@   0x0802cd88: 1c62        adds	r2, r4, #1
@   0x0802cd8a: 00d0        lsls	r0, r2, #3
@   0x0802cd8c: 1a80        subs	r0, r0, r2
@   0x0802cd8e: 0040        lsls	r0, r0, #1
@   0x0802cd90: 1840        adds	r0, r0, r1
@   0x0802cd92: 1980        adds	r0, r0, r6
@   0x0802cd94: 7800        ldrb	r0, [r0, #0]
@   0x0802cd96: 2800        cmp	r0, #0
@   0x0802cd98: d112        bne.n	0x2cdc0
@   0x0802cd9a: 1e68        subs	r0, r5, #1
@   0x0802cd9c: 1980        adds	r0, r0, r6
@   0x0802cd9e: 7800        ldrb	r0, [r0, #0]
@   0x0802cda0: 2800        cmp	r0, #0
@   0x0802cda2: d004        beq.n	0x2cdae
@   0x0802cda4: 1e48        subs	r0, r1, #1
@   0x0802cda6: 8018        strh	r0, [r3, #0]
@   0x0802cda8: 805c        strh	r4, [r3, #2]
@   0x0802cdaa: 2001        movs	r0, #1
@   0x0802cdac: e00d        b.n	0x2cdca
@   0x0802cdae: 1e62        subs	r2, r4, #1
@   0x0802cdb0: 00d0        lsls	r0, r2, #3
@   0x0802cdb2: 1a80        subs	r0, r0, r2
@   0x0802cdb4: 0040        lsls	r0, r0, #1
@   0x0802cdb6: 1840        adds	r0, r0, r1
@   0x0802cdb8: 1980        adds	r0, r0, r6
@   0x0802cdba: 7800        ldrb	r0, [r0, #0]
@   0x0802cdbc: 2800        cmp	r0, #0
@   0x0802cdbe: d003        beq.n	0x2cdc8
@   0x0802cdc0: 8019        strh	r1, [r3, #0]
@   0x0802cdc2: 805a        strh	r2, [r3, #2]
@   0x0802cdc4: 2001        movs	r0, #1
@   0x0802cdc6: e000        b.n	0x2cdca
@   0x0802cdc8: 2000        movs	r0, #0
@   0x0802cdca: bcf0        pop	{r4, r5, r6, r7}
@   0x0802cdcc: bc02        pop	{r1}
@   0x0802cdce: 4708        bx	r1

        thumb_func_start sub_0802CAFC
sub_0802CAFC: @ 0x0802cafc
        .incbin "frog_us_baserom.gba", 0x2cafc, 0x2d4
        thumb_func_end sub_0802CAFC
