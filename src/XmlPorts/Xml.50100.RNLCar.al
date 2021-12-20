xmlport 50100 "RNL Car"
{
    Caption = 'Car';
    Encoding = UTF8;
    FormatEvaluate = xml;



    schema
    {

        textelement(RootNodeName)
        {
            tableelement(Item; Item)
            {
                RequestFilterFields = Type;

                fieldelement(No; Item."No.")
                {

                }
                fieldelement(Type; Item.Type)
                {

                }

                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(RNLModel; Item."RNL Model")
                {
                }
                fieldelement(RNLMileage; Item."RNL Mileage")
                {
                }
                fieldelement(RNLPricePerDay; Item."RNL Price Per Day")
                {
                }
            }
        }



    }


}
