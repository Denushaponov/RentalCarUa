codeunit 50101 "RNL Looking For Maximum Disc"
{


    procedure GetMaximumDiscountLine(var DocumentNo: Code[20]; var LineNo: Integer; var Discount: Decimal) ReturnValue: Decimal
    var
        RentalSalesLineRec: Record "RNL Rental Sales Line";
        RentalSalesHeaderRec: Record "RNL Rental Sales Header";
        TheBiggestDiscount: Decimal;
    begin
        TheBiggestDiscount := 0;
        RentalSalesHeaderRec.SetRange("Doc. No.", DocumentNo);
        RentalSalesHeaderRec.FindFirst();
        TheBiggestDiscount := RentalSalesHeaderRec.Discount;
        if (Discount > TheBiggestDiscount) then begin TheBiggestDiscount := Discount; end;
        ReturnValue := TheBiggestDiscount;
    end;


}
