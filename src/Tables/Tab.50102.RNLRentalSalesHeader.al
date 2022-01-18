table 50102 "RNL Rental Sales Header"
{
    Caption = 'Rental Sales Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Doc. No."; Code[20])
        {
            Caption = 'Doc. No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                // Если Номер документа отличается от номера документа в старой записи тогда
                if "Doc. No." <> xRec."Doc. No." then begin
                    // Берём рекорд из Sales Setup
                    SalesSetup.Get();
                    // Проверяем как добавили этот номер, если он добавлен вручную, а не через сетап то ошибка
                    NoSeriesMgmt.TestManual((SalesSetup."Sales Nos."));
                    // ставим Блэнк
                    "No. Series" := '';
                    "Order Date" := WorkDate();
                end;
            end;
        }
        field(2; "Salesperson No."; Code[20])
        {
            Caption = 'Salesperson No.';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            var
                Customer: Record "Customer";
                TheBiggestDicLookup: Codeunit "RNL Looking For Maximum Disc";
                RentalSalesLine: Record "RNL Rental Sales Line";
                //
                CalcBill: Codeunit "RNL Calculating Bill";
            begin
                if ("Customer No." <> xRec."Customer No.") then begin

                    Customer.SetRange("No.", "Customer No.");
                    Customer.FindFirst();
                    Discount := Customer."RNL Discount";
                end;
                "Bill Amount Flowfield" := CalcBill.CalculateField("Doc. No.");




            end;
        }



        field(4; Name; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name where("No." = field("Customer No.")));

        }

        field(5; Discount; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            TableRelation = "RNL Discount".Percent where(Type = const(Customer));
        }

        field(50; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
            Editable = false;

        }

        field(75; "Bill Amount Flowfield"; Decimal)
        {
            Caption = 'Bill Amount';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = sum("RNL Rental Sales Line"."Final Price" where("Doc. No." = field("Doc. No.")));

        }




        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Doc. No.")
        {
            Clustered = true;
        }
    }

    var
        SalesSetup: Record "RNL Sales Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;

    // При добавлении
    trigger OnInsert()

    begin
        // Если Док номер пустой
        if "Doc. No." = '' then begin
            // Берём запись из Sales Setup
            SalesSetup.Get();
            // Проверяем поле
            SalesSetup.TestField("Sales Nos.");
            // Sends the next number from No series to field No
            NoSeriesMgmt.InitSeries(SalesSetup."Sales Nos.", xRec."Doc. No.", 0D, Rec."Doc. No.", Rec."No. Series");
            "Order Date" := Today();
        end;
    end;



}
