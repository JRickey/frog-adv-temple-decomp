@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ce98, 0x0800ced0)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ce98 --end 0x800ced0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ce98: b530        push	{r4, r5, lr}
@   0x0800ce9a: 1c0a        adds	r2, r1, #0
@   0x0800ce9c: 0600        lsls	r0, r0, #24
@   0x0800ce9e: 0612        lsls	r2, r2, #24
@   0x0800cea0: 0e12        lsrs	r2, r2, #24
@   0x0800cea2: 4909        ldr	r1, [pc, #36]	@ (0xcec8)
@   0x0800cea4: 0d40        lsrs	r0, r0, #21
@   0x0800cea6: 1840        adds	r0, r0, r1
@   0x0800cea8: 6803        ldr	r3, [r0, #0]
@   0x0800ceaa: 0091        lsls	r1, r2, #2
@   0x0800ceac: 1889        adds	r1, r1, r2
@   0x0800ceae: 0309        lsls	r1, r1, #12
@   0x0800ceb0: 4a06        ldr	r2, [pc, #24]	@ (0xcecc)
@   0x0800ceb2: 1889        adds	r1, r1, r2
@   0x0800ceb4: 7904        ldrb	r4, [r0, #4]
@   0x0800ceb6: 7945        ldrb	r5, [r0, #5]
@   0x0800ceb8: 1c22        adds	r2, r4, #0
@   0x0800ceba: 436a        muls	r2, r5
@   0x0800cebc: 1c18        adds	r0, r3, #0
@   0x0800cebe: f020        fb49 	bl	0x2d554
@   0x0800cec2: bc30        pop	{r4, r5}
@   0x0800cec4: bc02        pop	{r1}
@   0x0800cec6: 4708        bx	r1
@   0x0800cec8: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ceca: 0830        lsrs	r0, r6, #32
@   0x0800cecc: 0000        movs	r0, r0
@   0x0800cece: 0203        lsls	r3, r0, #8

        thumb_func_start sub_0800CE98
sub_0800CE98: @ 0x0800ce98
        .incbin "frog_us_baserom.gba", 0xce98, 0x38
        thumb_func_end sub_0800CE98
