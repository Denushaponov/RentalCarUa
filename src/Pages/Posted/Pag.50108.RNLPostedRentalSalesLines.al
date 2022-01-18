page 50108 "RNL Posted Rental Sales Lines"
{

    Caption = 'Posted Rental Sales Lines';
    PageType = ListPart;
    SourceTable = "RNL Posted Rental Sales Line";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }

                field("Rental Starting Date"; Rec."Rental Starting Date")
                {
                    ToolTip = 'Specifies the value of the The Date when renting starts field.';
                    ApplicationArea = All;
                }
                field("Rental Ending Date"; Rec."Rental Ending Date")
                {
                    ToolTip = 'Specifies the value of the The Date when renting ends field.';
                    ApplicationArea = All;
                }

                field("Final Price"; Rec."Final Price")
                {
                    ToolTip = 'Final rental car price field.';
                    ApplicationArea = All;

                }

            }
            group(TotalPrice)
            {
                field(Bill; Rec.Bill)
                {
                    ToolTip = 'Final price of an order';
                    ApplicationArea = all;
                    Editable = false;

                }
            }
        }
    }

}
