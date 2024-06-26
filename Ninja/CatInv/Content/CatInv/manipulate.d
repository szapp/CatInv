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
 * Add item to oCItemContainer (only in conjunction with looting oCMobContainers)
 */
func void CatInv_ContainerInsert() {
    var CatInv_oCItemContainer container;
    if (GOTHIC_BASE_VERSION == 2) { container = _^(EBP); } else { container = _^(EDI); };
    if (container.vtbl != CatInv_oCItemContainer___vftable)
    || (container.invMode != CatInv_INV_MODE_MOB)
    || (!_CatInv_BackupList) {
        return;
    };

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(_CatInv_BackupList), CatInv_zCListSort_oCItem___InsertSort);
        call = CALL_End();
    };
};


/*
 * Remove item from oCItemContainer (only in conjunction with looting oCMobContainers)
 */
func void CatInv_ContainerRemove() {
    var CatInv_oCItemContainer container; container = _^(EBX);
    if (container.vtbl != CatInv_oCItemContainer___vftable)
    || (container.invMode != CatInv_INV_MODE_MOB)
    || (!_CatInv_BackupList) {
        return;
    };

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(_CatInv_BackupList), CatInv_zCListSort_oCItem___Remove);
        call = CALL_End();
    };
};


/*
 * Add item to oCNpcInventory
 */
func void CatInv_NpcInvInsert() {
    if (!CatInv_ActiveCategory) {
        return;
    };

    var CatInv_oCNpcInventory npcInv; npcInv = _^(ECX);
    var C_Npc npc; npc = _^(npcInv.owner);
    if (!Npc_IsPlayer(npc)) {
        return;
    };

    // Check if container is open
    var int containerList; containerList = MEM_ReadInt(CatInv_s_openContainers_next);
    if (!containerList) {
        return;
    };
    if (!List_Contains(containerList, ECX)) {
        return;
    };

    var int list; list = npcInv._oCItemContainer_contents;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(list), CatInv_zCListSort_oCItem___InsertSort);
        call = CALL_End();
    };
};


/*
 * Remove item from oCNpcInventory
 */
func void CatInv_NpcInvRemove() {
    if (!CatInv_ActiveCategory) {
        return;
    };

    var CatInv_oCNpcInventory npcInv; npcInv = _^(EBX);
    var C_Npc npc; npc = _^(npcInv.owner);
    if (!Npc_IsPlayer(npc)) {
        return;
    };

    // Check if container is open
    var int containerList; containerList = MEM_ReadInt(CatInv_s_openContainers_next);
    if (!containerList) {
        return;
    };
    if (!List_Contains(containerList, EBX)) {
        return;
    };

    var int list; list = npcInv._oCItemContainer_contents;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(list), CatInv_zCListSort_oCItem___Remove);
        call = CALL_End();
    };
};
func void CatInv_NpcInvRemoveByPtr() {
    var int bak; bak = EBX;
    EBX = EBP;
    CatInv_NpcInvRemove();
    EBX = bak;
};
func void CatInv_NpcInvRemoveItem() {
    var int bak; bak = ESI;
    ESI = EDI;
    CatInv_NpcInvRemove();
    ESI = bak;
};
