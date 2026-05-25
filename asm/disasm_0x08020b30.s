@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020b30, 0x08020b50)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020b30 --end 0x8020b50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020b30: 4a06        ldr	r2, [pc, #24]	@ (0x20b4c)
@   0x08020b32: 2001        movs	r0, #1
@   0x08020b34: 7811        ldrb	r1, [r2, #0]
@   0x08020b36: 4308        orrs	r0, r1
@   0x08020b38: 2102        movs	r1, #2
@   0x08020b3a: 4308        orrs	r0, r1
@   0x08020b3c: 7010        strb	r0, [r2, #0]
@   0x08020b3e: 21f5        movs	r1, #245	@ 0xf5
@   0x08020b40: 7091        strb	r1, [r2, #2]
@   0x08020b42: 20cd        movs	r0, #205	@ 0xcd
@   0x08020b44: 7050        strb	r0, [r2, #1]
@   0x08020b46: 70d1        strb	r1, [r2, #3]
@   0x08020b48: 4770        bx	lr
@   0x08020b4a: 0000        movs	r0, r0
@   0x08020b4c: 3570        adds	r5, #112	@ 0x70
@   0x08020b4e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020B30
sub_08020B30: @ 0x08020b30
        .incbin "frog_us_baserom.gba", 0x20b30, 0x20
        thumb_func_end sub_08020B30
