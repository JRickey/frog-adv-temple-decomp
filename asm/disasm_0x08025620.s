@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025620, 0x08025644)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025620 --end 0x8025644 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025620: b500        push	{lr}
@   0x08025622: b081        sub	sp, #4
@   0x08025624: 4905        ldr	r1, [pc, #20]	@ (0x2563c)
@   0x08025626: 4b06        ldr	r3, [pc, #24]	@ (0x25640)
@   0x08025628: 2000        movs	r0, #0
@   0x0802562a: 9000        str	r0, [sp, #0]
@   0x0802562c: 2066        movs	r0, #102	@ 0x66
@   0x0802562e: 224c        movs	r2, #76	@ 0x4c
@   0x08025630: f7fb        ff6e 	bl	0x21510
@   0x08025634: b001        add	sp, #4
@   0x08025636: bc01        pop	{r0}
@   0x08025638: 4700        bx	r0
@   0x0802563a: 0000        movs	r0, r0
@   0x0802563c: 33a0        adds	r3, #160	@ 0xa0
@   0x0802563e: 0831        lsrs	r1, r6, #32
@   0x08025640: 6110        str	r0, [r2, #16]
@   0x08025642: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025620
sub_08025620: @ 0x08025620
        .incbin "baserom.gba", 0x25620, 0x24
        thumb_func_end sub_08025620
