@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803493c, 0x08034968)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803493c --end 0x8034968 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803493c: b570        push	{r4, r5, r6, lr}
@   0x0803493e: b086        sub	sp, #24
@   0x08034940: 9005        str	r0, [sp, #20]
@   0x08034942: a805        add	r0, sp, #20
@   0x08034944: a901        add	r1, sp, #4
@   0x08034946: f7ff        fbc5 	bl	0x340d4
@   0x0803494a: 9801        ldr	r0, [sp, #4]
@   0x0803494c: 9902        ldr	r1, [sp, #8]
@   0x0803494e: 9a03        ldr	r2, [sp, #12]
@   0x08034950: 9b04        ldr	r3, [sp, #16]
@   0x08034952: 2400        movs	r4, #0
@   0x08034954: 089e        lsrs	r6, r3, #2
@   0x08034956: 07a5        lsls	r5, r4, #30
@   0x08034958: 1c34        adds	r4, r6, #0
@   0x0803495a: 432c        orrs	r4, r5
@   0x0803495c: 079b        lsls	r3, r3, #30
@   0x0803495e: 9400        str	r4, [sp, #0]
@   0x08034960: f000        fed2 	bl	0x35708
@   0x08034964: b006        add	sp, #24
@   0x08034966: bd70        pop	{r4, r5, r6, pc}

        thumb_func_start sub_0803493C
sub_0803493C: @ 0x0803493c
        .incbin "frog_us_baserom.gba", 0x3493c, 0x2c
        thumb_func_end sub_0803493C
