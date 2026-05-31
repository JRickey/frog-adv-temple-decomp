@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ba64, 0x0802bb5c)  (248 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ba64 --end 0x802bb5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ba64: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ba66: b083        sub	sp, #12
@   0x0802ba68: 4a1e        ldr	r2, [pc, #120]	@ (0x2bae4)
@   0x0802ba6a: 9801        ldr	r0, [sp, #4]
@   0x0802ba6c: 4010        ands	r0, r2
@   0x0802ba6e: 210a        movs	r1, #10
@   0x0802ba70: 4308        orrs	r0, r1
@   0x0802ba72: 491d        ldr	r1, [pc, #116]	@ (0x2bae8)
@   0x0802ba74: 4008        ands	r0, r1
@   0x0802ba76: 9001        str	r0, [sp, #4]
@   0x0802ba78: 9802        ldr	r0, [sp, #8]
@   0x0802ba7a: 4010        ands	r0, r2
@   0x0802ba7c: 9002        str	r0, [sp, #8]
@   0x0802ba7e: 481b        ldr	r0, [pc, #108]	@ (0x2baec)
@   0x0802ba80: 2700        movs	r7, #0
@   0x0802ba82: 491b        ldr	r1, [pc, #108]	@ (0x2baf0)
@   0x0802ba84: 1845        adds	r5, r0, r1
@   0x0802ba86: 2609        movs	r6, #9
@   0x0802ba88: 2100        movs	r1, #0
@   0x0802ba8a: 5e68        ldrsh	r0, [r5, r1]
@   0x0802ba8c: 2118        movs	r1, #24
@   0x0802ba8e: f008        f941 	bl	0x33d14
@   0x0802ba92: 1c04        adds	r4, r0, #0
@   0x0802ba94: 0424        lsls	r4, r4, #16
@   0x0802ba96: 1424        asrs	r4, r4, #16
@   0x0802ba98: 2102        movs	r1, #2
@   0x0802ba9a: 5e68        ldrsh	r0, [r5, r1]
@   0x0802ba9c: 2118        movs	r1, #24
@   0x0802ba9e: f008        f939 	bl	0x33d14
@   0x0802baa2: 1c01        adds	r1, r0, #0
@   0x0802baa4: 0409        lsls	r1, r1, #16
@   0x0802baa6: 1409        asrs	r1, r1, #16
@   0x0802baa8: 1c20        adds	r0, r4, #0
@   0x0802baaa: f7e1        fbe1 	bl	0xd270
@   0x0802baae: 0600        lsls	r0, r0, #24
@   0x0802bab0: 0e00        lsrs	r0, r0, #24
@   0x0802bab2: 2802        cmp	r0, #2
@   0x0802bab4: d005        beq.n	0x2bac2
@   0x0802bab6: 2008        movs	r0, #8
@   0x0802bab8: 8e69        ldrh	r1, [r5, #50]	@ 0x32
@   0x0802baba: 4308        orrs	r0, r1
@   0x0802babc: 2104        movs	r1, #4
@   0x0802babe: 4308        orrs	r0, r1
@   0x0802bac0: 8668        strh	r0, [r5, #50]	@ 0x32
@   0x0802bac2: 3538        adds	r5, #56	@ 0x38
@   0x0802bac4: 3e01        subs	r6, #1
@   0x0802bac6: 2e00        cmp	r6, #0
@   0x0802bac8: dade        bge.n	0x2ba88
@   0x0802baca: 2000        movs	r0, #0
@   0x0802bacc: 4b09        ldr	r3, [pc, #36]	@ (0x2baf4)
@   0x0802bace: 9000        str	r0, [sp, #0]
@   0x0802bad0: 2017        movs	r0, #23
@   0x0802bad2: a901        add	r1, sp, #4
@   0x0802bad4: 2257        movs	r2, #87	@ 0x57
@   0x0802bad6: f7f5        fd1b 	bl	0x21510
@   0x0802bada: b003        add	sp, #12
@   0x0802badc: bcf0        pop	{r4, r5, r6, r7}
@   0x0802bade: bc01        pop	{r0}
@   0x0802bae0: 4700        bx	r0
@   0x0802bae2: 0000        movs	r0, r0
@   0x0802bae4: 0000        movs	r0, r0
@   0x0802bae6: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0802baea: 0000        movs	r0, r0
@   0x0802baec: 3720        adds	r7, #32
@   0x0802baee: 0300        lsls	r0, r0, #12
@   0x0802baf0: 050a        lsls	r2, r1, #20
@   0x0802baf2: 0000        movs	r0, r0
@   0x0802baf4: 6110        str	r0, [r2, #16]
@   0x0802baf6: 0300        lsls	r0, r0, #12
@   0x0802baf8: b530        push	{r4, r5, lr}
@   0x0802bafa: b087        sub	sp, #28
@   0x0802bafc: 0600        lsls	r0, r0, #24
@   0x0802bafe: ac03        add	r4, sp, #12
@   0x0802bb00: 2500        movs	r5, #0
@   0x0802bb02: 2301        movs	r3, #1
@   0x0802bb04: 8023        strh	r3, [r4, #0]
@   0x0802bb06: 1c23        adds	r3, r4, #0
@   0x0802bb08: 805d        strh	r5, [r3, #2]
@   0x0802bb0a: 809d        strh	r5, [r3, #4]
@   0x0802bb0c: 0609        lsls	r1, r1, #24
@   0x0802bb0e: 1609        asrs	r1, r1, #24
@   0x0802bb10: 004b        lsls	r3, r1, #1
@   0x0802bb12: 185b        adds	r3, r3, r1
@   0x0802bb14: 00db        lsls	r3, r3, #3
@   0x0802bb16: 330b        adds	r3, #11
@   0x0802bb18: 8123        strh	r3, [r4, #8]
@   0x0802bb1a: 1c23        adds	r3, r4, #0
@   0x0802bb1c: 0612        lsls	r2, r2, #24
@   0x0802bb1e: 1612        asrs	r2, r2, #24
@   0x0802bb20: 0051        lsls	r1, r2, #1
@   0x0802bb22: 1889        adds	r1, r1, r2
@   0x0802bb24: 00c9        lsls	r1, r1, #3
@   0x0802bb26: 310b        adds	r1, #11
@   0x0802bb28: 8159        strh	r1, [r3, #10]
@   0x0802bb2a: 1c1a        adds	r2, r3, #0
@   0x0802bb2c: 490a        ldr	r1, [pc, #40]	@ (0x2bb58)
@   0x0802bb2e: 8191        strh	r1, [r2, #12]
@   0x0802bb30: 0a00        lsrs	r0, r0, #8
@   0x0802bb32: 21c0        movs	r1, #192	@ 0xc0
@   0x0802bb34: 0289        lsls	r1, r1, #10
@   0x0802bb36: 1840        adds	r0, r0, r1
@   0x0802bb38: 0c00        lsrs	r0, r0, #16
@   0x0802bb3a: 2181        movs	r1, #129	@ 0x81
@   0x0802bb3c: 9100        str	r1, [sp, #0]
@   0x0802bb3e: 2102        movs	r1, #2
@   0x0802bb40: 9101        str	r1, [sp, #4]
@   0x0802bb42: 9502        str	r5, [sp, #8]
@   0x0802bb44: 1c11        adds	r1, r2, #0
@   0x0802bb46: 2210        movs	r2, #16
@   0x0802bb48: 2356        movs	r3, #86	@ 0x56
@   0x0802bb4a: f7f5        faf9 	bl	0x21140
@   0x0802bb4e: b007        add	sp, #28
@   0x0802bb50: bc30        pop	{r4, r5}
@   0x0802bb52: bc01        pop	{r0}
@   0x0802bb54: 4700        bx	r0
@   0x0802bb56: 0000        movs	r0, r0
@   0x0802bb58: 0303        lsls	r3, r0, #12

        thumb_func_start sub_0802BA64
sub_0802BA64: @ 0x0802ba64
        .incbin "frog_us_baserom.gba", 0x2ba64, 0xf8
        thumb_func_end sub_0802BA64
