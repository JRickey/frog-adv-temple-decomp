@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019984, 0x080199e4)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019984 --end 0x80199e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019984: b530        push	{r4, r5, lr}
@   0x08019986: 4904        ldr	r1, [pc, #16]	@ (0x19998)
@   0x08019988: 7b88        ldrb	r0, [r1, #14]
@   0x0801998a: 2800        cmp	r0, #0
@   0x0801998c: d00e        beq.n	0x199ac
@   0x0801998e: 4903        ldr	r1, [pc, #12]	@ (0x1999c)
@   0x08019990: 2000        movs	r0, #0
@   0x08019992: 7408        strb	r0, [r1, #16]
@   0x08019994: e006        b.n	0x199a4
@   0x08019996: 0000        movs	r0, r0
@   0x08019998: 53a0        strh	r0, [r4, r6]
@   0x0801999a: 0300        lsls	r0, r0, #12
@   0x0801999c: 5330        strh	r0, [r6, r4]
@   0x0801999e: 0300        lsls	r0, r0, #12
@   0x080199a0: 2000        movs	r0, #0
@   0x080199a2: 7428        strb	r0, [r5, #16]
@   0x080199a4: 2001        movs	r0, #1
@   0x080199a6: f007        f967 	bl	0x20c78
@   0x080199aa: e013        b.n	0x199d4
@   0x080199ac: 2200        movs	r2, #0
@   0x080199ae: 4d0b        ldr	r5, [pc, #44]	@ (0x199dc)
@   0x080199b0: 1c0c        adds	r4, r1, #0
@   0x080199b2: 4b0b        ldr	r3, [pc, #44]	@ (0x199e0)
@   0x080199b4: 1911        adds	r1, r2, r4
@   0x080199b6: 18d0        adds	r0, r2, r3
@   0x080199b8: 7809        ldrb	r1, [r1, #0]
@   0x080199ba: 7800        ldrb	r0, [r0, #0]
@   0x080199bc: 4281        cmp	r1, r0
@   0x080199be: d1ef        bne.n	0x199a0
@   0x080199c0: 1c50        adds	r0, r2, #1
@   0x080199c2: 0600        lsls	r0, r0, #24
@   0x080199c4: 0e02        lsrs	r2, r0, #24
@   0x080199c6: 2a0b        cmp	r2, #11
@   0x080199c8: d9f4        bls.n	0x199b4
@   0x080199ca: 2001        movs	r0, #1
@   0x080199cc: 7428        strb	r0, [r5, #16]
@   0x080199ce: 200d        movs	r0, #13
@   0x080199d0: f007        f952 	bl	0x20c78
@   0x080199d4: bc30        pop	{r4, r5}
@   0x080199d6: bc01        pop	{r0}
@   0x080199d8: 4700        bx	r0
@   0x080199da: 0000        movs	r0, r0
@   0x080199dc: 5330        strh	r0, [r6, r4]
@   0x080199de: 0300        lsls	r0, r0, #12
@   0x080199e0: 3610        adds	r6, #16
@   0x080199e2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019984
sub_08019984: @ 0x08019984
        .incbin "frog_us_baserom.gba", 0x19984, 0x60
        thumb_func_end sub_08019984
