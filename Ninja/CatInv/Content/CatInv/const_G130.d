/*
 * This file is part of CatInv.
 * Copyright (C) 2018-2023  mud-freak (@szapp)
 *
 * CatInv is free software: you can redistribute it and/or
 * modify it under the terms of the MIT License.
 * On redistribution this notice must remain intact and all copies must
 * identify the original author.
 */


const int invCatOrder                                           =  9055660; //0x8A2DAC
const int oCItemContainer___vftable                             =  8573900; //0x82D3CC
const int oCItemContainer__ActivateNextContainer                =  6997600; //0x6AC660
const int oCItemContainer__NextItem_check1                      =  6995118; //0x6ABCAE
const int oCItemContainer__NextItem_check2                      =  6995406; //0x6ABDCE
const int oCItemContainer__PrevItem_check1                      =  6996051; //0x6AC053
const int oCItemContainer__PrevItem_check2                      =  6996333; //0x6AC16D
const int oCNpc__CloseDeadNpc                                   =  7353856; //0x703600
const int oCNpc__game_mode                                      =  9974560; //0x983320
const int oCNpcContainer___vftable                              =  8574308; //0x82D564
const int oCNpcContainer__CreateList                            =  7002752; //0x6ADA80
const int oCNpcInventory___vftable                              =  8574516; //0x82D634
const int oCNpcInventory__HandleEvent_keyWeaponJZ               =  7018189; //0x6B16CD
const int oCStealContainer___vftable                            =  8574100; //0x82D494
const int oCStealContainer__CreateList                          =  7000816; //0x6AD2F0
const int s_openContainers_next                                 =  9968424; //0x981B28
const int zCListSort_oCItem____scalar_deleting_destructor       =  6994752; //0x6ABB40
const int zCListSort_oCItem___GetNumInList                      =  7025792; //0x6B3480
const int zCListSort_oCItem___InsertSort                        =  7025664; //0x6B3400
const int zCListSort_oCItem___Remove                            =  7477680; //0x7219B0
const int zCInput__IsBindedToggled                              =  5021440; //0x4C9F00
const int zCInput_Win32__GetState                               =  5056368; //0x4D2770
const int __ftol                                                =  8145544; //0x7C4A88
const int zCView__anx                                           =  7627648; //0x746380
const int zCView__Blit                                          =  7628992; //0x7468C0
const int zCView__ClrPrintwin                                   =  7644736; //0x74A640
const int zCView__FontSize                                      =  7642896; //0x749F10
const int zCView__InsertItem                                    =  7651280; //0x74BFD0
const int zCView__PrintCXY                                      =  7644464; //0x74A530
const int zCView__RemoveItem                                    =  7651856; //0x74C210
const int zCView__SetAlphaBlendFunc                             =  7628144; //0x746570
const int zCView__SetFontColor                                  =  7642640; //0x749E10
const int zCView__SetPos                                        =  7633584; //0x747AB0
const int zCView__SetSize                                       =  7634080; //0x747CA0
const int zCView__SetTransparency                               =  7628128; //0x746560
const int CatInv_DefaultHeightAddr                              =  9968308; //0x981AB4
const int CatInv_DefaultWidthAddr                               =  9968372; //0x981AF4
const int CatInv_BaseBlendFuncAddr    /*zRND_ALPHA_FUNC_BLEND*/ =  8573848; //0x82D398
const int CatInv_DefaultAlphaFuncAddr /*zRND_ALPHA_FUNC_BLEND*/ =  8573872; //0x82D3B0
const int CatInv_FontColorAddr        /* Default: white */      =  9968652; //0x981C0C
const int CatInv_TitleTextureAddr     /* "INV_TITLE.TGA" */     =  9968676; //0x981C24
const int CatInv_BackTextureAddr[6] = {
    /* strInv_back           */    /* "INV_BACK.TGA"           */  9968496, //0x981B70
    /* strInv_back_container */    /* "INV_BACK_CONTAINER.TGA" */  9968116, //0x9819F4
    /* strInv_back_plunder   */    /* "INV_BACK_PLUNDER.TGA"   */  9968600, //0x981BD8
    /* strInv_back_steal     */    /* "INV_BACK_STEAL.TGA"     */  9968560, //0x981BB0
    /* strInv_back_buy       */    /* "INV_BACK_BUY.TGA"       */  9968456, //0x981B48
    /* strInv_back_sell      */    /* "INV_BACK_SELL.TGA"      */  9968540  //0x981B9C
};

