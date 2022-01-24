report 50101 "RNL Car Profit"
{
    ApplicationArea = Basic;
    Caption = 'Car Profit';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'src\Layout\CarProfit.docx';
    DefaultLayout = word;
    dataset
    {
        dataitem(Item; "Item")
        {
            DataItemTableView = sorting("No.") where(Type = const(Car));


            column(No; "No.")
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

            column(TimesInOrder; TimesInOrder)
            {

            }
            column(ProfitByCar; ProfitByCar)
            {

            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                Item.SetFilter("No.", ItemNo);

            end;


            trigger OnAfterGetRecord()
            var
                PostedLines: Record "RNL Posted Rental Sales Line";
            begin

                PostedLines.SetFilter("Item No.", ItemNo);
                if (PostedLines.FindSet()) then begin
                    TimesInOrder := PostedLines.Count();
                    repeat
                        ProfitByCar += PostedLines."Final Price";
                    until PostedLines.Next() = 0;

                end;
            end;

        }


    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ItemNo; ItemNo)
                    {
                        Importance = Promoted;
                        ApplicationArea = all;
                        TableRelation = Item."No." where(Type = filter(Car));
                        Caption = 'Car No';
                        ToolTip = 'Specifies Car No. Field';
                    }
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

        TimesInOrder: Integer;
        ProfitByCar: Decimal;
        ItemNo: Code[20];
}
