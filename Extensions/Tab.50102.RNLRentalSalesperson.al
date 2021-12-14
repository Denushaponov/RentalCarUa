tableextension 50102 "RNL Rental Salesperson" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "RNL Location"; Text[50])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
        }
    }
}
