@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080115f8, 0x080116b8)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80115f8 --end 0x80116b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080115f8: b570        push	{r4, r5, r6, lr}
@   0x080115fa: b081        sub	sp, #4
@   0x080115fc: 2600        movs	r6, #0
@   0x080115fe: 4d04        ldr	r5, [pc, #16]	@ (0x11610)
@   0x08011600: 7828        ldrb	r0, [r5, #0]
@   0x08011602: 2801        cmp	r0, #1
@   0x08011604: d00e        beq.n	0x11624
@   0x08011606: 2801        cmp	r0, #1
@   0x08011608: dc04        bgt.n	0x11614
@   0x0801160a: 2800        cmp	r0, #0
@   0x0801160c: d005        beq.n	0x1161a
@   0x0801160e: e048        b.n	0x116a2
@   0x08011610: 53a0        strh	r0, [r4, r6]
@   0x08011612: 0300        lsls	r0, r0, #12
@   0x08011614: 2802        cmp	r0, #2
@   0x08011616: d035        beq.n	0x11684
@   0x08011618: e043        b.n	0x116a2
@   0x0801161a: f000        ff59 	bl	0x124d0
@   0x0801161e: 2001        movs	r0, #1
@   0x08011620: 7028        strb	r0, [r5, #0]
@   0x08011622: e03e        b.n	0x116a2
@   0x08011624: 4911        ldr	r1, [pc, #68]	@ (0x1166c)
@   0x08011626: 6848        ldr	r0, [r1, #4]
@   0x08011628: 6949        ldr	r1, [r1, #20]
@   0x0801162a: 4a11        ldr	r2, [pc, #68]	@ (0x11670)
@   0x0801162c: 6853        ldr	r3, [r2, #4]
@   0x0801162e: 240e        movs	r4, #14
@   0x08011630: 5f12        ldrsh	r2, [r2, r4]
@   0x08011632: 9200        str	r2, [sp, #0]
@   0x08011634: 1c1a        adds	r2, r3, #0
@   0x08011636: f000        fe01 	bl	0x1223c
@   0x0801163a: f000        fda1 	bl	0x12180
@   0x0801163e: 480d        ldr	r0, [pc, #52]	@ (0x11674)
@   0x08011640: 6840        ldr	r0, [r0, #4]
@   0x08011642: 490d        ldr	r1, [pc, #52]	@ (0x11678)
@   0x08011644: 4c0d        ldr	r4, [pc, #52]	@ (0x1167c)
@   0x08011646: 7aa2        ldrb	r2, [r4, #10]
@   0x08011648: 0090        lsls	r0, r2, #2
@   0x0801164a: 1840        adds	r0, r0, r1
@   0x0801164c: 6800        ldr	r0, [r0, #0]
@   0x0801164e: f022        fb43 	bl	0x33cd8
@   0x08011652: 2003        movs	r0, #3
@   0x08011654: f7ff        ff8e 	bl	0x11574
@   0x08011658: 0600        lsls	r0, r0, #24
@   0x0801165a: 2800        cmp	r0, #0
@   0x0801165c: d021        beq.n	0x116a2
@   0x0801165e: 4808        ldr	r0, [pc, #32]	@ (0x11680)
@   0x08011660: 6821        ldr	r1, [r4, #0]
@   0x08011662: 6041        str	r1, [r0, #4]
@   0x08011664: 2002        movs	r0, #2
@   0x08011666: 7028        strb	r0, [r5, #0]
@   0x08011668: e01b        b.n	0x116a2
@   0x0801166a: 0000        movs	r0, r0
@   0x0801166c: 6e08        ldr	r0, [r1, #96]	@ 0x60
@   0x0801166e: 0830        lsrs	r0, r6, #32
@   0x08011670: 6e28        ldr	r0, [r5, #96]	@ 0x60
@   0x08011672: 0830        lsrs	r0, r6, #32
@   0x08011674: 6150        str	r0, [r2, #20]
@   0x08011676: 0300        lsls	r0, r0, #12
@   0x08011678: 0cb8        lsrs	r0, r7, #18
@   0x0801167a: 080c        lsrs	r4, r1, #32
@   0x0801167c: 5330        strh	r0, [r6, r4]
@   0x0801167e: 0300        lsls	r0, r0, #12
@   0x08011680: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08011682: 0300        lsls	r0, r0, #12
@   0x08011684: 4909        ldr	r1, [pc, #36]	@ (0x116ac)
@   0x08011686: 4c0a        ldr	r4, [pc, #40]	@ (0x116b0)
@   0x08011688: 7aa2        ldrb	r2, [r4, #10]
@   0x0801168a: 0090        lsls	r0, r2, #2
@   0x0801168c: 1840        adds	r0, r0, r1
@   0x0801168e: 6800        ldr	r0, [r0, #0]
@   0x08011690: f022        fb22 	bl	0x33cd8
@   0x08011694: 4907        ldr	r1, [pc, #28]	@ (0x116b4)
@   0x08011696: 6820        ldr	r0, [r4, #0]
@   0x08011698: 6849        ldr	r1, [r1, #4]
@   0x0801169a: 1a40        subs	r0, r0, r1
@   0x0801169c: 283b        cmp	r0, #59	@ 0x3b
@   0x0801169e: d900        bls.n	0x116a2
@   0x080116a0: 2601        movs	r6, #1
@   0x080116a2: 1c30        adds	r0, r6, #0
@   0x080116a4: b001        add	sp, #4
@   0x080116a6: bc70        pop	{r4, r5, r6}
@   0x080116a8: bc02        pop	{r1}
@   0x080116aa: 4708        bx	r1
@   0x080116ac: 0cb8        lsrs	r0, r7, #18
@   0x080116ae: 080c        lsrs	r4, r1, #32
@   0x080116b0: 5330        strh	r0, [r6, r4]
@   0x080116b2: 0300        lsls	r0, r0, #12
@   0x080116b4: 6580        str	r0, [r0, #88]	@ 0x58
@   0x080116b6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080115F8
sub_080115F8: @ 0x080115f8
        .incbin "frog_us_baserom.gba", 0x115f8, 0xc0
        thumb_func_end sub_080115F8
