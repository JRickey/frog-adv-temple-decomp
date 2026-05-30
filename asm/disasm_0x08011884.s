@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011884, 0x080118d8)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011884 --end 0x80118d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011884: b530        push	{r4, r5, lr}
@   0x08011886: b081        sub	sp, #4
@   0x08011888: 2400        movs	r4, #0
@   0x0801188a: 490f        ldr	r1, [pc, #60]	@ (0x118c8)
@   0x0801188c: 6848        ldr	r0, [r1, #4]
@   0x0801188e: 6949        ldr	r1, [r1, #20]
@   0x08011890: 4a0e        ldr	r2, [pc, #56]	@ (0x118cc)
@   0x08011892: 6853        ldr	r3, [r2, #4]
@   0x08011894: 250e        movs	r5, #14
@   0x08011896: 5f52        ldrsh	r2, [r2, r5]
@   0x08011898: 9200        str	r2, [sp, #0]
@   0x0801189a: 1c1a        adds	r2, r3, #0
@   0x0801189c: f000        fcce 	bl	0x1223c
@   0x080118a0: f000        fc6e 	bl	0x12180
@   0x080118a4: 480a        ldr	r0, [pc, #40]	@ (0x118d0)
@   0x080118a6: 6840        ldr	r0, [r0, #4]
@   0x080118a8: 2800        cmp	r0, #0
@   0x080118aa: d108        bne.n	0x118be
@   0x080118ac: 4909        ldr	r1, [pc, #36]	@ (0x118d4)
@   0x080118ae: 6848        ldr	r0, [r1, #4]
@   0x080118b0: 2800        cmp	r0, #0
@   0x080118b2: d104        bne.n	0x118be
@   0x080118b4: 220e        movs	r2, #14
@   0x080118b6: 5e88        ldrsh	r0, [r1, r2]
@   0x080118b8: 2800        cmp	r0, #0
@   0x080118ba: d100        bne.n	0x118be
@   0x080118bc: 2401        movs	r4, #1
@   0x080118be: 1c20        adds	r0, r4, #0
@   0x080118c0: b001        add	sp, #4
@   0x080118c2: bc30        pop	{r4, r5}
@   0x080118c4: bc02        pop	{r1}
@   0x080118c6: 4708        bx	r1
@   0x080118c8: 6e08        ldr	r0, [r1, #96]	@ 0x60
@   0x080118ca: 0830        lsrs	r0, r6, #32
@   0x080118cc: 6e28        ldr	r0, [r5, #96]	@ 0x60
@   0x080118ce: 0830        lsrs	r0, r6, #32
@   0x080118d0: 6150        str	r0, [r2, #20]
@   0x080118d2: 0300        lsls	r0, r0, #12
@   0x080118d4: 5360        strh	r0, [r4, r5]
@   0x080118d6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08011884
sub_08011884: @ 0x08011884
        .incbin "frog_us_baserom.gba", 0x11884, 0x54
        thumb_func_end sub_08011884
