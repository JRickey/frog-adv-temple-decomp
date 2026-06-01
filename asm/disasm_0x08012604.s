@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012604, 0x08012664)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012604 --end 0x8012664 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012604: b510        push	{r4, lr}
@   0x08012606: b081        sub	sp, #4
@   0x08012608: 2400        movs	r4, #0
@   0x0801260a: 4912        ldr	r1, [pc, #72]	@ (0x12654)
@   0x0801260c: 7908        ldrb	r0, [r1, #4]
@   0x0801260e: 7d09        ldrb	r1, [r1, #20]
@   0x08012610: 4a11        ldr	r2, [pc, #68]	@ (0x12658)
@   0x08012612: 7913        ldrb	r3, [r2, #4]
@   0x08012614: 7b92        ldrb	r2, [r2, #14]
@   0x08012616: 9200        str	r2, [sp, #0]
@   0x08012618: 1c1a        adds	r2, r3, #0
@   0x0801261a: f7ff        fe0f 	bl	0x1223c
@   0x0801261e: f7ff        fdaf 	bl	0x12180
@   0x08012622: 480e        ldr	r0, [pc, #56]	@ (0x1265c)
@   0x08012624: 6840        ldr	r0, [r0, #4]
@   0x08012626: 2800        cmp	r0, #0
@   0x08012628: d10e        bne.n	0x12648
@   0x0801262a: 490d        ldr	r1, [pc, #52]	@ (0x12660)
@   0x0801262c: 6848        ldr	r0, [r1, #4]
@   0x0801262e: 2800        cmp	r0, #0
@   0x08012630: d10a        bne.n	0x12648
@   0x08012632: 220e        movs	r2, #14
@   0x08012634: 5e88        ldrsh	r0, [r1, r2]
@   0x08012636: 2800        cmp	r0, #0
@   0x08012638: d106        bne.n	0x12648
@   0x0801263a: 2000        movs	r0, #0
@   0x0801263c: f003        fa70 	bl	0x15b20
@   0x08012640: 2001        movs	r0, #1
@   0x08012642: f003        fa6d 	bl	0x15b20
@   0x08012646: 2401        movs	r4, #1
@   0x08012648: 1c20        adds	r0, r4, #0
@   0x0801264a: b001        add	sp, #4
@   0x0801264c: bc10        pop	{r4}
@   0x0801264e: bc02        pop	{r1}
@   0x08012650: 4708        bx	r1
@   0x08012652: 0000        movs	r0, r0
@   0x08012654: 6e08        ldr	r0, [r1, #96]	@ 0x60
@   0x08012656: 0830        lsrs	r0, r6, #32
@   0x08012658: 6e28        ldr	r0, [r5, #96]	@ 0x60
@   0x0801265a: 0830        lsrs	r0, r6, #32
@   0x0801265c: 6150        str	r0, [r2, #20]
@   0x0801265e: 0300        lsls	r0, r0, #12
@   0x08012660: 5360        strh	r0, [r4, r5]
@   0x08012662: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012604
sub_08012604: @ 0x08012604
        .incbin "frog_us_baserom.gba", 0x12604, 0x60
        thumb_func_end sub_08012604
