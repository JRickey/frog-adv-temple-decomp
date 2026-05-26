@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001d18, 0x08001d54)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001d18 --end 0x8001d54 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001d18: b500        push	{lr}
@   0x08001d1a: b082        sub	sp, #8
@   0x08001d1c: 480a        ldr	r0, [pc, #40]	@ (0x1d48)
@   0x08001d1e: 4b0b        ldr	r3, [pc, #44]	@ (0x1d4c)
@   0x08001d20: 2101        movs	r1, #1
@   0x08001d22: 9100        str	r1, [sp, #0]
@   0x08001d24: 2105        movs	r1, #5
@   0x08001d26: 9101        str	r1, [sp, #4]
@   0x08001d28: 2180        movs	r1, #128	@ 0x80
@   0x08001d2a: 2206        movs	r2, #6
@   0x08001d2c: f004        fc2e 	bl	0x658c
@   0x08001d30: 2006        movs	r0, #6
@   0x08001d32: 2100        movs	r1, #0
@   0x08001d34: f00b        f8b0 	bl	0xce98
@   0x08001d38: f007        ffc0 	bl	0x9cbc
@   0x08001d3c: 4904        ldr	r1, [pc, #16]	@ (0x1d50)
@   0x08001d3e: 2000        movs	r0, #0
@   0x08001d40: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08001d42: b002        add	sp, #8
@   0x08001d44: bc01        pop	{r0}
@   0x08001d46: 4700        bx	r0
@   0x08001d48: 6110        str	r0, [r2, #16]
@   0x08001d4a: 0300        lsls	r0, r0, #12
@   0x08001d4c: 9a50        ldr	r2, [sp, #320]	@ 0x140
@   0x08001d4e: 082f        lsrs	r7, r5, #32
@   0x08001d50: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08001d52: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001D18
sub_08001D18: @ 0x08001d18
        .incbin "frog_us_baserom.gba", 0x1d18, 0x3c
        thumb_func_end sub_08001D18
