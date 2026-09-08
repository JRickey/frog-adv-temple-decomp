#ifndef GUARD_LEVEL_LAYOUT_DATA_H
#define GUARD_LEVEL_LAYOUT_DATA_H

#include "types.h"

/* The record walker reads count at +0 and config at +2. */
typedef struct LevelLayoutHeader {
    u8 count;
    u8 _unk01;
    u8 config;
    u8 _unk03;
    u32 _unk04;
} LevelLayoutHeader;

/* Entries begin at +8 with an 8-byte stride. Packed fields stay uninterpreted. */
typedef struct LevelLayoutEntry {
    u16 x;
    u16 y;
    u8 packed0;
    u8 packed1;
    u8 _unk06;
    u8 _unk07;
} LevelLayoutEntry;

/* Physical path block: an eight-byte header and seven eight-byte records.
 * Entity_FollowPath reads the header's count and selector bytes. */
typedef struct EntityPath {
    u8 count;
    u8 _unk01;
    u8 _unk02;
    u8 _unk03;
    u8 selector;
    u8 _unk05[3];
    LevelLayoutEntry waypoints[7];
} EntityPath;

typedef char LevelLayoutHeaderSizeCheck[sizeof(LevelLayoutHeader) == 8 ? 1 : -1];
typedef char LevelLayoutEntrySizeCheck[sizeof(LevelLayoutEntry) == 8 ? 1 : -1];
typedef char EntityPathSizeCheck[sizeof(EntityPath) == 64 ? 1 : -1];

/* Fixed extents keep each global object the same size as its ROM layout. */
typedef struct LevelLayout1 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[1];
} LevelLayout1;

typedef struct LevelLayout2 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[2];
} LevelLayout2;

typedef struct LevelLayout3 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[3];
} LevelLayout3;

typedef struct LevelLayout4 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[4];
} LevelLayout4;

typedef struct LevelLayout5 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[5];
} LevelLayout5;

typedef struct LevelLayout6 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[6];
} LevelLayout6;

typedef struct LevelLayout30 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[30];
} LevelLayout30;

typedef struct LevelLayout31 {
    LevelLayoutHeader header;
    LevelLayoutEntry entries[31];
} LevelLayout31;

extern const LevelLayout1 sLevelLayout_312EDC;
extern const LevelLayout30 sLevelLayout_312EEC;
extern const LevelLayout5 sLevelLayout_312FE4;
extern const LevelLayout30 sLevelLayout_313014;
extern const LevelLayout1 sLevelLayout_31326C;
extern const LevelLayout2 sLevelLayout_31327C;
extern const LevelLayout31 sLevelLayout_3133D0;
extern const LevelLayout6 sLevelLayout_3134D0;
extern const LevelLayout3 sLevelLayout_313508;
extern const LevelLayout3 sLevelLayout_313528;
extern const EntityPath sEntityPath_313A98;
extern const EntityPath sEntityPath_313AD8;
extern const EntityPath sEntityPath_313B18;
extern const EntityPath sEntityPath_313B58;
extern const EntityPath sEntityPath_313B98;
extern const EntityPath sEntityPath_313BD8;
extern const EntityPath sEntityPath_313C18;
extern const EntityPath sEntityPath_313C58;
extern const EntityPath sEntityPath_313C98;
extern const EntityPath sEntityPath_313CD8;
extern const EntityPath sEntityPath_313D18;
extern const EntityPath sEntityPath_313D58;
extern const EntityPath sEntityPath_313D98;
extern const EntityPath sEntityPath_313DD8;
extern const EntityPath sEntityPath_313E18;
extern const EntityPath *const sEntityPathTable_313F88[15];
extern const LevelLayout5 sLevelLayout_3140B8;
extern const LevelLayout31 sLevelLayout_3140E8;
extern const LevelLayout3 sLevelLayout_3141E8;
extern const LevelLayout4 sLevelLayout_314208;

#endif /* GUARD_LEVEL_LAYOUT_DATA_H */
