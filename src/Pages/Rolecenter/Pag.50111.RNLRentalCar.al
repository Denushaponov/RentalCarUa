page 50111 "RNL Rental Car"
{
    Caption = 'Rental Car';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part("RNL Rental Sales Activities"; "RNL Rental Sales Activities")
                {
                    ApplicationArea = all;
                    Visible = true;
                }



            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(DiscountSetup)
            {
                CaptionML = ENU = 'Discount Nos. Setup';
                Image = Setup;
                RunPageMode = View;
                RunObject = page "RNL Discount Setup";
                ApplicationArea = All;


            }
            action("Sales Setup")
            {
                ApplicationArea = All;
                Caption = 'Order Setup';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Sales Setup";
                ToolTip = 'Opens order Nos. setup';
            }

            action("Discount List")
            {
                ApplicationArea = All;
                Caption = 'Discounts list';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount List";
                ToolTip = 'Opens discounts list.';
            }

            action("Orders List")
            {
                ApplicationArea = All;
                Caption = 'Order List';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Orders List";
                ToolTip = 'Opens orders list.';
            }



            action("Posted Orders List")
            {
                ApplicationArea = All;
                Caption = 'Posted Order List';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Posted Rental Sales List";
                ToolTip = 'Opens posted orders list.';
            }

            action(Item)
            {
                ApplicationArea = All;
                Caption = 'Items list';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Item List";
                ToolTip = 'Opens item list.';
            }





        }

        area(Reporting)
        {

            action(Cars)
            {
                ApplicationArea = all;
                RunObject = report "RNL Availible Cars";
                ToolTip = 'Creates all cars report';
                Caption = 'All cars report';
            }
            action(CarProfit)
            {
                ApplicationArea = all;
                RunObject = report "RNL Car Profit";
                ToolTip = 'Profit by car';
                Caption = 'Profit by car';
            }
            action(CustProfit)
            {
                ApplicationArea = all;
                RunObject = report "RNL Customer Profit";
                ToolTip = 'Profit by car';
                Caption = 'Profit by car';
            }
        }
    }
}
