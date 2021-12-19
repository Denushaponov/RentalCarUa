pageextension 50103 "Rental Salesperson Extension" extends "Salesperson/Purchaser Card"
{
    layout
    {
        modify("General")
        {
            Caption = 'Rental Salesperson';
        }
        addafter("E-Mail")
        {
            field("RNL Location"; Rec."RNL Location")
            {
                ApplicationArea = All;
            }
        }
    }
}
