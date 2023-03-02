pageextension 50120 ItemCardExt extends "Item Card"
{
    layout
    {
        addbefore(ItemPicture)
        {
            part(ZYItemCategoryPicture; "Jp Item Category Picture")
            {
                ApplicationArea = All;
                SubPageLink = Code = field("Item Category Code");
                Caption = 'Item Category Picture';
            }
        }
    }
}