#ifndef GUARD_TYPES_H
#define GUARD_TYPES_H

#define TRUE  1
#define FALSE 0
#define NULL  ((void *)0)

typedef unsigned char u8;
typedef signed char s8;
typedef unsigned short u16;
typedef signed short s16;
typedef unsigned int u32;
typedef signed int s32;
typedef unsigned long long u64;
typedef signed long long s64;

typedef volatile unsigned char vu8;
typedef volatile signed char vs8;
typedef volatile unsigned short vu16;
typedef volatile signed short vs16;
typedef volatile unsigned int vu32;
typedef volatile signed int vs32;

typedef u8 boolu8;
typedef u16 boolu16;
typedef u32 boolu32;

#define SCHAR_MIN  (-128)
#define SCHAR_MAX  (127)
#define UCHAR_MAX  (255)

#define SHORT_MIN  (-32768)
#define SHORT_MAX  (32767)
#define USHORT_MAX (65535)

#define INT_MIN    (-2147483648)
#define INT_MAX    (2147483647)
#define UINT_MAX   ((u32)4294967295)

#endif /* GUARD_TYPES_H */
