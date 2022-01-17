table 50107 "RNL Posted Rental Sales Line"
{
    Caption = 'Posted Rental Sales Line';
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
            // TableRelation = Item where(Type = filter(Car));


        }
        field(4; "Car Model"; Text[50])
        {
            Caption = 'Car Model';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            //  CalcFormula = Lookup(Item."RNL Model" WHERE("No." = FIELD("Item No.")));
        }


        field(15; Color; Enum "RNL Car Colors")
        {
            Caption = 'Car Color';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            //  CalcFormula = Lookup(Item."RNL Color" WHERE("No." = FIELD("Item No.")));
        }
        field(20; Mileage; Integer)
        {
            Caption = 'Car Mileage';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            //  CalcFormula = Lookup(Item."RNL Mileage" WHERE("No." = FIELD("Item No.")));
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

        }

        field(150; "Rental Ending Date"; Date)
        {
            Caption = 'Rental ending date';
            DataClassification = CustomerContent;


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


}
