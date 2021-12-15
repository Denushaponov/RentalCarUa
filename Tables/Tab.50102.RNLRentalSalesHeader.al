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
                   "No. Series" :='';
                end;
            end;
        }
        field(2; "Salesperson No."; Code[20 ])
        {
            Caption = 'Salesperson No.';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(4; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(5; "No. Series"; Code[20])
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
        end;
    end;
    
}
