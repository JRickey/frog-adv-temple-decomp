@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032ba0, 0x08032bc8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032ba0 --end 0x8032bc8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032ba0: 1c0b        adds	r3, r1, #0
@   0x08032ba2: 2800        cmp	r0, #0
@   0x08032ba4: d002        beq.n	0x32bac
@   0x08032ba6: 2080        movs	r0, #128	@ 0x80
@   0x08032ba8: 0040        lsls	r0, r0, #1
@   0x08032baa: 181b        adds	r3, r3, r0
@   0x08032bac: 4804        ldr	r0, [pc, #16]	@ (0x32bc0)
@   0x08032bae: 6800        ldr	r0, [r0, #0]
@   0x08032bb0: 0051        lsls	r1, r2, #1
@   0x08032bb2: 30ac        adds	r0, #172	@ 0xac
@   0x08032bb4: 1840        adds	r0, r0, r1
@   0x08032bb6: 8800        ldrh	r0, [r0, #0]
@   0x08032bb8: 4298        cmp	r0, r3
@   0x08032bba: d903        bls.n	0x32bc4
@   0x08032bbc: 2000        movs	r0, #0
@   0x08032bbe: e002        b.n	0x32bc6
@   0x08032bc0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032bc2: 0300        lsls	r0, r0, #12
@   0x08032bc4: 2001        movs	r0, #1
@   0x08032bc6: 4770        bx	lr

        thumb_func_start sub_08032BA0
sub_08032BA0: @ 0x08032ba0
        .incbin "frog_us_baserom.gba", 0x32ba0, 0x28
        thumb_func_end sub_08032BA0
