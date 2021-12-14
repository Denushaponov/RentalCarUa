table 50101 "RNL Discount"
{
    // Rename to Header
    Caption = 'Discount Header';
    DataClassification = CustomerContent;

    DrillDownPageId = "RNL Discount List";
    LookupPageId = "RNL Discount List";
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Code" <> xRec."Code" then begin
                    DiscountSetup.Get();
                   
                    // Does the No. Series can be fill manually?.
                    NoSeriesMgmt.TestManual((DiscountSetup."Discount Nos."));
                    // 
                   "No. Series" :='';
                end;
            end;
        }
        field(2; Type; Enum "RNL Discount Target")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; Percent; Decimal)
        {
            Caption = 'Percent';
            DataClassification = CustomerContent;
            MinValue = 0.01;
            MaxValue = 100;
        }
          field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Code","Type")
        {
            Clustered = true;
        }
    }

    var 
    DiscountSetup: Record "RNL Discount Setup";
    NoSeriesMgmt: Codeunit NoSeriesManagement;
    
    trigger OnInsert()
    
    begin
        if "Code" = '' then begin
            DiscountSetup.Get();
            DiscountSetup.TestField("Discount Nos.");
            // Sends the next number from No series to field No
            NoSeriesMgmt.InitSeries(DiscountSetup."Discount Nos.", xRec."Code", 0D, Rec."Code", Rec."No. Series");
        end;
    end;
    
}
