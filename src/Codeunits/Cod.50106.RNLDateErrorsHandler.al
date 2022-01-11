codeunit 50106 "RNL Date Errors Handler"
{



    procedure DateValidation(var ListRecord: Record "RNL Rental Sales Line")
    var
        CannotSelectPastError: Label 'You selected day from the past';
        StartingDateIsGreaterError: label 'Your starting date is greater than ending date';
        SouldBeOneDayError: label 'It should be a day at least';
        RentalSalesLine: Record "RNL Rental Sales Line";
        CheckingDateMgt: Codeunit "RNL Check If Date Is In Range";

    begin
        // Если старт и конечная дата не пустые

        // Стартовая дата меньше текущей
        if (ListRecord."Rental Starting Date" < Today()) then begin
            Error(CannotSelectPastError)
        end;
        if (ListRecord."Rental Ending Date" < Today()) then begin
            Error(CannotSelectPastError)
        end;
        // Стартовая дата больше конечной
        if (ListRecord."Rental Ending Date" < ListRecord."Rental Starting Date") then begin
            Error(StartingDateIsGreaterError);
        end;
        // Стартовая дата = конечной
        if (ListRecord."Rental Ending Date" = ListRecord."Rental Starting Date") and (ListRecord."Rental Ending Date" <> 0D) then begin
            Error(SouldBeOneDayError);
        end;


        CheckingDateMgt.CheckingRange(ListRecord."Doc. No.", ListRecord."Item No.", ListRecord."Line No.", ListRecord."Rental Starting Date", ListRecord."Rental Ending Date");


        // CheckingDateMgt.CheckingRange("Doc. No.", "Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date";




    end;
}
