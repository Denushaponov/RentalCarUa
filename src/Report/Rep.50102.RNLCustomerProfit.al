report 50102 "RNL Customer Profit"
{
    Caption = 'Customer Profit';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'src\Layout\CustomerProfit.docx';
    RDLCLayout = 'src\Layout\CustomerProfit.rdlc';
    DefaultLayout = rdlc;
    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No; "No.")
            {
                IncludeCaption = true;
            }

            column(Name; Name)
            {
                IncludeCaption = true;
            }

            column(ProfitTotalByCustomer; ProfitTotalByCustomer)
            {

            }

            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {

            }

            column(NameCaption; NameCaptionLbl)
            {

            }

            column(ProfitTotalByCustomerCaption; ProfitTotalByCustomerLbl)
            {

            }
            dataitem("RNL Posted Rental Sales Header"; "RNL Posted Rental Sales Header")
            {

                DataItemLink = "Customer No." = field("No.");
                column(Doc__No_; "Doc. No.")
                {
                    IncludeCaption = true;
                }
                column(Bill_Amount_Flowfield; "Bill Amount Flowfield")
                {
                    IncludeCaption = true;
                }
            }



            trigger OnAfterGetRecord()
            var
                PostedOrders: Record "RNL Posted Rental Sales Header";
                CustomerNo: Code[20];
                AmountBill: Decimal;
            begin
                CustomerNo := "No.";
                PostedOrders.SetFilter("Customer No.", CustomerNo);
                ProfitTotalByCustomer := 0;
                if (PostedOrders.FindSet())
                then begin
                    repeat
                        PostedOrders.CalcFields("Bill Amount Flowfield");
                        AmountBill := PostedOrders."Bill Amount Flowfield";
                        ProfitTotalByCustomer += AmountBill;
                    until PostedOrders.Next() = 0;
                    ProfitGeneralTotal += ProfitTotalByCustomer;
                end;
            end;


        }
        dataitem(Total; Integer)
        {

            DataItemTableView = where(number = const(1));
            column(ProfitGeneralTotal; ProfitGeneralTotal)
            {

            }

            trigger OnPreDataItem()
            begin
                if Customer.IsEmpty() then
                    CurrReport.Break();
            end;
        }
    }




    var

        ProfitGeneralTotal: Decimal;
        ProfitTotalByCustomer: Decimal;

        CustomerNoCaptionLbl: Label 'Customer No.';
        DocumentNoCaptionLbl: Label 'Document No.';
        AmountCaptionLbl: Label 'Amount';
        ProfitTotalByCustomerLbl: Label 'Profit Total By Customer';
        ProfitGeneralTotalLbl: Label 'Profit General Total';
        ReportCaptionLbl: Label 'Customer profit';
        NameCaptionLbl: Label 'Customer name';


}
