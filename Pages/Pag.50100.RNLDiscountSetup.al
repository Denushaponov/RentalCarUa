page 50100 "RNL Discount Setup"
{
    
    PageType = Card;
    ApplicationArea=All;
    UsageCategory = Administration;
    SourceTable = "RNL Discount Setup";
    Caption = 'Discount Setup';
    InsertAllowed= false;    
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption='Numbering';
                field("Discount Nos."; Rec."Discount Nos.")
                {
                    ToolTip = 'Specifies the number series that will be used for Discount Nos.';
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
