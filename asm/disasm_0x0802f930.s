@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f930, 0x0802f99c)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f930 --end 0x802f99c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f930: 1c02        adds	r2, r0, #0
@   0x0802f932: 4b08        ldr	r3, [pc, #32]	@ (0x2f954)
@   0x0802f934: 6810        ldr	r0, [r2, #0]
@   0x0802f936: 2810        cmp	r0, #16
@   0x0802f938: d110        bne.n	0x2f95c
@   0x0802f93a: 4907        ldr	r1, [pc, #28]	@ (0x2f958)
@   0x0802f93c: 2040        movs	r0, #64	@ 0x40
@   0x0802f93e: 7008        strb	r0, [r1, #0]
@   0x0802f940: 6910        ldr	r0, [r2, #16]
@   0x0802f942: c301        stmia	r3!, {r0}
@   0x0802f944: 6950        ldr	r0, [r2, #20]
@   0x0802f946: c301        stmia	r3!, {r0}
@   0x0802f948: 6990        ldr	r0, [r2, #24]
@   0x0802f94a: c301        stmia	r3!, {r0}
@   0x0802f94c: 69d0        ldr	r0, [r2, #28]
@   0x0802f94e: 6018        str	r0, [r3, #0]
@   0x0802f950: 2080        movs	r0, #128	@ 0x80
@   0x0802f952: e01b        b.n	0x2f98c
@   0x0802f954: 0090        lsls	r0, r2, #2
@   0x0802f956: 0400        lsls	r0, r0, #16
@   0x0802f958: 0070        lsls	r0, r6, #1
@   0x0802f95a: 0400        lsls	r0, r0, #16
@   0x0802f95c: 490c        ldr	r1, [pc, #48]	@ (0x2f990)
@   0x0802f95e: 2060        movs	r0, #96	@ 0x60
@   0x0802f960: 7008        strb	r0, [r1, #0]
@   0x0802f962: 6910        ldr	r0, [r2, #16]
@   0x0802f964: 6018        str	r0, [r3, #0]
@   0x0802f966: 4b0b        ldr	r3, [pc, #44]	@ (0x2f994)
@   0x0802f968: 6950        ldr	r0, [r2, #20]
@   0x0802f96a: c301        stmia	r3!, {r0}
@   0x0802f96c: 6990        ldr	r0, [r2, #24]
@   0x0802f96e: c301        stmia	r3!, {r0}
@   0x0802f970: 69d0        ldr	r0, [r2, #28]
@   0x0802f972: 6018        str	r0, [r3, #0]
@   0x0802f974: 4b08        ldr	r3, [pc, #32]	@ (0x2f998)
@   0x0802f976: 2020        movs	r0, #32
@   0x0802f978: 7008        strb	r0, [r1, #0]
@   0x0802f97a: 6a10        ldr	r0, [r2, #32]
@   0x0802f97c: c301        stmia	r3!, {r0}
@   0x0802f97e: 6a50        ldr	r0, [r2, #36]	@ 0x24
@   0x0802f980: c301        stmia	r3!, {r0}
@   0x0802f982: 6a90        ldr	r0, [r2, #40]	@ 0x28
@   0x0802f984: c301        stmia	r3!, {r0}
@   0x0802f986: 6ad0        ldr	r0, [r2, #44]	@ 0x2c
@   0x0802f988: 6018        str	r0, [r3, #0]
@   0x0802f98a: 20a0        movs	r0, #160	@ 0xa0
@   0x0802f98c: 7008        strb	r0, [r1, #0]
@   0x0802f98e: 4770        bx	lr
@   0x0802f990: 0070        lsls	r0, r6, #1
@   0x0802f992: 0400        lsls	r0, r0, #16
@   0x0802f994: 0094        lsls	r4, r2, #2
@   0x0802f996: 0400        lsls	r0, r0, #16
@   0x0802f998: 0090        lsls	r0, r2, #2
@   0x0802f99a: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0802F930
sub_0802F930: @ 0x0802f930
        .incbin "frog_us_baserom.gba", 0x2f930, 0x6c
        thumb_func_end sub_0802F930
