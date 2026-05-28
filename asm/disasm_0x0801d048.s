@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d048, 0x0801d094)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d048 --end 0x801d094 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d048: b570        push	{r4, r5, r6, lr}
@   0x0801d04a: 4646        mov	r6, r8
@   0x0801d04c: b440        push	{r6}
@   0x0801d04e: b083        sub	sp, #12
@   0x0801d050: 1c04        adds	r4, r0, #0
@   0x0801d052: 0624        lsls	r4, r4, #24
@   0x0801d054: 0e24        lsrs	r4, r4, #24
@   0x0801d056: 480e        ldr	r0, [pc, #56]	@ (0x1d090)
@   0x0801d058: 218b        movs	r1, #139	@ 0x8b
@   0x0801d05a: 0049        lsls	r1, r1, #1
@   0x0801d05c: 4688        mov	r8, r1
@   0x0801d05e: 9100        str	r1, [sp, #0]
@   0x0801d060: 260e        movs	r6, #14
@   0x0801d062: 9601        str	r6, [sp, #4]
@   0x0801d064: 2503        movs	r5, #3
@   0x0801d066: 9502        str	r5, [sp, #8]
@   0x0801d068: 2105        movs	r1, #5
@   0x0801d06a: 220b        movs	r2, #11
@   0x0801d06c: 230a        movs	r3, #10
@   0x0801d06e: f7fe        ff05 	bl	0x1be7c
@   0x0801d072: 9600        str	r6, [sp, #0]
@   0x0801d074: 9501        str	r5, [sp, #4]
@   0x0801d076: 1c20        adds	r0, r4, #0
@   0x0801d078: 2111        movs	r1, #17
@   0x0801d07a: 220a        movs	r2, #10
@   0x0801d07c: 4643        mov	r3, r8
@   0x0801d07e: f7ff        ff4b 	bl	0x1cf18
@   0x0801d082: b003        add	sp, #12
@   0x0801d084: bc08        pop	{r3}
@   0x0801d086: 4698        mov	r8, r3
@   0x0801d088: bc70        pop	{r4, r5, r6}
@   0x0801d08a: bc01        pop	{r0}
@   0x0801d08c: 4700        bx	r0
@   0x0801d08e: 0000        movs	r0, r0
@   0x0801d090: df84        svc	132	@ 0x84
@   0x0801d092: 081b        lsrs	r3, r3, #32

        thumb_func_start sub_0801D048
sub_0801D048: @ 0x0801d048
        .incbin "frog_us_baserom.gba", 0x1d048, 0x4c
        thumb_func_end sub_0801D048
