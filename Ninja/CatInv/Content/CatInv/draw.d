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
 * Draw the item category next to the currency (or container title).
 * The contents of this function is closely mapped to how the container title is drawn. I doubt all of the intermediate
 * assigning of variables is necessary or it might even be redundant, but this is how I found it in the engine.
 */
func void CatInv_DrawCategory() {
    if (!CatInv_ActiveCategory) {
        return;
    };

    if (!CatInv_SupportCat(ESI)) {
        return;
    };

    const int catViewPtr = 0;
    if (!catViewPtr) {
        catViewPtr = ViewPtr_New();
    };

    var CatInv_oCItemContainer container; container = _^(ESI);
    var zCView viewTitle; viewTitle = _^(EAX); // zCView* (oCItemContainer.viewTitle)
    var int screenPtr; screenPtr = ECX; // zCView*

    // Attempt to read TXT_INV_CAT if symbol exists
    const int TXT_INV_CAT_Ptr = 0;
    if (!TXT_INV_CAT_Ptr) {
        var int symbPtr; symbPtr = MEM_GetSymbol("TXT_INV_CAT");
        if (symbPtr) {
            TXT_INV_CAT_Ptr = MEM_ReadInt(symbPtr+zCParSymbol_content_offset);
        } else {
            // Fallback values if TXT_INV_CAT does not exist
            const string fallback[9] = {
                "", "Weapons", "Armor", "Magic", "Artifacts", "Food", "Potions", "Writings", "Miscellaneous"
            };
            TXT_INV_CAT_Ptr = _@s(fallback);
        };
    };

    var string text; text = MEM_ReadStringArray(TXT_INV_CAT_Ptr, CatInv_GetCatID(CatInv_ActiveCategory));
    text = ConcatStrings(text, STR_UnEscape("\n"));
    var int textPtr; textPtr = _@s(text);

    var int padding;
    var int fontSize;
    var int zero;
    const int ten = 10;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(zero));
        CALL_PtrParam(_@(catViewPtr));
        CALL__thiscall(_@(screenPtr), CatInv_zCView__InsertItem);

        CALL_PutRetValTo(_@(padding));
        CALL_IntParam(_@(ten));
        CALL__thiscall(_@(screenPtr), CatInv_zCView__anx);

        CALL_PutRetValTo(_@(fontSize));
        CALL_PtrParam(_@(textPtr));
        CALL__thiscall(_@(screenPtr), CatInv_zCView__FontSize);

        call = CALL_End();
    };

    var int height; height = MEM_ReadInt(CatInv_DefaultHeightAddr) / 2;
    var int posX; posX = container.marginLeft - padding;
    var int posY; posY = posX + height;
    posX += viewTitle.vsizex; // Set next to currency view/container title
    fontSize += 2 * padding;

    var int width; width = 2 * MEM_ReadInt(CatInv_DefaultWidthAddr);
    if (width <= fontSize){
        width = fontSize;
    };

    if (container.right) {
        posX = PS_VMax - width - posX;
    };

    var int blendPtr; blendPtr = CatInv_BaseBlendFuncAddr + container.invMode * 4; // zTRnd_AlphaBlendFunc
    var int texPtr; texPtr = MEM_ReadStatArr(CatInv_BackTextureAddr, container.invMode);
    var int i255; i255 = 255;

    const int call2 = 0;
    if (CALL_Begin(call2)) {
        ASM_Open(512); // Manually allocate more space (default: 256 bytes)

        CALL_PtrParam(_@(texPtr));
        CALL__thiscall(_@(catViewPtr), zCView__InsertBack);

        CALL_PtrParam(_@(blendPtr));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetAlphaBlendFunc);

        CALL_PtrParam(_@(CatInv_FontColorAddr));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetFontColor);

        CALL_IntParam(_@(i255));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetTransparency);

        CALL_IntParam(_@(posY));
        CALL_IntParam(_@(posX));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetPos);

        CALL_IntParam(_@(height));
        CALL_IntParam(_@(width));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetSize);

        CALL__thiscall(_@(catViewPtr), CatInv_zCView__ClrPrintwin);

        CALL__thiscall(_@(catViewPtr), CatInv_zCView__Blit);

        CALL_PtrParam(_@(CatInv_TitleTextureAddr));
        CALL__thiscall(_@(catViewPtr), zCView__InsertBack);

        CALL_PtrParam(_@(CatInv_DefaultAlphaFuncAddr));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__SetAlphaBlendFunc);

        CALL_PtrParam(_@(textPtr));
        CALL__thiscall(_@(catViewPtr), CatInv_zCView__PrintCXY);

        CALL__thiscall(_@(catViewPtr), CatInv_zCView__Blit);

        CALL_PtrParam(_@(catViewPtr));
        CALL__thiscall(_@(screenPtr), CatInv_zCView__RemoveItem);

        call2 = CALL_End();
    };
};
