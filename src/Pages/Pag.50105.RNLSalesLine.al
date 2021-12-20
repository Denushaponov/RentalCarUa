page 50105 "RNL Sales Line"
{

    Caption = 'Cars to order';
    PageType = ListPart;
    SourceTable = "RNL Rental Sales Line";
    //AutoSplitKey=true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;

                }
                field("Car Model"; Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Model field.';
                    ApplicationArea = All;
                }

                field(Color; Rec.Color)
                {
                    ToolTip = 'Specifies the value of the Car Color field.';
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ToolTip = 'Specifies the value of the Car Mileage field.';
                    ApplicationArea = All;
                }

                field("Price Per Day"; Rec."Price Per Day")
                {
                    ToolTip = 'Specifies the value of the Price per day';
                    ApplicationArea = All;
                }

                field(Discount; rec.Discount)
                {
                    ToolTip = 'Specifies the value of the discount field';
                    ApplicationArea = All;
                }

                field("Dominant Discount"; rec."Dominant Discount")
                {
                    ToolTip = 'Specifies the value of the dominant discount field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;
                }

                field("Rental Starting Date"; Rec."Rental Starting Date")
                {
                    ToolTip = 'Specifies the value of the Rental Starting Date field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;
                }
                field("Rental Ending Date"; Rec."Rental Ending Date")
                {
                    ToolTip = 'Specifies the value of the Rental Ending Date field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;
                }
                field("Final Price"; Rec."Final Price")
                {
                    ToolTip = 'Specifies the value of the Final Car Price field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;
                }
            }

        }
    }

}