/* Hooks */
const int oCAIHuman__ChangeCamModeBySituation_switchMobCam      =  6556741; //0x640C45
const int oCItemContainer__CheckSelectedItem_isActive           =  6994937; //0x6ABBF9
const int oCItemContainer__CheckSelectedItem_isActiveP          =  6994972; //0x6ABC1C
const int oCItemContainer__Close                                =  6992989; //0x6AB45D
const int oCItemContainer__DrawCategory_end                     =  6984467; //0x6A9313
const int oCItemContainer__HandleEvent_last                     =  6999919; //0x6ACF6F
const int oCItemContainer__Insert_insertListNode                =  6994169; //0x6AB8F9
const int oCItemContainer__NextItem_check0                      =  6995059; //0x6ABC73
const int oCItemContainer__OpenPassive                          =  6990816; //0x6AABE0
const int oCItemContainer__PrevItem_check0                      =  6996022; //0x6AC036
const int oCItemContainer__Remove_removeListNode                =  6994327; //0x6AB997
const int oCNpc__OpenDeadNpc_setupInv                           =  7353560; //0x7034D8
const int oCNpcContainer__CreateList_isArmor                    =  7003077; //0x6ADBC5
const int oCNpcContainer__CreateList_isArmor_sp18               =  7003085; //0x6ADBCD
const int oCNpcContainer__HandleEvent_isEmpty                   =  7003853; //0x6ADECD
const int oCNpcContainer__HandleEvent_last                      =  7003581; //0x6ADDBD
const int oCNpcInventory__Insert_insertListNode                 =  7007675; //0x6AEDBB
const int oCNpcInventory__Remove_removeListNode                 =  7009464; //0x6AF4B8
const int oCNpcInventory__RemoveByPtr_removeListNode            =  7008818; //0x6AF232
const int oCNpcInventory__RemoveItem_removeListNode             =  7008583; //0x6AF147
const int oCNpcInventory__HandleEvent_keyWeapon                 =  7018177; //0x6B16C1
const int oCStealContainer__CreateList_isArmor                  =  7001172; //0x6AD454
const int oCStealContainer__CreateList_isArmor_sp18             =  7001181; //0x6AD45D
const int oCStealContainer__HandleEvent_last                    =  7001912; //0x6AD738
const int oCViewDialogTrade__HandleEvent_last                   =  7821726; //0x77599E

const int oCViewDialogTrade_containerLeft_offset                =  12; //0x00C
const int oCViewDialogTrade_containerRight_offset               =  16; //0x010
const int oCViewDialogTrade_right_offset                        =  20; //0x014
const int oCViewDialogItemContainer_itemContainer_offset        = 256; //0x100

const int zOPT_GAMEKEY_WEAPON  = 8;

const int INV_MODE_PLAYER      = 0;
const int INV_MODE_MOB         = 1;
const int INV_MODE_DEAD        = 2;
const int INV_MODE_STEAL       = 3;
const int INV_MODE_TRADE_LEFT  = 4;
const int INV_MODE_TRADE_RIGHT = 5;

const int INV_CAT_GROUPS[/*INV_CAT_MAX*/ 9] = {
    0,                                                                                     // All
    /*ITEM_KAT_NF*/      (1 <<  1) | /*ITEM_KAT_FF*/ (1 << 2) | /*ITEM_KAT_MUN*/ (1 << 3), // INV_WEAPON  COMBAT
    /*ITEM_KAT_ARMOR*/   (1 <<  4),                                                        // INV_ARMOR   ARMOR
    /*ITEM_KAT_RUNE*/    (1 <<  9),                                                        // INV_RUNE    RUNE
    /*ITEM_KAT_MAGIC*/   (1 << 31),                                                        // INV_MAGIC   MAGIC
    /*ITEM_KAT_FOOD*/    (1 <<  5),                                                        // INV_FOOD    FOOD
    /*ITEM_KAT_POTIONS*/ (1 <<  7),                                                        // INV_POTION  POTION
    /*ITEM_KAT_DOCS*/    (1 <<  6),                                                        // INV_DOC     DOCS
    /*ITEM_KAT_NONE*/    (1 <<  0) | /*ITEM_KAT_LIGHT*/ (1 <<  8)                          // INV_MISC    OTHER
};


const int ASMINT_OP_nop4times = -1869574000; //0x90909090
const int ASMINT_OP_add4ESP   = -1878735741; //83 C4 04 90   add  esp, 4h
const int ASMINT_OP_shortJmp  =         235; //0xEB

const int CatInv_SP18Armor    = 0; // Indicate whether SystemPack has unlocked armors

var   int CatInv_ActiveCategory;
const int _CatInv_CurrentList = 0;
const int _CatInv_BackupList  = 0; // Only for oCItemContainer (NPCs handled differently)

const int CatInv_Initialized  = 0; // Global in case used elsewhere
const int CatInv_ChangeOnLast = 0;
const int CatInv_G1Mode       = 0;
