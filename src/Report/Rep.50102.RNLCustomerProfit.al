report 50102 "RNL Customer Profit"
{
    Caption = 'Customer Profit';
    ApplicationArea = basic;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'src\Layout\CustomerProfit.docx';
    DefaultLayout = word;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
                IncludeCaption = true;
            }

            dataitem("RNL Posted Rental Sales Header"; "RNL Posted Rental Sales Header")
            {

                column(Doc__No_; "Doc. No.")
                {
                    IncludeCaption = true;
                }
                column(Bill_Amount_Flowfield; "Bill Amount Flowfield")
                {
                    IncludeCaption = true;
                }



                trigger OnAfterGetRecord()
                var
                    PostedOrders: Record "RNL Posted Rental Sales Header";
                begin
                    PostedOrders.CopyFilters("RNL Posted Rental Sales Header");
                    PostedOrders.SetRange("Customer No.", Customer."No.");
                    PostedOrders.CalcSums("Bill Amount Flowfield");
                    ProfitTotalByCustomer := PostedOrders."Bill Amount Flowfield";
                end;




            }





        }




    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var

        ProfitGeneralTotal: Decimal;
        ProfitTotalByCustomer: Decimal;

}
