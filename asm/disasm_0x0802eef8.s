@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802eef8, 0x0802f054)  (348 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802eef8 --end 0x802f054 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802eef8: b570        push	{r4, r5, r6, lr}
@   0x0802eefa: 1c06        adds	r6, r0, #0
@   0x0802eefc: 0609        lsls	r1, r1, #24
@   0x0802eefe: 0e0d        lsrs	r5, r1, #24
@   0x0802ef00: 2a03        cmp	r2, #3
@   0x0802ef02: dc1d        bgt.n	0x2ef40
@   0x0802ef04: 480d        ldr	r0, [pc, #52]	@ (0x2ef3c)
@   0x0802ef06: 6804        ldr	r4, [r0, #0]
@   0x0802ef08: 0091        lsls	r1, r2, #2
@   0x0802ef0a: 1c20        adds	r0, r4, #0
@   0x0802ef0c: 3010        adds	r0, #16
@   0x0802ef0e: 1843        adds	r3, r0, r1
@   0x0802ef10: 6819        ldr	r1, [r3, #0]
@   0x0802ef12: 2027        movs	r0, #39	@ 0x27
@   0x0802ef14: 4240        negs	r0, r0
@   0x0802ef16: 4001        ands	r1, r0
@   0x0802ef18: 6019        str	r1, [r3, #0]
@   0x0802ef1a: 2009        movs	r0, #9
@   0x0802ef1c: 2d00        cmp	r5, #0
@   0x0802ef1e: d100        bne.n	0x2ef22
@   0x0802ef20: 2001        movs	r0, #1
@   0x0802ef22: 4301        orrs	r1, r0
@   0x0802ef24: 6019        str	r1, [r3, #0]
@   0x0802ef26: 00d2        lsls	r2, r2, #3
@   0x0802ef28: 18a0        adds	r0, r4, r2
@   0x0802ef2a: 3090        adds	r0, #144	@ 0x90
@   0x0802ef2c: 2100        movs	r1, #0
@   0x0802ef2e: 8001        strh	r1, [r0, #0]
@   0x0802ef30: 1c20        adds	r0, r4, #0
@   0x0802ef32: 308c        adds	r0, #140	@ 0x8c
@   0x0802ef34: 1880        adds	r0, r0, r2
@   0x0802ef36: 6006        str	r6, [r0, #0]
@   0x0802ef38: e018        b.n	0x2ef6c
@   0x0802ef3a: 0000        movs	r0, r0
@   0x0802ef3c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ef3e: 0300        lsls	r0, r0, #12
@   0x0802ef40: 480c        ldr	r0, [pc, #48]	@ (0x2ef74)
@   0x0802ef42: 6801        ldr	r1, [r0, #0]
@   0x0802ef44: 31c8        adds	r1, #200	@ 0xc8
@   0x0802ef46: 0190        lsls	r0, r2, #6
@   0x0802ef48: 4a0b        ldr	r2, [pc, #44]	@ (0x2ef78)
@   0x0802ef4a: 1880        adds	r0, r0, r2
@   0x0802ef4c: 6809        ldr	r1, [r1, #0]
@   0x0802ef4e: 1809        adds	r1, r1, r0
@   0x0802ef50: 6b8b        ldr	r3, [r1, #56]	@ 0x38
@   0x0802ef52: 2027        movs	r0, #39	@ 0x27
@   0x0802ef54: 4240        negs	r0, r0
@   0x0802ef56: 4003        ands	r3, r0
@   0x0802ef58: 638b        str	r3, [r1, #56]	@ 0x38
@   0x0802ef5a: 2009        movs	r0, #9
@   0x0802ef5c: 2d00        cmp	r5, #0
@   0x0802ef5e: d100        bne.n	0x2ef62
@   0x0802ef60: 2001        movs	r0, #1
@   0x0802ef62: 4303        orrs	r3, r0
@   0x0802ef64: 638b        str	r3, [r1, #56]	@ 0x38
@   0x0802ef66: 2000        movs	r0, #0
@   0x0802ef68: 8508        strh	r0, [r1, #40]	@ 0x28
@   0x0802ef6a: 624e        str	r6, [r1, #36]	@ 0x24
@   0x0802ef6c: bc70        pop	{r4, r5, r6}
@   0x0802ef6e: bc01        pop	{r0}
@   0x0802ef70: 4700        bx	r0
@   0x0802ef72: 0000        movs	r0, r0
@   0x0802ef74: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ef76: 0300        lsls	r0, r0, #12
@   0x0802ef78: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802ef7c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ef7e: 4647        mov	r7, r8
@   0x0802ef80: b480        push	{r7}
@   0x0802ef82: 1c14        adds	r4, r2, #0
@   0x0802ef84: 0600        lsls	r0, r0, #24
@   0x0802ef86: 0e06        lsrs	r6, r0, #24
@   0x0802ef88: 0409        lsls	r1, r1, #16
@   0x0802ef8a: 0c0f        lsrs	r7, r1, #16
@   0x0802ef8c: 2c03        cmp	r4, #3
@   0x0802ef8e: dc37        bgt.n	0x2f000
@   0x0802ef90: 4b1a        ldr	r3, [pc, #104]	@ (0x2effc)
@   0x0802ef92: 681d        ldr	r5, [r3, #0]
@   0x0802ef94: 00a2        lsls	r2, r4, #2
@   0x0802ef96: 1c28        adds	r0, r5, #0
@   0x0802ef98: 3010        adds	r0, #16
@   0x0802ef9a: 1880        adds	r0, r0, r2
@   0x0802ef9c: 6801        ldr	r1, [r0, #0]
@   0x0802ef9e: 2021        movs	r0, #33	@ 0x21
@   0x0802efa0: 4001        ands	r1, r0
@   0x0802efa2: 4698        mov	r8, r3
@   0x0802efa4: 4694        mov	ip, r2
@   0x0802efa6: 00e4        lsls	r4, r4, #3
@   0x0802efa8: 2900        cmp	r1, #0
@   0x0802efaa: d108        bne.n	0x2efbe
@   0x0802efac: 1928        adds	r0, r5, r4
@   0x0802efae: 2100        movs	r1, #0
@   0x0802efb0: 2e00        cmp	r6, #0
@   0x0802efb2: d102        bne.n	0x2efba
@   0x0802efb4: 22ff        movs	r2, #255	@ 0xff
@   0x0802efb6: 0212        lsls	r2, r2, #8
@   0x0802efb8: 1c11        adds	r1, r2, #0
@   0x0802efba: 3090        adds	r0, #144	@ 0x90
@   0x0802efbc: 8001        strh	r1, [r0, #0]
@   0x0802efbe: 4640        mov	r0, r8
@   0x0802efc0: 6803        ldr	r3, [r0, #0]
@   0x0802efc2: 1c1a        adds	r2, r3, #0
@   0x0802efc4: 3210        adds	r2, #16
@   0x0802efc6: 4462        add	r2, ip
@   0x0802efc8: 6810        ldr	r0, [r2, #0]
@   0x0802efca: 2108        movs	r1, #8
@   0x0802efcc: 4249        negs	r1, r1
@   0x0802efce: 4008        ands	r0, r1
@   0x0802efd0: 2120        movs	r1, #32
@   0x0802efd2: 4308        orrs	r0, r1
@   0x0802efd4: 6010        str	r0, [r2, #0]
@   0x0802efd6: 338c        adds	r3, #140	@ 0x8c
@   0x0802efd8: 191b        adds	r3, r3, r4
@   0x0802efda: 601f        str	r7, [r3, #0]
@   0x0802efdc: 2e00        cmp	r6, #0
@   0x0802efde: d101        bne.n	0x2efe4
@   0x0802efe0: 4278        negs	r0, r7
@   0x0802efe2: 6018        str	r0, [r3, #0]
@   0x0802efe4: 4641        mov	r1, r8
@   0x0802efe6: 6808        ldr	r0, [r1, #0]
@   0x0802efe8: 1900        adds	r0, r0, r4
@   0x0802efea: 2100        movs	r1, #0
@   0x0802efec: 2e00        cmp	r6, #0
@   0x0802efee: d102        bne.n	0x2eff6
@   0x0802eff0: 22ff        movs	r2, #255	@ 0xff
@   0x0802eff2: 0212        lsls	r2, r2, #8
@   0x0802eff4: 1c11        adds	r1, r2, #0
@   0x0802eff6: 3090        adds	r0, #144	@ 0x90
@   0x0802eff8: 8001        strh	r1, [r0, #0]
@   0x0802effa: e021        b.n	0x2f040
@   0x0802effc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802effe: 0300        lsls	r0, r0, #12
@   0x0802f000: 4812        ldr	r0, [pc, #72]	@ (0x2f04c)
@   0x0802f002: 6801        ldr	r1, [r0, #0]
@   0x0802f004: 31c8        adds	r1, #200	@ 0xc8
@   0x0802f006: 01a0        lsls	r0, r4, #6
@   0x0802f008: 4a11        ldr	r2, [pc, #68]	@ (0x2f050)
@   0x0802f00a: 1880        adds	r0, r0, r2
@   0x0802f00c: 6809        ldr	r1, [r1, #0]
@   0x0802f00e: 180a        adds	r2, r1, r0
@   0x0802f010: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802f012: 2121        movs	r1, #33	@ 0x21
@   0x0802f014: 4008        ands	r0, r1
@   0x0802f016: 2800        cmp	r0, #0
@   0x0802f018: d106        bne.n	0x2f028
@   0x0802f01a: 2000        movs	r0, #0
@   0x0802f01c: 2e00        cmp	r6, #0
@   0x0802f01e: d102        bne.n	0x2f026
@   0x0802f020: 21ff        movs	r1, #255	@ 0xff
@   0x0802f022: 0209        lsls	r1, r1, #8
@   0x0802f024: 1c08        adds	r0, r1, #0
@   0x0802f026: 8510        strh	r0, [r2, #40]	@ 0x28
@   0x0802f028: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802f02a: 2108        movs	r1, #8
@   0x0802f02c: 4249        negs	r1, r1
@   0x0802f02e: 4008        ands	r0, r1
@   0x0802f030: 2120        movs	r1, #32
@   0x0802f032: 4308        orrs	r0, r1
@   0x0802f034: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802f036: 6257        str	r7, [r2, #36]	@ 0x24
@   0x0802f038: 2e00        cmp	r6, #0
@   0x0802f03a: d101        bne.n	0x2f040
@   0x0802f03c: 4278        negs	r0, r7
@   0x0802f03e: 6250        str	r0, [r2, #36]	@ 0x24
@   0x0802f040: bc08        pop	{r3}
@   0x0802f042: 4698        mov	r8, r3
@   0x0802f044: bcf0        pop	{r4, r5, r6, r7}
@   0x0802f046: bc01        pop	{r0}
@   0x0802f048: 4700        bx	r0
@   0x0802f04a: 0000        movs	r0, r0
@   0x0802f04c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f04e: 0300        lsls	r0, r0, #12
@   0x0802f050: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>

        thumb_func_start sub_0802EEF8
sub_0802EEF8: @ 0x0802eef8
        .incbin "frog_us_baserom.gba", 0x2eef8, 0x15c
        thumb_func_end sub_0802EEF8
