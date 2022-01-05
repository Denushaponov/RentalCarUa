page 50102 "RNL Discount List"
{

    ApplicationArea = All;
    Caption = 'Discounts';
    PageType = List;
    SourceTable = "RNL Discount";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "RNL Discount Card";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(Percent; Rec.Percent)
                {
                    ToolTip = 'Specifies the value of the Percent field.';
                    ApplicationArea = All;
                }
            }

        }

    }



    actions
    {
        area(Navigation)
        {
            action(DiscountCard)
            {
                ApplicationArea = All;
                Caption = 'Discount Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "RNL Discount Card";
                RunPageLink = "Code" = field("Code");
                ToolTip = 'Opens discount card.';
            }
        }
    }

}
