codeunit 50100 "RNL Check If Date Is In Range"
{
    TableNo = "RNL Rental Sales Line";

    procedure CheckingRange(var DocNo: Code[20]; var ItemNo: Code[20]; var LineNo: Integer; var StartingDate: Date; var EndingDate: Date)
    begin

        CheckingLinesMaybePeriodIsInvalid(DocNo, ItemNo, LineNo, StartingDate, EndingDate);
        CheckingPostedLinesMaybePeriodIsInvalid(DocNo, ItemNo, LineNo, StartingDate, EndingDate);
    end;


    local procedure CheckingLinesMaybePeriodIsInvalid(var DocNo: Code[20]; var ItemNo: Code[20]; var LineNo: Integer; var StartingDate: Date; var EndingDate: Date)
    var
        FilteredOrderLine: Record "RNL Rental Sales Line";
        FilteredRecStartingDate: Date;
        FilteredRecordEndingDate: Date;
        ChangedEndingDate: Date;
        ChangedStartingDate: Date;
        PeriodIsBusyErr: Label 'Period Is Busy by another line in current document';
        IncludesDayForCarServiceErr: Label 'LABEL Includes a day for a service %1 or %2 try to change the date and reselect the car', Comment = '%1 = Date, %2=Date';

    begin
        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // Установить фильтр - стартовая дата попадает в диапазон
        FilteredOrderLine.SetFilter("Rental Starting Date", '%1..%2', StartingDate, EndingDate);
        // А также конечная дата попадает в диапазон

        // При нахождении такого наброа - ошибка
        if (FilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;


        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // А также конечная дата попадает в диапазон
        FilteredOrderLine.SetFilter("Rental Ending Date", '%1..%2', StartingDate, EndingDate);
        // Установить фильтр - стартовая дата попадает в диапазон

        // При нахождении такого наброа - ошибка
        if (FilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;


        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.Reset();
        FilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        FilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        FilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли проверяемый диапазон внутри другого диапазона
        FilteredOrderLine.SetFilter("Rental Starting Date", '..%1', StartingDate);
        FilteredOrderLine.SetFilter("Rental Ending Date", '%1..', EndingDate);
        // Если находится такой набро- ошибка
        if (FilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;

        // Сбрасваю фильтр 
        FilteredOrderLine.Reset();
        // Фильтрую по параметрам Айтим но и лан Но
        FilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        FilteredOrderLine.SetFilter("Item No.", ItemNo);
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
                        Error(IncludesDayForCarServiceErr, FilteredOrderLine."Rental Ending Date" + 1, FilteredOrderLine."Rental Starting Date" - 1);
                    end;
                    exit
                end;

            until FilteredOrderLine.Next() = 0;
    end;

    local procedure CheckingPostedLinesMaybePeriodIsInvalid(var DocNo: Code[20]; var ItemNo: Code[20]; var LineNo: Integer; var StartingDate: Date; var EndingDate: Date)
    var
        PostedFilteredOrderLine: Record "RNL Posted Rental Sales Line";
        FilteredRecStartingDate: Date;
        FilteredRecordEndingDate: Date;
        ChangedEndingDate: Date;
        ChangedStartingDate: Date;
        PeriodIsBusyErr: Label 'Period Is Busy by another line in posted document', Comment = '%1 = Code[20]';
        IncludesDayForCarServiceErr: Label 'Includes a day for a service %1 or %2, from posted lines, try to change the date and reselect the car', Comment = '%1 = Date, %2=Date';

    begin
        // Поиск по запощеным линиям
        // Фильтрую по параметрам Айтим но и лан Но
        PostedFilteredOrderLine.Reset();

        PostedFilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        PostedFilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // Установить фильтр - стартовая дата попадает в диапазон
        PostedFilteredOrderLine.SetFilter("Rental Starting Date", '%1..%2', StartingDate, EndingDate);
        // А также конечная дата попадает в диапазон

        // При нахождении такого наброа - ошибка
        if (PostedFilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;


        // Фильтрую по параметрам Айтим но и лан Но
        PostedFilteredOrderLine.Reset();
        // PostedFilteredOrderLine.SetFilter("Doc. No.", '=%1', DocNo);
        PostedFilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        PostedFilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли внутри проверяемого диапазона какой либо диапаззон
        // А также конечная дата попадает в диапазон
        PostedFilteredOrderLine.SetFilter("Rental Ending Date", '%1..%2', StartingDate, EndingDate);
        // Установить фильтр - стартовая дата попадает в диапазон

        // При нахождении такого наброа - ошибка
        if (PostedFilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;


        // Фильтрую по параметрам Айтим но и лан Но
        PostedFilteredOrderLine.Reset();

        PostedFilteredOrderLine.SetFilter("Item No.", '=%1', ItemNo);
        PostedFilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);
        // Проверяю находится ли проверяемый диапазон внутри другого диапазона
        PostedFilteredOrderLine.SetFilter("Rental Starting Date", '..%1', StartingDate);
        PostedFilteredOrderLine.SetFilter("Rental Ending Date", '%1..', EndingDate);
        // Если находится такой набро- ошибка
        if (PostedFilteredOrderLine.FindSet()) then begin Error(PeriodIsBusyErr); end;

        // Сбрасваю фильтр 
        PostedFilteredOrderLine.Reset();
        // Фильтрую по параметрам Айтим но и лан Но

        PostedFilteredOrderLine.SetRange("Item No.", ItemNo);
        PostedFilteredOrderLine.SetFilter("Line No.", '<>%1', LineNo);

        // Если найден такой набор захожу в цикл
        if (PostedFilteredOrderLine.FindSet()) then
            repeat
                // Начальный диапаон

                // Присваиваю даты текущей фильтрованой линии 
                // Начальную 
                FilteredRecStartingDate := PostedFilteredOrderLine."Rental Starting Date";
                // Конечную
                FilteredRecordEndingDate := PostedFilteredOrderLine."Rental Ending Date";

                // Если обе не пустые
                if (FilteredRecordEndingDate <> 0D) or (FilteredRecStartingDate <> 0D) then begin
                    if (PostedFilteredOrderLine."Rental Ending Date" + 1 = StartingDate) or (EndingDate + 1 = PostedFilteredOrderLine."Rental Starting Date") then begin
                        Error(IncludesDayForCarServiceErr, PostedFilteredOrderLine."Rental Ending Date" + 1, PostedFilteredOrderLine."Rental Starting Date" - 1);
                    end;
                    exit
                end;

            until PostedFilteredOrderLine.Next() = 0;
    end;


}
