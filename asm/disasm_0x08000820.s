@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000820, 0x0800088c)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000820 --end 0x800088c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000820: b510        push	{r4, lr}
@   0x08000822: 490f        ldr	r1, [pc, #60]	@ (0x860)
@   0x08000824: 480f        ldr	r0, [pc, #60]	@ (0x864)
@   0x08000826: 6008        str	r0, [r1, #0]
@   0x08000828: 4c0f        ldr	r4, [pc, #60]	@ (0x868)
@   0x0800082a: 604c        str	r4, [r1, #4]
@   0x0800082c: 480f        ldr	r0, [pc, #60]	@ (0x86c)
@   0x0800082e: 6088        str	r0, [r1, #8]
@   0x08000830: 6888        ldr	r0, [r1, #8]
@   0x08000832: 490f        ldr	r1, [pc, #60]	@ (0x870)
@   0x08000834: 2003        movs	r0, #3
@   0x08000836: f033        f86b 	bl	0x33910
@   0x0800083a: 480e        ldr	r0, [pc, #56]	@ (0x874)
@   0x0800083c: 6004        str	r4, [r0, #0]
@   0x0800083e: 490e        ldr	r1, [pc, #56]	@ (0x878)
@   0x08000840: 2001        movs	r0, #1
@   0x08000842: 8008        strh	r0, [r1, #0]
@   0x08000844: 3906        subs	r1, #6
@   0x08000846: 2000        movs	r0, #0
@   0x08000848: 8008        strh	r0, [r1, #0]
@   0x0800084a: 3902        subs	r1, #2
@   0x0800084c: 4a0b        ldr	r2, [pc, #44]	@ (0x87c)
@   0x0800084e: 1c10        adds	r0, r2, #0
@   0x08000850: 8008        strh	r0, [r1, #0]
@   0x08000852: 490b        ldr	r1, [pc, #44]	@ (0x880)
@   0x08000854: 2008        movs	r0, #8
@   0x08000856: 8008        strh	r0, [r1, #0]
@   0x08000858: bc10        pop	{r4}
@   0x0800085a: bc01        pop	{r0}
@   0x0800085c: 4700        bx	r0
@   0x0800085e: 0000        movs	r0, r0
@   0x08000860: 00d4        lsls	r4, r2, #3
@   0x08000862: 0400        lsls	r0, r0, #16
@   0x08000864: 012c        lsls	r4, r5, #4
@   0x08000866: 0800        lsrs	r0, r0, #32
@   0x08000868: 58a0        ldr	r0, [r4, r2]
@   0x0800086a: 0300        lsls	r0, r0, #12
@   0x0800086c: 0400        lsls	r0, r0, #16
@   0x0800086e: 8000        strh	r0, [r0, #0]
@   0x08000870: 5db4        ldrb	r4, [r6, r6]
@   0x08000872: 0803        lsrs	r3, r0, #32
@   0x08000874: 7ffc        ldrb	r4, [r7, #31]
@   0x08000876: 0300        lsls	r0, r0, #12
@   0x08000878: 0208        lsls	r0, r1, #8
@   0x0800087a: 0400        lsls	r0, r0, #16
@   0x0800087c: 2011        movs	r0, #17
@   0x0800087e: 0000        movs	r0, r0
@   0x08000880: 0004        movs	r4, r0
@   0x08000882: 0400        lsls	r0, r0, #16
@   0x08000884: 4770        bx	lr
@   0x08000886: 0000        movs	r0, r0
@   0x08000888: 4770        bx	lr

        thumb_func_start sub_08000820
sub_08000820: @ 0x08000820
        .incbin "frog_us_baserom.gba", 0x820, 0x6c
        thumb_func_end sub_08000820
