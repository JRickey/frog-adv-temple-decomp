@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013828, 0x08013880)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x13828 --end 0x13880 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013828: b500        push	{lr}
@   0x0801382a: 2003        movs	r0, #3
@   0x0801382c: f7fb f816 	bl	sub_0800E85C
@   0x08013830: f7fb f974 	bl	sub_0800EB1C
@   0x08013834: 2002        movs	r0, #2
@   0x08013836: f7fb fd09 	bl	sub_0800F24C
@   0x0801383a: 480f        ldr	r0, [pc, #60]
@   0x0801383c: 2200        movs	r2, #0
@   0x0801383e: 7002        strb	r2, [r0, #0]
@   0x08013840: 1c01        adds	r1, r0, #0
@   0x08013842: 31dc        adds	r1, #220
@   0x08013844: 700a        strb	r2, [r1, #0]
@   0x08013846: 30d4        adds	r0, #212
@   0x08013848: 7002        strb	r2, [r0, #0]
@   0x0801384a: 490c        ldr	r1, [pc, #48]
@   0x0801384c: 850a        strh	r2, [r1, #40]
@   0x0801384e: 312b        adds	r1, #43
@   0x08013850: 200f        movs	r0, #15
@   0x08013852: 780a        ldrb	r2, [r1, #0]
@   0x08013854: 4010        ands	r0, r2
@   0x08013856: 7008        strb	r0, [r1, #0]
@   0x08013858: f7ff fc58 	bl	sub_0801310C
@   0x0801385c: f7ff fc56 	bl	sub_0801310C
@   0x08013860: 2003        movs	r0, #3
@   0x08013862: f7fb f9bb 	bl	sub_0800EBDC
@   0x08013866: f003 f8eb 	bl	sub_08016A40
@   0x0801386a: f7ff fadf 	bl	sub_08012E2C
@   0x0801386e: 2002        movs	r0, #2
@   0x08013870: f7fb fae0 	bl	sub_0800EE34
@   0x08013874: bc01        pop	{r0}
@   0x08013876: 4700        bx	r0

        thumb_func_start sub_08013828
sub_08013828: @ 0x08013828
        .incbin "frog_us_baserom.gba", 0x13828, 0x58
        thumb_func_end sub_08013828
