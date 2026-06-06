extern void CharLayers_Upload(unsigned int arg);
extern void FrogOam_Init(void);
extern void Scroll_UpdateCamera(unsigned int arg);
extern void BgScrollBlit(unsigned int arg);
extern void StatusBar_Update(void);

void InitScene2LayerB(void)
{
    CharLayers_Upload(2);
    *(unsigned char *)0x03003610 = 0;
    FrogOam_Init();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}
