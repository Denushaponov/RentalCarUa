codeunit 50102 "RNL Calc Price With Disc"
{
    procedure CalculateFinalCarPrice(var StartingDate: Date; var EndingDate: Date; var DominantDiscount: Decimal; var PricePerDay: Decimal) ReturnValue: Decimal
    var

        Quantity: Decimal;
        DiscountedPricePart: Decimal;
        TotalSumOfOrder: Decimal;

    begin
        if (StartingDate = 0D) or (EndingDate = 0D) or (PricePerDay = 0) or (DominantDiscount = 0) then begin exit end;
        Quantity := EndingDate - StartingDate;
        if Quantity = 0 then exit;
        TotalSumOfOrder := Quantity * PricePerDay;
        DiscountedPricePart := DominantDiscount * (TotalSumOfOrder / 100);
        ReturnValue := TotalSumOfOrder - DiscountedPricePart;
    end;

    procedure FinalPriceCalculationAfterValidation(var ListRecord: Record "RNL Rental Sales Line") ReturnValue: Decimal
    var
        FinalPrice: Decimal;
        CalculateFinalPrice: Codeunit "RNL Calc Price With Disc";
        DateValidationHandler: Codeunit "RNL Date Errors Handler";
    begin
        if (ListRecord."Rental Starting Date" <> 0D) and (ListRecord."Rental Ending Date" <> 0D)
              then begin
            DateValidationHandler.DateValidation(ListRecord);
            FinalPrice := CalculateFinalPrice.CalculateFinalCarPrice(ListRecord."Rental Starting Date", ListRecord."Rental Ending Date", ListRecord."Dominant Discount", ListRecord."Price Per Day");
            ReturnValue := FinalPrice;
        end
        else
            ReturnValue := 0;
    end;
}
