/*
 * This file is part of CatInv.
 * Copyright (C) 2018-2019  mud-freak (@szapp)
 *
 * CatInv is free software: you can redistribute it and/or
 * modify it under the terms of the MIT License.
 * On redistribution this notice must remain intact and all copies must
 * identify the original author.
 */


/*
 * Initialization function
 */
func void invInit() {
    // Basic
    HookEngineF(oCItemContainer__OpenPassive, 7, invOpen);
    HookEngineF(oCItemContainer__Close, 6, invClose);

    // Going right
    MemoryProtectionOverride(oCItemContainer__PrevItem_check1, 2);
    MemoryProtectionOverride(oCItemContainer__NextItem_check2, 1);
    HookEngineF(oCItemContainer__NextItem_check0, 5, invRight);

    // Going left
    MemoryProtectionOverride(oCItemContainer__PrevItem_check1, 2);
    MemoryProtectionOverride(oCItemContainer__PrevItem_check2, 1);
    HookEngineF(oCItemContainer__PrevItem_check0, 5, invLeft);

    // Register extended key strokes (HOME/END for first/last category and keyWeapon for switching container)
    HookEngineF(oCItemContainer__HandleEvent_last, 6, invHandleEventEDI);
    HookEngineF(oCNpcContainer__HandleEvent_last, 6, invHandleEventEDI);
    HookEngineF(oCStealContainer__HandleEvent_last, 6, invHandleEventEDI);
    HookEngineF(oCViewDialogTrade__HandleEvent_last, 6, invHandleEventEBX);

    // Update on removing item
    HookEngineF(oCItemContainer__Remove_removeListNode, 5, invContainerRemove);
    HookEngineF(oCNpcInventory__Remove_removeListNode, 5, invNpcInvRemove);
    HookEngineF(oCNpcInventory__RemoveByPtr_removeListNode, 5, invNpcInvRemoveByPtr);
    HookEngineF(oCNpcInventory__RemoveItem_removeListNode, 5, invNpcInvRemoveItem);

    // Update on inserting item
    HookEngineF(oCItemContainer__Insert_insertListNode, 5, invContainerInsert);
    HookEngineF(oCNpcInventory__Insert_insertListNode, 6, invNpcInvInsert);

    // Reset category before opening dead inventory
    HookEngineF(oCNpc__OpenDeadNpc_setupInv, 6, invDeadResetCategory);

    // Draw category
    HookEngineF(oCItemContainer__DrawCategory_end, 5, invDrawCategory);

    const int once = 0;
    if (!once) {
        // Handle equipped (active) items in trading menu
        MemoryProtectionOverride(oCItemContainer__CheckSelectedItem_isActive, 5);
        MEM_WriteByte(oCItemContainer__CheckSelectedItem_isActive, ASMINT_OP_nop);
        MEM_WriteInt(oCItemContainer__CheckSelectedItem_isActive+1, ASMINT_OP_add4ESP);
        HookEngineF(oCItemContainer__CheckSelectedItem_isActive, 5, invClampCategory);

        // Manipulate trading inventory
        MemoryProtectionOverride(oCStealContainer__CreateList_isArmor, 5);
        MEM_WriteByte(oCStealContainer__CreateList_isArmor, ASMINT_OP_nop);
        MEM_WriteInt(oCStealContainer__CreateList_isArmor+1, ASMINT_OP_add4ESP);
        HookEngineF(oCStealContainer__CreateList_isArmor, 5, invManipulateCreateList);

        // Manipulate dead inventory
        MemoryProtectionOverride(oCNpcContainer__CreateList_isArmor, 5);
        MEM_WriteByte(oCNpcContainer__CreateList_isArmor, ASMINT_OP_nop);
        MEM_WriteInt(oCNpcContainer__CreateList_isArmor+1, ASMINT_OP_add4ESP);
        HookEngineF(oCNpcContainer__CreateList_isArmor, 5, invManipulateCreateList);

        // Prevent closing dead inventory if actually non-empty
        MemoryProtectionOverride(oCNpcContainer__HandleEvent_isEmpty, 5);
        MEM_WriteByte(oCNpcContainer__HandleEvent_isEmpty, ASMINT_OP_nop);
        MEM_WriteInt(oCNpcContainer__HandleEvent_isEmpty+1, ASMINT_OP_nop4times);
        HookEngineF(oCNpcContainer__HandleEvent_isEmpty, 5, invPreventCloseDeadInv);

        // Register extended key strokes (HOME/END for first/last category and keyWeapon for switching container)
        MemoryProtectionOverride(oCNpcInventory__HandleEvent_keyWeaponJZ, 1);
        MemoryProtectionOverride(oCNpcInventory__HandleEvent_keyWeapon, 8);
        MEM_WriteInt(oCNpcInventory__HandleEvent_keyWeapon, ASMINT_OP_nop4times);
        MEM_WriteInt(oCNpcInventory__HandleEvent_keyWeapon+4, ASMINT_OP_nop4times);
        HookEngineF(oCNpcInventory__HandleEvent_keyWeapon, 8, invHandleEventNpcInventory);

        // Delay the mob camera switch
        MemoryProtectionOverride(oCAIHuman__ChangeCamModeBySituation_switchMobCam, 8);
        MEM_WriteInt(oCAIHuman__ChangeCamModeBySituation_switchMobCam, ASMINT_OP_add4ESP);
        MEM_WriteInt(oCAIHuman__ChangeCamModeBySituation_switchMobCam+4, ASMINT_OP_nop4times);
        HookEngineF(oCAIHuman__ChangeCamModeBySituation_switchMobCam, 8, invDelayMobCamera);

        once = 1;
    };
};
