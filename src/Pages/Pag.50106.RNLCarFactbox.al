page 50106 "RNL Car Factbox"
{
    Caption = 'Car Factbox';
    PageType = CardPart;
    SourceTable = Item;
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
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies No.';
                    ApplicationArea = All;
                }

                field("RNL Mileage"; Rec."RNL Mileage")
                {
                    ToolTip = 'Specifies the value of the Mileage field.';
                    ApplicationArea = All;
                }
            }

        }
    }

}
