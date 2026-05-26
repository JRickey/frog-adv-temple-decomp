@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020bc0, 0x08020bf0)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020bc0 --end 0x8020bf0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020bc0: b500        push	{lr}
@   0x08020bc2: 4907        ldr	r1, [pc, #28]	@ (0x20be0)
@   0x08020bc4: 2002        movs	r0, #2
@   0x08020bc6: 7809        ldrb	r1, [r1, #0]
@   0x08020bc8: 4008        ands	r0, r1
@   0x08020bca: 2800        cmp	r0, #0
@   0x08020bcc: d005        beq.n	0x20bda
@   0x08020bce: f011        fabb 	bl	0x32148
@   0x08020bd2: 2800        cmp	r0, #0
@   0x08020bd4: d101        bne.n	0x20bda
@   0x08020bd6: f011        ff0d 	bl	0x329f4
@   0x08020bda: bc01        pop	{r0}
@   0x08020bdc: 4700        bx	r0
@   0x08020bde: 0000        movs	r0, r0
@   0x08020be0: 3570        adds	r5, #112	@ 0x70
@   0x08020be2: 0300        lsls	r0, r0, #12
@   0x08020be4: 4901        ldr	r1, [pc, #4]	@ (0x20bec)
@   0x08020be6: 7048        strb	r0, [r1, #1]
@   0x08020be8: 4770        bx	lr
@   0x08020bea: 0000        movs	r0, r0
@   0x08020bec: 3570        adds	r5, #112	@ 0x70
@   0x08020bee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020BC0
sub_08020BC0: @ 0x08020bc0
        .incbin "frog_us_baserom.gba", 0x20bc0, 0x30
        thumb_func_end sub_08020BC0
