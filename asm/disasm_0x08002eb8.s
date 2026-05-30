@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002eb8, 0x08002ee8)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002eb8 --end 0x8002ee8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002eb8: b510        push	{r4, lr}
@   0x08002eba: 4b0a        ldr	r3, [pc, #40]	@ (0x2ee4)
@   0x08002ebc: 2010        movs	r0, #16
@   0x08002ebe: 8a19        ldrh	r1, [r3, #16]
@   0x08002ec0: 4008        ands	r0, r1
@   0x08002ec2: 2800        cmp	r0, #0
@   0x08002ec4: d00b        beq.n	0x2ede
@   0x08002ec6: 7e18        ldrb	r0, [r3, #24]
@   0x08002ec8: 7e59        ldrb	r1, [r3, #25]
@   0x08002eca: 2408        movs	r4, #8
@   0x08002ecc: 5f1a        ldrsh	r2, [r3, r4]
@   0x08002ece: 240a        movs	r4, #10
@   0x08002ed0: 5f1b        ldrsh	r3, [r3, r4]
@   0x08002ed2: f009        ff59 	bl	0xcd88
@   0x08002ed6: 0600        lsls	r0, r0, #24
@   0x08002ed8: 0e00        lsrs	r0, r0, #24
@   0x08002eda: f007        ff05 	bl	0xace8
@   0x08002ede: bc10        pop	{r4}
@   0x08002ee0: bc01        pop	{r0}
@   0x08002ee2: 4700        bx	r0
@   0x08002ee4: 35e0        adds	r5, #224	@ 0xe0
@   0x08002ee6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002EB8
sub_08002EB8: @ 0x08002eb8
        .incbin "frog_us_baserom.gba", 0x2eb8, 0x30
        thumb_func_end sub_08002EB8
