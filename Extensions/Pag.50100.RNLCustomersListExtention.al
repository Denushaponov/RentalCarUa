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

           action("RNL DiscountList")
        {
            ApplicationArea = All;
            Caption = 'Discounts';
            Image = Discount;
            Promoted = true;
            PromotedCategory = Process;
            RunObject = page "RNL Discount List";
            ToolTip = 'Opens discounts list.';
        }
    }

  }  
}
