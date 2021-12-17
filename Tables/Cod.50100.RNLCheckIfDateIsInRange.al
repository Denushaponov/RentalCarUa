codeunit 50100 "RNL Check If Date Is In Range"
{
    TableNo = "RNL Rental Sales Line";
    
    procedure CheckingRange(var ItemNo: Code[20]; var LineNo: Integer; var StartingDate: Date; var EndingDate: Date)
    var
        FilteredOrderLine: Record "RNL Rental Sales Line";
        Count: Integer;
        DateDifference: Integer;
        FromDate: Date;
        ToDate: Date;
        ChangedEndingDate: Date;
        ChangedStartingDate: Date;
        
    begin
        // Беру все рекорд где поле такое же как в ордер лайн
        FilteredOrderLine.SetRange("Item No.", ItemNo);
        // Отсеиваю сам рекорд OrderLine
        FilteredOrderLine.SetFilter("Line No.",'<>%1',LineNo);
        FilteredOrderLine.SetFilter("Rental Starting Date", '<>%1', ChangedEndingDate);
        FilteredOrderLine.SetFilter("Rental Ending Date", '<>%1', ChangedEndingDate);
        if (FilteredOrderLine.FindSet()) then 
    
        repeat
        // Начальный диапаон
        Count := 0;
        FromDate:=FilteredOrderLine."Rental Starting Date";
        ToDate:= FilteredOrderLine."Rental Ending Date";
        DateDifference:=ToDate-FromDate;
        if (StartingDate=0D) then begin exit end;
        if (EndingDate = 0D) then begin exit end;

        // Ecли
            if (StartingDate<=FilteredOrderLine."Rental Starting Date") and (FilteredOrderLine."Rental Ending Date"<=EndingDate)
           then Error('Your wished period is already In Between some other Order period'); 
           if (FilteredOrderLine."Rental Ending Date"+1=StartingDate) or (EndingDate+1=FilteredOrderLine."Rental Starting Date")
           then Error('Includes a day for a service');
        //Если начальная дата в рассматриваемрм рекорде больше чем в изменяемом 
      // Добавлять один день
           repeat 
           if (FromDate=StartingDate) then begin Error('Your starting date is invalid');  end;
           if (FromDate=EndingDate) then begin Error('Your ending date is invalid'); end;
           FromDate:= FromDate+1;
           Count := Count+1;
      // Пока начальная не совпадёт с конечной
         until Count=DateDifference+1;
        until FilteredOrderLine.Next()=0;   
       end; 
  

   
       


    
}
