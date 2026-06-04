@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802eef8, 0x0802ef7c)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802eef8 --end 0x802ef7c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802eef8: b570        push	{r4, r5, r6, lr}
@   0x0802eefa: 1c06        adds	r6, r0, #0
@   0x0802eefc: 0609        lsls	r1, r1, #24
@   0x0802eefe: 0e0d        lsrs	r5, r1, #24
@   0x0802ef00: 2a03        cmp	r2, #3
@   0x0802ef02: dc1d        bgt.n	0x2ef40
@   0x0802ef04: 480d        ldr	r0, [pc, #52]	@ (0x2ef3c)
@   0x0802ef06: 6804        ldr	r4, [r0, #0]
@   0x0802ef08: 0091        lsls	r1, r2, #2
@   0x0802ef0a: 1c20        adds	r0, r4, #0
@   0x0802ef0c: 3010        adds	r0, #16
@   0x0802ef0e: 1843        adds	r3, r0, r1
@   0x0802ef10: 6819        ldr	r1, [r3, #0]
@   0x0802ef12: 2027        movs	r0, #39	@ 0x27
@   0x0802ef14: 4240        negs	r0, r0
@   0x0802ef16: 4001        ands	r1, r0
@   0x0802ef18: 6019        str	r1, [r3, #0]
@   0x0802ef1a: 2009        movs	r0, #9
@   0x0802ef1c: 2d00        cmp	r5, #0
@   0x0802ef1e: d100        bne.n	0x2ef22
@   0x0802ef20: 2001        movs	r0, #1
@   0x0802ef22: 4301        orrs	r1, r0
@   0x0802ef24: 6019        str	r1, [r3, #0]
@   0x0802ef26: 00d2        lsls	r2, r2, #3
@   0x0802ef28: 18a0        adds	r0, r4, r2
@   0x0802ef2a: 3090        adds	r0, #144	@ 0x90
@   0x0802ef2c: 2100        movs	r1, #0
@   0x0802ef2e: 8001        strh	r1, [r0, #0]
@   0x0802ef30: 1c20        adds	r0, r4, #0
@   0x0802ef32: 308c        adds	r0, #140	@ 0x8c
@   0x0802ef34: 1880        adds	r0, r0, r2
@   0x0802ef36: 6006        str	r6, [r0, #0]
@   0x0802ef38: e018        b.n	0x2ef6c
@   0x0802ef3a: 0000        movs	r0, r0
@   0x0802ef3c: 65e0 0300   .word 0x030065e0  @ =gpSoundSystem
@   0x0802ef40: 480c        ldr	r0, [pc, #48]	@ (0x2ef74)
@   0x0802ef42: 6801        ldr	r1, [r0, #0]
@   0x0802ef44: 31c8        adds	r1, #200	@ 0xc8
@   0x0802ef46: 0190        lsls	r0, r2, #6
@   0x0802ef48: 4a0b        ldr	r2, [pc, #44]	@ (0x2ef78)
@   0x0802ef4a: 1880        adds	r0, r0, r2
@   0x0802ef4c: 6809        ldr	r1, [r1, #0]
@   0x0802ef4e: 1809        adds	r1, r1, r0
@   0x0802ef50: 6b8b        ldr	r3, [r1, #56]	@ 0x38
@   0x0802ef52: 2027        movs	r0, #39	@ 0x27
@   0x0802ef54: 4240        negs	r0, r0
@   0x0802ef56: 4003        ands	r3, r0
@   0x0802ef58: 638b        str	r3, [r1, #56]	@ 0x38
@   0x0802ef5a: 2009        movs	r0, #9
@   0x0802ef5c: 2d00        cmp	r5, #0
@   0x0802ef5e: d100        bne.n	0x2ef62
@   0x0802ef60: 2001        movs	r0, #1
@   0x0802ef62: 4303        orrs	r3, r0
@   0x0802ef64: 638b        str	r3, [r1, #56]	@ 0x38
@   0x0802ef66: 2000        movs	r0, #0
@   0x0802ef68: 8508        strh	r0, [r1, #40]	@ 0x28
@   0x0802ef6a: 624e        str	r6, [r1, #36]	@ 0x24
@   0x0802ef6c: bc70        pop	{r4, r5, r6}
@   0x0802ef6e: bc01        pop	{r0}
@   0x0802ef70: 4700        bx	r0
@   0x0802ef72: 0000        movs	r0, r0
@   0x0802ef74: 65e0 0300   .word 0x030065e0  @ =gpSoundSystem
@   0x0802ef78: ff00 ffff   .word 0xffffff00

        thumb_func_start sub_0802EEF8
sub_0802EEF8: @ 0x0802eef8
        .incbin "frog_us_baserom.gba", 0x2eef8, 0x84
        thumb_func_end sub_0802EEF8
