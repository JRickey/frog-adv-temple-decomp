@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025578, 0x080255bc)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025578 --end 0x80255bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025578: b570        push	{r4, r5, r6, lr}
@   0x0802557a: b084        sub	sp, #16
@   0x0802557c: 2400        movs	r4, #0
@   0x0802557e: 4e0d        ldr	r6, [pc, #52]	@ (0x255b4)
@   0x08025580: 2503        movs	r5, #3
@   0x08025582: 1c20        adds	r0, r4, #0
@   0x08025584: 305f        adds	r0, #95	@ 0x5f
@   0x08025586: 00a1        lsls	r1, r4, #2
@   0x08025588: 1989        adds	r1, r1, r6
@   0x0802558a: 6809        ldr	r1, [r1, #0]
@   0x0802558c: 4a0a        ldr	r2, [pc, #40]	@ (0x255b8)
@   0x0802558e: 9200        str	r2, [sp, #0]
@   0x08025590: 220c        movs	r2, #12
@   0x08025592: 9201        str	r2, [sp, #4]
@   0x08025594: 9502        str	r5, [sp, #8]
@   0x08025596: 9503        str	r5, [sp, #12]
@   0x08025598: 2210        movs	r2, #16
@   0x0802559a: 2326        movs	r3, #38	@ 0x26
@   0x0802559c: f7fb        fd80 	bl	0x210a0
@   0x080255a0: 1c60        adds	r0, r4, #1
@   0x080255a2: 0600        lsls	r0, r0, #24
@   0x080255a4: 0e04        lsrs	r4, r0, #24
@   0x080255a6: 2c03        cmp	r4, #3
@   0x080255a8: d9eb        bls.n	0x25582
@   0x080255aa: b004        add	sp, #16
@   0x080255ac: bc70        pop	{r4, r5, r6}
@   0x080255ae: bc01        pop	{r0}
@   0x080255b0: 4700        bx	r0
@   0x080255b2: 0000        movs	r0, r0
@   0x080255b4: 4048        eors	r0, r1
@   0x080255b6: 0831        lsrs	r1, r6, #32
@   0x080255b8: 02f1        lsls	r1, r6, #11

        thumb_func_start sub_08025578
sub_08025578: @ 0x08025578
        .incbin "baserom.gba", 0x25578, 0x44
        thumb_func_end sub_08025578
