@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800690c, 0x08006948)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800690c --end 0x8006948 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800690c: b530        push	{r4, r5, lr}
@   0x0800690e: 4684        mov	ip, r0
@   0x08006910: 9a03        ldr	r2, [sp, #12]
@   0x08006912: 4664        mov	r4, ip
@   0x08006914: 3431        adds	r4, #49	@ 0x31
@   0x08006916: 2000        movs	r0, #0
@   0x08006918: 7020        strb	r0, [r4, #0]
@   0x0800691a: 2400        movs	r4, #0
@   0x0800691c: 2500        movs	r5, #0
@   0x0800691e: 4660        mov	r0, ip
@   0x08006920: 6144        str	r4, [r0, #20]
@   0x08006922: 6185        str	r5, [r0, #24]
@   0x08006924: 61c4        str	r4, [r0, #28]
@   0x08006926: 6205        str	r5, [r0, #32]
@   0x08006928: 3032        adds	r0, #50	@ 0x32
@   0x0800692a: 7002        strb	r2, [r0, #0]
@   0x0800692c: 3802        subs	r0, #2
@   0x0800692e: 7001        strb	r1, [r0, #0]
@   0x08006930: 4660        mov	r0, ip
@   0x08006932: 6343        str	r3, [r0, #52]	@ 0x34
@   0x08006934: bc30        pop	{r4, r5}
@   0x08006936: bc01        pop	{r0}
@   0x08006938: 4700        bx	r0
@   0x0800693a: 0000        movs	r0, r0
@   0x0800693c: 0409        lsls	r1, r1, #16
@   0x0800693e: 0c09        lsrs	r1, r1, #16
@   0x08006940: 8dc2        ldrh	r2, [r0, #46]	@ 0x2e
@   0x08006942: 4311        orrs	r1, r2
@   0x08006944: 85c1        strh	r1, [r0, #46]	@ 0x2e
@   0x08006946: 4770        bx	lr

        thumb_func_start sub_0800690C
sub_0800690C: @ 0x0800690c
        .incbin "frog_us_baserom.gba", 0x690c, 0x3c
        thumb_func_end sub_0800690C
