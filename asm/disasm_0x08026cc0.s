@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026cc0, 0x08026ce8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026cc0 --end 0x8026ce8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026cc0: b500        push	{lr}
@   0x08026cc2: b083        sub	sp, #12
@   0x08026cc4: 4907        ldr	r1, [pc, #28]	@ (0x26ce4)
@   0x08026cc6: 20c1        movs	r0, #193	@ 0xc1
@   0x08026cc8: 9000        str	r0, [sp, #0]
@   0x08026cca: 2008        movs	r0, #8
@   0x08026ccc: 9001        str	r0, [sp, #4]
@   0x08026cce: 2000        movs	r0, #0
@   0x08026cd0: 9002        str	r0, [sp, #8]
@   0x08026cd2: 204c        movs	r0, #76	@ 0x4c
@   0x08026cd4: 2210        movs	r2, #16
@   0x08026cd6: 2302        movs	r3, #2
@   0x08026cd8: f7fa        fa32 	bl	0x21140
@   0x08026cdc: b003        add	sp, #12
@   0x08026cde: bc01        pop	{r0}
@   0x08026ce0: 4700        bx	r0
@   0x08026ce2: 0000        movs	r0, r0
@   0x08026ce4: 58c0        ldr	r0, [r0, r3]
@   0x08026ce6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026CC0
sub_08026CC0: @ 0x08026cc0
        .incbin "baserom.gba", 0x26cc0, 0x28
        thumb_func_end sub_08026CC0
