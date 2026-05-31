@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080184dc, 0x080185c0)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80184dc --end 0x80185c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080184dc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080184de: 4657        mov	r7, sl
@   0x080184e0: 464e        mov	r6, r9
@   0x080184e2: 4645        mov	r5, r8
@   0x080184e4: b4e0        push	{r5, r6, r7}
@   0x080184e6: b081        sub	sp, #4
@   0x080184e8: 1c05        adds	r5, r0, #0
@   0x080184ea: 0409        lsls	r1, r1, #16
@   0x080184ec: 0c09        lsrs	r1, r1, #16
@   0x080184ee: 4689        mov	r9, r1
@   0x080184f0: 0412        lsls	r2, r2, #16
@   0x080184f2: 0c12        lsrs	r2, r2, #16
@   0x080184f4: 4690        mov	r8, r2
@   0x080184f6: 061b        lsls	r3, r3, #24
@   0x080184f8: 0e1b        lsrs	r3, r3, #24
@   0x080184fa: 1c18        adds	r0, r3, #0
@   0x080184fc: 2b01        cmp	r3, #1
@   0x080184fe: d00d        beq.n	0x1851c
@   0x08018500: 2b01        cmp	r3, #1
@   0x08018502: dc02        bgt.n	0x1850a
@   0x08018504: 2b00        cmp	r3, #0
@   0x08018506: d005        beq.n	0x18514
@   0x08018508: e016        b.n	0x18538
@   0x0801850a: 2802        cmp	r0, #2
@   0x0801850c: d00c        beq.n	0x18528
@   0x0801850e: 2803        cmp	r0, #3
@   0x08018510: d010        beq.n	0x18534
@   0x08018512: e011        b.n	0x18538
@   0x08018514: 4800        ldr	r0, [pc, #0]	@ (0x18518)
@   0x08018516: e00e        b.n	0x18536
@   0x08018518: e000        b.n	0x1851c
@   0x0801851a: 0600        lsls	r0, r0, #24
@   0x0801851c: 4901        ldr	r1, [pc, #4]	@ (0x18524)
@   0x0801851e: 468a        mov	sl, r1
@   0x08018520: e00a        b.n	0x18538
@   0x08018522: 0000        movs	r0, r0
@   0x08018524: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08018528: 4e01        ldr	r6, [pc, #4]	@ (0x18530)
@   0x0801852a: 46b2        mov	sl, r6
@   0x0801852c: e004        b.n	0x18538
@   0x0801852e: 0000        movs	r0, r0
@   0x08018530: f000        0600 	and.w	r6, r0, #0
@   0x08018534: 4820        ldr	r0, [pc, #128]	@ (0x185b8)
@   0x08018536: 4682        mov	sl, r0
@   0x08018538: 4649        mov	r1, r9
@   0x0801853a: 0708        lsls	r0, r1, #28
@   0x0801853c: 0c00        lsrs	r0, r0, #16
@   0x0801853e: 4681        mov	r9, r0
@   0x08018540: 4646        mov	r6, r8
@   0x08018542: 0730        lsls	r0, r6, #28
@   0x08018544: 0c00        lsrs	r0, r0, #16
@   0x08018546: 4680        mov	r8, r0
@   0x08018548: 7869        ldrb	r1, [r5, #1]
@   0x0801854a: 0148        lsls	r0, r1, #5
@   0x0801854c: 782e        ldrb	r6, [r5, #0]
@   0x0801854e: 1830        adds	r0, r6, r0
@   0x08018550: 0040        lsls	r0, r0, #1
@   0x08018552: 4482        add	sl, r0
@   0x08018554: 2000        movs	r0, #0
@   0x08018556: 78e9        ldrb	r1, [r5, #3]
@   0x08018558: 4288        cmp	r0, r1
@   0x0801855a: d224        bcs.n	0x185a6
@   0x0801855c: 2200        movs	r2, #0
@   0x0801855e: 1c46        adds	r6, r0, #1
@   0x08018560: 9600        str	r6, [sp, #0]
@   0x08018562: 78a9        ldrb	r1, [r5, #2]
@   0x08018564: 428a        cmp	r2, r1
@   0x08018566: d218        bcs.n	0x1859a
@   0x08018568: 0180        lsls	r0, r0, #6
@   0x0801856a: 4656        mov	r6, sl
@   0x0801856c: 1984        adds	r4, r0, r6
@   0x0801856e: 20f0        movs	r0, #240	@ 0xf0
@   0x08018570: 0200        lsls	r0, r0, #8
@   0x08018572: 4684        mov	ip, r0
@   0x08018574: 4f11        ldr	r7, [pc, #68]	@ (0x185bc)
@   0x08018576: 0050        lsls	r0, r2, #1
@   0x08018578: 1901        adds	r1, r0, r4
@   0x0801857a: 880b        ldrh	r3, [r1, #0]
@   0x0801857c: 1c18        adds	r0, r3, #0
@   0x0801857e: 4666        mov	r6, ip
@   0x08018580: 4030        ands	r0, r6
@   0x08018582: 4548        cmp	r0, r9
@   0x08018584: d103        bne.n	0x1858e
@   0x08018586: 403b        ands	r3, r7
@   0x08018588: 4646        mov	r6, r8
@   0x0801858a: 1998        adds	r0, r3, r6
@   0x0801858c: 8008        strh	r0, [r1, #0]
@   0x0801858e: 1c50        adds	r0, r2, #1
@   0x08018590: 0600        lsls	r0, r0, #24
@   0x08018592: 0e02        lsrs	r2, r0, #24
@   0x08018594: 78a8        ldrb	r0, [r5, #2]
@   0x08018596: 4282        cmp	r2, r0
@   0x08018598: d3ed        bcc.n	0x18576
@   0x0801859a: 9900        ldr	r1, [sp, #0]
@   0x0801859c: 0608        lsls	r0, r1, #24
@   0x0801859e: 0e00        lsrs	r0, r0, #24
@   0x080185a0: 78ee        ldrb	r6, [r5, #3]
@   0x080185a2: 42b0        cmp	r0, r6
@   0x080185a4: d3da        bcc.n	0x1855c
@   0x080185a6: b001        add	sp, #4
@   0x080185a8: bc38        pop	{r3, r4, r5}
@   0x080185aa: 4698        mov	r8, r3
@   0x080185ac: 46a1        mov	r9, r4
@   0x080185ae: 46aa        mov	sl, r5
@   0x080185b0: bcf0        pop	{r4, r5, r6, r7}
@   0x080185b2: bc01        pop	{r0}
@   0x080185b4: 4700        bx	r0
@   0x080185b6: 0000        movs	r0, r0
@   0x080185b8: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x080185bc: 0fff        lsrs	r7, r7, #31

        thumb_func_start sub_080184DC
sub_080184DC: @ 0x080184dc
        .incbin "frog_us_baserom.gba", 0x184dc, 0xe4
        thumb_func_end sub_080184DC
