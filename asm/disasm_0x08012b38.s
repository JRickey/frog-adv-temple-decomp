@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012b38, 0x08012b78)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012b38 --end 0x8012b78 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012b38: 4904        ldr	r1, [pc, #16]	@ (0x12b4c)
@   0x08012b3a: 4805        ldr	r0, [pc, #20]	@ (0x12b50)
@   0x08012b3c: 6008        str	r0, [r1, #0]
@   0x08012b3e: 4805        ldr	r0, [pc, #20]	@ (0x12b54)
@   0x08012b40: 6048        str	r0, [r1, #4]
@   0x08012b42: 4805        ldr	r0, [pc, #20]	@ (0x12b58)
@   0x08012b44: 6088        str	r0, [r1, #8]
@   0x08012b46: 6888        ldr	r0, [r1, #8]
@   0x08012b48: 4770        bx	lr
@   0x08012b4a: 0000        movs	r0, r0
@   0x08012b4c: 00d4        lsls	r4, r2, #3
@   0x08012b4e: 0400        lsls	r0, r0, #16
@   0x08012b50: 8edc        ldrh	r4, [r3, #54]	@ 0x36
@   0x08012b52: 0818        lsrs	r0, r3, #32
@   0x08012b54: e000        b.n	0x12b58
@   0x08012b56: 0600        lsls	r0, r0, #24
@   0x08012b58: 0400        lsls	r0, r0, #16
@   0x08012b5a: 8000        strh	r0, [r0, #0]
@   0x08012b5c: 4804        ldr	r0, [pc, #16]	@ (0x12b70)
@   0x08012b5e: 2100        movs	r1, #0
@   0x08012b60: 60c1        str	r1, [r0, #12]
@   0x08012b62: 2208        movs	r2, #8
@   0x08012b64: 6102        str	r2, [r0, #16]
@   0x08012b66: 62c1        str	r1, [r0, #44]	@ 0x2c
@   0x08012b68: 6302        str	r2, [r0, #48]	@ 0x30
@   0x08012b6a: 4802        ldr	r0, [pc, #8]	@ (0x12b74)
@   0x08012b6c: 7001        strb	r1, [r0, #0]
@   0x08012b6e: 4770        bx	lr
@   0x08012b70: 60a0        str	r0, [r4, #8]
@   0x08012b72: 0300        lsls	r0, r0, #12
@   0x08012b74: 3610        adds	r6, #16
@   0x08012b76: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012B38
sub_08012B38: @ 0x08012b38
        .incbin "frog_us_baserom.gba", 0x12b38, 0x40
        thumb_func_end sub_08012B38
