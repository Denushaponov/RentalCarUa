page 50107 "RNL Orders List"
{

    ApplicationArea = All;
    Caption = 'Orders List';
    PageType = List;
    SourceTable = "RNL Rental Sales Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "RNL Rental Sales";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Doc. No."; Rec."Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Doc. No. field.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ToolTip = 'Specifies the value of the Bill Amount field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
