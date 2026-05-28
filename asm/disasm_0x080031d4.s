@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080031d4, 0x08003254)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80031d4 --end 0x8003254 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080031d4: b510        push	{r4, lr}
@   0x080031d6: 491c        ldr	r1, [pc, #112]	@ (0x3248)
@   0x080031d8: 2004        movs	r0, #4
@   0x080031da: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x080031dc: 4010        ands	r0, r2
@   0x080031de: 1c0a        adds	r2, r1, #0
@   0x080031e0: 2800        cmp	r0, #0
@   0x080031e2: d12d        bne.n	0x3240
@   0x080031e4: 4919        ldr	r1, [pc, #100]	@ (0x324c)
@   0x080031e6: 2080        movs	r0, #128	@ 0x80
@   0x080031e8: 0140        lsls	r0, r0, #5
@   0x080031ea: 880b        ldrh	r3, [r1, #0]
@   0x080031ec: 4018        ands	r0, r3
@   0x080031ee: 1c0b        adds	r3, r1, #0
@   0x080031f0: 2800        cmp	r0, #0
@   0x080031f2: d00f        beq.n	0x3214
@   0x080031f4: 2402        movs	r4, #2
@   0x080031f6: 5f10        ldrsh	r0, [r2, r4]
@   0x080031f8: 2803        cmp	r0, #3
@   0x080031fa: dd0b        ble.n	0x3214
@   0x080031fc: 4914        ldr	r1, [pc, #80]	@ (0x3250)
@   0x080031fe: 7b8c        ldrb	r4, [r1, #14]
@   0x08003200: 00e0        lsls	r0, r4, #3
@   0x08003202: 1b00        subs	r0, r0, r4
@   0x08003204: 00c0        lsls	r0, r0, #3
@   0x08003206: 1880        adds	r0, r0, r2
@   0x08003208: 8841        ldrh	r1, [r0, #2]
@   0x0800320a: 3903        subs	r1, #3
@   0x0800320c: 8041        strh	r1, [r0, #2]
@   0x0800320e: 8850        ldrh	r0, [r2, #2]
@   0x08003210: 3803        subs	r0, #3
@   0x08003212: 8050        strh	r0, [r2, #2]
@   0x08003214: 2080        movs	r0, #128	@ 0x80
@   0x08003216: 0180        lsls	r0, r0, #6
@   0x08003218: 881b        ldrh	r3, [r3, #0]
@   0x0800321a: 4018        ands	r0, r3
@   0x0800321c: 2800        cmp	r0, #0
@   0x0800321e: d00f        beq.n	0x3240
@   0x08003220: 2102        movs	r1, #2
@   0x08003222: 5e50        ldrsh	r0, [r2, r1]
@   0x08003224: 28ec        cmp	r0, #236	@ 0xec
@   0x08003226: dc0b        bgt.n	0x3240
@   0x08003228: 4909        ldr	r1, [pc, #36]	@ (0x3250)
@   0x0800322a: 7b8b        ldrb	r3, [r1, #14]
@   0x0800322c: 00d8        lsls	r0, r3, #3
@   0x0800322e: 1ac0        subs	r0, r0, r3
@   0x08003230: 00c0        lsls	r0, r0, #3
@   0x08003232: 1880        adds	r0, r0, r2
@   0x08003234: 8841        ldrh	r1, [r0, #2]
@   0x08003236: 3103        adds	r1, #3
@   0x08003238: 8041        strh	r1, [r0, #2]
@   0x0800323a: 8850        ldrh	r0, [r2, #2]
@   0x0800323c: 3003        adds	r0, #3
@   0x0800323e: 8050        strh	r0, [r2, #2]
@   0x08003240: bc10        pop	{r4}
@   0x08003242: bc01        pop	{r0}
@   0x08003244: 4700        bx	r0
@   0x08003246: 0000        movs	r0, r0
@   0x08003248: 3720        adds	r7, #32
@   0x0800324a: 0300        lsls	r0, r0, #12
@   0x0800324c: 5398        strh	r0, [r3, r6]
@   0x0800324e: 0300        lsls	r0, r0, #12
@   0x08003250: 35e0        adds	r5, #224	@ 0xe0
@   0x08003252: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080031D4
sub_080031D4: @ 0x080031d4
        .incbin "frog_us_baserom.gba", 0x31d4, 0x80
        thumb_func_end sub_080031D4
