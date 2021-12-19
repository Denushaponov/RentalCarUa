pageextension 50101 "RNL Item Car Extension" extends "Item Card"
{
    layout
    {
        modify("Item")
        {
            Caption = 'Car Information';
        }
        addafter(Type)
        {

            field("RNL Model"; Rec."RNL Model")
            {
                ApplicationArea = All;
            }
            field("RNL Color"; Rec."RNL Color")
            {
                ApplicationArea = All;
            }
            field("RNL Millage"; Rec."RNL Millage")
            {
                ApplicationArea = All;
            }
            field("RNL Price Per Day"; Rec."RNL Price Per Day")
            {
                ApplicationArea = All;
            }
            field("RNL Discount"; Rec."RNL Discount")
            {
                ApplicationArea = All;
            }

        }
    }
}
