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
 * Wrapper for zCListSort<oCItem>::`scalar deleting destructor'
 */
func void invDeleteListSortFromPool(var int list, var int purge) {
    const int call = 0;
    const int one = -1; // Set all bits, because char
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(one));
        CALL__thiscall(_@(list), zCListSort_oCItem____scalar_deleting_destructor);
        call = CALL_End();
    };
    if (purge) {
        List_DestroyS(list);
    } else {
        var zCListSort l; l = _^(list);
        l.next = 0;
    };
};


/*
 * Get category offset as defined in Gothic.ini (GAME.invCatOrder)
 * The variable int invCatOrder[9] contains the position (array value) of each category (array key).
 */
func int invGetCatID(var int offset) {
    // The "all" category
    if (!offset) {
        return 0;
    };

    // Skip "NONE" category
    offset += (offset > MEM_ReadInt(invCatOrder));

    repeat(i, INV_CAT_MAX + 1); var int i;
        if (MEM_ReadIntArray(invCatOrder, i) == offset-1) {
            return i;
        };
    end;

    // Should never be reached
    return 0;
};


/*
 * Reset the inventory to full view (category == 0)
 */
func int invReset(var int container) {
    var int container_vtbl; container_vtbl = MEM_ReadInt(container);
    if (container_vtbl == oCNpcInventory___vftable) {
        var oCNpcInventory npcInv; npcInv = _^(container);
        if (npcInv._oCItemContainer_contents != _@(npcInv.inventory_Compare)) {
            invDeleteListSortFromPool(npcInv._oCItemContainer_contents, 1); // Some nodes are in zCMemListPool
            npcInv._oCItemContainer_contents = _@(npcInv.inventory_Compare);
        };
    } else if (container_vtbl == oCStealContainer___vftable) {
        const int call = 0;
        if (CALL_Begin(call)) {
            CALL__thiscall(_@(container), oCStealContainer__CreateList);
            call = CALL_End();
        };
    } else if (container_vtbl == oCNpcContainer___vftable) {
        var oCItemContainer npcCon; npcCon = _^(container);
        var zCListSort l; l = _^(npcCon.contents);
        if (l.next) {
            invDeleteListSortFromPool(l.next, 1); // Some nodes are in zCMemListPool
            l.next = 0;
        };
        const int call2 = 0;
        if (CALL_Begin(call2)) {
            CALL__thiscall(_@(container), oCNpcContainer__CreateList);
            call2 = CALL_End();
        };
    } else if (container_vtbl == oCItemContainer___vftable) {
        if (_invBackupList) {
            var oCItemContainer itmCon; itmCon = _^(container);
            invDeleteListSortFromPool(itmCon.contents, 1); // Some nodes are in zCMemListPool
            itmCon.contents = _invBackupList;
            _invBackupList = 0;
        };
    };
    return container_vtbl;
};


/*
 * Intercept creation of trading and dead inventory
 */
func void invManipulateCreateList() {
    var C_Item itm; itm = _^(ECX);
    if (itm.mainflag == ITEM_KAT_ARMOR) {
        EAX = 1;
    } else if (!invActiveCategory) {
        // 'All' category
        EAX = 0;
    } else if (itm.mainflag & MEM_ReadStatArr(INV_CAT_GROUPS, invGetCatID(invActiveCategory))) {
        // Check if item is in active inventory category
        EAX = 0;
    } else {
        // Wrong category
        EAX = 1;
    };
};


/*
 * Scroll to top
 */
func void invResetOffset(var int container) {
    var oCItemContainer con; con = _^(container);
    con.selectedItem -= con.offset;
    con.offset = 0;
};


/*
 * Update the inventory to category view
 */
func void invUpdate(var int container) {
    var int container_vtbl; container_vtbl = invReset(container);
    if (!invActiveCategory) {
        return;
    };

    if (container_vtbl == oCNpcInventory___vftable) {
        var oCNpcInventory npcInv; npcInv = _^(container);

        npcInv._oCItemContainer_contents = List_CreateS(0);
        var zCListSort list0; list0 = _^(npcInv._oCItemContainer_contents);
        list0.compareFunc = npcInv.inventory_Compare;

        _invCurrentList = npcInv._oCItemContainer_contents;
        if (npcInv.inventory_next) {
            List_ForFS(npcInv.inventory_next, invAddItem);
        };
    } else if (container_vtbl == oCItemContainer___vftable) {
        var oCItemContainer itmCon; itmCon = _^(container);
        if (_invBackupList) {
            invDeleteListSortFromPool(_invBackupList, 1); // Some nodes are in zCMemListPool
        };
        _invBackupList = itmCon.contents;
        var zCListSort backupList; backupList = _^(_invBackupList);

        itmCon.contents = List_CreateS(0);
        var zCListSort list; list = _^(itmCon.contents);
        list.compareFunc = backupList.compareFunc;

        _invCurrentList = itmCon.contents;
        if (backupList.next) {
            List_ForFS(backupList.next, invAddItem);
        };
    };
};
func void invAddItem(var int listPtr) {
    var zCListSort l; l = _^(listPtr);
    var C_Item itm; itm = _^(l.data);
    if (itm.mainflag & MEM_ReadStatArr(INV_CAT_GROUPS, invGetCatID(invActiveCategory))) {
        List_AddS(_invCurrentList, l.data);
    };
};
func void invUpdateAll() {
    var int list; list = MEM_ReadInt(s_openContainers_next);
    while(list);
        var zCList l; l = _^(list);
        invUpdate(l.data);
        invResetOffset(l.data);
        list = l.next;
    end;
};


/*
 * Intercept opening/closing of any oCItemContainer
 */
func void invOpen() {
    // Reset active category when trading or looting
    var oCItemContainer container; container = _^(ECX);
    if (container.vtbl != oCNpcInventory___vftable) {
        invActiveCategory = 0;
        invResetOffset(ECX);
    };

    invUpdate(ECX);
};
func void invClose() {
    if (Hlp_IsValidNpc(hero)) {
        var int i; i = invReset(ESI);
    };
};


/*
 * Sets the inventory category
 */
func int invSetCategory(var int pos) {
    var int invNewCategory; invNewCategory = pos;
    if (invNewCategory < 0) {
        invNewCategory = 0;
    } else if (invNewCategory >= INV_CAT_MAX) {
        invNewCategory = INV_CAT_MAX-1;
    };

    if (invNewCategory == invActiveCategory) {
        return FALSE;
    };
    invActiveCategory = invNewCategory;

    invUpdateAll();
    return TRUE;
};


/*
 * Change the inventory category
 */
func int invShiftCategory(var int offset) {
    return invSetCategory(invActiveCategory + offset);
};


/*
 * Sets the inventory to the first category ('all')
 */
func int invSetCategoryFirst() {
    return invSetCategory(0);
};


/*
 * Sets the inventory to the last category
 */
func int invSetCategoryLast() {
    return invSetCategory(INV_CAT_MAX-1);
};
