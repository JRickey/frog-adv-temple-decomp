@ Four parallel BG scenery-variant pairs at 0x081b62aa..0x081bd8ca
@ (8 anchors x 0xec4 = 0x7620 bytes; whole range 0x9620 bytes).
@
@ Eight ROM anchors surfaced as siblings by refcount_pool_loads.py and
@ confirmed paired by a 4-way mode dispatcher in the still-asm screen
@ helper at 0x080155f0. The dispatcher reads byte [0x0300613b] and
@ branches by mode to one of four (low, high) pairs:
@
@   mode 0  ->  0x081b9dba / 0x081bac7e   (consumer 0x0801561a / 0x0801561c)
@   mode 1  ->  0x081b62aa / 0x081b716e   (consumer 0x08015694 / 0x08015696)
@   mode 2  ->  0x081bbb42 / 0x081bca06   (consumer 0x08015710 / 0x08015712)
@   mode 3  ->  0x081b8032 / 0x081b8ef6   (consumer 0x0801578c / 0x0801578e)
@
@ Each anchor is exactly 0xec4 = 3780 bytes (60 x 63 / 1890 halfwords).
@ All eight have the same internal shape (zero-padded lead followed by
@ structured halfword tile-id-and-attribute payload), strongly
@ suggesting they are layout-equivalent variants of the same screen
@ asset.
@
@ Consumer pattern (per pair, observed at the consumer addresses above):
@
@   1. Read selector halfword at [gIwramBlock1+0xb70] -> r1
@   2. Compare against cached byte [gIwramBlock2+11];
@      equal -> skip DMA (already loaded).
@   3. r1 != 0 case: SAD = <high>,
@      else (r1 == 0):  SAD = <low>
@   4. DAD = 0x02010000 (EWRAM scratch),
@      CNT = 0x80008000 (DMA_ENABLE | over-read past blob end, EWRAM-
@                        bound; the renderer enforces actual size).
@   5. Cache new selector byte at [gIwramBlock2+11].
@   6. BL 0x080100e4 with (r0=1, r1=0x040000d4, r2=0x0600e800):
@      streams processed tiles from EWRAM scratch to BG screenblock 29.
@
@ The "low / high" pair encoding (selector 0 -> low, selector !=0 ->
@ high) lets the same renderer call site pick between two visual
@ variants per mode. Combined with the 4-way mode dispatch outside, the
@ block provides 4 * 2 = 8 distinct screen variants sharing one
@ rendering path.
@
@ Sibling pattern to:
@   - bg_tilemap_19c312 (iter-22): same DMA template, same renderer at
@     0x080100e4, but two variants total (instead of eight) and EWRAM
@     scratch at 0x02000000 instead of 0x02010000.
@   - screen_d8b98, screen_c578, screen_188edc, screen_0800f014:
@     screen-install variants with full DMA stages.
@
@ The trailing 2 bytes at 0x081bd8ca (zeros) are alignment-fill leading
@ into the EEPROM-signature block at 0x081bd8cc.
@
@ Hand-written .s rather than a C file because all eight anchors are
@ 2-byte aligned but not 4-byte aligned. See docs/codegen-notes.md
@ "Non-u32-aligned .rodata data anchors".
@
@ TODO: rename once the dispatcher at 0x080155f0 lands in C and the
@ true semantic role (level / world / mode) of byte [0x0300613b] is
@ understood. Likely a screen-scenery variant set (background tiles
@ for the four-way world / level select grid).

        .section .rodata, "a", %progbits
        .balign  2

        .global  sScenerVariantMode1Low_1B62AA
        .type    sScenerVariantMode1Low_1B62AA, %object
        .size    sScenerVariantMode1Low_1B62AA, 0xec4
sScenerVariantMode1Low_1B62AA:
        .incbin "data/sprite/scenery_1b62aa/mode1_low.bin"

        .global  sScenerVariantMode1High_1B716E
        .type    sScenerVariantMode1High_1B716E, %object
        .size    sScenerVariantMode1High_1B716E, 0xec4
sScenerVariantMode1High_1B716E:
        .incbin "data/sprite/scenery_1b62aa/mode1_high.bin"

        .global  sScenerVariantMode3Low_1B8032
        .type    sScenerVariantMode3Low_1B8032, %object
        .size    sScenerVariantMode3Low_1B8032, 0xec4
sScenerVariantMode3Low_1B8032:
        .incbin "data/sprite/scenery_1b62aa/mode3_low.bin"

        .global  sScenerVariantMode3High_1B8EF6
        .type    sScenerVariantMode3High_1B8EF6, %object
        .size    sScenerVariantMode3High_1B8EF6, 0xec4
sScenerVariantMode3High_1B8EF6:
        .incbin "data/sprite/scenery_1b62aa/mode3_high.bin"

        .global  sScenerVariantMode0Low_1B9DBA
        .type    sScenerVariantMode0Low_1B9DBA, %object
        .size    sScenerVariantMode0Low_1B9DBA, 0xec4
sScenerVariantMode0Low_1B9DBA:
        .incbin "data/sprite/scenery_1b62aa/mode0_low.bin"

        .global  sScenerVariantMode0High_1BAC7E
        .type    sScenerVariantMode0High_1BAC7E, %object
        .size    sScenerVariantMode0High_1BAC7E, 0xec4
sScenerVariantMode0High_1BAC7E:
        .incbin "data/sprite/scenery_1b62aa/mode0_high.bin"

        .global  sScenerVariantMode2Low_1BBB42
        .type    sScenerVariantMode2Low_1BBB42, %object
        .size    sScenerVariantMode2Low_1BBB42, 0xec4
sScenerVariantMode2Low_1BBB42:
        .incbin "data/sprite/scenery_1b62aa/mode2_low.bin"

        .global  sScenerVariantMode2High_1BCA06
        .type    sScenerVariantMode2High_1BCA06, %object
        .size    sScenerVariantMode2High_1BCA06, 0xec4
sScenerVariantMode2High_1BCA06:
        .incbin "data/sprite/scenery_1b62aa/mode2_high.bin"

        .global  sScenerVariantTailPad_1BD8CA
        .type    sScenerVariantTailPad_1BD8CA, %object
        .size    sScenerVariantTailPad_1BD8CA, 0x2
sScenerVariantTailPad_1BD8CA:
        .incbin "data/sprite/scenery_1b62aa/post_tail_pad.bin"
