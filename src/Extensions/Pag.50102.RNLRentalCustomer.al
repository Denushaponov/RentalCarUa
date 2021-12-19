pageextension 50102 "RNL Rental Customer" extends "Customer Card"
{
    layout
    {
        modify(General)
        {
            Caption = 'Customer Information';
        }
        addafter(Blocked)
        {
            field("RNL Discount"; Rec."RNL Discount")
            {
                ApplicationArea = all;
            }
        }

    }
}
