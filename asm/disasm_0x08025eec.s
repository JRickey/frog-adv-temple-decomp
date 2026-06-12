@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025eec, 0x08025f38)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025eec --end 0x8025f38 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025eec: b570        push	{r4, r5, r6, lr}
@   0x08025eee: b084        sub	sp, #16
@   0x08025ef0: 2400        movs	r4, #0
@   0x08025ef2: 4e0f        ldr	r6, [pc, #60]	@ (0x25f30)
@   0x08025ef4: 2503        movs	r5, #3
@   0x08025ef6: 1c20        adds	r0, r4, #0
@   0x08025ef8: 3040        adds	r0, #64	@ 0x40
@   0x08025efa: 00a1        lsls	r1, r4, #2
@   0x08025efc: 1989        adds	r1, r1, r6
@   0x08025efe: 6809        ldr	r1, [r1, #0]
@   0x08025f00: 4a0c        ldr	r2, [pc, #48]	@ (0x25f34)
@   0x08025f02: 9200        str	r2, [sp, #0]
@   0x08025f04: 2206        movs	r2, #6
@   0x08025f06: 9201        str	r2, [sp, #4]
@   0x08025f08: 9502        str	r5, [sp, #8]
@   0x08025f0a: 9503        str	r5, [sp, #12]
@   0x08025f0c: 2280        movs	r2, #128	@ 0x80
@   0x08025f0e: 00d2        lsls	r2, r2, #3
@   0x08025f10: 2323        movs	r3, #35	@ 0x23
@   0x08025f12: f7fb        f8c5 	bl	0x210a0
@   0x08025f16: 1c60        adds	r0, r4, #1
@   0x08025f18: 0600        lsls	r0, r0, #24
@   0x08025f1a: 0e04        lsrs	r4, r0, #24
@   0x08025f1c: 2c03        cmp	r4, #3
@   0x08025f1e: d9ea        bls.n	0x25ef6
@   0x08025f20: 2040        movs	r0, #64	@ 0x40
@   0x08025f22: f7e0        fa63 	bl	0x63ec
@   0x08025f26: b004        add	sp, #16
@   0x08025f28: bc70        pop	{r4, r5, r6}
@   0x08025f2a: bc01        pop	{r0}
@   0x08025f2c: 4700        bx	r0
@   0x08025f2e: 0000        movs	r0, r0
@   0x08025f30: 4ac4        ldr	r2, [pc, #784]	@ (0x26244)
@   0x08025f32: 0831        lsrs	r1, r6, #32
@   0x08025f34: 0171        lsls	r1, r6, #5

        thumb_func_start sub_08025EEC
sub_08025EEC: @ 0x08025eec
        .incbin "baserom.gba", 0x25eec, 0x4c
        thumb_func_end sub_08025EEC
