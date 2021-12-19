codeunit 50100 "RNL Check If Date Is In Range"
{
    TableNo = "RNL Rental Sales Line";

    procedure CheckingRange(var ItemNo: Code[20]; var LineNo: Integer; var StartingDate: Date; var EndingDate: Date)
    var
        FilteredOrderLine: Record "RNL Rental Sales Line";
        FilteredRecStartingDate: Date;
        FilteredRecordEndingDate: Date;
        ChangedEndingDate: Date;
        ChangedStartingDate: Date;

    begin


        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // Установить фильтр - стартовая дата попадает в диапазон
        FilteredOrderLine.SetFilter("Rental Starting Date", '%1..%2', StartingDate, EndingDate);
        // А также конечная дата попадает в диапазон
        // FilteredOrderLine.SetFilter("Rental Ending Date", '%1..%2', StartingDate, EndingDate);
        // При нахождении такого наброа - ошибка
        if (FilteredOrderLine.FindSet()) then begin Message('Includes period from another line'); end;


        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // А также конечная дата попадает в диапазон
        FilteredOrderLine.SetFilter("Rental Ending Date", '%1..%2', StartingDate, EndingDate);
        // Установить фильтр - стартовая дата попадает в диапазон
        //  FilteredOrderLine.SetFilter("Rental Starting Date", '%1..%2', StartingDate, EndingDate);
        // При нахождении такого наброа - ошибка
        if (FilteredOrderLine.FindSet()) then begin Message('Includes period from another line'); end;


        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли проверяемый диапазон внутри другого диапазона
        FilteredOrderLine.SetFilter("Rental Starting Date", '..%1', StartingDate);
        FilteredOrderLine.SetFilter("Rental Ending Date", '%1..', EndingDate);
        // Если находится такой набро- ошибка
        if (FilteredOrderLine.FindSet()) then begin Message('Period is busy by another line'); end;

        // Сбрасваю фильтр 
        FilteredOrderLine.Reset();
        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.SetRange("Item No.", ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);

        // Если найден такой набор захожу в цикл
        if (FilteredOrderLine.FindSet()) then
            repeat
                // Начальный диапаон

                // Присваиваю даты текущей фильтрованой линии 
                // Начальную 
                FilteredRecStartingDate := FilteredOrderLine."Rental Starting Date";
                // Конечную
                FilteredRecordEndingDate := FilteredOrderLine."Rental Ending Date";

                // Если обе не пустые
                if (FilteredRecordEndingDate <> 0D) or (FilteredRecStartingDate <> 0D) then begin
                    if (FilteredOrderLine."Rental Ending Date" + 1 = StartingDate) or (EndingDate + 1 = FilteredOrderLine."Rental Starting Date") then begin
                        Error('Includes a day for a service %1 or %2 try to change the date and reselect the car', FilteredOrderLine."Rental Ending Date" + 1, FilteredOrderLine."Rental Starting Date" - 1);
                    end;
                    exit
                end;

            until FilteredOrderLine.Next() = 0;
    end;

    local procedure SetFiltersForLines(var ItemNo: Code[20]; var LineNo: Integer) ReturnValue: Record "RNL Rental Sales Line"
    var
        FilteredOrderLine: Record "RNL Rental Sales Line";
    begin
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        ReturnValue := FilteredOrderLine;
    end;







}
