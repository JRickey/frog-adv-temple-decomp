@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006ba4, 0x08006bb4)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006ba4 --end 0x8006bb4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006ba4: 8a00        ldrh	r0, [r0, #16]
@   0x08006ba6: 4008        ands	r0, r1
@   0x08006ba8: 2800        cmp	r0, #0
@   0x08006baa: d101        bne.n	0x6bb0
@   0x08006bac: 2000        movs	r0, #0
@   0x08006bae: e000        b.n	0x6bb2
@   0x08006bb0: 2001        movs	r0, #1
@   0x08006bb2: 4770        bx	lr

        thumb_func_start sub_08006BA4
sub_08006BA4: @ 0x08006ba4
        .incbin "frog_us_baserom.gba", 0x6ba4, 0x10
        thumb_func_end sub_08006BA4
