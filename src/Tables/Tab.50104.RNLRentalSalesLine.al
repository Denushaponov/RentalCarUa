table 50104 "RNL Rental Sales Line"
{
    Caption = 'Rental Sales Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Doc. No."; Code[20])
        {
            Caption = 'Doc. No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item where(Type = filter(Car));

            trigger OnValidate()
            var
                Item: Record "Item";
                LookingForTheGreatestDisc: Codeunit "RNL Looking For Maximum Disc";
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
                CheckingDateMgt: Codeunit "RNL Check If Date Is In Range";
                //
                BillCalcMgt: Codeunit "RNL Calculating Bill";
            begin
                if ("Item No." <> xRec."Item No.") then begin
                    CalcFields("Car Model");
                    Item.SetRange("No.", "Item No.");
                    Item.FindFirst();
                    "Price Per Day" := Item."RNL Price Per Day";
                    "Discount" := Item."RNL Discount";
                    CheckingDateMgt.CheckingRange(rec."Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                    "Dominant Discount" := LookingForTheGreatestDisc.GetMaximumDiscountLine("Doc. No.", "Line No.", Discount);
                    "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");
                    BillCalcMgt.Calculate("Doc. No.", "Line No.", "Final Price");

                end;
            end;
        }
        field(4; "Car Model"; Text[50])
        {
            Caption = 'Car Model';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."RNL Model" WHERE("No." = FIELD("Item No.")));
        }

        field(5; "Price Per Day"; Decimal)
        {
            Caption = 'Represent price of the car for one rental day';
            Editable = false;
            DataClassification = CustomerContent;
            // FieldClass =FlowField;
            // CalcFormula=lookup(Item."RNL Price Per Day" where ("No."=field("Item No.")));

        }

        field(50; Discount; Decimal)
        {
            Caption = 'Represents selected car discount ';
            Editable = false;
            DataClassification = CustomerContent;

        }

        field(60; "Dominant Discount"; Decimal)
        {
            Caption = 'Represents the maximum discount';
            Editable = false;
            DataClassification = CustomerContent;
        }



        field(75; "Final Price"; Decimal)
        {
            Caption = 'Price including car discount';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(100; "Rental Starting Date"; Date)
        {
            Caption = 'The Date when renting starts';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CurrentDate: Date;
                CannotSelectPastError: Text;
                StartingDateIsGreaterError: Text;
                RentalSalesLine: Record "RNL Rental Sales Line";
                CheckingDateMgt: Codeunit "RNL Check If Date Is In Range";
                BlankDate: Date;
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
            begin
                StartingDateIsGreaterError := 'Your starting date is greater than ending date';
                CannotSelectPastError := 'You have selected day from the past';

                if ("Rental Starting Date" <> xRec."Rental Starting Date") then begin
                    RentalSalesLine.SetRange("Item No.", "Item No.");
                    RentalSalesLine.SetRange("Line No.", "Line No.");
                    if (RentalSalesLine.FindFirst()) then begin
                        CheckingDateMgt.CheckingRange("Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                    end
                    else begin
                        exit;
                    end;
                end;

                // Если старт и конечная дата не пустые
                if (rec."Rental Starting Date" <> 0D) and (rec."Rental Ending Date" <> 0D)
                then begin

                    // Стартовая дата меньше текущей
                    if ("Rental Starting Date" < CurrentDate) then begin
                        Error(CannotSelectPastError)
                    end;
                    // Стартовая дата больше конечной
                    if ("Rental Ending Date" < "Rental Starting Date") then begin
                        Error(StartingDateIsGreaterError);
                    end;
                    // Стартовая дата = конечной
                    if ("Rental Ending Date" = "Rental Starting Date") then begin
                        Error('It should be a day at least');
                    end;



                end;

                "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");

            end;
        }

        field(150; "Rental Ending Date"; Date)
        {
            Caption = 'The Date when renting ends';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CurrentDate: Date;
                CannotSelectPastError: Text;
                CheckingdateMgt: Codeunit "RNL Check If Date Is In Range";
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
                StartingDateIsGreaterError: Text;
            begin

                StartingDateIsGreaterError := 'Your starting date is greater than ending date';
                CannotSelectPastError := 'You have to select one day at least';

                // Если старт и конечная дата не пустые
                if (rec."Rental Starting Date" <> 0D) and (rec."Rental Ending Date" <> 0D)
                then begin

                    // Стартовая дата меньше текущей
                    if ("Rental Starting Date" < CurrentDate) then begin
                        Error(CannotSelectPastError)
                    end;
                    // Старотовая дата больше конечной
                    if ("Rental Ending Date" < "Rental Starting Date") then begin
                        Error(StartingDateIsGreaterError);
                    end;
                    // Стартовая дата = конечной
                    if ("Rental Ending Date" = "Rental Starting Date") then begin
                        Error('It should be a day at least');
                    end;

                end;


                CheckingDateMgt.CheckingRange("Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");
            end;
        }

    }
    keys
    {
        key(PK; "Doc. No.", "Line No.")
        {
            Clustered = true;
        }
    }




    trigger OnInsert()
    var
        recSalesLine: Record "RNL Rental Sales Line";
    begin
        // Очистить
        Clear(recSalesLine);
        // Если если нашли последний
        IF recSalesLine.FindLast() then
            // То присваимваем инкрементированый номер
            "Line No." := recSalesLine."Line No." + 10
        else
            "Line No." := 10;
    end;





}
