@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800441c, 0x08004470)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800441c --end 0x8004470 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800441c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800441e: 4647        mov	r7, r8
@   0x08004420: b480        push	{r7}
@   0x08004422: 1c04        adds	r4, r0, #0
@   0x08004424: 1c0d        adds	r5, r1, #0
@   0x08004426: 1c16        adds	r6, r2, #0
@   0x08004428: 4698        mov	r8, r3
@   0x0800442a: 9f06        ldr	r7, [sp, #24]
@   0x0800442c: 490f        ldr	r1, [pc, #60]	@ (0x446c)
@   0x0800442e: 200d        movs	r0, #13
@   0x08004430: 7288        strb	r0, [r1, #10]
@   0x08004432: 2002        movs	r0, #2
@   0x08004434: 1c21        adds	r1, r4, #0
@   0x08004436: f002        fbbd 	bl	0x6bb4
@   0x0800443a: 2003        movs	r0, #3
@   0x0800443c: 1c29        adds	r1, r5, #0
@   0x0800443e: 2202        movs	r2, #2
@   0x08004440: f002        fef2 	bl	0x7228
@   0x08004444: 2004        movs	r0, #4
@   0x08004446: 1c31        adds	r1, r6, #0
@   0x08004448: 2202        movs	r2, #2
@   0x0800444a: f002        feed 	bl	0x7228
@   0x0800444e: 4640        mov	r0, r8
@   0x08004450: 1c39        adds	r1, r7, #0
@   0x08004452: 220b        movs	r2, #11
@   0x08004454: f007        f9ac 	bl	0xb7b0
@   0x08004458: 9807        ldr	r0, [sp, #28]
@   0x0800445a: 9908        ldr	r1, [sp, #32]
@   0x0800445c: 2210        movs	r2, #16
@   0x0800445e: f007        f9a7 	bl	0xb7b0
@   0x08004462: bc08        pop	{r3}
@   0x08004464: 4698        mov	r8, r3
@   0x08004466: bcf0        pop	{r4, r5, r6, r7}
@   0x08004468: bc01        pop	{r0}
@   0x0800446a: 4700        bx	r0
@   0x0800446c: 5330        strh	r0, [r6, r4]
@   0x0800446e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800441C
sub_0800441C: @ 0x0800441c
        .incbin "frog_us_baserom.gba", 0x441c, 0x54
        thumb_func_end sub_0800441C
