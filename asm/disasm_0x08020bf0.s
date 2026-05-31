@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020bf0, 0x08020c14)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020bf0 --end 0x8020c14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020bf0: b500        push	{lr}
@   0x08020bf2: 4807        ldr	r0, [pc, #28]	@ (0x20c10)
@   0x08020bf4: 21fe        movs	r1, #254	@ 0xfe
@   0x08020bf6: 7802        ldrb	r2, [r0, #0]
@   0x08020bf8: 4011        ands	r1, r2
@   0x08020bfa: 7001        strb	r1, [r0, #0]
@   0x08020bfc: f011        faa4 	bl	0x32148
@   0x08020c00: 2800        cmp	r0, #0
@   0x08020c02: d002        beq.n	0x20c0a
@   0x08020c04: 2001        movs	r0, #1
@   0x08020c06: f011        f9e9 	bl	0x31fdc
@   0x08020c0a: bc01        pop	{r0}
@   0x08020c0c: 4700        bx	r0
@   0x08020c0e: 0000        movs	r0, r0
@   0x08020c10: 3570        adds	r5, #112	@ 0x70
@   0x08020c12: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020BF0
sub_08020BF0: @ 0x08020bf0
        .incbin "frog_us_baserom.gba", 0x20bf0, 0x24
        thumb_func_end sub_08020BF0
