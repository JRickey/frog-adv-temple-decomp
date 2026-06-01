@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013aac, 0x08013ae8)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013aac --end 0x8013ae8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013aac: b570        push	{r4, r5, r6, lr}
@   0x08013aae: b083        sub	sp, #12
@   0x08013ab0: 0600        lsls	r0, r0, #24
@   0x08013ab2: 0e00        lsrs	r0, r0, #24
@   0x08013ab4: 4e0b        ldr	r6, [pc, #44]	@ (0x13ae4)
@   0x08013ab6: 0045        lsls	r5, r0, #1
@   0x08013ab8: 182d        adds	r5, r5, r0
@   0x08013aba: 00ed        lsls	r5, r5, #3
@   0x08013abc: 19ac        adds	r4, r5, r6
@   0x08013abe: 7a20        ldrb	r0, [r4, #8]
@   0x08013ac0: 8821        ldrh	r1, [r4, #0]
@   0x08013ac2: 8862        ldrh	r2, [r4, #2]
@   0x08013ac4: 88a3        ldrh	r3, [r4, #4]
@   0x08013ac6: 88e4        ldrh	r4, [r4, #6]
@   0x08013ac8: 9400        str	r4, [sp, #0]
@   0x08013aca: 3610        adds	r6, #16
@   0x08013acc: 19ad        adds	r5, r5, r6
@   0x08013ace: 682c        ldr	r4, [r5, #0]
@   0x08013ad0: 9401        str	r4, [sp, #4]
@   0x08013ad2: 2403        movs	r4, #3
@   0x08013ad4: 9402        str	r4, [sp, #8]
@   0x08013ad6: f7ff        f875 	bl	0x12bc4
@   0x08013ada: b003        add	sp, #12
@   0x08013adc: bc70        pop	{r4, r5, r6}
@   0x08013ade: bc01        pop	{r0}
@   0x08013ae0: 4700        bx	r0
@   0x08013ae2: 0000        movs	r0, r0
@   0x08013ae4: 70ec        strb	r4, [r5, #3]
@   0x08013ae6: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08013AAC
sub_08013AAC: @ 0x08013aac
        .incbin "frog_us_baserom.gba", 0x13aac, 0x3c
        thumb_func_end sub_08013AAC
