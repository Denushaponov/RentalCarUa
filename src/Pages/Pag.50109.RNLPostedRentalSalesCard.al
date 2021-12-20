page 50109 "RNL Posted Rental Sales Card"
{

    Caption = 'RNL Posted Rental Sales Card';
    PageType = Card;
    SourceTable = "RNL Posted Rental Sales Header";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Salesperson No."; Rec."Salesperson No.")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field.';
                    ApplicationArea = All;
                }
            }

            part(Lines; "RNL Posted Rental Sales Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Doc. No." = field("Doc. No.");
                Editable = false;
            }
            group("Total amount")
            {
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ToolTip = 'Specifies the value of the Bill Amount field.';
                    ApplicationArea = All;
                }
            }



        }


    }


}
