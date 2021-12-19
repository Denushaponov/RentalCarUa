tableextension 50100 "RNL Item" extends Item
{
    Caption = 'Rental Car Extension';
    fields
    {

        field(50101; "RNL Model"; Code[20])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(50102; "RNL Color"; Enum "RNL Car Colors")
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
        }
        field(50103; "RNL Millage"; Integer)
        {
            Caption = 'Millage';
            DataClassification = CustomerContent;
        }
        field(50104; "RNL Price Per Day"; Decimal)
        {
            Caption = 'Price Per Day';
            DataClassification = CustomerContent;
        }
        field(50105; "RNL Discount"; Decimal)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
            TableRelation = "RNL Discount".Percent where(Type = filter(Car));
            ValidateTableRelation = false;
        }

    }
}
