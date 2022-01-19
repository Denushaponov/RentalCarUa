pageextension 50104 "RNL RentalCarMenu" extends "Business Manager Role Center"
{
    actions
    {

        addlast(embedding)
        {




            action("RNL Discount List")
            {
                ApplicationArea = All;
                Caption = 'Discounts';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount List";
                ToolTip = 'Opens discounts list.';
            }
            action("RNL DiscountSetup")
            {
                ApplicationArea = All;
                Caption = 'Discount Nos. Setup';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount Setup";
                ToolTip = 'Opens discount Nos. setup';
            }





            action("RNL Sales Setup")
            {
                ApplicationArea = All;
                Caption = 'Order Setup';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Sales Setup";
                ToolTip = 'Opens order Nos. setup';
            }

            action("RNL Orders List")
            {
                ApplicationArea = All;
                Caption = 'Order List';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Orders List";
                ToolTip = 'Opens orders list.';
            }





            action("RNL Posted Orders List")
            {
                ApplicationArea = All;
                Caption = 'Posted Order List';

                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Posted Rental Sales List";
                ToolTip = 'Opens posted orders list.';
            }





        }

    }
}
