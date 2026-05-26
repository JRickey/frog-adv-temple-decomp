@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f8ec4, 0x082f9920)  (0xa5c bytes)
@
@ Tail half of the original [0x082f0000, 0x08300000) blob. Carved out
@ when sSoundDmaBufCfg / sSoundDmaMaster were extracted at 0x082f8e98
@ into src/data/sound_dma_records.c. Further shrunk when
@ sUnkDispatchData_82F9920 / sUnkPtrPair_82F998C landed at 0x082f9920
@ in src/data/unk_dispatch_2f9920.c.
@
@ Contains ARM literal pools for the sound system at 0x080338xx, then
@ a stride-16 descriptor table starting near 0x082f91e0 with rows
@ {u32 a, u32 b, u32 c=0x802, u32 ptr_to_subarray} pointing into
@ sub-arrays of u16 pairs in the same blob. The descriptor cluster
@ has no current pool-load refs in the still-asm code and is left
@ here until its consumer surfaces.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_082f8ec4
        .type   text_082f8ec4, %object
text_082f8ec4:
        .incbin "frog_us_baserom.gba", 0x002f8ec4, 0x00000a5c
        .size   text_082f8ec4, . - text_082f8ec4
