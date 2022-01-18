page 50110 "RNL Posted Rental Sales List"
{

    ApplicationArea = All;
    Caption = 'Posted Rental Sales';
    PageType = List;
    SourceTable = "RNL Posted Rental Sales Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "RNL Posted Rental Sales Card";


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
                field(Discount; Rec.Discount)
                {
                    ToolTip = 'Specifies the value of the Customer Discount field.';
                    ApplicationArea = All;
                }
                field("Salesperson No."; Rec."Salesperson No.")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field.';
                    ApplicationArea = All;
                }

                field("Bill Amount"; Rec."Bill Amount Flowfield")
                {
                    ToolTip = 'Specifies the value of the Bill Amount field.';
                    ApplicationArea = All;
                }

            }
        }
    }

}
