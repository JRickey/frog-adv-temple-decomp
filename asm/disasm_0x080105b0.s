@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080105b0, 0x08010694)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80105b0 --end 0x8010694 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080105b0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080105b2: 4657        mov	r7, sl
@   0x080105b4: 464e        mov	r6, r9
@   0x080105b6: 4645        mov	r5, r8
@   0x080105b8: b4e0        push	{r5, r6, r7}
@   0x080105ba: 4681        mov	r9, r0
@   0x080105bc: 0609        lsls	r1, r1, #24
@   0x080105be: 0e09        lsrs	r1, r1, #24
@   0x080105c0: 468c        mov	ip, r1
@   0x080105c2: 0612        lsls	r2, r2, #24
@   0x080105c4: 0e16        lsrs	r6, r2, #24
@   0x080105c6: 0048        lsls	r0, r1, #1
@   0x080105c8: 4460        add	r0, ip
@   0x080105ca: 00c0        lsls	r0, r0, #3
@   0x080105cc: 4448        add	r0, r9
@   0x080105ce: 7a00        ldrb	r0, [r0, #8]
@   0x080105d0: 0900        lsrs	r0, r0, #4
@   0x080105d2: 2101        movs	r1, #1
@   0x080105d4: 4008        ands	r0, r1
@   0x080105d6: 2800        cmp	r0, #0
@   0x080105d8: d006        beq.n	0x105e8
@   0x080105da: 4901        ldr	r1, [pc, #4]	@ (0x105e0)
@   0x080105dc: 4801        ldr	r0, [pc, #4]	@ (0x105e4)
@   0x080105de: e006        b.n	0x105ee
@   0x080105e0: 6500        str	r0, [r0, #80]	@ 0x50
@   0x080105e2: 0300        lsls	r0, r0, #12
@   0x080105e4: 0000        movs	r0, r0
@   0x080105e6: 0201        lsls	r1, r0, #8
@   0x080105e8: 4928        ldr	r1, [pc, #160]	@ (0x1068c)
@   0x080105ea: 2080        movs	r0, #128	@ 0x80
@   0x080105ec: 0480        lsls	r0, r0, #18
@   0x080105ee: 6148        str	r0, [r1, #20]
@   0x080105f0: 1c0c        adds	r4, r1, #0
@   0x080105f2: 4660        mov	r0, ip
@   0x080105f4: 0045        lsls	r5, r0, #1
@   0x080105f6: 1828        adds	r0, r5, r0
@   0x080105f8: 00c0        lsls	r0, r0, #3
@   0x080105fa: 4649        mov	r1, r9
@   0x080105fc: 1843        adds	r3, r0, r1
@   0x080105fe: 4a24        ldr	r2, [pc, #144]	@ (0x10690)
@   0x08010600: 8b57        ldrh	r7, [r2, #26]
@   0x08010602: 8858        ldrh	r0, [r3, #2]
@   0x08010604: 1c39        adds	r1, r7, #0
@   0x08010606: 4341        muls	r1, r0
@   0x08010608: 881f        ldrh	r7, [r3, #0]
@   0x0801060a: 1879        adds	r1, r7, r1
@   0x0801060c: 0049        lsls	r1, r1, #1
@   0x0801060e: 6960        ldr	r0, [r4, #20]
@   0x08010610: 1840        adds	r0, r0, r1
@   0x08010612: 6160        str	r0, [r4, #20]
@   0x08010614: 6919        ldr	r1, [r3, #16]
@   0x08010616: 00b0        lsls	r0, r6, #2
@   0x08010618: 1840        adds	r0, r0, r1
@   0x0801061a: 6800        ldr	r0, [r0, #0]
@   0x0801061c: 60e0        str	r0, [r4, #12]
@   0x0801061e: 2100        movs	r1, #0
@   0x08010620: 88d8        ldrh	r0, [r3, #6]
@   0x08010622: 4281        cmp	r1, r0
@   0x08010624: d22a        bcs.n	0x1067c
@   0x08010626: 46a0        mov	r8, r4
@   0x08010628: 46aa        mov	sl, r5
@   0x0801062a: 1c1f        adds	r7, r3, #0
@   0x0801062c: 2400        movs	r4, #0
@   0x0801062e: 4662        mov	r2, ip
@   0x08010630: 18a8        adds	r0, r5, r2
@   0x08010632: 00c0        lsls	r0, r0, #3
@   0x08010634: 4448        add	r0, r9
@   0x08010636: 1c4e        adds	r6, r1, #1
@   0x08010638: 8883        ldrh	r3, [r0, #4]
@   0x0801063a: 429c        cmp	r4, r3
@   0x0801063c: d20f        bcs.n	0x1065e
@   0x0801063e: 4b13        ldr	r3, [pc, #76]	@ (0x1068c)
@   0x08010640: 1c05        adds	r5, r0, #0
@   0x08010642: 695a        ldr	r2, [r3, #20]
@   0x08010644: 68d9        ldr	r1, [r3, #12]
@   0x08010646: 8808        ldrh	r0, [r1, #0]
@   0x08010648: 8010        strh	r0, [r2, #0]
@   0x0801064a: 3102        adds	r1, #2
@   0x0801064c: 60d9        str	r1, [r3, #12]
@   0x0801064e: 3202        adds	r2, #2
@   0x08010650: 615a        str	r2, [r3, #20]
@   0x08010652: 1c60        adds	r0, r4, #1
@   0x08010654: 0600        lsls	r0, r0, #24
@   0x08010656: 0e04        lsrs	r4, r0, #24
@   0x08010658: 88a8        ldrh	r0, [r5, #4]
@   0x0801065a: 4284        cmp	r4, r0
@   0x0801065c: d3f1        bcc.n	0x10642
@   0x0801065e: 490c        ldr	r1, [pc, #48]	@ (0x10690)
@   0x08010660: 8b49        ldrh	r1, [r1, #26]
@   0x08010662: 88ba        ldrh	r2, [r7, #4]
@   0x08010664: 1a88        subs	r0, r1, r2
@   0x08010666: 0040        lsls	r0, r0, #1
@   0x08010668: 4643        mov	r3, r8
@   0x0801066a: 6959        ldr	r1, [r3, #20]
@   0x0801066c: 1809        adds	r1, r1, r0
@   0x0801066e: 6159        str	r1, [r3, #20]
@   0x08010670: 0630        lsls	r0, r6, #24
@   0x08010672: 0e01        lsrs	r1, r0, #24
@   0x08010674: 4655        mov	r5, sl
@   0x08010676: 88f8        ldrh	r0, [r7, #6]
@   0x08010678: 4281        cmp	r1, r0
@   0x0801067a: d3d7        bcc.n	0x1062c
@   0x0801067c: bc38        pop	{r3, r4, r5}
@   0x0801067e: 4698        mov	r8, r3
@   0x08010680: 46a1        mov	r9, r4
@   0x08010682: 46aa        mov	sl, r5
@   0x08010684: bcf0        pop	{r4, r5, r6, r7}
@   0x08010686: bc01        pop	{r0}
@   0x08010688: 4700        bx	r0
@   0x0801068a: 0000        movs	r0, r0
@   0x0801068c: 6500        str	r0, [r0, #80]	@ 0x50
@   0x0801068e: 0300        lsls	r0, r0, #12
@   0x08010690: 60a0        str	r0, [r4, #8]
@   0x08010692: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080105B0
sub_080105B0: @ 0x080105b0
        .incbin "frog_us_baserom.gba", 0x105b0, 0xe4
        thumb_func_end sub_080105B0
