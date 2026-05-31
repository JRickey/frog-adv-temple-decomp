@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a158, 0x0800a1c8)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a158 --end 0x800a1c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a158: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800a15a: b083        sub	sp, #12
@   0x0800a15c: 888b        ldrh	r3, [r1, #4]
@   0x0800a15e: 8ccc        ldrh	r4, [r1, #38]	@ 0x26
@   0x0800a160: 191a        adds	r2, r3, r4
@   0x0800a162: 1c0b        adds	r3, r1, #0
@   0x0800a164: 3329        adds	r3, #41	@ 0x29
@   0x0800a166: 781e        ldrb	r6, [r3, #0]
@   0x0800a168: 1b92        subs	r2, r2, r6
@   0x0800a16a: 0412        lsls	r2, r2, #16
@   0x0800a16c: 0c12        lsrs	r2, r2, #16
@   0x0800a16e: 4c14        ldr	r4, [pc, #80]	@ (0xa1c0)
@   0x0800a170: 1c23        adds	r3, r4, #0
@   0x0800a172: 9d01        ldr	r5, [sp, #4]
@   0x0800a174: 402b        ands	r3, r5
@   0x0800a176: 4313        orrs	r3, r2
@   0x0800a178: 9301        str	r3, [sp, #4]
@   0x0800a17a: 884f        ldrh	r7, [r1, #2]
@   0x0800a17c: 8c8a        ldrh	r2, [r1, #36]	@ 0x24
@   0x0800a17e: 18bd        adds	r5, r7, r2
@   0x0800a180: 3128        adds	r1, #40	@ 0x28
@   0x0800a182: 780f        ldrb	r7, [r1, #0]
@   0x0800a184: 087a        lsrs	r2, r7, #1
@   0x0800a186: 1aad        subs	r5, r5, r2
@   0x0800a188: 042d        lsls	r5, r5, #16
@   0x0800a18a: 4a0e        ldr	r2, [pc, #56]	@ (0xa1c4)
@   0x0800a18c: 4013        ands	r3, r2
@   0x0800a18e: 432b        orrs	r3, r5
@   0x0800a190: 9301        str	r3, [sp, #4]
@   0x0800a192: 9b02        ldr	r3, [sp, #8]
@   0x0800a194: 401c        ands	r4, r3
@   0x0800a196: 7809        ldrb	r1, [r1, #0]
@   0x0800a198: 430c        orrs	r4, r1
@   0x0800a19a: 9402        str	r4, [sp, #8]
@   0x0800a19c: 0436        lsls	r6, r6, #16
@   0x0800a19e: 4014        ands	r4, r2
@   0x0800a1a0: 4334        orrs	r4, r6
@   0x0800a1a2: 9402        str	r4, [sp, #8]
@   0x0800a1a4: 2100        movs	r1, #0
@   0x0800a1a6: 9100        str	r1, [sp, #0]
@   0x0800a1a8: 9901        ldr	r1, [sp, #4]
@   0x0800a1aa: 9a02        ldr	r2, [sp, #8]
@   0x0800a1ac: 2300        movs	r3, #0
@   0x0800a1ae: f002        fe8f 	bl	0xced0
@   0x0800a1b2: 0600        lsls	r0, r0, #24
@   0x0800a1b4: 0e00        lsrs	r0, r0, #24
@   0x0800a1b6: b003        add	sp, #12
@   0x0800a1b8: bcf0        pop	{r4, r5, r6, r7}
@   0x0800a1ba: bc02        pop	{r1}
@   0x0800a1bc: 4708        bx	r1
@   0x0800a1be: 0000        movs	r0, r0
@   0x0800a1c0: 0000        movs	r0, r0
@   0x0800a1c2: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff

        thumb_func_start sub_0800A158
sub_0800A158: @ 0x0800a158
        .incbin "frog_us_baserom.gba", 0xa158, 0x70
        thumb_func_end sub_0800A158
