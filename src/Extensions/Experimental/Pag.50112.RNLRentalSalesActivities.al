page 50112 "RNL Rental Sales Activities"
{
    Caption = 'Rental Car Sales Activities';
    PageType = CardPart;
    SourceTable = "RNL Rental Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(Activities)
            {
                field("Unposted Orders"; Rec."Unposted Orders")
                {
                    DrillDownPageId = "RNL Orders List";
                    Image = Calculator;
                    ApplicationArea = all;
                }
                field("Posted Orders"; Rec."Posted Orders")
                {
                    DrillDownPageId = "RNL Posted Rental Sales List";
                    Image = Calculator;
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = all;

            }
        }
    }



    trigger OnOpenPage();
    var
    //myInt : Integer;
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;
    end;

}
