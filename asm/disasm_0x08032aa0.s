@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032aa0, 0x08032b18)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032aa0 --end 0x8032b18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032aa0: b570        push	{r4, r5, r6, lr}
@   0x08032aa2: 464e        mov	r6, r9
@   0x08032aa4: 4645        mov	r5, r8
@   0x08032aa6: b460        push	{r5, r6}
@   0x08032aa8: 4681        mov	r9, r0
@   0x08032aaa: 1c0d        adds	r5, r1, #0
@   0x08032aac: 4818        ldr	r0, [pc, #96]	@ (0x32b10)
@   0x08032aae: 4680        mov	r8, r0
@   0x08032ab0: 6800        ldr	r0, [r0, #0]
@   0x08032ab2: 268c        movs	r6, #140	@ 0x8c
@   0x08032ab4: 0076        lsls	r6, r6, #1
@   0x08032ab6: 1980        adds	r0, r0, r6
@   0x08032ab8: 6005        str	r5, [r0, #0]
@   0x08032aba: 24aa        movs	r4, #170	@ 0xaa
@   0x08032abc: 0064        lsls	r4, r4, #1
@   0x08032abe: 1c28        adds	r0, r5, #0
@   0x08032ac0: 1c21        adds	r1, r4, #0
@   0x08032ac2: f7fb        fc5d 	bl	0x2e380
@   0x08032ac6: 192c        adds	r4, r5, r4
@   0x08032ac8: 4642        mov	r2, r8
@   0x08032aca: 6811        ldr	r1, [r2, #0]
@   0x08032acc: 1989        adds	r1, r1, r6
@   0x08032ace: 6808        ldr	r0, [r1, #0]
@   0x08032ad0: 2288        movs	r2, #136	@ 0x88
@   0x08032ad2: 0052        lsls	r2, r2, #1
@   0x08032ad4: 1880        adds	r0, r0, r2
@   0x08032ad6: 6004        str	r4, [r0, #0]
@   0x08032ad8: 6808        ldr	r0, [r1, #0]
@   0x08032ada: 1880        adds	r0, r0, r2
@   0x08032adc: 6800        ldr	r0, [r0, #0]
@   0x08032ade: 4649        mov	r1, r9
@   0x08032ae0: 788a        ldrb	r2, [r1, #2]
@   0x08032ae2: 3204        adds	r2, #4
@   0x08032ae4: 0051        lsls	r1, r2, #1
@   0x08032ae6: 1889        adds	r1, r1, r2
@   0x08032ae8: 0089        lsls	r1, r1, #2
@   0x08032aea: f7fb        fc49 	bl	0x2e380
@   0x08032aee: 4a09        ldr	r2, [pc, #36]	@ (0x32b14)
@   0x08032af0: 18a9        adds	r1, r5, r2
@   0x08032af2: 2000        movs	r0, #0
@   0x08032af4: 7008        strb	r0, [r1, #0]
@   0x08032af6: 4649        mov	r1, r9
@   0x08032af8: 7888        ldrb	r0, [r1, #2]
@   0x08032afa: 3201        adds	r2, #1
@   0x08032afc: 18a9        adds	r1, r5, r2
@   0x08032afe: 7008        strb	r0, [r1, #0]
@   0x08032b00: 2001        movs	r0, #1
@   0x08032b02: bc18        pop	{r3, r4}
@   0x08032b04: 4698        mov	r8, r3
@   0x08032b06: 46a1        mov	r9, r4
@   0x08032b08: bc70        pop	{r4, r5, r6}
@   0x08032b0a: bc02        pop	{r1}
@   0x08032b0c: 4708        bx	r1
@   0x08032b0e: 0000        movs	r0, r0
@   0x08032b10: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032b12: 0300        lsls	r0, r0, #12
@   0x08032b14: 0151        lsls	r1, r2, #5

        thumb_func_start sub_08032AA0
sub_08032AA0: @ 0x08032aa0
        .incbin "frog_us_baserom.gba", 0x32aa0, 0x78
        thumb_func_end sub_08032AA0
