tableextension 50101 "RNL Rental Customer" extends Customer
{
    fields
    {
        field(50101; "RNL Discount"; Decimal)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
            TableRelation = "RNL Discount".Percent where(Type = filter(Customer));
            ValidateTableRelation = false;

        }

    }
}
