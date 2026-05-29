@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801cfa0, 0x0801d048)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801cfa0 --end 0x801d048 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801cfa0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801cfa2: 4684        mov	ip, r0
@   0x0801cfa4: 9c05        ldr	r4, [sp, #20]
@   0x0801cfa6: 9806        ldr	r0, [sp, #24]
@   0x0801cfa8: 9f07        ldr	r7, [sp, #28]
@   0x0801cfaa: 0609        lsls	r1, r1, #24
@   0x0801cfac: 0e0d        lsrs	r5, r1, #24
@   0x0801cfae: 0612        lsls	r2, r2, #24
@   0x0801cfb0: 0e12        lsrs	r2, r2, #24
@   0x0801cfb2: 041b        lsls	r3, r3, #16
@   0x0801cfb4: 0c1b        lsrs	r3, r3, #16
@   0x0801cfb6: 0600        lsls	r0, r0, #24
@   0x0801cfb8: 0e00        lsrs	r0, r0, #24
@   0x0801cfba: 1c01        adds	r1, r0, #0
@   0x0801cfbc: 0724        lsls	r4, r4, #28
@   0x0801cfbe: 0c24        lsrs	r4, r4, #16
@   0x0801cfc0: 2801        cmp	r0, #1
@   0x0801cfc2: d00d        beq.n	0x1cfe0
@   0x0801cfc4: 2801        cmp	r0, #1
@   0x0801cfc6: dc02        bgt.n	0x1cfce
@   0x0801cfc8: 2800        cmp	r0, #0
@   0x0801cfca: d005        beq.n	0x1cfd8
@   0x0801cfcc: e011        b.n	0x1cff2
@   0x0801cfce: 2902        cmp	r1, #2
@   0x0801cfd0: d00a        beq.n	0x1cfe8
@   0x0801cfd2: 2903        cmp	r1, #3
@   0x0801cfd4: d00c        beq.n	0x1cff0
@   0x0801cfd6: e00c        b.n	0x1cff2
@   0x0801cfd8: 4e00        ldr	r6, [pc, #0]	@ (0x1cfdc)
@   0x0801cfda: e00a        b.n	0x1cff2
@   0x0801cfdc: e000        b.n	0x1cfe0
@   0x0801cfde: 0600        lsls	r0, r0, #24
@   0x0801cfe0: 4e00        ldr	r6, [pc, #0]	@ (0x1cfe4)
@   0x0801cfe2: e006        b.n	0x1cff2
@   0x0801cfe4: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801cfe8: 4e00        ldr	r6, [pc, #0]	@ (0x1cfec)
@   0x0801cfea: e002        b.n	0x1cff2
@   0x0801cfec: f000        0600 	and.w	r6, r0, #0
@   0x0801cff0: 4e0a        ldr	r6, [pc, #40]	@ (0x1d01c)
@   0x0801cff2: 2f00        cmp	r7, #0
@   0x0801cff4: d01e        beq.n	0x1d034
@   0x0801cff6: 4660        mov	r0, ip
@   0x0801cff8: 2800        cmp	r0, #0
@   0x0801cffa: d011        beq.n	0x1d020
@   0x0801cffc: 0191        lsls	r1, r2, #6
@   0x0801cffe: 0068        lsls	r0, r5, #1
@   0x0801d000: 1980        adds	r0, r0, r6
@   0x0801d002: 1809        adds	r1, r1, r0
@   0x0801d004: 2080        movs	r0, #128	@ 0x80
@   0x0801d006: 00c0        lsls	r0, r0, #3
@   0x0801d008: 1c02        adds	r2, r0, #0
@   0x0801d00a: 1c18        adds	r0, r3, #0
@   0x0801d00c: 4310        orrs	r0, r2
@   0x0801d00e: 1820        adds	r0, r4, r0
@   0x0801d010: 8008        strh	r0, [r1, #0]
@   0x0801d012: 3140        adds	r1, #64	@ 0x40
@   0x0801d014: 3001        adds	r0, #1
@   0x0801d016: 8008        strh	r0, [r1, #0]
@   0x0801d018: e013        b.n	0x1d042
@   0x0801d01a: 0000        movs	r0, r0
@   0x0801d01c: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801d020: 0190        lsls	r0, r2, #6
@   0x0801d022: 0069        lsls	r1, r5, #1
@   0x0801d024: 1989        adds	r1, r1, r6
@   0x0801d026: 1840        adds	r0, r0, r1
@   0x0801d028: 18e1        adds	r1, r4, r3
@   0x0801d02a: 8001        strh	r1, [r0, #0]
@   0x0801d02c: 3040        adds	r0, #64	@ 0x40
@   0x0801d02e: 3101        adds	r1, #1
@   0x0801d030: 8001        strh	r1, [r0, #0]
@   0x0801d032: e006        b.n	0x1d042
@   0x0801d034: 0191        lsls	r1, r2, #6
@   0x0801d036: 0068        lsls	r0, r5, #1
@   0x0801d038: 1980        adds	r0, r0, r6
@   0x0801d03a: 1809        adds	r1, r1, r0
@   0x0801d03c: 800f        strh	r7, [r1, #0]
@   0x0801d03e: 3140        adds	r1, #64	@ 0x40
@   0x0801d040: 800f        strh	r7, [r1, #0]
@   0x0801d042: bcf0        pop	{r4, r5, r6, r7}
@   0x0801d044: bc01        pop	{r0}
@   0x0801d046: 4700        bx	r0

        thumb_func_start sub_0801CFA0
sub_0801CFA0: @ 0x0801cfa0
        .incbin "frog_us_baserom.gba", 0x1cfa0, 0xa8
        thumb_func_end sub_0801CFA0
