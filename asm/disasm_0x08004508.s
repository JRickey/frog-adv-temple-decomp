@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004508, 0x08004588)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004508 --end 0x8004588 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004508: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800450a: 464f        mov	r7, r9
@   0x0800450c: 4646        mov	r6, r8
@   0x0800450e: b4c0        push	{r6, r7}
@   0x08004510: 1c06        adds	r6, r0, #0
@   0x08004512: 1c0f        adds	r7, r1, #0
@   0x08004514: 4690        mov	r8, r2
@   0x08004516: 4699        mov	r9, r3
@   0x08004518: 220b        movs	r2, #11
@   0x0800451a: f007        f9fd 	bl	0xb918
@   0x0800451e: 4640        mov	r0, r8
@   0x08004520: 4649        mov	r1, r9
@   0x08004522: 2210        movs	r2, #16
@   0x08004524: f007        f9f8 	bl	0xb918
@   0x08004528: 4915        ldr	r1, [pc, #84]	@ (0x4580)
@   0x0800452a: 2004        movs	r0, #4
@   0x0800452c: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800452e: 4008        ands	r0, r1
@   0x08004530: 2800        cmp	r0, #0
@   0x08004532: d11e        bne.n	0x4572
@   0x08004534: 4c13        ldr	r4, [pc, #76]	@ (0x4584)
@   0x08004536: 7e20        ldrb	r0, [r4, #24]
@   0x08004538: 7e61        ldrb	r1, [r4, #25]
@   0x0800453a: 2308        movs	r3, #8
@   0x0800453c: 5ee2        ldrsh	r2, [r4, r3]
@   0x0800453e: 250a        movs	r5, #10
@   0x08004540: 5f63        ldrsh	r3, [r4, r5]
@   0x08004542: f008        fc21 	bl	0xcd88
@   0x08004546: 0600        lsls	r0, r0, #24
@   0x08004548: 0e05        lsrs	r5, r0, #24
@   0x0800454a: 2010        movs	r0, #16
@   0x0800454c: 8a24        ldrh	r4, [r4, #16]
@   0x0800454e: 4020        ands	r0, r4
@   0x08004550: 2800        cmp	r0, #0
@   0x08004552: d00e        beq.n	0x4572
@   0x08004554: 1c30        adds	r0, r6, #0
@   0x08004556: 1c39        adds	r1, r7, #0
@   0x08004558: 220b        movs	r2, #11
@   0x0800455a: 1c2b        adds	r3, r5, #0
@   0x0800455c: f007        f9a4 	bl	0xb8a8
@   0x08004560: 4640        mov	r0, r8
@   0x08004562: 4649        mov	r1, r9
@   0x08004564: 2210        movs	r2, #16
@   0x08004566: 1c2b        adds	r3, r5, #0
@   0x08004568: f007        f99e 	bl	0xb8a8
@   0x0800456c: 1c28        adds	r0, r5, #0
@   0x0800456e: f006        fa31 	bl	0xa9d4
@   0x08004572: bc18        pop	{r3, r4}
@   0x08004574: 4698        mov	r8, r3
@   0x08004576: 46a1        mov	r9, r4
@   0x08004578: bcf0        pop	{r4, r5, r6, r7}
@   0x0800457a: bc01        pop	{r0}
@   0x0800457c: 4700        bx	r0
@   0x0800457e: 0000        movs	r0, r0
@   0x08004580: 3720        adds	r7, #32
@   0x08004582: 0300        lsls	r0, r0, #12
@   0x08004584: 35e0        adds	r5, #224	@ 0xe0
@   0x08004586: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004508
sub_08004508: @ 0x08004508
        .incbin "frog_us_baserom.gba", 0x4508, 0x80
        thumb_func_end sub_08004508
