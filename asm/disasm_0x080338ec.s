@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080338ec, 0x08033910)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80338ec --end 0x8033910 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080338ec: 4906        ldr	r1, [pc, #24]	@ (0x33908)
@   0x080338ee: 8808        ldrh	r0, [r1, #0]
@   0x080338f0: 2800        cmp	r0, #0
@   0x080338f2: d008        beq.n	0x33906
@   0x080338f4: 8808        ldrh	r0, [r1, #0]
@   0x080338f6: 3801        subs	r0, #1
@   0x080338f8: 8008        strh	r0, [r1, #0]
@   0x080338fa: 0400        lsls	r0, r0, #16
@   0x080338fc: 2800        cmp	r0, #0
@   0x080338fe: d102        bne.n	0x33906
@   0x08033900: 4902        ldr	r1, [pc, #8]	@ (0x3390c)
@   0x08033902: 2001        movs	r0, #1
@   0x08033904: 7008        strb	r0, [r1, #0]
@   0x08033906: 4770        bx	lr
@   0x08033908: 3432        adds	r4, #50	@ 0x32
@   0x0803390a: 0300        lsls	r0, r0, #12
@   0x0803390c: 3434        adds	r4, #52	@ 0x34
@   0x0803390e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080338EC
sub_080338EC: @ 0x080338ec
        .incbin "frog_us_baserom.gba", 0x338ec, 0x24
        thumb_func_end sub_080338EC
