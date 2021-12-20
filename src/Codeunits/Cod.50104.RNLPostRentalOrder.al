codeunit 50104 "RNL Post Rental Order"
{

    procedure PostRentalOrder(RNLRentalOrder: Record "RNL Rental Sales Header")
    var
        RNLRentalOrderLine: Record "RNL Rental Sales Line";
        RNLPostedRentalSalesHeader: Record "RNL Posted Rental Sales Header";
        RNLPostedRentalOrderLine: Record "RNL Posted Rental Sales Line";
        OrderPostedMsg: Label 'The order is posted as number %1 and moved to the %2', Comment = '%1 = No, %2 = TableCaption';
    begin
        RNLPostedRentalSalesHeader.TransferFields(RNLRentalOrder);
        RNLPostedRentalSalesHeader."Doc. No." := '';
        RNLPostedRentalSalesHeader.Insert(true);

        RNLRentalOrderLine.SetRange("Doc. No.", RNLRentalOrder."Doc. No.");
        if RNLRentalOrderLine.FindSet() then
            repeat
                RNLPostedRentalOrderLine.TransferFields(RNLRentalOrderLine);
                RNLPostedRentalOrderLine.Validate("Doc. No.", RNLPostedRentalSalesHeader."Doc. No.");
                RNLPostedRentalOrderLine.Insert(true);
            until RNLRentalOrderLine.Next() = 0;

        //
        PostRentalOrderToGenJnl(RNLRentalOrder, RNLPostedRentalSalesHeader."Doc. No.");
        RNLRentalOrder.Delete(true);
        RNLRentalOrderLine.DeleteAll(true);
        Commit();
        Error(OrderPostedMsg, RNLPostedRentalSalesHeader."Doc. No.", RNLPostedRentalSalesHeader.TableCaption());
    end;

    // Настроить сетапы
    local procedure PostRentalOrderToGenJnl(RNLRentalOrder: Record "RNL Rental Sales Header"; DocumentNo_: Code[20])
    var
        RNLRentalSalesLine: Record "RNL Rental Sales Line";
    begin
        RNLRentalSalesSetup.Get();
        RNLRentalSalesSetup.TestField("Interest Account");
        RNLRentalSalesSetup.TestField("Gross Receivable");
        RNLRentalSalesSetup.TestField("Post. Jnl. Template Name");
        RNLRentalSalesSetup.TestField("Post. Jnl. Batch Name");

        PostingDate := WorkDate();
        DocumentDate := WorkDate();
        DocumentNo := DocumentNo_;

        RNLRentalSalesLine.SetRange("Doc. No.", RNLRentalOrder."Doc. No.");
        RNLRentalSalesLine.CalcSums("Final Price");

        PostGenJnl(RNLRentalSalesSetup."Interest Account", 'Radion Show Interest', RNLRentalSalesLine."Final Price");
        PostGenJnl(RNLRentalSalesSetup."Gross Receivable", 'Radion Show Gross Receivable', -RNLRentalSalesLine."Final Price");
    end;

    local procedure PostGenJnl(GLAccNo: Code[20]; Descr: Text; Amt: Decimal)
    var
        GenJournalLine: Record "Gen. Journal Line";
        Currency: Record Currency;
    begin
        if Amt = 0 then
            exit;

        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := RNLRentalSalesSetup."Post. Jnl. Template Name";
        GenJournalLine."Journal Batch Name" := RNLRentalSalesSetup."Post. Jnl. Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.Validate("Account No.", GLAccNo);
        GenJournalLine.Validate("Posting Date", PostingDate);
        GenJournalLine.Validate("Document Date", DocumentDate);
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::" ";
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine.Description := CopyStr(Descr, 1, MaxStrLen(GenJournalLine.Description));

        Currency.InitRoundingPrecision();
        if (Round(Amt, Currency."Amount Rounding Precision") - Amt) < Currency."Amount Rounding Precision" then
            Amt := Round(Amt, Currency."Amount Rounding Precision");

        GenJournalLine.Validate(Amount, Amt);

        GenJournalLine."Gen. Bus. Posting Group" := '';
        GenJournalLine."Gen. Prod. Posting Group" := '';
        GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
        GenJournalLine."VAT Bus. Posting Group" := '';
        GenJournalLine."VAT Prod. Posting Group" := '';
        GenJournalLine."Tax Liable" := false;
        GenJournalLine."Tax Area Code" := '';
        GenJournalLine."Tax Group Code" := '';
        GenJournalLine."System-Created Entry" := true;

        GenJnlPostLine.Run(GenJournalLine);
    end;

    var
        RNLRentalSalesSetup: Record "RNL Sales Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PostingDate, DocumentDate : Date;
        DocumentNo: Code[20];
}

