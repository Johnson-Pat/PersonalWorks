pageextension 50121 ItemCategoriesExt extends "Item Categories"
{
    layout
    {
        addbefore(ItemAttributesFactbox)
        {
            part(ZYItemCategoryPicture; "Jp Item Category Picture")
            {
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
                Caption = 'Item Category Picture';
            }
        }
    }
}