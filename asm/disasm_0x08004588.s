@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004588, 0x080045e0)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004588 --end 0x80045e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004588: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800458a: 1c04        adds	r4, r0, #0
@   0x0800458c: 1c0d        adds	r5, r1, #0
@   0x0800458e: 1c16        adds	r6, r2, #0
@   0x08004590: 1c1f        adds	r7, r3, #0
@   0x08004592: 4804        ldr	r0, [pc, #16]	@ (0x45a4)
@   0x08004594: 7940        ldrb	r0, [r0, #5]
@   0x08004596: 0600        lsls	r0, r0, #24
@   0x08004598: 1600        asrs	r0, r0, #24
@   0x0800459a: 2801        cmp	r0, #1
@   0x0800459c: dc06        bgt.n	0x45ac
@   0x0800459e: 4902        ldr	r1, [pc, #8]	@ (0x45a8)
@   0x080045a0: 2000        movs	r0, #0
@   0x080045a2: e005        b.n	0x45b0
@   0x080045a4: 35e0        adds	r5, #224	@ 0xe0
@   0x080045a6: 0300        lsls	r0, r0, #12
@   0x080045a8: 6110        str	r0, [r2, #16]
@   0x080045aa: 0300        lsls	r0, r0, #12
@   0x080045ac: 490b        ldr	r1, [pc, #44]	@ (0x45dc)
@   0x080045ae: 2001        movs	r0, #1
@   0x080045b0: 6108        str	r0, [r1, #16]
@   0x080045b2: 1c20        adds	r0, r4, #0
@   0x080045b4: f005        fb2e 	bl	0x9c14
@   0x080045b8: 2800        cmp	r0, #0
@   0x080045ba: d101        bne.n	0x45c0
@   0x080045bc: 2007        movs	r0, #7
@   0x080045be: 7020        strb	r0, [r4, #0]
@   0x080045c0: 1c28        adds	r0, r5, #0
@   0x080045c2: 1c31        adds	r1, r6, #0
@   0x080045c4: 220b        movs	r2, #11
@   0x080045c6: f007        f8f3 	bl	0xb7b0
@   0x080045ca: 1c38        adds	r0, r7, #0
@   0x080045cc: 9905        ldr	r1, [sp, #20]
@   0x080045ce: 2210        movs	r2, #16
@   0x080045d0: f007        f8ee 	bl	0xb7b0
@   0x080045d4: bcf0        pop	{r4, r5, r6, r7}
@   0x080045d6: bc01        pop	{r0}
@   0x080045d8: 4700        bx	r0
@   0x080045da: 0000        movs	r0, r0
@   0x080045dc: 6110        str	r0, [r2, #16]
@   0x080045de: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004588
sub_08004588: @ 0x08004588
        .incbin "frog_us_baserom.gba", 0x4588, 0x58
        thumb_func_end sub_08004588
