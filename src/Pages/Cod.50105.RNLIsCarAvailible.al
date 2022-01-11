// The codeunit to check if the car is availile at the moment
// To be called from RNL Sales Card Header table
codeunit 50105 "RNL Is Car Availible"
{
    // 1.  Procedure needs to recieve item  No 
    // 2. 

    procedure IsAvailible(var CarNo: Code[20]): Boolean
    var
        myInt: Integer;
    begin
        // Need to check if any posted document has the car risght now
    end;
}
