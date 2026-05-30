@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005308, 0x0800534c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005308 --end 0x800534c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005308: b570        push	{r4, r5, r6, lr}
@   0x0800530a: 4646        mov	r6, r8
@   0x0800530c: b440        push	{r6}
@   0x0800530e: 1c04        adds	r4, r0, #0
@   0x08005310: 1c0d        adds	r5, r1, #0
@   0x08005312: 1c16        adds	r6, r2, #0
@   0x08005314: 4698        mov	r8, r3
@   0x08005316: f004        ffdf 	bl	0xa2d8
@   0x0800531a: f7fb        fadf 	bl	0x8dc
@   0x0800531e: f005        f803 	bl	0xa328
@   0x08005322: f004        f8e9 	bl	0x94f8
@   0x08005326: f004        fb2d 	bl	0x9984
@   0x0800532a: 1c20        adds	r0, r4, #0
@   0x0800532c: 1c29        adds	r1, r5, #0
@   0x0800532e: 1c32        adds	r2, r6, #0
@   0x08005330: 4643        mov	r3, r8
@   0x08005332: f7ff        fced 	bl	0x4d10
@   0x08005336: 4904        ldr	r1, [pc, #16]	@ (0x5348)
@   0x08005338: 6948        ldr	r0, [r1, #20]
@   0x0800533a: 3001        adds	r0, #1
@   0x0800533c: 6148        str	r0, [r1, #20]
@   0x0800533e: bc08        pop	{r3}
@   0x08005340: 4698        mov	r8, r3
@   0x08005342: bc70        pop	{r4, r5, r6}
@   0x08005344: bc01        pop	{r0}
@   0x08005346: 4700        bx	r0
@   0x08005348: 5330        strh	r0, [r6, r4]
@   0x0800534a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08005308
sub_08005308: @ 0x08005308
        .incbin "frog_us_baserom.gba", 0x5308, 0x44
        thumb_func_end sub_08005308
