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
 * Draw the item category next to the currency (or container title).
 * The contents of this function is closely mapped to how the container title is drawn. I doubt all of the intermediate
 * assigning of variables is necessary or it might even be redundant, but this is how I found it in the engine.
 */
func void invDrawCategory() {
    if (!invActiveCategory) {
        return;
    };

    const int invCatViewPtr = 0;
    if (!invCatViewPtr) {
        invCatViewPtr = ViewPtr_New();
    };

    var oCItemContainer container; container = _^(ESI);
    var zCView viewTitle; viewTitle = _^(EAX); // zCView* (oCItemContainer.viewTitle)
    var int screenPtr; screenPtr = ECX; // zCView*

    var string text; text = MEM_ReadStatStringArr(TXT_INV_CAT, invGetCatID(invActiveCategory));
    text = ConcatStrings(text, STR_UnEscape("\n"));
    var int textPtr; textPtr = _@s(text);

    var int padding;
    var int fontSize;
    var int zero;
    const int ten = 10;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(zero));
        CALL_PtrParam(_@(invCatViewPtr));
        CALL__thiscall(_@(screenPtr), zCView__InsertItem);

        CALL_PutRetValTo(_@(padding));
        CALL_IntParam(_@(ten));
        CALL__thiscall(_@(screenPtr), zCView__anx);

        CALL_PutRetValTo(_@(fontSize));
        CALL_PtrParam(_@(textPtr));
        CALL__thiscall(_@(screenPtr), zCView__FontSize);

        call = CALL_End();
    };

    var int height; height = MEM_ReadInt(invDefaultHeight_addr) / 2;
    var int posX; posX = container.marginLeft - padding;
    var int posY; posY = posX + height;
    posX += viewTitle.vsizex; // Set next to currency view/container title
    fontSize += 2 * padding;

    var int width; width = 2 * MEM_ReadInt(invDefaultWidth_addr);
    if (width <= fontSize){
        width = fontSize;
    };

    if (container.right) {
        posX = PS_VMax - width - posX;
    };

    var int blendPtr; blendPtr = invBaseBlendFunc_addr + container.invMode * 4; // zTRnd_AlphaBlendFunc
    var int texPtr; texPtr = MEM_ReadStatArr(invBackTexture_addr, container.invMode);
    var int i255; i255 = 255;

    const int call2 = 0;
    if (CALL_Begin(call2)) {
        ASM_Open(512); // Manually allocate more space (default: 256 bytes)

        CALL_PtrParam(_@(texPtr));
        CALL__thiscall(_@(invCatViewPtr), zCView__InsertBack);

        CALL_PtrParam(_@(blendPtr));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetAlphaBlendFunc);

        CALL_PtrParam(_@(invFontColor_addr));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetFontColor);

        CALL_IntParam(_@(i255));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetTransparency);

        CALL_IntParam(_@(posY));
        CALL_IntParam(_@(posX));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetPos);

        CALL_IntParam(_@(height));
        CALL_IntParam(_@(width));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetSize);

        CALL__thiscall(_@(invCatViewPtr), zCView__ClrPrintwin);

        CALL__thiscall(_@(invCatViewPtr), zCView__Blit);

        CALL_PtrParam(_@(invTitleTexture_addr));
        CALL__thiscall(_@(invCatViewPtr), zCView__InsertBack);

        CALL_PtrParam(_@(invDefaultAlphaFunc_addr));
        CALL__thiscall(_@(invCatViewPtr), zCView__SetAlphaBlendFunc);

        CALL_PtrParam(_@(textPtr));
        CALL__thiscall(_@(invCatViewPtr), zCView__PrintCXY);

        CALL__thiscall(_@(invCatViewPtr), zCView__Blit);

        CALL_PtrParam(_@(invCatViewPtr));
        CALL__thiscall(_@(screenPtr), zCView__RemoveItem);

        call2 = CALL_End();
    };
};
