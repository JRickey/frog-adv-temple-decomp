@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019500, 0x08019540)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019500 --end 0x8019540 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019500: b500        push	{lr}
@   0x08019502: 4806        ldr	r0, [pc, #24]	@ (0x1951c)
@   0x08019504: 7840        ldrb	r0, [r0, #1]
@   0x08019506: 2800        cmp	r0, #0
@   0x08019508: d10e        bne.n	0x19528
@   0x0801950a: 4905        ldr	r1, [pc, #20]	@ (0x19520)
@   0x0801950c: 4805        ldr	r0, [pc, #20]	@ (0x19524)
@   0x0801950e: 7800        ldrb	r0, [r0, #0]
@   0x08019510: 0080        lsls	r0, r0, #2
@   0x08019512: 1840        adds	r0, r0, r1
@   0x08019514: 6800        ldr	r0, [r0, #0]
@   0x08019516: f01a        fbdf 	bl	0x33cd8
@   0x0801951a: e00e        b.n	0x1953a
@   0x0801951c: 34a0        adds	r4, #160	@ 0xa0
@   0x0801951e: 0300        lsls	r0, r0, #12
@   0x08019520: 806c        strh	r4, [r5, #2]
@   0x08019522: 0830        lsrs	r0, r6, #32
@   0x08019524: 3480        adds	r4, #128	@ 0x80
@   0x08019526: 0300        lsls	r0, r0, #12
@   0x08019528: 2801        cmp	r0, #1
@   0x0801952a: d102        bne.n	0x19532
@   0x0801952c: f000        fa1a 	bl	0x19964
@   0x08019530: e003        b.n	0x1953a
@   0x08019532: 2802        cmp	r0, #2
@   0x08019534: d101        bne.n	0x1953a
@   0x08019536: f7ff        fef9 	bl	0x1932c
@   0x0801953a: bc01        pop	{r0}
@   0x0801953c: 4700        bx	r0

        thumb_func_start sub_08019500
sub_08019500: @ 0x08019500
        .incbin "frog_us_baserom.gba", 0x19500, 0x40
        thumb_func_end sub_08019500
