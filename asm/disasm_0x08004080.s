@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004080, 0x080040c4)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004080 --end 0x80040c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004080: b530        push	{r4, r5, lr}
@   0x08004082: b082        sub	sp, #8
@   0x08004084: 4c0d        ldr	r4, [pc, #52]	@ (0x40bc)
@   0x08004086: 4b0e        ldr	r3, [pc, #56]	@ (0x40c0)
@   0x08004088: 2001        movs	r0, #1
@   0x0800408a: 9000        str	r0, [sp, #0]
@   0x0800408c: 2500        movs	r5, #0
@   0x0800408e: 9501        str	r5, [sp, #4]
@   0x08004090: 1c20        adds	r0, r4, #0
@   0x08004092: 2132        movs	r1, #50	@ 0x32
@   0x08004094: 220d        movs	r2, #13
@   0x08004096: f002        fa79 	bl	0x658c
@   0x0800409a: 200d        movs	r0, #13
@   0x0800409c: 2100        movs	r1, #0
@   0x0800409e: f008        fefb 	bl	0xce98
@   0x080040a2: 1c20        adds	r0, r4, #0
@   0x080040a4: 302a        adds	r0, #42	@ 0x2a
@   0x080040a6: 7005        strb	r5, [r0, #0]
@   0x080040a8: 2006        movs	r0, #6
@   0x080040aa: 2100        movs	r1, #0
@   0x080040ac: 6060        str	r0, [r4, #4]
@   0x080040ae: 60a1        str	r1, [r4, #8]
@   0x080040b0: f005        fe04 	bl	0x9cbc
@   0x080040b4: b002        add	sp, #8
@   0x080040b6: bc30        pop	{r4, r5}
@   0x080040b8: bc01        pop	{r0}
@   0x080040ba: 4700        bx	r0
@   0x080040bc: 6110        str	r0, [r2, #16]
@   0x080040be: 0300        lsls	r0, r0, #12
@   0x080040c0: 9cd0        ldr	r4, [sp, #832]	@ 0x340
@   0x080040c2: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08004080
sub_08004080: @ 0x08004080
        .incbin "frog_us_baserom.gba", 0x4080, 0x44
        thumb_func_end sub_08004080
