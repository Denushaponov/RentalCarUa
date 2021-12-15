table 50103 "RNL Sales Setup"
{
    Caption = 'RNL Sales Setup';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Sales Nos."; Code[20])
        {
            Caption = 'Sales Nos.';
            DataClassification = CustomerContent;
            TableRelation="No. Series";
            
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    
}
