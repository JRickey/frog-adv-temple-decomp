@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020270, 0x080202a8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020270 --end 0x80202a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020270: b500        push	{lr}
@   0x08020272: 490a        ldr	r1, [pc, #40]	@ (0x2029c)
@   0x08020274: 2000        movs	r0, #0
@   0x08020276: 2204        movs	r2, #4
@   0x08020278: 724a        strb	r2, [r1, #9]
@   0x0802027a: 4909        ldr	r1, [pc, #36]	@ (0x202a0)
@   0x0802027c: 700a        strb	r2, [r1, #0]
@   0x0802027e: 7148        strb	r0, [r1, #5]
@   0x08020280: 7088        strb	r0, [r1, #2]
@   0x08020282: 7048        strb	r0, [r1, #1]
@   0x08020284: 4a07        ldr	r2, [pc, #28]	@ (0x202a4)
@   0x08020286: 2300        movs	r3, #0
@   0x08020288: 8010        strh	r0, [r2, #0]
@   0x0802028a: 2001        movs	r0, #1
@   0x0802028c: 7188        strb	r0, [r1, #6]
@   0x0802028e: 71cb        strb	r3, [r1, #7]
@   0x08020290: 20bf        movs	r0, #191	@ 0xbf
@   0x08020292: f7f0        f9ff 	bl	0x10694
@   0x08020296: bc01        pop	{r0}
@   0x08020298: 4700        bx	r0
@   0x0802029a: 0000        movs	r0, r0
@   0x0802029c: 5330        strh	r0, [r6, r4]
@   0x0802029e: 0300        lsls	r0, r0, #12
@   0x080202a0: 3480        adds	r4, #128	@ 0x80
@   0x080202a2: 0300        lsls	r0, r0, #12
@   0x080202a4: 5398        strh	r0, [r3, r6]
@   0x080202a6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020270
sub_08020270: @ 0x08020270
        .incbin "frog_us_baserom.gba", 0x20270, 0x38
        thumb_func_end sub_08020270
