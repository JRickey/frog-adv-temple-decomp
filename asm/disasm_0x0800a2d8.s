@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a2d8, 0x0800a328)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a2d8 --end 0x800a328 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a2d8: b510        push	{r4, lr}
@   0x0800a2da: f000        f921 	bl	0xa520
@   0x0800a2de: 490e        ldr	r1, [pc, #56]	@ (0xa318)
@   0x0800a2e0: 4c0e        ldr	r4, [pc, #56]	@ (0xa31c)
@   0x0800a2e2: 7aa2        ldrb	r2, [r4, #10]
@   0x0800a2e4: 0090        lsls	r0, r2, #2
@   0x0800a2e6: 1840        adds	r0, r0, r1
@   0x0800a2e8: 6800        ldr	r0, [r0, #0]
@   0x0800a2ea: f029        fcf5 	bl	0x33cd8
@   0x0800a2ee: 480c        ldr	r0, [pc, #48]	@ (0xa320)
@   0x0800a2f0: 7aa1        ldrb	r1, [r4, #10]
@   0x0800a2f2: 1808        adds	r0, r1, r0
@   0x0800a2f4: 7800        ldrb	r0, [r0, #0]
@   0x0800a2f6: f004        ffa9 	bl	0xf24c
@   0x0800a2fa: 490a        ldr	r1, [pc, #40]	@ (0xa324)
@   0x0800a2fc: 7aa4        ldrb	r4, [r4, #10]
@   0x0800a2fe: 00a0        lsls	r0, r4, #2
@   0x0800a300: 1840        adds	r0, r0, r1
@   0x0800a302: 6800        ldr	r0, [r0, #0]
@   0x0800a304: f029        fce8 	bl	0x33cd8
@   0x0800a308: f7ff        fba6 	bl	0x9a58
@   0x0800a30c: f7fe        ff3c 	bl	0x9188
@   0x0800a310: bc10        pop	{r4}
@   0x0800a312: bc01        pop	{r0}
@   0x0800a314: 4700        bx	r0
@   0x0800a316: 0000        movs	r0, r0
@   0x0800a318: 0cb8        lsrs	r0, r7, #18
@   0x0800a31a: 080c        lsrs	r4, r1, #32
@   0x0800a31c: 5330        strh	r0, [r6, r4]
@   0x0800a31e: 0300        lsls	r0, r0, #12
@   0x0800a320: 0d84        lsrs	r4, r0, #22
@   0x0800a322: 080c        lsrs	r4, r1, #32
@   0x0800a324: 0d40        lsrs	r0, r0, #21
@   0x0800a326: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800A2D8
sub_0800A2D8: @ 0x0800a2d8
        .incbin "frog_us_baserom.gba", 0xa2d8, 0x50
        thumb_func_end sub_0800A2D8
