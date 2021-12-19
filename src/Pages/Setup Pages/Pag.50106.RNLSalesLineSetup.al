page 50106 "RNL Sales Line Setup"
{
    
    Caption = 'Sales Line Setup';
    PageType = Card;
    SourceTable = "RNL Sales Line Setup";
    UsageCategory = Administration;
    InsertAllowed= false;    
    DeleteAllowed = false;
    
    
    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption ='Numbering';
                field("Line No."; Rec."Line Nos.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
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
