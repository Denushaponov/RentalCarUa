page 50104 "RNL Rental Sales Card"
{

    Caption = 'Rental Sales Card';
    PageType = Card;
    SourceTable = "RNL Rental Sales Header";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate';

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
                    Editable = false;

                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ToolTip = 'Represents name of the customer';
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

                field(Discount; Rec.Discount)
                {
                    ToolTip = 'Specifies the value of Discount field.';
                    ApplicationArea = All;
                    Editable = false;
                }



            }
            part(SalesLines; "RNL Sales Line")
            {
                ApplicationArea = All;
                /*add link between the header and lines
                that "No." in header is the same as 
                "Document No." in the lines.*/
                SubPageLink = "Doc. No." = field("Doc. No.");
                UpdatePropagation = Both;

            }

        }

        area(FactBoxes)
        {
            part(factbox; "RNL Car Factbox")
            {
                ApplicationArea = suite;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("Item No.");
            }
        }
    }



    actions
    {
        area(Navigation)
        {
            action(CustomerCard)
            {
                ApplicationArea = all;
                Caption = 'Customer Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Customer Card";
                RunPageLink = "No." = field("Customer No.");
                ToolTip = 'Opens customer card';
            }

            //// Edit this
            action(PostedOrders)
            {
                ApplicationArea = all;
                Caption = 'Posted Orders';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Posted Rental Sales List";
                ToolTip = 'Opens posted orders';
            }
        }
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document';

                AboutTitle = 'Posting the order';
                AboutText = 'Posting will post the quantities on the order.';

                trigger OnAction()
                var
                    RNLCheckingDates: Codeunit "RNL Check If Date Is In Range";
                    RNLPostRentalSalesOrder: Codeunit "RNL Post Rental Order";
                begin
                    RNLCheckingDates.IsValidDateInDocumentToBePosted(Rec."Doc. No.");
                    RNLPostRentalSalesOrder.PostRentalOrder(Rec);
                end;
            }
        }
    }



}
