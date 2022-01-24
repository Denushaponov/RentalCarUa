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
            DataItemTableView = sorting(Type) where(Type = filter(Car));

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
            column(Description; "Description")
            {
                IncludeCaption = true;
            }
            column(RNLPricePerDay; "RNL Price Per Day")
            {
                IncludeCaption = true;
            }



            trigger OnAfterGetRecord()
            var
                CheckToSkip: Codeunit "CheckDatesInReport";
            begin
                if (CheckToSkip.CheckingPostedLinesMaybePeriodIsInvalid("No.", UserStartingDate, UserEndingDate))
                then begin
                    CurrReport.Skip();
                end;
            end;
        }


    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(UserStartingDate; UserStartingDate)
                    {
                        ApplicationArea = all;
                        Caption = 'User Starting Date';
                        ToolTip = 'Specifies User Starting Date';

                    }
                    field(UserEndingDate; UserEndingDate)
                    {
                        ApplicationArea = all;
                        Caption = 'User Ending Date';
                        ToolTip = 'Specifies User Ending Date';
                    }

                }
            }
        }
    }


    var
        UserStartingDate: Date;
        UserEndingDate: Date;
        MyInt: Decimal;


}

