typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef volatile u8 vu8;
typedef volatile u16 vu16;

#define REG_IME    (*(volatile u16 *)0x04000208)
#define REG_IE     (*(volatile u16 *)0x04000200)
#define IRQ_TIMER0 (1U << 3)

extern u16 gEepromTimerSavedIme;
extern u8 gEepromTimerIndex;
extern vu16 *gEepromTimerRegisters;
extern vu16 gIwram_3432;
extern vu8 gIwram_3434;

void Eeprom_StartTimer(const u16 *config)
{
    gEepromTimerSavedIme = REG_IME;
    REG_IME = 0;
    REG_IE |= IRQ_TIMER0 << gEepromTimerIndex;
    REG_IME = 1;

    gIwram_3434 = 0;
    gIwram_3432 = *config++;

    *gEepromTimerRegisters++ = *config++;
    *gEepromTimerRegisters-- = *config;
}
