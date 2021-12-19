codeunit 50102 "RNL CalculatingPriceWithDisc"
{
    procedure CalculateFinalCarPrice(var StartingDate: Date; var EndingDate: Date; var DominantDiscount: Decimal; var PricePerDay: Decimal) ReturnValue: Decimal
    var

        Quantity: Integer;
        DiscountedPricePart: Integer;
        TotalSumOfOrder: Decimal;

    begin
        if (StartingDate = 0D) or (EndingDate = 0D) or (PricePerDay = 0) or (DominantDiscount = 0) then begin exit end;
        Quantity := EndingDate - StartingDate;
        if Quantity = 0 then exit;
        TotalSumOfOrder := Quantity * PricePerDay;
        //DiscountedPricePart := DominantDiscount * TotalSumOfOrder / 100;
        ReturnValue := TotalSumOfOrder - DiscountedPricePart;
    end;
}
