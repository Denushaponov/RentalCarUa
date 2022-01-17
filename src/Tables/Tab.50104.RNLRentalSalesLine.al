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
                CalculateFinalPrice: Codeunit "RNL Calc Price With Disc";
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
                    Picture := ItemRec.Picture;

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
                FinalPriceCalculation: Codeunit "RNL Calc Price With Disc";
            begin
                "Final Price" := FinalPriceCalculation.FinalPriceCalculationAfterValidation(Rec);
            end;
        }

        field(150; "Rental Ending Date"; Date)
        {
            Caption = 'Rental ending date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FinalPriceCalculation: Codeunit "RNL Calc Price With Disc";
            begin
                "Final Price" := FinalPriceCalculation.FinalPriceCalculationAfterValidation(Rec);
            end;

        }

        field(155; Picture; MediaSet)
        {
            Caption = 'Picture';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Picture WHERE("No." = FIELD("Item No.")));
        }

        field(156; Availability; Boolean)
        {
            Caption = 'Is availible today';
            DataClassification = CustomerContent;
        }

        field(170; Bill; Decimal)
        {
            Caption = 'Final bill';
            DataClassification = CustomerContent;
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

    trigger OnModify()

    var
        BillCalculate: Codeunit "RNL CalcBill";
    begin
        if ("Final Price" <> xRec."Final Price") then
            Bill := BillCalculate.CalcBill("Doc. No.", "Line No.", "Final Price");
    end;





}
