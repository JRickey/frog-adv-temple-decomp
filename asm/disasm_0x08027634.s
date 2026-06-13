@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027634, 0x08027680)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027634 --end 0x8027680 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027634: b530        push	{r4, r5, lr}
@   0x08027636: b084        sub	sp, #16
@   0x08027638: 2400        movs	r4, #0
@   0x0802763a: 2503        movs	r5, #3
@   0x0802763c: 1c20        adds	r0, r4, #0
@   0x0802763e: 3064        adds	r0, #100	@ 0x64
@   0x08027640: 4a0d        ldr	r2, [pc, #52]	@ (0x27678)
@   0x08027642: 00a1        lsls	r1, r4, #2
@   0x08027644: 1889        adds	r1, r1, r2
@   0x08027646: 6809        ldr	r1, [r1, #0]
@   0x08027648: 1c22        adds	r2, r4, #0
@   0x0802764a: 402a        ands	r2, r5
@   0x0802764c: 0592        lsls	r2, r2, #22
@   0x0802764e: 4b0b        ldr	r3, [pc, #44]	@ (0x2767c)
@   0x08027650: 18d2        adds	r2, r2, r3
@   0x08027652: 0c12        lsrs	r2, r2, #16
@   0x08027654: 9200        str	r2, [sp, #0]
@   0x08027656: 220b        movs	r2, #11
@   0x08027658: 9201        str	r2, [sp, #4]
@   0x0802765a: 9502        str	r5, [sp, #8]
@   0x0802765c: 9503        str	r5, [sp, #12]
@   0x0802765e: 2210        movs	r2, #16
@   0x08027660: 2339        movs	r3, #57	@ 0x39
@   0x08027662: f7f9        fd1d 	bl	0x210a0
@   0x08027666: 1c60        adds	r0, r4, #1
@   0x08027668: 0600        lsls	r0, r0, #24
@   0x0802766a: 0e04        lsrs	r4, r0, #24
@   0x0802766c: 2c03        cmp	r4, #3
@   0x0802766e: d9e5        bls.n	0x2763c
@   0x08027670: b004        add	sp, #16
@   0x08027672: bc30        pop	{r4, r5}
@   0x08027674: bc01        pop	{r0}
@   0x08027676: 4700        bx	r0
@   0x08027678: 66f4        str	r4, [r6, #108]	@ 0x6c
@   0x0802767a: 0831        lsrs	r1, r6, #32
@   0x0802767c: 0000        movs	r0, r0
@   0x0802767e: 0171        lsls	r1, r6, #5

        thumb_func_start sub_08027634
sub_08027634: @ 0x08027634
        .incbin "baserom.gba", 0x27634, 0x4c
        thumb_func_end sub_08027634
