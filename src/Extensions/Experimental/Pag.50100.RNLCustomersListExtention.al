pageextension 50100 "RNL Customers List Extention" extends "Customer List"
{

    actions
    {

        addlast(navigation)
        {
            action("RNL DiscountSetup")
            {
                ApplicationArea = All;
                Caption = 'Discount Nos. Setup';
                Image = Discount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount Setup";
                ToolTip = 'Opens discount Nos. setup';
            }

            action("RNL Discount List")
            {
                ApplicationArea = All;
                Caption = 'Discounts';
                Image = Discount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount List";
                ToolTip = 'Opens discounts list.';
            }
            action("RNL Sales Setup")
            {
                ApplicationArea = All;
                Caption = 'Sales Setup';
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Sales Setup";
                ToolTip = 'Opens discounts list.';
            }

            action("RNL Rental Sales Header")
            {
                ApplicationArea = All;
                Caption = 'Sales Card';
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Rental Sales Card";
                ToolTip = 'Opens sales document.';
            }


            action("RNL Orders List")
            {
                ApplicationArea = All;
                Caption = 'Order List';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Orders List";
                ToolTip = 'Opens orders list.';
            }

        }

    }
}
