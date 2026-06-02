@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801c69c, 0x0801c6e4)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801c69c --end 0x801c6e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801c69c: b081        sub	sp, #4
@   0x0801c69e: 0600        lsls	r0, r0, #24
@   0x0801c6a0: 0e00        lsrs	r0, r0, #24
@   0x0801c6a2: 2380        movs	r3, #128	@ 0x80
@   0x0801c6a4: 04db        lsls	r3, r3, #19
@   0x0801c6a6: 881a        ldrh	r2, [r3, #0]
@   0x0801c6a8: 490e        ldr	r1, [pc, #56]	@ (0x1c6e4)
@   0x0801c6aa: 4011        ands	r1, r2
@   0x0801c6ac: 8019        strh	r1, [r3, #0]
@   0x0801c6ae: 490e        ldr	r1, [pc, #56]	@ (0x1c6e8)
@   0x0801c6b0: 2200        movs	r2, #0
@   0x0801c6b2: 800a        strh	r2, [r1, #0]
@   0x0801c6b4: 3104        adds	r1, #4
@   0x0801c6b6: 800a        strh	r2, [r1, #0]
@   0x0801c6b8: 21a0        movs	r1, #160	@ 0xa0
@   0x0801c6ba: 04c9        lsls	r1, r1, #19
@   0x0801c6bc: 800a        strh	r2, [r1, #0]
@   0x0801c6be: 4669        mov	r1, sp
@   0x0801c6c0: 2000        movs	r0, #0
@   0x0801c6c2: 8008        strh	r0, [r1, #0]
@   0x0801c6c4: 4909        ldr	r1, [pc, #36]	@ (0x1c6ec)
@   0x0801c6c6: 4668        mov	r0, sp
@   0x0801c6c8: 6008        str	r0, [r1, #0]
@   0x0801c6ca: 4809        ldr	r0, [pc, #36]	@ (0x1c6f0)
@   0x0801c6cc: 6048        str	r0, [r1, #4]
@   0x0801c6ce: 4809        ldr	r0, [pc, #36]	@ (0x1c6f4)
@   0x0801c6d0: 6088        str	r0, [r1, #8]
@   0x0801c6d2: 6888        ldr	r0, [r1, #8]
@   0x0801c6d4: 2280        movs	r2, #128	@ 0x80
@   0x0801c6d6: 04d2        lsls	r2, r2, #19
@   0x0801c6d8: 8811        ldrh	r1, [r2, #0]
@   0x0801c6da: 4807        ldr	r0, [pc, #28]	@ (0x1c6f8)
@   0x0801c6dc: 4008        ands	r0, r1
@   0x0801c6de: 8010        strh	r0, [r2, #0]
@   0x0801c6e0: b001        add	sp, #4
@   0x0801c6e2: 4770        bx	lr

        thumb_func_start sub_0801C69C
sub_0801C69C: @ 0x0801c69c
        .incbin "frog_us_baserom.gba", 0x1c69c, 0x48
        thumb_func_end sub_0801C69C
