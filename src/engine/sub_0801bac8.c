extern void Level_PreLoadHook(void);
extern void LoadWorldLevelLayout(void);

void Level_LoadLayout(void)
{
    Level_PreLoadHook();
    LoadWorldLevelLayout();
}

void Credits_PreInitHook(void)
{}
