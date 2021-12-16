page 50105 "RNL Sales Subform"
{
    
  
    Caption = 'Cars to order';
    PageType = ListPart;
    SourceTable = "RNL Rental Sales Line";
    //AutoSplitKey=true;
  
    
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
                    ToolTip = 'Specifies the value of the Item No field.';
                    ApplicationArea = All;
                }
                field("Car Model"; Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Model field.';
                    ApplicationArea = All;
                }

                field("Price Per Day"; Rec."Price Per Day")
                {
                    ToolTip = 'Specifies the value of the Price per day';
                    ApplicationArea = All;
                }

                field(Discount; rec.Discount)
                {
                    ToolTip = 'Specifies the value of the discount field';
                    ApplicationArea = All;
                }

                 field("Rental Starting Date"; Rec."Rental Starting Date")
                {
                    ToolTip = 'Specifies the value of the Rental Starting Date field';
                    ApplicationArea = All;
                }
                field("Rental Ending Date"; Rec."Rental Ending Date")
                {
                    ToolTip = 'Specifies the value of the Rental Ending Date field';
                    ApplicationArea = All;
                }
                field("Final Price"; Rec."Final Price")
                {
                    ToolTip = 'Specifies the value of the Final Car Price field';
                    ApplicationArea = All;
                }
            }
            // Сюда писать поля финальніе калькуляции
        }
    }
    
}
