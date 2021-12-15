page 50104 "RNL Rental Sales Header"
{
    
    Caption = 'Rental Sales Card';
    PageType = Document;
    SourceTable = "RNL Rental Sales Header";
    
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
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                    ApplicationArea = All;
                }
                field("Salesperson No."; Rec."Salesperson No.")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field.';
                    ApplicationArea = All;
                }
            }
              part(SalesLines;"RNL Sales Subform")
            {
                ApplicationArea = All;
                /*add link between the header and lines
                that "No." in header is the same as 
                "Document No." in the lines.*/
                SubPageLink = "Doc. No." = field("Doc. No.");

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(CustomerCard)
            {
                ApplicationArea=all;
                Caption='Customer Card';
                Image=Customer;
                Promoted=true;
                PromotedCategory=Process;
                RunObject=page"Customer Card";
                RunPageLink="No."=field("Customer No.");
                ToolTip='Opens customer card';
            }
        }
    }
    
}
