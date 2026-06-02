@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802eb34, 0x0802ec7c)  (328 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802eb34 --end 0x802ec7c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802eb34: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802eb36: 4647        mov	r7, r8
@   0x0802eb38: b480        push	{r7}
@   0x0802eb3a: 0600        lsls	r0, r0, #24
@   0x0802eb3c: 0e07        lsrs	r7, r0, #24
@   0x0802eb3e: 46bc        mov	ip, r7
@   0x0802eb40: 0409        lsls	r1, r1, #16
@   0x0802eb42: 0c0d        lsrs	r5, r1, #16
@   0x0802eb44: 46a8        mov	r8, r5
@   0x0802eb46: 0412        lsls	r2, r2, #16
@   0x0802eb48: 0c16        lsrs	r6, r2, #16
@   0x0802eb4a: 1c32        adds	r2, r6, #0
@   0x0802eb4c: 2b02        cmp	r3, #2
@   0x0802eb4e: dc22        bgt.n	0x2eb96
@   0x0802eb50: 480c        ldr	r0, [pc, #48]	@ (0x2eb84)
@   0x0802eb52: 00d9        lsls	r1, r3, #3
@   0x0802eb54: 18c9        adds	r1, r1, r3
@   0x0802eb56: 008a        lsls	r2, r1, #2
@   0x0802eb58: 1c11        adds	r1, r2, #0
@   0x0802eb5a: 3120        adds	r1, #32
@   0x0802eb5c: 6800        ldr	r0, [r0, #0]
@   0x0802eb5e: 1843        adds	r3, r0, r1
@   0x0802eb60: 1c1c        adds	r4, r3, #0
@   0x0802eb62: 341c        adds	r4, #28
@   0x0802eb64: 2f00        cmp	r7, #0
@   0x0802eb66: d00f        beq.n	0x2eb88
@   0x0802eb68: 1882        adds	r2, r0, r2
@   0x0802eb6a: 0428        lsls	r0, r5, #16
@   0x0802eb6c: 1400        asrs	r0, r0, #16
@   0x0802eb6e: 8c15        ldrh	r5, [r2, #32]
@   0x0802eb70: 1b41        subs	r1, r0, r5
@   0x0802eb72: 80a1        strh	r1, [r4, #4]
@   0x0802eb74: 2520        movs	r5, #32
@   0x0802eb76: 5f51        ldrsh	r1, [r2, r5]
@   0x0802eb78: 251c        movs	r5, #28
@   0x0802eb7a: 5f5a        ldrsh	r2, [r3, r5]
@   0x0802eb7c: 1889        adds	r1, r1, r2
@   0x0802eb7e: 1a40        subs	r0, r0, r1
@   0x0802eb80: 1c31        adds	r1, r6, #0
@   0x0802eb82: e030        b.n	0x2ebe6
@   0x0802eb84: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802eb86: 0300        lsls	r0, r0, #12
@   0x0802eb88: 0428        lsls	r0, r5, #16
@   0x0802eb8a: 1400        asrs	r0, r0, #16
@   0x0802eb8c: 88a2        ldrh	r2, [r4, #4]
@   0x0802eb8e: 1811        adds	r1, r2, r0
@   0x0802eb90: 80a1        strh	r1, [r4, #4]
@   0x0802eb92: 1c31        adds	r1, r6, #0
@   0x0802eb94: e027        b.n	0x2ebe6
@   0x0802eb96: 2b03        cmp	r3, #3
@   0x0802eb98: dd28        ble.n	0x2ebec
@   0x0802eb9a: 480d        ldr	r0, [pc, #52]	@ (0x2ebd0)
@   0x0802eb9c: 6801        ldr	r1, [r0, #0]
@   0x0802eb9e: 31c8        adds	r1, #200	@ 0xc8
@   0x0802eba0: 0198        lsls	r0, r3, #6
@   0x0802eba2: 4b0c        ldr	r3, [pc, #48]	@ (0x2ebd4)
@   0x0802eba4: 18c0        adds	r0, r0, r3
@   0x0802eba6: 6809        ldr	r1, [r1, #0]
@   0x0802eba8: 180b        adds	r3, r1, r0
@   0x0802ebaa: 1c1c        adds	r4, r3, #0
@   0x0802ebac: 341c        adds	r4, #28
@   0x0802ebae: 4660        mov	r0, ip
@   0x0802ebb0: 2800        cmp	r0, #0
@   0x0802ebb2: d011        beq.n	0x2ebd8
@   0x0802ebb4: 0428        lsls	r0, r5, #16
@   0x0802ebb6: 1400        asrs	r0, r0, #16
@   0x0802ebb8: 881a        ldrh	r2, [r3, #0]
@   0x0802ebba: 1a81        subs	r1, r0, r2
@   0x0802ebbc: 80a1        strh	r1, [r4, #4]
@   0x0802ebbe: 2500        movs	r5, #0
@   0x0802ebc0: 5f59        ldrsh	r1, [r3, r5]
@   0x0802ebc2: 251c        movs	r5, #28
@   0x0802ebc4: 5f5a        ldrsh	r2, [r3, r5]
@   0x0802ebc6: 1889        adds	r1, r1, r2
@   0x0802ebc8: 1a40        subs	r0, r0, r1
@   0x0802ebca: 1c31        adds	r1, r6, #0
@   0x0802ebcc: e00b        b.n	0x2ebe6
@   0x0802ebce: 0000        movs	r0, r0
@   0x0802ebd0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ebd2: 0300        lsls	r0, r0, #12
@   0x0802ebd4: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802ebd8: 4641        mov	r1, r8
@   0x0802ebda: 0408        lsls	r0, r1, #16
@   0x0802ebdc: 1400        asrs	r0, r0, #16
@   0x0802ebde: 88a3        ldrh	r3, [r4, #4]
@   0x0802ebe0: 1819        adds	r1, r3, r0
@   0x0802ebe2: 80a1        strh	r1, [r4, #4]
@   0x0802ebe4: 1c11        adds	r1, r2, #0
@   0x0802ebe6: f005        f895 	bl	0x33d14
@   0x0802ebea: 8060        strh	r0, [r4, #2]
@   0x0802ebec: bc08        pop	{r3}
@   0x0802ebee: 4698        mov	r8, r3
@   0x0802ebf0: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ebf2: bc01        pop	{r0}
@   0x0802ebf4: 4700        bx	r0
@   0x0802ebf6: 0000        movs	r0, r0
@   0x0802ebf8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ebfa: 0400        lsls	r0, r0, #16
@   0x0802ebfc: 0c07        lsrs	r7, r0, #16
@   0x0802ebfe: 0409        lsls	r1, r1, #16
@   0x0802ec00: 0c09        lsrs	r1, r1, #16
@   0x0802ec02: 468c        mov	ip, r1
@   0x0802ec04: 2a03        cmp	r2, #3
@   0x0802ec06: d033        beq.n	0x2ec70
@   0x0802ec08: 480a        ldr	r0, [pc, #40]	@ (0x2ec34)
@   0x0802ec0a: 6803        ldr	r3, [r0, #0]
@   0x0802ec0c: 218c        movs	r1, #140	@ 0x8c
@   0x0802ec0e: 0049        lsls	r1, r1, #1
@   0x0802ec10: 1858        adds	r0, r3, r1
@   0x0802ec12: 6801        ldr	r1, [r0, #0]
@   0x0802ec14: 2088        movs	r0, #136	@ 0x88
@   0x0802ec16: 0040        lsls	r0, r0, #1
@   0x0802ec18: 1809        adds	r1, r1, r0
@   0x0802ec1a: 0050        lsls	r0, r2, #1
@   0x0802ec1c: 1880        adds	r0, r0, r2
@   0x0802ec1e: 0080        lsls	r0, r0, #2
@   0x0802ec20: 6809        ldr	r1, [r1, #0]
@   0x0802ec22: 180c        adds	r4, r1, r0
@   0x0802ec24: 2a02        cmp	r2, #2
@   0x0802ec26: dc07        bgt.n	0x2ec38
@   0x0802ec28: 00d0        lsls	r0, r2, #3
@   0x0802ec2a: 1880        adds	r0, r0, r2
@   0x0802ec2c: 0080        lsls	r0, r0, #2
@   0x0802ec2e: 3020        adds	r0, #32
@   0x0802ec30: 181e        adds	r6, r3, r0
@   0x0802ec32: e008        b.n	0x2ec46
@   0x0802ec34: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ec36: 0300        lsls	r0, r0, #12
@   0x0802ec38: 1c18        adds	r0, r3, #0
@   0x0802ec3a: 30c8        adds	r0, #200	@ 0xc8
@   0x0802ec3c: 0191        lsls	r1, r2, #6
@   0x0802ec3e: 4a0e        ldr	r2, [pc, #56]	@ (0x2ec78)
@   0x0802ec40: 1889        adds	r1, r1, r2
@   0x0802ec42: 6800        ldr	r0, [r0, #0]
@   0x0802ec44: 1846        adds	r6, r0, r1
@   0x0802ec46: 1c35        adds	r5, r6, #0
@   0x0802ec48: 351c        adds	r5, #28
@   0x0802ec4a: 2d00        cmp	r5, #0
@   0x0802ec4c: d010        beq.n	0x2ec70
@   0x0802ec4e: 2000        movs	r0, #0
@   0x0802ec50: 8028        strh	r0, [r5, #0]
@   0x0802ec52: 79e4        ldrb	r4, [r4, #7]
@   0x0802ec54: 0221        lsls	r1, r4, #8
@   0x0802ec56: 0438        lsls	r0, r7, #16
@   0x0802ec58: 1400        asrs	r0, r0, #16
@   0x0802ec5a: 1840        adds	r0, r0, r1
@   0x0802ec5c: 88ec        ldrh	r4, [r5, #6]
@   0x0802ec5e: 1b00        subs	r0, r0, r4
@   0x0802ec60: 80a8        strh	r0, [r5, #4]
@   0x0802ec62: 2104        movs	r1, #4
@   0x0802ec64: 5e68        ldrsh	r0, [r5, r1]
@   0x0802ec66: 4661        mov	r1, ip
@   0x0802ec68: f005        f854 	bl	0x33d14
@   0x0802ec6c: 8068        strh	r0, [r5, #2]
@   0x0802ec6e: 8034        strh	r4, [r6, #0]
@   0x0802ec70: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ec72: bc01        pop	{r0}
@   0x0802ec74: 4700        bx	r0
@   0x0802ec76: 0000        movs	r0, r0
@   0x0802ec78: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>

        thumb_func_start sub_0802EB34
sub_0802EB34: @ 0x0802eb34
        .incbin "frog_us_baserom.gba", 0x2eb34, 0x148
        thumb_func_end sub_0802EB34
