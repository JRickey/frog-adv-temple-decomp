@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802af84, 0x0802afc0)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802af84 --end 0x802afc0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802af84: b570        push	{r4, r5, r6, lr}
@   0x0802af86: b084        sub	sp, #16
@   0x0802af88: 2400        movs	r4, #0
@   0x0802af8a: 4e0c        ldr	r6, [pc, #48]	@ (0x2afbc)
@   0x0802af8c: 2503        movs	r5, #3
@   0x0802af8e: 1ca0        adds	r0, r4, #2
@   0x0802af90: 00a1        lsls	r1, r4, #2
@   0x0802af92: 1989        adds	r1, r1, r6
@   0x0802af94: 6809        ldr	r1, [r1, #0]
@   0x0802af96: 2241        movs	r2, #65	@ 0x41
@   0x0802af98: 9200        str	r2, [sp, #0]
@   0x0802af9a: 2201        movs	r2, #1
@   0x0802af9c: 9201        str	r2, [sp, #4]
@   0x0802af9e: 9502        str	r5, [sp, #8]
@   0x0802afa0: 9503        str	r5, [sp, #12]
@   0x0802afa2: 2210        movs	r2, #16
@   0x0802afa4: 2353        movs	r3, #83	@ 0x53
@   0x0802afa6: f7f6        f87b 	bl	0x210a0
@   0x0802afaa: 1c60        adds	r0, r4, #1
@   0x0802afac: 0600        lsls	r0, r0, #24
@   0x0802afae: 0e04        lsrs	r4, r0, #24
@   0x0802afb0: 2c00        cmp	r4, #0
@   0x0802afb2: d0ec        beq.n	0x2af8e
@   0x0802afb4: b004        add	sp, #16
@   0x0802afb6: bc70        pop	{r4, r5, r6}
@   0x0802afb8: bc01        pop	{r0}
@   0x0802afba: 4700        bx	r0
@   0x0802afbc: 7ed4        ldrb	r4, [r2, #27]
@   0x0802afbe: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AF84
sub_0802AF84: @ 0x0802af84
        .incbin "baserom.gba", 0x2af84, 0x3c
        thumb_func_end sub_0802AF84
