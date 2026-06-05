@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bbc0, 0x0802bc24)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bbc0 --end 0x802bc24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bbc0: 1c01        adds	r1, r0, #0
@   0x0802bbc2: 2200        movs	r2, #0
@   0x0802bbc4: 5e88        ldrsh	r0, [r1, r2]
@   0x0802bbc6: 283a        cmp	r0, #58	@ 0x3a
@   0x0802bbc8: dc02        bgt.n	0x2bbd0
@   0x0802bbca: 203b        movs	r0, #59	@ 0x3b
@   0x0802bbcc: 8008        strh	r0, [r1, #0]
@   0x0802bbce: e003        b.n	0x2bbd8
@   0x0802bbd0: 4a05        ldr	r2, [pc, #20]	@ (0x2bbe8)
@   0x0802bbd2: 4290        cmp	r0, r2
@   0x0802bbd4: dd00        ble.n	0x2bbd8
@   0x0802bbd6: 800a        strh	r2, [r1, #0]
@   0x0802bbd8: 2202        movs	r2, #2
@   0x0802bbda: 5e88        ldrsh	r0, [r1, r2]
@   0x0802bbdc: 2858        cmp	r0, #88	@ 0x58
@   0x0802bbde: dc05        bgt.n	0x2bbec
@   0x0802bbe0: 2059        movs	r0, #89	@ 0x59
@   0x0802bbe2: 8048        strh	r0, [r1, #2]
@   0x0802bbe4: e006        b.n	0x2bbf4
@   0x0802bbe6: 0000        movs	r0, r0
@   0x0802bbe8: 012b        lsls	r3, r5, #4
@   0x0802bbea: 0000        movs	r0, r0
@   0x0802bbec: 4a02        ldr	r2, [pc, #8]	@ (0x2bbf8)
@   0x0802bbee: 4290        cmp	r0, r2
@   0x0802bbf0: dd00        ble.n	0x2bbf4
@   0x0802bbf2: 804a        strh	r2, [r1, #2]
@   0x0802bbf4: 4770        bx	lr
@   0x0802bbf6: 0000        movs	r0, r0
@   0x0802bbf8: 0149        lsls	r1, r1, #5
@   0x0802bbfa: 0000        movs	r0, r0
@   0x0802bbfc: b500        push	{lr}
@   0x0802bbfe: b083        sub	sp, #12
@   0x0802bc00: 4907        ldr	r1, [pc, #28]	@ (0x2bc20)
@   0x0802bc02: 2081        movs	r0, #129	@ 0x81
@   0x0802bc04: 9000        str	r0, [sp, #0]
@   0x0802bc06: 2002        movs	r0, #2
@   0x0802bc08: 9001        str	r0, [sp, #4]
@   0x0802bc0a: 2000        movs	r0, #0
@   0x0802bc0c: 9002        str	r0, [sp, #8]
@   0x0802bc0e: 2003        movs	r0, #3
@   0x0802bc10: 2210        movs	r2, #16
@   0x0802bc12: 2356        movs	r3, #86	@ 0x56
@   0x0802bc14: f7f5        fa94 	bl	0x21140
@   0x0802bc18: b003        add	sp, #12
@   0x0802bc1a: bc01        pop	{r0}
@   0x0802bc1c: 4700        bx	r0
@   0x0802bc1e: 0000        movs	r0, r0
@   0x0802bc20: 7fa8        ldrb	r0, [r5, #30]
@   0x0802bc22: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802BBC0
sub_0802BBC0: @ 0x0802bbc0
        .incbin "frog_us_baserom.gba", 0x2bbc0, 0x64
        thumb_func_end sub_0802BBC0
