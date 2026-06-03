@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023384, 0x080233b0)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023384 --end 0x80233b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023384: b500        push	{lr}
@   0x08023386: b083        sub	sp, #12
@   0x08023388: 4907        ldr	r1, [pc, #28]	@ (0x233a8)
@   0x0802338a: 4808        ldr	r0, [pc, #32]	@ (0x233ac)
@   0x0802338c: 9000        str	r0, [sp, #0]
@   0x0802338e: 200a        movs	r0, #10
@   0x08023390: 9001        str	r0, [sp, #4]
@   0x08023392: 2000        movs	r0, #0
@   0x08023394: 9002        str	r0, [sp, #8]
@   0x08023396: 204e        movs	r0, #78	@ 0x4e
@   0x08023398: 2200        movs	r2, #0
@   0x0802339a: 230b        movs	r3, #11
@   0x0802339c: f7fd        fed0 	bl	0x21140
@   0x080233a0: b003        add	sp, #12
@   0x080233a2: bc01        pop	{r0}
@   0x080233a4: 4700        bx	r0
@   0x080233a6: 0000        movs	r0, r0
@   0x080233a8: 1d38        adds	r0, r7, #4
@   0x080233aa: 0831        lsrs	r1, r6, #32
@   0x080233ac: 0161        lsls	r1, r4, #5

        thumb_func_start sub_08023384
sub_08023384: @ 0x08023384
        .incbin "frog_us_baserom.gba", 0x23384, 0x2c
        thumb_func_end sub_08023384
