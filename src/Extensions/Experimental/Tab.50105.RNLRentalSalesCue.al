table 50105 "RNL Rental Sales Cue"
{
    Caption = 'Rental Sales Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Unposted Orders"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("RNL Rental Sales Header");
            Editable = false;
        }
        field(3; "Posted Orders"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("RNL Posted Rental Sales Header");
            Editable = false;
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
