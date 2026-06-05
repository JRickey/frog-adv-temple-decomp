@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e0bc, 0x0802e100)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e0bc --end 0x802e100 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e0bc: b510        push	{r4, lr}
@   0x0802e0be: 0600        lsls	r0, r0, #24
@   0x0802e0c0: 0e01        lsrs	r1, r0, #24
@   0x0802e0c2: 480a        ldr	r0, [pc, #40]	@ (0x2e0ec)
@   0x0802e0c4: 6802        ldr	r2, [r0, #0]
@   0x0802e0c6: 7813        ldrb	r3, [r2, #0]
@   0x0802e0c8: 428b        cmp	r3, r1
@   0x0802e0ca: d015        beq.n	0x2e0f8
@   0x0802e0cc: 248c        movs	r4, #140	@ 0x8c
@   0x0802e0ce: 0064        lsls	r4, r4, #1
@   0x0802e0d0: 1910        adds	r0, r2, r4
@   0x0802e0d2: 6800        ldr	r0, [r0, #0]
@   0x0802e0d4: 343a        adds	r4, #58	@ 0x3a
@   0x0802e0d6: 1900        adds	r0, r0, r4
@   0x0802e0d8: 7804        ldrb	r4, [r0, #0]
@   0x0802e0da: 42a1        cmp	r1, r4
@   0x0802e0dc: d900        bls.n	0x2e0e0
@   0x0802e0de: 7801        ldrb	r1, [r0, #0]
@   0x0802e0e0: 7011        strb	r1, [r2, #0]
@   0x0802e0e2: 2900        cmp	r1, #0
@   0x0802e0e4: d104        bne.n	0x2e0f0
@   0x0802e0e6: f001        ff37 	bl	0x2ff58
@   0x0802e0ea: e005        b.n	0x2e0f8
@   0x0802e0ec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e0ee: 0300        lsls	r0, r0, #12
@   0x0802e0f0: 2b00        cmp	r3, #0
@   0x0802e0f2: d101        bne.n	0x2e0f8
@   0x0802e0f4: f002        f8cc 	bl	0x30290
@   0x0802e0f8: bc10        pop	{r4}
@   0x0802e0fa: bc01        pop	{r0}
@   0x0802e0fc: 4700        bx	r0

        thumb_func_start sub_0802E0BC
sub_0802E0BC: @ 0x0802e0bc
        .incbin "frog_us_baserom.gba", 0x2e0bc, 0x44
        thumb_func_end sub_0802E0BC
