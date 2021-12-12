page 50101 "RNL Discount Card"
{
    
    Caption = 'Discount Card';

    // change to card
    PageType = Card;
    SourceTable = "RNL Discount";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(Percent; Rec.Percent)
                {
                    ToolTip = 'Specifies the value of the Percent field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    
}
