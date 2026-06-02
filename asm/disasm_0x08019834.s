@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019834, 0x080198a8)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019834 --end 0x80198a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019834: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08019836: 464f        mov	r7, r9
@   0x08019838: 4646        mov	r6, r8
@   0x0801983a: b4c0        push	{r6, r7}
@   0x0801983c: 4681        mov	r9, r0
@   0x0801983e: 9807        ldr	r0, [sp, #28]
@   0x08019840: 0409        lsls	r1, r1, #16
@   0x08019842: 0c09        lsrs	r1, r1, #16
@   0x08019844: 4688        mov	r8, r1
@   0x08019846: 0412        lsls	r2, r2, #16
@   0x08019848: 0c17        lsrs	r7, r2, #16
@   0x0801984a: 061b        lsls	r3, r3, #24
@   0x0801984c: 0e1e        lsrs	r6, r3, #24
@   0x0801984e: 0600        lsls	r0, r0, #24
@   0x08019850: 0e04        lsrs	r4, r0, #24
@   0x08019852: 2c00        cmp	r4, #0
@   0x08019854: d022        beq.n	0x1989c
@   0x08019856: 4d06        ldr	r5, [pc, #24]	@ (0x19870)
@   0x08019858: 2001        movs	r0, #1
@   0x0801985a: 4020        ands	r0, r4
@   0x0801985c: 2800        cmp	r0, #0
@   0x0801985e: d009        beq.n	0x19874
@   0x08019860: 4648        mov	r0, r9
@   0x08019862: 4641        mov	r1, r8
@   0x08019864: 1c3a        adds	r2, r7, #0
@   0x08019866: 1c33        adds	r3, r6, #0
@   0x08019868: f7fe        fe38 	bl	0x184dc
@   0x0801986c: e008        b.n	0x19880
@   0x0801986e: 0000        movs	r0, r0
@   0x08019870: 8100        strh	r0, [r0, #8]
@   0x08019872: 0830        lsrs	r0, r6, #32
@   0x08019874: 4648        mov	r0, r9
@   0x08019876: 1c39        adds	r1, r7, #0
@   0x08019878: 4642        mov	r2, r8
@   0x0801987a: 1c33        adds	r3, r6, #0
@   0x0801987c: f7fe        fe2e 	bl	0x184dc
@   0x08019880: 2005        movs	r0, #5
@   0x08019882: f004        fcf5 	bl	0x1e270
@   0x08019886: 6828        ldr	r0, [r5, #0]
@   0x08019888: 6869        ldr	r1, [r5, #4]
@   0x0801988a: 68aa        ldr	r2, [r5, #8]
@   0x0801988c: 68eb        ldr	r3, [r5, #12]
@   0x0801988e: f7fe        fe97 	bl	0x185c0
@   0x08019892: 1e60        subs	r0, r4, #1
@   0x08019894: 0600        lsls	r0, r0, #24
@   0x08019896: 0e04        lsrs	r4, r0, #24
@   0x08019898: 2c00        cmp	r4, #0
@   0x0801989a: d1dd        bne.n	0x19858
@   0x0801989c: bc18        pop	{r3, r4}
@   0x0801989e: 4698        mov	r8, r3
@   0x080198a0: 46a1        mov	r9, r4
@   0x080198a2: bcf0        pop	{r4, r5, r6, r7}
@   0x080198a4: bc01        pop	{r0}
@   0x080198a6: 4700        bx	r0

        thumb_func_start sub_08019834
sub_08019834: @ 0x08019834
        .incbin "frog_us_baserom.gba", 0x19834, 0x74
        thumb_func_end sub_08019834
