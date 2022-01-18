page 50103 "RNL Sales Setup"
{

    Caption = 'Sales Setup';
    PageType = Card;
    SourceTable = "RNL Sales Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Sales Nos."; Rec."Sales Nos.")
                {
                    ToolTip = 'Specifies the value of the Sales Nos. field.';
                    ApplicationArea = All;
                }
                field("Posted Sales Nos."; Rec."Posted Sales Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Sales Nos. field.';
                    ApplicationArea = All;
                }


            }
            group(Posting)
            {
                field("Gross Receivable"; Rec."Gross Receivable")
                {
                    ToolTip = 'Specifies the value of the Gross Receivable field.';
                    ApplicationArea = All;
                }
                field("Interest Account"; Rec."Interest Account")
                {
                    ToolTip = 'Specifies the value of the Interest Account field.';
                    ApplicationArea = All;
                }
                field("Post. Jnl. Batch Name"; Rec."Post. Jnl. Batch Name")
                {
                    ToolTip = 'Specifies the value of the Postings Journal Template Name field.';
                    ApplicationArea = All;
                }
                field("Post. Jnl. Template Name"; Rec."Post. Jnl. Template Name")
                {
                    ToolTip = 'Specifies the value of the Leasing Postings Journal Template Name field.';
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
