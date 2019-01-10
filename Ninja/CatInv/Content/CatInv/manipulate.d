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
 * Add item to oCItemContainer (only in conjunction with looting oCMobContainers)
 */
func void invContainerInsert() {
    var oCItemContainer container; container = _^(EBP);
    if (container.vtbl != oCItemContainer___vftable)
    || (container.invMode != INV_MODE_MOB)
    || (!_invBackupList) {
        return;
    };

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(_invBackupList), zCListSort_oCItem___InsertSort);
        call = CALL_End();
    };
};


/*
 * Remove item from oCItemContainer (only in conjunction with looting oCMobContainers)
 */
func void invContainerRemove() {
    var oCItemContainer container; container = _^(EBX);
    if (container.vtbl != oCItemContainer___vftable)
    || (container.invMode != INV_MODE_MOB)
    || (!_invBackupList) {
        return;
    };

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ESI));
        CALL__thiscall(_@(_invBackupList), zCListSort_oCItem___Remove);
        call = CALL_End();
    };
};


/*
 * Add item to oCNpcInventory
 */
func void invNpcInvInsert() {
    if (!invActiveCategory) {
        return;
    };

    var oCNpcInventory npcInv; npcInv = _^(ECX);
    var C_Npc npc; npc = _^(npcInv.owner);
    if (!Npc_IsPlayer(npc)) {
        return;
    };

    // Check if container is open
    var int containerList; containerList = MEM_ReadInt(s_openContainers_next);
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
        CALL__thiscall(_@(list), zCListSort_oCItem___InsertSort);
        call = CALL_End();
    };
};


/*
 * Remove item from oCNpcInventory
 */
func void invNpcInvRemove() {
    if (!invActiveCategory) {
        return;
    };

    var oCNpcInventory npcInv; npcInv = _^(EBX);
    var C_Npc npc; npc = _^(npcInv.owner);
    if (!Npc_IsPlayer(npc)) {
        return;
    };

    // Check if container is open
    var int containerList; containerList = MEM_ReadInt(s_openContainers_next);
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
        CALL__thiscall(_@(list), zCListSort_oCItem___Remove);
        call = CALL_End();
    };
};
func void invNpcInvRemoveByPtr() {
    var int bak; bak = EBX;
    EBX = EBP;
    invNpcInvRemove();
    EBX = bak;
};
func void invNpcInvRemoveItem() {
    var int bak; bak = ESI;
    ESI = EDI;
    invNpcInvRemove();
    ESI = bak;
};
