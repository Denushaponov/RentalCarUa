page 50111 "RNL Rental Car"
{
    Caption = 'Rental Car';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part("RNL Rental Sales Activities"; "RNL Rental Sales Activities")
                {
                    ApplicationArea = all;
                    Visible = true;
                }



            }
        }
    }
    actions
    {
        area(Embedding)
        {
            // Actions in embedding area
        }
    }
}
