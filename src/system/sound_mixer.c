#include "types.h"

/* Sound-system per-VBlank tick. Owner of `sub_0802F4B0` (still in asm —
 * see asm/disasm_0x0802f4b0.s). Called once per frame from the VBlank
 * IRQ handler (`sub_08000790`), AFTER the OAM/BG-scroll shadow flush.
 *
 * The function operates on a SoundSystem state pointed to by
 * `*(void**)0x030065e0` (set up earlier in boot — writer is sub_0802D558
 * via CpuFastSet, suggesting the state is DMA-initialized from ROM).
 *
 * High-level structure (m2c seed unavailable — body is still .incbin'd):
 *   - Calls 8 sub-update routines (sub_080315D8, sub_0802E934, ...,
 *     sub_0802F2FC) in sequence — channel state, envelope, allocator.
 *   - Loops i=0..2 processing "fade-request" slots (bit 0x40 of a per-
 *     channel u32). When set, sums 6 halfwords (mix accumulators) and
 *     forwards to sub_0802E5D8.
 *   - Loops j=0..3 processing "volume-request" slots (bit 0x80 of the
 *     same u32). Reads a per-channel halfword at +0x90, multiplies by
 *     a byte at +0x93, optionally swaps in a pan-base from +0xbc/+0xbe,
 *     and forwards to sub_0802E684.
 *   - Per active sound-slot in the table at SoundSystem+0xcc:
 *     decrements a u16 countdown at +0x36, applies pitch envelope
 *     (+0x28 halfword * +0x2b byte), pan-curve LUT from coefficient
 *     pool (constants 0x4ac8 / 0xb538 / 0xb818 / 0xda1c083d).
 *   - Brackets the mutating block with sub_0802E418 (lock,
 *     increments refcount at +0xbb) and sub_0802E3F8 (unlock).
 *
 * See docs/unknowns.md (sub_0802F4B0 section) for the decomp blocker
 * notes and docs/subsystems.md for the sound-system overview.
 */