codeunit 50101 "RNL Looking For Maximum Disc"
{


    procedure GetMaximumDiscount(var DocumentNo: Code[20]) ReturnValue: Decimal
    var
        RentalSalesLineRec: Record "RNL Rental Sales Line";
        RentalSalesHeaderRec: Record "RNL Rental Sales Header";
        TheBiggestDiscount: Decimal;
    begin
        TheBiggestDiscount := 0;
        RentalSalesHeaderRec.SetRange("Doc. No.", DocumentNo);
        RentalSalesHeaderRec.FindFirst();
        TheBiggestDiscount := RentalSalesHeaderRec.Discount;
        repeat
            if (RentalSalesLineRec.Discount > TheBiggestDiscount)
            then begin
                TheBiggestDiscount := RentalSalesLineRec.Discount
            end;
        until RentalSalesLineRec.Next() = 0;

        ReturnValue := TheBiggestDiscount;
    end;



}
