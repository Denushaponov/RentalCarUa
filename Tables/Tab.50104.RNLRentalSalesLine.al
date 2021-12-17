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
            
            trigger OnValidate()
            var 
            Item: Record "Item";
            begin
                if ("Item No." <> xRec."Item No.") then begin 
                  
                    Item.SetRange("No.", "Item No.");
                    Item.FindFirst();
                    "Price Per Day":= Item."RNL Price Per Day";
                    "Discount":=Item."RNL Discount";
                end;
            end;
        }
        field(4; "Car Model"; Text[50])
        {
            Caption = 'Car Model';
            Editable = false;
            // Добавить логику заполнения поля модели
            FieldClass = FlowField;
            CalcFormula=Lookup(Item."RNL Model" WHERE ("No."=FIELD("Item No.")));
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
           begin
              StartingDateIsGreaterError:='Your starting date is greater than ending date';
               CannotSelectPastError:='You have selected day from the past';
              
               if("Rental Starting Date"<>xRec."Rental Starting Date") then begin
                    RentalSalesLine.SetRange("Item No.","Item No.");
                    RentalSalesLine.SetRange("Line No.","Line No.");
                  if( RentalSalesLine.FindFirst()) then begin
                        CheckingDateMgt.CheckingRange("Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");
                  end
                else begin exit; end;
               end;
               
               if ("Rental Starting Date"< CurrentDate) then begin 
               Error(CannotSelectPastError);
               
               end;

                     // Checking if starting date is greater than ending date
                if("Rental Ending Date"<"Rental Starting Date") then begin
                    // Messaging
                    if("Rental Ending Date" <> 0D) then 
                    Error(StartingDateIsGreaterError);
                    // Setting that starting date to normal

                end;

                 // Checking if ending date  Today or less
             // if false
               if ("Rental Ending Date">"Rental Starting Date") then begin end
               // if true
             else begin 
               Error(CannotSelectPastError);
               
             end;
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
             
           begin
               CannotSelectPastError:='You have to select one day at least';
             // Checking if ending date  Today or less
             // if false
               if ("Rental Ending Date">"Rental Starting Date") then begin end
               // if true
             else begin 
               Error(CannotSelectPastError);
              // "Rental Ending Date":=Today()+1;
             end;

             CheckingDateMgt.CheckingRange("Item No.", "Line No.", "Rental Starting Date", "Rental Ending Date");

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
