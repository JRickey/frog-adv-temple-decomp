@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e418, 0x0802e43c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e418 --end 0x802e43c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e418: b500        push	{lr}
@   0x0802e41a: 4807        ldr	r0, [pc, #28]	@ (0x2e438)
@   0x0802e41c: 6801        ldr	r1, [r0, #0]
@   0x0802e41e: 31bb        adds	r1, #187	@ 0xbb
@   0x0802e420: 7808        ldrb	r0, [r1, #0]
@   0x0802e422: 3001        adds	r0, #1
@   0x0802e424: 7008        strb	r0, [r1, #0]
@   0x0802e426: 0600        lsls	r0, r0, #24
@   0x0802e428: 0e00        lsrs	r0, r0, #24
@   0x0802e42a: 2801        cmp	r0, #1
@   0x0802e42c: d101        bne.n	0x2e432
@   0x0802e42e: f007        fcad 	bl	0x35d8c
@   0x0802e432: bc01        pop	{r0}
@   0x0802e434: 4700        bx	r0
@   0x0802e436: 0000        movs	r0, r0
@   0x0802e438: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e43a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802E418
sub_0802E418: @ 0x0802e418
        .incbin "frog_us_baserom.gba", 0x2e418, 0x24
        thumb_func_end sub_0802E418
