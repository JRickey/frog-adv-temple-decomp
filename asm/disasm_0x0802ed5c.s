@ sub_0802ED5C: per-frame sound-channel pitch/pan envelope updater.
@
@ Called once per VBlank tick from sub_0802F4B0 (sound mixer). Iterates
@ over ss->slot_ptr_table[0..ss->count], where ss = *gpSoundSystem.
@ For each non-null slot whose flag bit 0x400 (in slot[0x38]) is set,
@ updates a signed pan/pitch accumulator at slot[0x2c..0x2f]:
@   sum = (s16)slot[0x2c] + (s16)slot[0x2e]
@   if (s16)slot[0x2e] >= 0:
@       limit = (s8)slot[0x31];  if sum < limit*256, skip clamp
@   else:
@       limit = (s8)slot[0x30];  if sum > limit*256, skip clamp
@   clamp: sum = limit*512 - sum;  slot[0x2e] = -(u16)slot[0x2e]
@   slot[0x2c] = sum;  ss->mix[i].outSample = ss->mix[i].base + (sum>>8)+16
@
@ Range:  [0x0802ed5c, 0x0802edf0)  (148 bytes incl. 2 trailing pad bytes)
@
@ NON_MATCHING C in src/system/sound_channel.c gets byte_diff 4
@ (just two instructions order-swapped: `mov ip, r2` before `movs r7, #0`
@ at offsets 0x14/0x16). agbcc 2.x's instruction scheduler picks the
@ opposite order from the baserom, and structural source changes don't
@ swap them. Worth a permuter pass in a future session — see
@ docs/codegen-notes.md.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802ED5C
sub_0802ED5C: @ 0x0802ed5c
        push    {r4, r5, r6, r7, lr}
        ldr     r2, _0802EDAC               @ -> gpSoundSystem (0x030065e0)
        ldr     r1, [r2, #0]                @ r1 = *gpSoundSystem  (SoundSystem state)
        adds    r0, r1, #0
        adds    r0, #0xcc
        ldr     r5, [r0, #0]                @ r5 = ss->slot_ptr_table
        movs    r6, #0                      @ r6 = i = 0
        ldrb    r1, [r1, #0]                @ r1 = ss->count
        cmp     r6, r1
        bge.n   _0802EDE8
        mov     ip, r2                      @ ip = &gpSoundSystem (cached)
        movs    r7, #0                      @ r7 = i * 28 (mix-table byte offset)
_0802ED74:
        ldr     r2, [r5, #0]                @ slot = slot_ptr_table[i]
        cmp     r2, #0
        beq.n   _0802EDD8
        ldr     r0, [r2, #0x38]             @ slot->flags
        movs    r1, #0x80
        lsls    r1, r1, #3                  @ r1 = 0x400 (envelope-active bit)
        ands    r0, r1
        cmp     r0, #0
        beq.n   _0802EDD8
        adds    r3, r2, #0
        adds    r3, #0x2c                   @ r3 = &slot[0x2c]
        movs    r1, #0x2c
        ldrsh   r0, [r2, r1]                @ r0 = (s16)slot[0x2c]  (acc)
        movs    r2, #2
        ldrsh   r1, [r3, r2]                @ r1 = (s16)slot[0x2e]  (step)
        adds    r1, r0, r1                  @ r1 = acc + step
        ldrh    r4, [r3, #2]                @ r4 = (u16)slot[0x2e]
        movs    r2, #2
        ldrsh   r0, [r3, r2]                @ r0 = (s16)slot[0x2e]  (sign test)
        cmp     r0, #0
        blt.n   _0802EDB0                   @ step < 0  -> compare against -limit
        movs    r0, #5
        ldrsb   r0, [r3, r0]                @ r0 = (s8)slot[0x31]   (+limit byte)
        lsls    r2, r0, #8                  @ r2 = limit << 8
        cmp     r1, r2
        blt.n   _0802EDC2                   @ acc' < limit  -> apply (no clamp)
        b.n     _0802EDBA
        .balign 4, 0                        @ alignment nop before inline pool
_0802EDAC:
        .4byte  0x030065e0                  @ gpSoundSystem
_0802EDB0:
        movs    r0, #4
        ldrsb   r0, [r3, r0]                @ r0 = (s8)slot[0x30]   (-limit byte)
        lsls    r2, r0, #8                  @ r2 = limit << 8
        cmp     r1, r2
        bgt.n   _0802EDC2                   @ acc' > -limit  -> apply (no clamp)
_0802EDBA:
        lsls    r0, r0, #9                  @ r0 = limit << 9
        subs    r1, r0, r1                  @ acc' = (limit*2) - acc'
        negs    r0, r4                      @ flip step sign (u16, two's complement)
        strh    r0, [r3, #2]                @ slot[0x2e] = -step
_0802EDC2:
        strh    r1, [r3, #0]                @ slot[0x2c] = acc'
        mov     r2, ip
        ldr     r0, [r2, #0]                @ r0 = *gpSoundSystem
        adds    r0, #0xc0
        ldr     r2, [r0, #0]                @ r2 = ss->mix_table  (28-byte entries)
        adds    r2, r2, r7                  @ r2 = &mix_table[i]
        lsrs    r1, r1, #8                  @ r1 = acc' >> 8
        adds    r1, #16
        ldr     r0, [r2, #0]
        adds    r0, r0, r1
        str     r0, [r2, #12]               @ mix_table[i].outSample = base + r1
_0802EDD8:
        adds    r7, #28                     @ next mix-table entry
        adds    r6, #1                      @ i++
        adds    r5, #4                      @ next slot_ptr
        mov     r1, ip
        ldr     r0, [r1, #0]
        ldrb    r0, [r0, #0]                @ reload ss->count
        cmp     r6, r0
        blt.n   _0802ED74
_0802EDE8:
        pop     {r4, r5, r6, r7}
        pop     {r0}
        bx      r0
        .balign 4, 0                        @ 2 trailing pad bytes to align 0x0802edf0
        thumb_func_end sub_0802ED5C
