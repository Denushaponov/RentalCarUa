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
            TableRelation = "RNL Posted Rental Sales Header"."Doc. No.";
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
        }

        field(4; "Car Model"; Text[50])
        {
            Caption = 'Car Model';
            DataClassification = CustomerContent;
        }


        field(15; Color; Enum "RNL Car Colors")
        {
            Caption = 'Car Color';
            DataClassification = CustomerContent;
        }
        field(20; Mileage; Integer)
        {
            Caption = 'Car Mileage';
        }


        field(100; "Rental Starting Date"; Date)
        {
            Caption = 'The Date when renting starts';
            DataClassification = CustomerContent;
        }

        field(150; "Rental Ending Date"; Date)
        {
            Caption = 'The Date when renting ends';
            DataClassification = CustomerContent;
        }

        field(160; "Final Price"; Decimal)
        {
            Caption = 'Price including car discount';
            Editable = false;
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


}
