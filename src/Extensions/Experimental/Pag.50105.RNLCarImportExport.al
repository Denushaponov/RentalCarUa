pageextension 50105 "RNL CarImportExport" extends "Item List"
{
    actions
    {
        addafter(History)
        {
            action("RNL ImportCars")
            {
                // ApplicationArea = All;
                Caption = 'Export or import car';
                //RunObject = xmlport "RNL Car";
                Promoted = true;
                PromotedCategory = New;
                //  PromotedIsBig = true;
                //   PromotedOnly = true;
                Image = Export;
                trigger OnAction()
                begin
                    Xmlport.Run(50100, true, true);
                end;


            }
        }
    }
}
