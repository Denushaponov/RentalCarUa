xmlport 50100 "RNL Car"
{
    Caption = 'Car';
    //Encoding = UTF8;
    Direction = Import;
    FormatEvaluate = Legacy;
    Format = VariableText;




    schema
    {

        textelement(RootNodeName)
        {
            tableelement(Item; Item)
            {


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
