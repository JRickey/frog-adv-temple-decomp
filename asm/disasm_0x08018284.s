@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08018284, 0x080182cc)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x18284 --end 0x182cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08018284: b510        push	{r4, lr}
@   0x08018286: f7e8 fb3b 	bl	0x900
@   0x0801828a: 4c0c        ldr	r4, [pc, #48]	@ (0x182bc)
@   0x0801828c: 60e0        str	r0, [r4, #12]
@   0x0801828e: 20bf        movs	r0, #191	@ 0xbf
@   0x08018290: f7f8 fa2c 	bl	0x106ec
@   0x08018294: 490a        ldr	r1, [pc, #40]	@ (0x182c0)
@   0x08018296: 2200        movs	r2, #0
@   0x08018298: 700a        strb	r2, [r1, #0]
@   0x0801829a: 704a        strb	r2, [r1, #1]
@   0x0801829c: 20a0        movs	r0, #160	@ 0xa0
@   0x0801829e: 70c8        strb	r0, [r1, #3]
@   0x080182a0: 20f0        movs	r0, #240	@ 0xf0
@   0x080182a2: 7088        strb	r0, [r1, #2]
@   0x080182a4: 4807        ldr	r0, [pc, #28]	@ (0x182c4)
@   0x080182a6: 2100        movs	r1, #0
@   0x080182a8: 8002        strh	r2, [r0, #0]
@   0x080182aa: 8042        strh	r2, [r0, #2]
@   0x080182ac: 78e0        ldrb	r0, [r4, #3]
@   0x080182ae: 3001        adds	r0, #1
@   0x080182b0: 70e0        strb	r0, [r4, #3]
@   0x080182b2: 4805        ldr	r0, [pc, #20]	@ (0x182c8)
@   0x080182b4: 7041        strb	r1, [r0, #1]
@   0x080182b6: bc10        pop	{r4}
@   0x080182b8: bc01        pop	{r0}
@   0x080182ba: 4700        bx	r0
@   0x080182bc: 3480        .word 0x03003480
@   0x080182c0: 3470        .word 0x03003470
@   0x080182c4: 3550        .word 0x03003550
@   0x080182c8: 34a0        .word 0x030034a0

        thumb_func_start sub_08018284
sub_08018284: @ 0x08018284
        .incbin "frog_us_baserom.gba", 0x18284, 0x48
        thumb_func_end sub_08018284
