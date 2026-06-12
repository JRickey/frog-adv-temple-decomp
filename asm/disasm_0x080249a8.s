@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080249a8, 0x080249e8)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80249a8 --end 0x80249e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080249a8: b570        push	{r4, r5, r6, lr}
@   0x080249aa: b084        sub	sp, #16
@   0x080249ac: 2400        movs	r4, #0
@   0x080249ae: 4e0d        ldr	r6, [pc, #52]	@ (0x249e4)
@   0x080249b0: 2503        movs	r5, #3
@   0x080249b2: 1c20        adds	r0, r4, #0
@   0x080249b4: 3049        adds	r0, #73	@ 0x49
@   0x080249b6: 00a1        lsls	r1, r4, #2
@   0x080249b8: 1989        adds	r1, r1, r6
@   0x080249ba: 6809        ldr	r1, [r1, #0]
@   0x080249bc: 22e1        movs	r2, #225	@ 0xe1
@   0x080249be: 9200        str	r2, [sp, #0]
@   0x080249c0: 2206        movs	r2, #6
@   0x080249c2: 9201        str	r2, [sp, #4]
@   0x080249c4: 9502        str	r5, [sp, #8]
@   0x080249c6: 9503        str	r5, [sp, #12]
@   0x080249c8: 2200        movs	r2, #0
@   0x080249ca: 231b        movs	r3, #27
@   0x080249cc: f7fc        fb68 	bl	0x210a0
@   0x080249d0: 1c60        adds	r0, r4, #1
@   0x080249d2: 0600        lsls	r0, r0, #24
@   0x080249d4: 0e04        lsrs	r4, r0, #24
@   0x080249d6: 2c00        cmp	r4, #0
@   0x080249d8: d0eb        beq.n	0x249b2
@   0x080249da: b004        add	sp, #16
@   0x080249dc: bc70        pop	{r4, r5, r6}
@   0x080249de: bc01        pop	{r0}
@   0x080249e0: 4700        bx	r0
@   0x080249e2: 0000        movs	r0, r0
@   0x080249e4: 3344        adds	r3, #68	@ 0x44
@   0x080249e6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080249A8
sub_080249A8: @ 0x080249a8
        .incbin "baserom.gba", 0x249a8, 0x40
        thumb_func_end sub_080249A8
