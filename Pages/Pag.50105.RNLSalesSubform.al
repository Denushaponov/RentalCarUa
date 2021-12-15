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
            }
        }
    }
    
}
