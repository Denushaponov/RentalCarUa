// The codeunit to check if the car is availile at the moment
// To be called from RNL Item tablext
codeunit 50105 "RNL Is Car Availible"
{
    // 1.  Procedure needs to recieve item  No 
    // 2. 

    procedure IsAvailible(var CarNo: Code[20]) ReturnValue: Boolean
    var
        PostedLines: Record "RNL Posted Rental Sales Line";
    begin
        // Need to check if any posted document includes the car right now
        PostedLines.SetFilter("Rental Starting Date", '..%1', Today());
        PostedLines.SetFilter("Rental Ending Date", '%1..', Today() - 1);
        if (PostedLines.FindSet()) then ReturnValue := false else ReturnValue := true;
    end;
}
