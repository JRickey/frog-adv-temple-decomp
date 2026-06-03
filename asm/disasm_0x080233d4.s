@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080233d4, 0x08023400)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80233d4 --end 0x8023400 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080233d4: b500        push	{lr}
@   0x080233d6: b083        sub	sp, #12
@   0x080233d8: 4907        ldr	r1, [pc, #28]	@ (0x233f8)
@   0x080233da: 4808        ldr	r0, [pc, #32]	@ (0x233fc)
@   0x080233dc: 9000        str	r0, [sp, #0]
@   0x080233de: 2008        movs	r0, #8
@   0x080233e0: 9001        str	r0, [sp, #4]
@   0x080233e2: 2000        movs	r0, #0
@   0x080233e4: 9002        str	r0, [sp, #8]
@   0x080233e6: 203e        movs	r0, #62	@ 0x3e
@   0x080233e8: 2200        movs	r2, #0
@   0x080233ea: 2304        movs	r3, #4
@   0x080233ec: f7fd        fea8 	bl	0x21140
@   0x080233f0: b003        add	sp, #12
@   0x080233f2: bc01        pop	{r0}
@   0x080233f4: 4700        bx	r0
@   0x080233f6: 0000        movs	r0, r0
@   0x080233f8: 1cb0        adds	r0, r6, #2
@   0x080233fa: 0831        lsrs	r1, r6, #32
@   0x080233fc: 0141        lsls	r1, r0, #5

        thumb_func_start sub_080233D4
sub_080233D4: @ 0x080233d4
        .incbin "frog_us_baserom.gba", 0x233d4, 0x2c
        thumb_func_end sub_080233D4
