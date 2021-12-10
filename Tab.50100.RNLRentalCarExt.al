tableextension 50100 "RNL Rental Car Ext" extends Item
{
    fields
    {
        field(50100; "RNL Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
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
        }
       
    }
}
