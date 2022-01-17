codeunit 50103 "RNL Calculating Bill"
{

    procedure Calculate(var DocumentNo: Code[20]; var LineNo: Integer; var FinalPrice: Decimal)
    var
        RentalOrderlines: Record "RNL Rental Sales Line";
        BillAmount: Decimal;
        RentalHeaderRec: Record "RNL Rental Sales Header";
    begin
        BillAmount := 0 + FinalPrice;
        RentalOrderlines.SetRange("Doc. No.", DocumentNo);
        RentalOrderlines.SetFilter("Line No.", '<>%1', LineNo);
        if RentalOrderlines.FindSet() then
            repeat
                BillAmount := BillAmount + RentalOrderlines."Final Price";
            until RentalOrderlines.Next() = 0;
        RentalHeaderRec.SetRange("Doc. No.", DocumentNo);
        RentalHeaderRec.FindFirst();
        RentalHeaderRec."Bill Amount Flowfield" := BillAmount;
    end;

    procedure CalculateField(var DocumentNo: Code[20]) ReturnValue: Decimal
    var
        RentalOrderlines: Record "RNL Rental Sales Line";

        RentalHeaderRec: Record "RNL Rental Sales Header";
    begin

        RentalOrderlines.SetRange("Doc. No.", DocumentNo);
        ReturnValue := 0;
        if RentalOrderlines.FindSet() then
            repeat
                ReturnValue := ReturnValue + RentalOrderlines."Final Price";
            until RentalOrderlines.Next() = 0;
    end;

}
