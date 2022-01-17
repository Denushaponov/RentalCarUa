report 50100 "RNL Availible Cars"
{
    ApplicationArea = Basic;
    Caption = 'Availible Cars';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'src\Layout\AvailibleCars.docx';
    RDLCLayout = 'src\Layout\AvailibleCars.rdlc';
    DefaultLayout = word;


    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "Type";
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(Type; "Type")
            {
                IncludeCaption = true;
            }
            column(RNLColor; "RNL Color")
            {
                IncludeCaption = true;
            }
            column(RNLDiscount; "RNL Discount")
            {
                IncludeCaption = true;
            }
            column(RNLMileage; "RNL Mileage")
            {
                IncludeCaption = true;
            }
            column(RNLModel; "RNL Model")
            {
                IncludeCaption = true;
            }
            column(RNLPricePerDay; "RNL Price Per Day")
            {
                IncludeCaption = true;
            }
        }
    }



}

