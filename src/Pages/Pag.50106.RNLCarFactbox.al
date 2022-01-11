page 50106 "RNL Car Factbox"
{
    Caption = 'Car Factbox';
    PageType = CardPart;
    SourceTable = "RNL Rental Sales Line";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Image)
            {
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the picture that has been inserted for the item.';
                    ApplicationArea = All;
                }
            }
            group(General)
            {
                field("No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies Item No.';
                    ApplicationArea = All;
                }

                field("RNL Mileage"; Rec."Mileage")
                {
                    ToolTip = 'Specifies the value of the Mileage field.';
                    ApplicationArea = All;
                }
                field("RNL Availability"; Rec.Availability)
                {
                    ToolTip = 'Is car availible today';
                    ApplicationArea = all;
                }
            }

        }
    }
    trigger OnAfterGetCurrRecord()
    var
        CheckForAvailability: Codeunit "RNL Is Car Availible";
    begin
        Rec.Availability := CheckForAvailability.IsAvailible(Rec."Item No.");

    end;

}
