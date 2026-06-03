@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023360, 0x08023384)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023360 --end 0x8023384 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023360: b500        push	{lr}
@   0x08023362: b081        sub	sp, #4
@   0x08023364: 4905        ldr	r1, [pc, #20]	@ (0x2337c)
@   0x08023366: 4b06        ldr	r3, [pc, #24]	@ (0x23380)
@   0x08023368: 2000        movs	r0, #0
@   0x0802336a: 9000        str	r0, [sp, #0]
@   0x0802336c: 2043        movs	r0, #67	@ 0x43
@   0x0802336e: 2202        movs	r2, #2
@   0x08023370: f7fe        f8ce 	bl	0x21510
@   0x08023374: b001        add	sp, #4
@   0x08023376: bc01        pop	{r0}
@   0x08023378: 4700        bx	r0
@   0x0802337a: 0000        movs	r0, r0
@   0x0802337c: 1ce0        adds	r0, r4, #3
@   0x0802337e: 0831        lsrs	r1, r6, #32
@   0x08023380: 6110        str	r0, [r2, #16]
@   0x08023382: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023360
sub_08023360: @ 0x08023360
        .incbin "frog_us_baserom.gba", 0x23360, 0x24
        thumb_func_end sub_08023360
