@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025644, 0x080256c8)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025644 --end 0x80256c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025644: b510        push	{r4, lr}
@   0x08025646: 491e        ldr	r1, [pc, #120]	@ (0x256c0)
@   0x08025648: 2002        movs	r0, #2
@   0x0802564a: 8a0a        ldrh	r2, [r1, #16]
@   0x0802564c: 4010        ands	r0, r2
@   0x0802564e: 2800        cmp	r0, #0
@   0x08025650: d019        beq.n	0x25686
@   0x08025652: 7b88        ldrb	r0, [r1, #14]
@   0x08025654: 2800        cmp	r0, #0
@   0x08025656: d016        beq.n	0x25686
@   0x08025658: 4a1a        ldr	r2, [pc, #104]	@ (0x256c4)
@   0x0802565a: 7b8b        ldrb	r3, [r1, #14]
@   0x0802565c: 00d8        lsls	r0, r3, #3
@   0x0802565e: 1ac0        subs	r0, r0, r3
@   0x08025660: 00c0        lsls	r0, r0, #3
@   0x08025662: 1880        adds	r0, r0, r2
@   0x08025664: 8844        ldrh	r4, [r0, #2]
@   0x08025666: 8c83        ldrh	r3, [r0, #36]	@ 0x24
@   0x08025668: 18e0        adds	r0, r4, r3
@   0x0802566a: 8050        strh	r0, [r2, #2]
@   0x0802566c: 7b8c        ldrb	r4, [r1, #14]
@   0x0802566e: 00e0        lsls	r0, r4, #3
@   0x08025670: 1b00        subs	r0, r0, r4
@   0x08025672: 00c0        lsls	r0, r0, #3
@   0x08025674: 1880        adds	r0, r0, r2
@   0x08025676: 8883        ldrh	r3, [r0, #4]
@   0x08025678: 8cc4        ldrh	r4, [r0, #38]	@ 0x26
@   0x0802567a: 1919        adds	r1, r3, r4
@   0x0802567c: 3029        adds	r0, #41	@ 0x29
@   0x0802567e: 7800        ldrb	r0, [r0, #0]
@   0x08025680: 0840        lsrs	r0, r0, #1
@   0x08025682: 1a09        subs	r1, r1, r0
@   0x08025684: 8091        strh	r1, [r2, #4]
@   0x08025686: f7ff        fd8f 	bl	0x251a8
@   0x0802568a: f7ff        fdb3 	bl	0x251f4
@   0x0802568e: f7ff        fdd7 	bl	0x25240
@   0x08025692: f7ff        fe0d 	bl	0x252b0
@   0x08025696: f7ff        fe49 	bl	0x2532c
@   0x0802569a: f7ff        fe79 	bl	0x25390
@   0x0802569e: f7ff        fecd 	bl	0x2543c
@   0x080256a2: f7ff        fb15 	bl	0x24cd0
@   0x080256a6: f7ff        fb89 	bl	0x24dbc
@   0x080256aa: f7ff        fcef 	bl	0x2508c
@   0x080256ae: f7ff        ff2b 	bl	0x25508
@   0x080256b2: f7ff        ff83 	bl	0x255bc
@   0x080256b6: f7ff        ffb3 	bl	0x25620
@   0x080256ba: bc10        pop	{r4}
@   0x080256bc: bc01        pop	{r0}
@   0x080256be: 4700        bx	r0
@   0x080256c0: 35e0        adds	r5, #224	@ 0xe0
@   0x080256c2: 0300        lsls	r0, r0, #12
@   0x080256c4: 3720        adds	r7, #32
@   0x080256c6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025644
sub_08025644: @ 0x08025644
        .incbin "baserom.gba", 0x25644, 0x84
        thumb_func_end sub_08025644
