@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006948, 0x0800696c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006948 --end 0x800696c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006948: 0409        lsls	r1, r1, #16
@   0x0800694a: 0c09        lsrs	r1, r1, #16
@   0x0800694c: 8dc2        ldrh	r2, [r0, #46]	@ 0x2e
@   0x0800694e: 438a        bics	r2, r1
@   0x08006950: 1c11        adds	r1, r2, #0
@   0x08006952: 85c1        strh	r1, [r0, #46]	@ 0x2e
@   0x08006954: 4770        bx	lr
@   0x08006956: 0000        movs	r0, r0
@   0x08006958: 0609        lsls	r1, r1, #24
@   0x0800695a: 0e09        lsrs	r1, r1, #24
@   0x0800695c: 8dc0        ldrh	r0, [r0, #46]	@ 0x2e
@   0x0800695e: 4001        ands	r1, r0
@   0x08006960: 2900        cmp	r1, #0
@   0x08006962: d101        bne.n	0x6968
@   0x08006964: 2000        movs	r0, #0
@   0x08006966: e000        b.n	0x696a
@   0x08006968: 2001        movs	r0, #1
@   0x0800696a: 4770        bx	lr

        thumb_func_start sub_08006948
sub_08006948: @ 0x08006948
        .incbin "frog_us_baserom.gba", 0x6948, 0x24
        thumb_func_end sub_08006948
