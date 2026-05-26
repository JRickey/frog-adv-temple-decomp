@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080008dc, 0x0800090c)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80008dc --end 0x800090c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080008dc: 4806        ldr	r0, [pc, #24]	@ (0x8f8)
@   0x080008de: 8802        ldrh	r2, [r0, #0]
@   0x080008e0: 4906        ldr	r1, [pc, #24]	@ (0x8fc)
@   0x080008e2: 4011        ands	r1, r2
@   0x080008e4: 8001        strh	r1, [r0, #0]
@   0x080008e6: 1c02        adds	r2, r0, #0
@   0x080008e8: 2301        movs	r3, #1
@   0x080008ea: 8811        ldrh	r1, [r2, #0]
@   0x080008ec: 1c18        adds	r0, r3, #0
@   0x080008ee: 4008        ands	r0, r1
@   0x080008f0: 2800        cmp	r0, #0
@   0x080008f2: d0fa        beq.n	0x8ea
@   0x080008f4: 4770        bx	lr
@   0x080008f6: 0000        movs	r0, r0
@   0x080008f8: 6148        str	r0, [r1, #20]
@   0x080008fa: 0300        lsls	r0, r0, #12
@   0x080008fc: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08000900: 4801        ldr	r0, [pc, #4]	@ (0x908)
@   0x08000902: 6800        ldr	r0, [r0, #0]
@   0x08000904: 4770        bx	lr
@   0x08000906: 0000        movs	r0, r0
@   0x08000908: 5330        strh	r0, [r6, r4]
@   0x0800090a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080008DC
sub_080008DC: @ 0x080008dc
        .incbin "frog_us_baserom.gba", 0x8dc, 0x30
        thumb_func_end sub_080008DC
