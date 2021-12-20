pageextension 50100 "RNL Customers List Extention" extends "Customer List"
{

    actions
    {

        addlast(navigation)
        {

            group("RNL Discount")
            {


                action("RNL Discount List")
                {
                    ApplicationArea = All;
                    Caption = 'Discounts';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "RNL Discount List";
                    ToolTip = 'Opens discounts list.';
                }
                action("RNL DiscountSetup")
                {
                    ApplicationArea = All;
                    Caption = 'Discount Nos. Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "RNL Discount Setup";
                    ToolTip = 'Opens discount Nos. setup';
                }
            }


            group("RNL Orders")
            {

                action("RNL Sales Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Order Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "RNL Sales Setup";
                    ToolTip = 'Opens order Nos. setup';
                }

                action("RNL Orders List")
                {
                    ApplicationArea = All;
                    Caption = 'Order List';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "RNL Orders List";
                    ToolTip = 'Opens orders list.';
                }
            }

            group("RNL Posted")
            {
                action("RNL Posted Orders List")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Order List';
                    Image = PostedOrder;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "RNL Posted Rental Sales List";
                    ToolTip = 'Opens posted orders list';
                }
            }

            group("RNL Report")
            {
                action("RNL Report all cars")
                {
                    ApplicationArea = All;
                    Caption = 'Car report';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = report "RNL Availible Cars";
                    ToolTip = 'Creates Car Report';
                }
            }
        }



    }

}
