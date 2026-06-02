extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void sub_0800CE98(unsigned int a, unsigned int b);
extern void sub_08009CBC(void);
extern void sub_08007660(unsigned int a, unsigned int b);
extern void sub_080072E0(unsigned int a, unsigned int b, unsigned int c);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08004508(unsigned int a, unsigned int b, unsigned int c, unsigned int d);

struct Unk_03005330 {
    unsigned char unk0[20];
    unsigned int unk14;
};

void sub_08004470(void)
{
    ModeControl_Init(0x03006110, 0x80, 14, 0x082F9B6C, 1, 3);
    sub_0800CE98(14, 0);
    sub_08009CBC();
}

void sub_080044A4(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e, unsigned int f,
                  unsigned int g)
{
    sub_08007660(2, a);
    sub_080072E0(0, 3, b);
    sub_080072E0(1, 4, c);
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08004508(d, e, f, g);
    ((struct Unk_03005330 *)0x03005330)->unk14++;
}
