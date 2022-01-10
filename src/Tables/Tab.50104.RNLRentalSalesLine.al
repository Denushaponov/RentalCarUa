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
                ItemRec: Record "Item";
                LookingForTheGreatestDisc: Codeunit "RNL Looking For Maximum Disc";
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
                CheckingDateMgt: Codeunit "RNL Check If Date Is In Range";
                //
                BillCalcMgt: Codeunit "RNL Calculating Bill";
            begin
                if ("Item No." <> xRec."Item No.") then begin
                    ItemRec.SetRange("No.", "Item No.");
                    ItemRec.FindFirst();
                    CalcFields("Car Model");
                    "Rental Ending Date" := 0D;
                    "Rental Starting Date" := 0D;
                    //"Final Price" := 0;
                    "Price Per Day" := ItemRec."RNL Price Per Day";
                    "Discount" := ItemRec."RNL Discount";

                    // CheckingDateMgt.CheckingRange("Doc. No.", rec."Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                    "Dominant Discount" := LookingForTheGreatestDisc.GetMaximumDiscountLine("Doc. No.", "Line No.", Discount);
                    //  "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");
                    //  BillCalcMgt.Calculate("Doc. No.", "Line No.", "Final Price");
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


        field(15; Color; Enum "RNL Car Colors")
        {
            Caption = 'Car Color';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."RNL Color" WHERE("No." = FIELD("Item No.")));
        }
        field(20; Mileage; Integer)
        {
            Caption = 'Car Mileage';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."RNL Mileage" WHERE("No." = FIELD("Item No.")));
        }

        field(25; "Price Per Day"; Decimal)
        {
            Caption = 'Specifies Price Per Day field';
            Editable = false;
            DataClassification = CustomerContent;
            // FieldClass =FlowField;
            // CalcFormula=lookup(Item."RNL Price Per Day" where ("No."=field("Item No.")));

        }

        field(50; Discount; Decimal)
        {
            Caption = 'Specifies selected car discount';
            Editable = false;
            DataClassification = CustomerContent;

        }

        field(60; "Dominant Discount"; Decimal)
        {
            Caption = 'Specifies dominant discount field';
            Editable = false;
            DataClassification = CustomerContent;
        }



        field(75; "Final Price"; Decimal)
        {
            Caption = 'Specifies final price';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(100; "Rental Starting Date"; Date)
        {

            Caption = 'Specifies Rental Starting Date field';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CurrentDate: Date;
                CannotSelectPastError: Label 'You have selected day from the past';
                StartingDateIsGreaterError: label 'Your starting date is greater than ending date';
                SouldBeOneDayError: label 'It should be a day at least';
                RentalSalesLine: Record "RNL Rental Sales Line";
                CheckingDateMgt: Codeunit "RNL Check If Date Is In Range";
                BlankDate: Date;
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
            begin

                // Если старт и конечная дата не пустые
                if (rec."Rental Starting Date" <> 0D) and (rec."Rental Ending Date" <> 0D)

                then begin

                    // Стартовая дата меньше текущей
                    if ("Rental Starting Date" < Today()) then begin
                        Error(CannotSelectPastError)
                    end;
                    // Стартовая дата больше конечной
                    if ("Rental Ending Date" < "Rental Starting Date") then begin
                        TestField("Rental Ending Date");
                        Error(StartingDateIsGreaterError);
                    end;
                    // Стартовая дата = конечной
                    if ("Rental Ending Date" = "Rental Starting Date") then begin

                        Error(SouldBeOneDayError);
                    end;


                    CheckingDateMgt.CheckingRange("Doc. No.", "Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                    "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");

                end;


            end;
        }

        field(150; "Rental Ending Date"; Date)
        {
            Caption = 'Rental ending date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CurrentDate: Date;
                CannotSelectPastError: Label 'You have to select one day at least';
                CheckingdateMgt: Codeunit "RNL Check If Date Is In Range";
                CalculateFinalPrice: Codeunit "RNL CalculatingPriceWithDisc";
                StartingDateIsGreaterError: Label 'Your starting date is greater than ending date';
                SouldBeOneDayError: label 'It should be a day at least';
            begin
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
                        Error(SouldBeOneDayError);
                    end;

                    CheckingDateMgt.CheckingRange("Doc. No.", "Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                    "Final Price" := CalculateFinalPrice.CalculateFinalCarPrice("Rental Starting Date", "Rental Ending Date", "Dominant Discount", "Price Per Day");
                end;
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
