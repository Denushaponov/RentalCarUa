// The codeunit to check if the car is availile at the moment
// To be called from RNL Item tablext
codeunit 50105 "RNL Is Car Availible"
{
    // 1.  Procedure needs to recieve item  No 
    // 2. 

    procedure IsAvailible(var CarNo: Code[20]; var StartingDate: Date; var EndingDate: Date) ReturnValue: Boolean
    var
        PostedLines: Record "RNL Posted Rental Sales Line";
    begin
        ReturnValue := true;



        PostedLines.Reset();

        PostedLines.SetFilter("Item No.", '=%1', CarNo);

        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // Установить фильтр - стартовая дата попадает в диапазон
        PostedLines.SetFilter("Rental Starting Date", '%1..%2', StartingDate, EndingDate + 1);
        // А также конечная дата попадает в диапазон

        // При нахождении такого наброа - false
        if (PostedLines.FindSet()) then
            ReturnValue := false else begin
            ReturnValue := true
        end;

        if ReturnValue = false then exit;


        // Фильтрую по параметрам Айтим но и лан Но
        PostedLines.Reset();
        // PostedFilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        PostedLines.SetFilter("Item No.", '=%1', CarNo);

        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // А также конечная дата попадает в диапазон
        PostedLines.SetFilter("Rental Ending Date", '%1..%2', StartingDate - 1, EndingDate + 1);
        // Установить фильтр - стартовая дата попадает в диапазон

        // При нахождении такого наброа - false
        if (PostedLines.FindSet()) then
            ReturnValue := false else begin
            ReturnValue := true
        end;

        if ReturnValue = false then exit;

        PostedLines.SetFilter("Rental Starting Date", '..%1', Today());
        PostedLines.SetFilter("Rental Ending Date", '%1..', Today() - 1);
        if (PostedLines.FindSet()) then
            ReturnValue := false else begin
            ReturnValue := true
        end;


    end;
}
