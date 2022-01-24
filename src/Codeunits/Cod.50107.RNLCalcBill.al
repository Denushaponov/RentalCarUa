codeunit 50107 "RNL CalcBill"
{
    procedure CalcBill(var DocNo: Code[20]; var LineNo: Integer; var RecentPrice: Decimal) ReturnValue: Decimal
    var
        Lines: Record "RNL Rental Sales Line";
        Result: Decimal;
    begin
        Result := 0;
        Lines.SetFilter("Doc. No.", DocNo);
        Lines.SetFilter("Line No.", '<>%1', LineNo);
        if (Lines.FindSet()) then
            repeat
                Result += Lines."Final Price";
            until Lines.Next() = 0;
        ReturnValue := Result + RecentPrice;
    end;
}
