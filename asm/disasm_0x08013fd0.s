@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013fd0, 0x08014020)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013fd0 --end 0x8014020 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013fd0: b510        push	{r4, lr}
@   0x08013fd2: b082        sub	sp, #8
@   0x08013fd4: 4c0f        ldr	r4, [pc, #60]	@ (0x14014)
@   0x08013fd6: 78a0        ldrb	r0, [r4, #2]
@   0x08013fd8: 9000        str	r0, [sp, #0]
@   0x08013fda: 480f        ldr	r0, [pc, #60]	@ (0x14018)
@   0x08013fdc: 9001        str	r0, [sp, #4]
@   0x08013fde: 6820        ldr	r0, [r4, #0]
@   0x08013fe0: 6861        ldr	r1, [r4, #4]
@   0x08013fe2: 68a2        ldr	r2, [r4, #8]
@   0x08013fe4: 68e3        ldr	r3, [r4, #12]
@   0x08013fe6: f7ff        fe3b 	bl	0x13c60
@   0x08013fea: 7ca0        ldrb	r0, [r4, #18]
@   0x08013fec: 9000        str	r0, [sp, #0]
@   0x08013fee: 480b        ldr	r0, [pc, #44]	@ (0x1401c)
@   0x08013ff0: 9001        str	r0, [sp, #4]
@   0x08013ff2: 6920        ldr	r0, [r4, #16]
@   0x08013ff4: 6961        ldr	r1, [r4, #20]
@   0x08013ff6: 69a2        ldr	r2, [r4, #24]
@   0x08013ff8: 69e3        ldr	r3, [r4, #28]
@   0x08013ffa: f7ff        fe31 	bl	0x13c60
@   0x08013ffe: 2006        movs	r0, #6
@   0x08014000: 2102        movs	r1, #2
@   0x08014002: f7fc        fd1f 	bl	0x10a44
@   0x08014006: f002        fffb 	bl	0x17000
@   0x0801400a: b002        add	sp, #8
@   0x0801400c: bc10        pop	{r4}
@   0x0801400e: bc01        pop	{r0}
@   0x08014010: 4700        bx	r0
@   0x08014012: 0000        movs	r0, r0
@   0x08014014: 7518        strb	r0, [r3, #20]
@   0x08014016: 0830        lsrs	r0, r6, #32
@   0x08014018: 6500        str	r0, [r0, #80]	@ 0x50
@   0x0801401a: 0300        lsls	r0, r0, #12
@   0x0801401c: 6580        str	r0, [r0, #88]	@ 0x58
@   0x0801401e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013FD0
sub_08013FD0: @ 0x08013fd0
        .incbin "frog_us_baserom.gba", 0x13fd0, 0x50
        thumb_func_end sub_08013FD0
