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
            TableRelation = Item;
           // Как заполнить поле модели в зависимости от выбора здесь 
           trigger OnValidate()
           var
               Item: Record Item;
           begin
               if "Item No." <> '' then begin  
                   Rec.Validate("Car Model", Item."RNL Model");
                  
               end
           end;
        }
        field(4; "Car Model"; Text[50])
        {
            Caption = 'Car Model';
            DataClassification = CustomerContent;
            // Добавить логику заполнения поля модели
            Editable=false;
           
        

        }
       
    }
    keys
    {
        key(PK; "Doc. No.", "Line No.")
        {
            Clustered = true;
        }
    }

     var
        //myInt: Integer;

    trigger OnInsert()
    var
        recSalesLine: Record "RNL Rental Sales Line";
    begin
        Clear(recSalesLine);
        IF recSalesLine.FindLast() then
            "Line No." := recSalesLine."Line No." + 1
        else
            "Line No." := 1;
    end;

   
    
}
