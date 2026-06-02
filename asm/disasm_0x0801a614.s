@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a614, 0x0801a6d4)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a614 --end 0x801a6d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a614: dfff        svc	255	@ 0xff
@   0x0801a616: 0000        movs	r0, r0
@   0x0801a618: bfff        itttt	<und>
@   0x0801a61a: 0000        mov<und>	r0, r0
@   0x0801a61c: 3540        add<und>	r5, #64	@ 0x40
@   0x0801a61e: 0300        lsl<und>	r0, r0, #12
@   0x0801a620: 5330        strh<und>	r0, [r6, r4]
@   0x0801a622: 0300        lsls	r0, r0, #12
@   0x0801a624: b570        push	{r4, r5, r6, lr}
@   0x0801a626: 0600        lsls	r0, r0, #24
@   0x0801a628: 0e00        lsrs	r0, r0, #24
@   0x0801a62a: 2900        cmp	r1, #0
@   0x0801a62c: d004        beq.n	0x1a638
@   0x0801a62e: 4901        ldr	r1, [pc, #4]	@ (0x1a634)
@   0x0801a630: e003        b.n	0x1a63a
@   0x0801a632: 0000        movs	r0, r0
@   0x0801a634: 8164        strh	r4, [r4, #10]
@   0x0801a636: 0830        lsrs	r0, r6, #32
@   0x0801a638: 490e        ldr	r1, [pc, #56]	@ (0x1a674)
@   0x0801a63a: 0080        lsls	r0, r0, #2
@   0x0801a63c: 1840        adds	r0, r0, r1
@   0x0801a63e: 6806        ldr	r6, [r0, #0]
@   0x0801a640: 4d0d        ldr	r5, [pc, #52]	@ (0x1a678)
@   0x0801a642: 7868        ldrb	r0, [r5, #1]
@   0x0801a644: 2800        cmp	r0, #0
@   0x0801a646: d009        beq.n	0x1a65c
@   0x0801a648: f7e6        f95a 	bl	0x900
@   0x0801a64c: 6869        ldr	r1, [r5, #4]
@   0x0801a64e: 1a40        subs	r0, r0, r1
@   0x0801a650: 213c        movs	r1, #60	@ 0x3c
@   0x0801a652: f019        fc47 	bl	0x33ee4
@   0x0801a656: 7869        ldrb	r1, [r5, #1]
@   0x0801a658: 4288        cmp	r0, r1
@   0x0801a65a: d336        bcc.n	0x1a6ca
@   0x0801a65c: 2100        movs	r1, #0
@   0x0801a65e: 7069        strb	r1, [r5, #1]
@   0x0801a660: 6069        str	r1, [r5, #4]
@   0x0801a662: 782a        ldrb	r2, [r5, #0]
@   0x0801a664: 1990        adds	r0, r2, r6
@   0x0801a666: 7804        ldrb	r4, [r0, #0]
@   0x0801a668: 2cfe        cmp	r4, #254	@ 0xfe
@   0x0801a66a: d107        bne.n	0x1a67c
@   0x0801a66c: 2001        movs	r0, #1
@   0x0801a66e: 60e8        str	r0, [r5, #12]
@   0x0801a670: e007        b.n	0x1a682
@   0x0801a672: 0000        movs	r0, r0
@   0x0801a674: 81a0        strh	r0, [r4, #12]
@   0x0801a676: 0830        lsrs	r0, r6, #32
@   0x0801a678: 34c0        adds	r4, #192	@ 0xc0
@   0x0801a67a: 0300        lsls	r0, r0, #12
@   0x0801a67c: 2cfd        cmp	r4, #253	@ 0xfd
@   0x0801a67e: d100        bne.n	0x1a682
@   0x0801a680: 60e9        str	r1, [r5, #12]
@   0x0801a682: 4d0a        ldr	r5, [pc, #40]	@ (0x1a6ac)
@   0x0801a684: 7828        ldrb	r0, [r5, #0]
@   0x0801a686: 1c41        adds	r1, r0, #1
@   0x0801a688: 7029        strb	r1, [r5, #0]
@   0x0801a68a: 0600        lsls	r0, r0, #24
@   0x0801a68c: 0e00        lsrs	r0, r0, #24
@   0x0801a68e: 1830        adds	r0, r6, r0
@   0x0801a690: 7804        ldrb	r4, [r0, #0]
@   0x0801a692: 2c00        cmp	r4, #0
@   0x0801a694: d10c        bne.n	0x1a6b0
@   0x0801a696: 1c48        adds	r0, r1, #1
@   0x0801a698: 7028        strb	r0, [r5, #0]
@   0x0801a69a: 0608        lsls	r0, r1, #24
@   0x0801a69c: 0e00        lsrs	r0, r0, #24
@   0x0801a69e: 1830        adds	r0, r6, r0
@   0x0801a6a0: 7800        ldrb	r0, [r0, #0]
@   0x0801a6a2: 7068        strb	r0, [r5, #1]
@   0x0801a6a4: f7e6        f92c 	bl	0x900
@   0x0801a6a8: 6068        str	r0, [r5, #4]
@   0x0801a6aa: e00f        b.n	0x1a6cc
@   0x0801a6ac: 34c0        adds	r4, #192	@ 0xc0
@   0x0801a6ae: 0300        lsls	r0, r0, #12
@   0x0801a6b0: 1ce0        adds	r0, r4, #3
@   0x0801a6b2: 0600        lsls	r0, r0, #24
@   0x0801a6b4: 0e00        lsrs	r0, r0, #24
@   0x0801a6b6: 2801        cmp	r0, #1
@   0x0801a6b8: d907        bls.n	0x1a6ca
@   0x0801a6ba: 2cff        cmp	r4, #255	@ 0xff
@   0x0801a6bc: d106        bne.n	0x1a6cc
@   0x0801a6be: 2000        movs	r0, #0
@   0x0801a6c0: 7028        strb	r0, [r5, #0]
@   0x0801a6c2: 7068        strb	r0, [r5, #1]
@   0x0801a6c4: 60e8        str	r0, [r5, #12]
@   0x0801a6c6: 20ff        movs	r0, #255	@ 0xff
@   0x0801a6c8: e001        b.n	0x1a6ce
@   0x0801a6ca: 2400        movs	r4, #0
@   0x0801a6cc: 1c20        adds	r0, r4, #0
@   0x0801a6ce: bc70        pop	{r4, r5, r6}
@   0x0801a6d0: bc02        pop	{r1}
@   0x0801a6d2: 4708        bx	r1

        thumb_func_start sub_0801A614
sub_0801A614: @ 0x0801a614
        .incbin "frog_us_baserom.gba", 0x1a614, 0xc0
        thumb_func_end sub_0801A614
