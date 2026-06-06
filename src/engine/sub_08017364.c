#include "gba/intr.h"
#include "iwram.h"
#include "save.h"
#include "types.h"

/* EEPROM save-load (called once from Init1). Seeds gSaveData with defaults,
 * probes/validates the EEPROM save, loads each populated slot, and restores
 * the saved level (gIwram_34B0) + game-state tuple (gIwram_34B4). See
 * docs/subsystems.md "EEPROM save system".
 *
 * NON_MATCHING: this C is *structurally* byte-exact — it compiles to 520
 * bytes with the identical instruction stream as the baserom; only the
 * register colouring of the validation field reads diverges (byte_diff 169):
 *   - `header` lives in r8 (a high reg, forced by pressure); Thumb can't use
 *     a high reg as a memory base (REGNO_OK_FOR_BASE_P rejects r>=8), so each
 *     `header->field` read copies r8 into a low reg first.
 *   - local-alloc's find_free_reg (local-alloc.c:1947) picks the first free
 *     reg, r0 — and since each copy dies exactly where the `ldrb` result (r0)
 *     is born, r0 is free, so every copy funnels to r0. The baserom spreads
 *     these to r3/r4/r1/r2.
 * This is a source-structure LOCAL MINIMUM, not a compiler cut: the two agbcc
 * forks (pret, jiangzhengwenjz) have byte-identical allocators, and the Konami
 * cvaos decomp spreads this idiom with that same allocator. The natural form of
 * our pattern funnels (corpus-confirmed); the C shape that spreads it hasn't
 * been found, so the asm slice provides the matching bytes. Full analysis in
 * docs/deferred-analysis/SaveLoad.md. */
#ifdef NON_MATCHING

extern int SaveDetect(void);
extern int SaveReadHeader(u16 *dest);
extern int SaveWriteHeader(u16 *src);
extern int SaveReadSlot(u16 *dest, u8 idx);
extern void LevelLayout_SetupManager(u16 ie);
extern void LevelLayout_InitManager(void);
extern void Sound_ClearActiveFlag(void);
extern void Music_Resume(void);
extern void Music_Stop(void);

int SaveLoad(void)
{
    /* sav (r6) holds gSaveData across init + the header copy; saveBase (sl)
     * re-loads it for the slot loop, mirroring the baserom's live-range split.
     * The asm("rN") pins + zero/fullByte constant regs reproduce the matching
     * prologue and init block. */
    struct SaveData *sav;
    register struct SaveHeader *header asm("r8");
    register u16 *savedIe asm("r9");
    struct SaveSlot scratch[SAVE_SLOT_COUNT];
    u16 savedIeBuf;
    struct SaveHeader headerBuf;
    register int ok asm("r7");
    u8 i;
    u8 *saveBase;
    u16 *iePtr;
    u16 ie;
    register u32 zero asm("r2");
    register u32 fullByte asm("r0");

    iePtr = &savedIeBuf;
    ie = REG_IE;
    *iePtr = ie;
    LevelLayout_SetupManager(ie);
    REG_IE &= 0xfffe;
    REG_IE &= 0xfffd;
    REG_IE |= 0x40;

    sav = &gSaveData;
    zero = 0;
    sav->valid = zero;
    sav->cursor = zero;
    sav->slots[0]._field6 = zero;
    sav->slots[0]._field5 = 5;
    sav->slots[0]._field4 = zero;
    fullByte = 0xff;
    sav->slots[0]._field0 = fullByte;
    sav->slots[0]._field7 |= fullByte;
    sav->slots[0]._field11 = fullByte | sav->slots[0]._field11;
    sav->header.level = zero;
    sav->header.slotMask = zero;
    savedIe = iePtr;

    if (SaveDetect() == 0) {
        sav->valid = 0;
        goto restore;
    }

    asm("" : "=r"(ok)); /* launder the uninitialized r7 read so agbcc emits cmp r7,#0 */
    if (ok != 0) {
        goto restore;
    }
    header = &headerBuf;
    if (SaveReadHeader((u16 *)header) == 0) {
        goto restore;
    }

    sav->valid = 1;

    ok = 1;
    if (header->slotMask > 15)
        ok = 0;
    if (header->version != 0)
        ok = 0;
    if (header->level > 4)
        ok = 0;
    if ((u8)(header->tail.byte[2] - 3) > 6)
        ok = 0;
    if ((u8)(header->tail.byte[3] - 3) > 6)
        ok = 0;

    if (ok == 0) {
        header->slotMask = ok;
        header->_field2 = ok;
        header->version = ok;
        header->level = ok;
        header->tail.word = *(u32 *)&gIwram_34B4;
        if (SaveWriteHeader((u16 *)header) == 0) {
            goto restore;
        }
    }

    *(u32 *)&sav->header = *(u32 *)&headerBuf;
    sav->header.tail.word = *((u32 *)&headerBuf + 1);

    saveBase = (u8 *)&gSaveData;
    i = 0;
    do {
        if ((header->slotMask >> i) & 1) {
            SaveReadSlot((u16 *)&scratch[i], i);
        } else {
            scratch[i]._field5 = 0;
            scratch[i]._field6 = 0;
            scratch[i].name[0] = SAVE_NAME_DEFAULT;
            scratch[i].name[1] = SAVE_NAME_DEFAULT;
            scratch[i].name[2] = SAVE_NAME_DEFAULT;
            scratch[i]._field4 = 0;
            scratch[i]._field0 = 0;
            scratch[i]._field7 = 0;
            scratch[i]._field11 = 0;
        }
        {
            u8 *dst = saveBase + i * 12;
            *(struct SaveSlot *)(dst + 8) = scratch[i];
            dst[16] = scratch[i].name[0];
            dst[17] = scratch[i].name[1];
            dst[18] = scratch[i].name[2];
        }
        i = (u8)(i + 1);
    } while (i <= 3);

    gIwram_34B4._data[3] = 5;
    gIwram_34B4._data[2] = 5;
    gIwram_34B4._data[0] = 1;
    gIwram_34B4._data[1] = 1;
    gIwram_34B0._data = header->level;
    gSaveData.cursor = 0;
    LevelLayout_InitManager();
    if (gIwram_34B4._data[0] == 0)
        Sound_ClearActiveFlag();
    if (gIwram_34B4._data[1] != 0)
        Music_Resume();
    else
        Music_Stop();
    REG_IE = *savedIe;
    return 1;

restore:
    LevelLayout_InitManager();
    if (gIwram_34B4._data[0] == 0)
        Sound_ClearActiveFlag();
    if (gIwram_34B4._data[1] != 0)
        Music_Resume();
    else
        Music_Stop();
    REG_IE = *savedIe;
    return 0;
}

#endif /* NON_MATCHING */
