page 50103 "RNL Sales Setup"
{
    
    Caption = 'Sales Setup';
    PageType = Card;
    SourceTable = "RNL Sales Setup";
    UsageCategory = Administration;
    InsertAllowed= false;    
    DeleteAllowed = false;
    
    
    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption='Numbering';
                field("Sales Nos."; Rec."Sales Nos.")
                {
                    ToolTip = 'Specifies the value of the Sales Nos. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
       Rec.Reset();
       if not Rec.Get() then begin
           Rec.Init();
           Rec.Insert();
       end; 
    end;
    
}
