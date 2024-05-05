/*
 * This file is part of CatInv.
 * Copyright (C) 2018-2024  Sören Zapp
 *
 * CatInv is free software: you can redistribute it and/or
 * modify it under the terms of the MIT License.
 * On redistribution this notice must remain intact and all copies must
 * identify the original author.
 */


/*
 * Initialization function
 */
func void CatInv_Init() {
    // Basic
    HookEngineF(CatInv_oCItemContainer__OpenPassive, 7, CatInv_Open);
    HookEngineF(CatInv_oCItemContainer__Close, 6, CatInv_Close);

    // Going right
    MemoryProtectionOverride(CatInv_oCItemContainer__PrevItem_check1, 2);
    MemoryProtectionOverride(CatInv_oCItemContainer__NextItem_check2, 1);
    HookEngineF(CatInv_oCItemContainer__NextItem_check0, 5, CatInv_Right);

    // Going left
    MemoryProtectionOverride(CatInv_oCItemContainer__PrevItem_check1, 2);
    MemoryProtectionOverride(CatInv_oCItemContainer__PrevItem_check2, 1);
    HookEngineF(CatInv_oCItemContainer__PrevItem_check0, 5, CatInv_Left);

    // Register extended key strokes (HOME/END for first/last category and keyWeapon for switching container)
    HookEngineF(CatInv_oCItemContainer__HandleEvent_last, 6, CatInv_HandleEventEDI);
    HookEngineF(CatInv_oCNpcContainer__HandleEvent_last, 6, CatInv_HandleEventEDI);
    HookEngineF(CatInv_oCStealContainer__HandleEvent_last, 6, CatInv_HandleEventEDI);
    HookEngineF(CatInv_oCViewDialogTrade__HandleEvent_last, 6, CatInv_HandleEventEBX);

    // Update on removing item
    HookEngineF(CatInv_oCItemContainer__Remove_removeListNode, 5, CatInv_ContainerRemove);
    HookEngineF(CatInv_oCNpcInventory__Remove_removeListNode, 5, CatInv_NpcInvRemove);
    HookEngineF(CatInv_oCNpcInventory__RemoveByPtr_removeListNode, 5, CatInv_NpcInvRemoveByPtr);
    HookEngineF(CatInv_oCNpcInventory__RemoveItem_removeListNode, 5, CatInv_NpcInvRemoveItem);

    // Update on inserting item
    HookEngineF(CatInv_oCItemContainer__Insert_insertListNode, 5, CatInv_ContainerInsert);
    HookEngineF(CatInv_oCNpcInventory__Insert_insertListNode, 6, CatInv_NpcInvInsert);

    // Reset category before opening dead inventory
    HookEngineF(CatInv_oCNpc__OpenDeadNpc_setupInv, 6, CatInv_DeadResetCategory);

    // Draw category
    HookEngineF(CatInv_oCItemContainer__DrawCategory_end, 5, CatInv_DrawCategory);

    if (!CatInv_Initialized) {
        // Handle equipped (active) items in trading menu
        MemoryProtectionOverride(CatInv_oCItemContainer__CheckSelectedItem_isActive, 5);
        MEM_WriteByte(CatInv_oCItemContainer__CheckSelectedItem_isActive, ASMINT_OP_nop);
        MEM_WriteInt(CatInv_oCItemContainer__CheckSelectedItem_isActive+1, CatInv_ASMINT_OP_add4ESP);
        HookEngineF(CatInv_oCItemContainer__CheckSelectedItem_isActive, 5, CatInv_ClampCategory);
        MemoryProtectionOverride(CatInv_oCItemContainer__CheckSelectedItem_isActiveP, 1);
        MEM_WriteByte(CatInv_oCItemContainer__CheckSelectedItem_isActiveP, CatInv_ASMINT_OP_shortJmp);

        // Revert changes of SystemPack 1.8 (Armor_unlock_in_trade, Armor_unlock_in_npc)
        if (MEM_ReadInt(CatInv_oCStealContainer__CreateList_isArmor_sp18) == 0) {
            MemoryProtectionOverride(CatInv_oCStealContainer__CreateList_isArmor_sp18, 4);
            MEM_WriteInt(CatInv_oCStealContainer__CreateList_isArmor_sp18, /*0F 01 00 00*/ 271);
            CatInv_SP18Armor = TRUE;
        };
        if (MEM_ReadByte(CatInv_oCNpcContainer__CreateList_isArmor_sp18) == 0) {
            MemoryProtectionOverride(CatInv_oCNpcContainer__CreateList_isArmor_sp18, 1);
            MEM_WriteByte(CatInv_oCNpcContainer__CreateList_isArmor_sp18, /*1A*/ 26);
            CatInv_SP18Armor = TRUE;
        };

        // Manipulate trading inventory
        MemoryProtectionOverride(CatInv_oCStealContainer__CreateList_isArmor, 5);
        MEM_WriteByte(CatInv_oCStealContainer__CreateList_isArmor, ASMINT_OP_nop);
        MEM_WriteInt(CatInv_oCStealContainer__CreateList_isArmor+1, CatInv_ASMINT_OP_add4ESP);
        HookEngineF(CatInv_oCStealContainer__CreateList_isArmor, 5, CatInv_ManipulateCreateList);

        // Manipulate dead inventory
        MemoryProtectionOverride(CatInv_oCNpcContainer__CreateList_isArmor, 5);
        MEM_WriteByte(CatInv_oCNpcContainer__CreateList_isArmor, ASMINT_OP_nop);
        MEM_WriteInt(CatInv_oCNpcContainer__CreateList_isArmor+1, CatInv_ASMINT_OP_add4ESP);
        HookEngineF(CatInv_oCNpcContainer__CreateList_isArmor, 5, CatInv_ManipulateCreateList);

        // Prevent closing dead inventory if actually non-empty
        MemoryProtectionOverride(CatInv_oCNpcContainer__HandleEvent_isEmpty, 5);
        MEM_WriteByte(CatInv_oCNpcContainer__HandleEvent_isEmpty, ASMINT_OP_nop);
        MEM_WriteInt(CatInv_oCNpcContainer__HandleEvent_isEmpty+1, CatInv_ASMINT_OP_nop4times);
        HookEngineF(CatInv_oCNpcContainer__HandleEvent_isEmpty, 5, CatInv_PreventCloseDeadInv);

        // Register extended key strokes (HOME/END for first/last category and keyWeapon for switching container)
        MemoryProtectionOverride(CatInv_oCNpcInventory__HandleEvent_keyWeaponJZ, 1);
        MemoryProtectionOverride(CatInv_oCNpcInventory__HandleEvent_keyWeapon, 8);
        MEM_WriteInt(CatInv_oCNpcInventory__HandleEvent_keyWeapon, CatInv_ASMINT_OP_nop4times);
        MEM_WriteInt(CatInv_oCNpcInventory__HandleEvent_keyWeapon+4, CatInv_ASMINT_OP_nop4times);
        HookEngineF(CatInv_oCNpcInventory__HandleEvent_keyWeapon, 8, CatInv_HandleEventNpcInventory);

        // Delay the mob camera switch
        MemoryProtectionOverride(CatInv_oCAIHuman__ChangeCamModeBySituation_switchMobCam, 8);
        MEM_WriteInt(CatInv_oCAIHuman__ChangeCamModeBySituation_switchMobCam, CatInv_ASMINT_OP_add4ESP);
        MEM_WriteInt(CatInv_oCAIHuman__ChangeCamModeBySituation_switchMobCam+4, CatInv_ASMINT_OP_nop4times);
        HookEngineF(CatInv_oCAIHuman__ChangeCamModeBySituation_switchMobCam, 8, CatInv_DelayMobCamera);

        CatInv_Initialized = 1;
    };

    // Introducing the INI entries if not present
    if (!MEM_GothOptExists("GAME", "invCatChangeOnLast")) {
        MEM_SetGothOpt("GAME", "invCatChangeOnLast", "0");
    };
    if (!MEM_GothOptExists("GAME", "invCatG1Mode")) {
        MEM_SetGothOpt("GAME", "invCatG1Mode", "0");
    };
    CatInv_ChangeOnLast = !!STR_ToInt(MEM_GetGothOpt("GAME", "invCatChangeOnLast"));
    CatInv_G1Mode       = !!STR_ToInt(MEM_GetGothOpt("GAME", "invCatG1Mode"));

    // Do not show 'all' category
    if (CatInv_G1Mode) && (!CatInv_ActiveCategory) {
        CatInv_ActiveCategory += 1;
    };
};
