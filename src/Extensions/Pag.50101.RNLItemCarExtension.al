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
            field("RNL Millage"; Rec."RNL Mileage")
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

    actions
    {
        addlast(processing)
        {
            group("RNL XMLExportImport")
            {
                action("RNL ExportImport")
                {
                    ApplicationArea = All;
                    Caption = 'Export or import car';
                    RunObject = xmlport "RNL Car";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Export;
                }


            }
        }
    }

}
