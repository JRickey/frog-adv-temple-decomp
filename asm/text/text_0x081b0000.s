@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x081b0000, 0x081bd8cc)  (shrunk for ui-text cluster extraction)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ Truncated upstream — bytes 0x081bd8cc onwards are extracted into typed
@ C symbols under src/data/, see linker.ld for placement.

        .section .text, "ax", %progbits
        .align  2
        .global text_081b0000
        .type   text_081b0000, %object
text_081b0000:
        .incbin "frog_us_baserom.gba", 0x001b0000, 0x0000d8cc
        .size   text_081b0000, . - text_081b0000
