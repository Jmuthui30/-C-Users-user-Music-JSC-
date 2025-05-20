codeunit 51803 "Purchases Management"
{
    // version THL- PRM 1.0
    trigger OnRun()
    begin
    end;
    var Header: Record "Requisition Header";
    Lines: Record "Requisition Line";
    Selection: Integer;
    ProcessText: Label 'Generate Request for Quotes,Generate Purchase Order,Direct Purchase';
    Text000: Label 'You are about to process the purchase requisition, Do you want to continue?';
    Window: Dialog;
    Names: Text;
    RequisitionHeader: Record "Requisition Header";
    CompInfo: Record "Company Information";
    SMTPMail: Codeunit EMail;
    LastLineNo: Integer;
    local procedure ProcessPurchaseRequisition()
    begin
        if Confirm(Text000, false) = true then begin
            Selection:=StrMenu(ProcessText, 1);
            /*
            //Insert Header
            Header.INIT;
            IF Selection = 1 THEN BEGIN
            Header.Transaction := Header.Transaction::Receive;
            Header.INSERT(TRUE);
            END ELSE IF Selection = 2 THEN BEGIN
            Header.Transaction := Header.Transaction::Issue;
            Header.INSERT(TRUE);
            END ELSE BEGIN
            Header.Transaction := Header.Transaction::Transfer;
            Header.INSERT(TRUE);
            END;
            */
            PAGE.Run(51819, Header);
        end;
    end;
    procedure GetRequisitionsToRFQ(var RFQHeader: Record "RFQ Header")
    var
        RFQLines: Record "RFQ Lines";
        RequisitionHeader: Record "Requisition Header";
        RequisitionLines: Record "Requisition Lines";
        LineNo: Integer;
        RequisitionsPage: Page "Purchase Requisitions";
        SelectedRecord: Record "Requisition Header";
        RequestHeader: Record "Requisition Header";
    begin
        LineNo:=10000;
        RequisitionHeader.Reset;
        RequisitionHeader.SetCurrentKey("No.");
        RequisitionHeader.SetRange("Requisition Type", RequisitionHeader."Requisition Type"::"Purchase Requisition");
        RequisitionHeader.SetRange(Status, RequisitionHeader.Status::Released);
        RequisitionHeader.SetRange("PR Closed", false);
        RequisitionsPage.SetTableView(RequisitionHeader);
        RequisitionsPage.LookupMode(true);
        if RequisitionsPage.RunModal = ACTION::LookupOK then begin
            SelectedRecord:=RequisitionHeader;
            RequisitionsPage.SetSelectionFilter(SelectedRecord);
            if SelectedRecord.Find('-')then begin
                repeat RFQHeader."Requisition No.":=SelectedRecord."No.";
                    RFQHeader.Title:=SelectedRecord.Title;
                    RFQHeader.Description:=SelectedRecord.Title;
                    RFQHeader.Modify;
                    //Insert requisition items into the Lines
                    Window.Open('Fetching Requisition Details for #####1', Names);
                    RequisitionLines.Reset;
                    RequisitionLines.SetRange("Requisition No", SelectedRecord."No.");
                    if RequisitionLines.Find('-')then begin
                        repeat LineNo:=LineNo + 1000;
                            RFQLines.Init;
                            RFQLines."RFQ No":=RFQHeader.No;
                            RFQLines."Line No":=LineNo;
                            if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                                RFQLines.Type:=RFQLines.Type::"G/L Account";
                                RFQLines.No:=RequisitionLines."GL Account";
                            end
                            else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                                    RFQLines.Type:=RFQLines.Type::Item;
                                    RFQLines.No:=RequisitionLines.No;
                                end
                                else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                                        RFQLines.Type:=RFQLines.Type::"Fixed Asset";
                                        RFQLines.No:=RequisitionLines.No;
                                    end;
                            RFQLines.Description:=RequisitionLines.Description;
                            RFQLines."Unit of Measure":=RequisitionLines."Unit of Measure";
                            if RequisitionLines."Quantity Approved" <> 0 then RFQLines.Quantity:=RequisitionLines."Quantity Approved"
                            else
                                RFQLines.Quantity:=RequisitionLines.Quantity;
                            RFQLines."Currency Code":=RequisitionLines."Currency Code";
                            RFQLines."Store of Delivery":=RequisitionLines."Location Code";
                            RFQLines."Requisition No":=SelectedRecord."No.";
                            RFQLines."Req Line No":=RequisitionLines."Line No";
                            if RequestHeader.Get(SelectedRecord."No.")then begin
                                RFQLines."Global Dimension 1 Code":=RequestHeader."Global Dimension 1 Code";
                                RFQLines."Global Dimension 2 Code":=RequestHeader."Global Dimension 2 Code";
                                RFQLines."Responsibility Center":=RequestHeader."Global Dimension 3 Code";
                            //RFQLines."Cost Center" := RequestHeader."Cost Center";
                            end;
                            RFQLines."Catalog No.":=RequisitionLines."Catalog No.";
                            RFQLines.MFR:=RequisitionLines.MFR;
                            RFQLines.Insert;
                            Window.Update(1, RequisitionLines.Description);
                        until RequisitionLines.Next = 0;
                    end; //Requisition Lines FIND
                until SelectedRecord.Next = 0;
            end;
            Window.Close;
        end; //Page Lookup
    //RFQ Header
    end;
    procedure GenerateQuote(var RFQNo: Code[20]; var VendorNo: Code[20])
    var
        QuoteHeader: Record "Purchase Header";
        QuoteLines: Record "Purchase Line";
        RFQHeader: Record "RFQ Header";
        RFQLines: Record "RFQ Lines";
        LineNo: Integer;
        RFQVendors: Record "RFQ Vendors";
        Vend: Record Vendor;
        VendReg: Record "Vendor Reg. Request";
    begin
        /*//Check if quote had been generated
        IF NOT RFQVendors.GET(RFQNo,VendorNo) THEN
        */
        if RFQHeader.Get(RFQNo)then begin
            //Quote Header
            QuoteHeader.Init;
            QuoteHeader."Document Type":=QuoteHeader."Document Type"::Quote;
            QuoteHeader.Validate("Buy-from Vendor No.", VendorNo);
            QuoteHeader."Requisition No":=RFQHeader."Requisition No.";
            QuoteHeader."Location Code":=RFQHeader."Location Code";
            QuoteHeader."Vendor Application No.":=VendReg."No.";
            QuoteHeader.RFQNo:=RFQHeader.No;
            QuoteHeader.RFQRemarks:=RFQHeader.Remarks;
            QuoteHeader.Description:=RFQHeader.Description;
            QuoteHeader.RFQTitle:=RFQHeader.Title;
            QuoteHeader.Department:=RFQHeader."Global Dimension 1 Code";
            QuoteHeader.Validate(Remarks);
            QuoteHeader.Insert(true);
            //Quote Lines
            LineNo:=10000;
            RFQLines.Reset;
            RFQLines.SetRange("RFQ No", RFQNo);
            if RFQLines.Find('-')then begin
                repeat LineNo:=LineNo + 1000;
                    QuoteLines.Init;
                    QuoteLines."Document No.":=QuoteHeader."No.";
                    QuoteLines."Document Type":=QuoteLines."Document Type"::Quote;
                    QuoteLines."Line No.":=LineNo;
                    QuoteLines.Type:=RFQLines.Type;
                    QuoteLines.Validate("No.", RFQLines.No);
                    QuoteLines.Description:=RFQLines.Description;
                    QuoteLines."Location Code":=RFQLines."Store of Delivery";
                    QuoteLines."Catalog No.":=RFQLines."Catalog No.";
                    QuoteLines.MFR:=RFQLines.MFR;
                    QuoteLines.Validate(Quantity, RFQLines.Quantity);
                    QuoteLines.Validate("Unit of Measure Code", RFQLines."Unit of Measure");
                    QuoteLines.Validate("Shortcut Dimension 1 Code", RFQLines."Global Dimension 1 Code");
                    QuoteLines.Validate("Shortcut Dimension 2 Code", RFQLines."Global Dimension 2 Code");
                    //QuoteLines."Shortcut Dimension 3 Code" := RFQLines."Responsibility Center";
                    //QuoteLines."Cost Center" := RFQLines."Cost Center";
                    //QuoteLines.ValidateShortcutDimCode(3,RFQLines."Cost Center");
                    QuoteLines."RFQ No":=RFQNo;
                    QuoteLines.Insert;
                until RFQLines.Next = 0;
            end;
            //Update RFQ Vendor with the quote no
            if RFQVendors.Get(RFQNo, VendorNo)then begin
                RFQVendors."Quote No":=QuoteHeader."No.";
                RFQVendors.Modify;
            end;
            Message('Quote No: %1 generated for Vendor: %2', QuoteHeader."No.", QuoteHeader."Buy-from Vendor Name");
            PAGE.Run(49, QuoteHeader);
        end;
    end;
    procedure GenerateOrderFormRequisition(var Requisition: Record "Requisition Header")
    var
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        RequisitionLines: Record "Requisition Lines";
    begin
        if Requisition.Status <> Requisition.Status::Released then Error('This requisition has not been fully approved.');
        if Requisition."PO Generated Directly" then Error('A Purchase Order No. %1 has already been generated for this Requisition.', Requisition."PO Number");
        //Create Header
        PurchOrderHeader.Init;
        PurchOrderHeader."Document Type":=PurchOrderHeader."Document Type"::Order;
        PurchOrderHeader."No. Printed":=0;
        PurchOrderHeader.Status:=PurchOrderHeader.Status::Open;
        PurchOrderHeader."No.":='';
        PurchOrderHeader."Requisition No":=Requisition."No.";
        PurchOrderHeader."Order Date":=Today;
        PurchOrderHeader."Document Date":=Today;
        PurchOrderHeader."Expected Receipt Date":=Today;
        PurchOrderHeader."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
        PurchOrderHeader."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
        /*PurchOrderHeader."Shortcut Dimension 3 Code" := "Global Dimension 3 Code";
        PurchOrderHeader.THLValidateShortcutDimCode(3,PurchOrderHeader."Shortcut Dimension 3 Code");
        PurchOrderHeader."Cost Center" := "Cost Center";
        PurchOrderHeader.THLValidateShortcutDimCode(3,PurchOrderHeader."Cost Center");*/
        PurchOrderHeader."Location Code":=Requisition."Location Code";
        PurchOrderHeader."Currency Code":=Requisition."Currency Code";
        PurchOrderHeader."Posting Date":=WorkDate;
        PurchOrderHeader.Insert(true);
        //Fetch Supplier Details
        Requisition.Reset;
        Requisition.SetRange("No.", Requisition."No.");
        Commit;
        if PAGE.RunModal(PAGE::"Supplier Selection for PO", Requisition) = ACTION::LookupOK then begin
            Requisition.TestField("Supplier No");
            PurchOrderHeader.Validate("Buy-from Vendor No.", Requisition."Supplier No");
            PurchOrderHeader.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
            PurchOrderHeader.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
        end;
        Commit;
        PurchOrderHeader.Modify(true);
        //Create Lines
        RequisitionLines.Reset;
        RequisitionLines.SetRange("Requisition No", Requisition."No.");
        if RequisitionLines.Find('-')then begin
            repeat PurchOrderLine.Init;
                PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
                PurchOrderLine."Document No.":=PurchOrderHeader."No.";
                PurchOrderLine."Line No.":=RequisitionLines."Line No";
                PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                PurchOrderLine.MFR:=RequisitionLines.MFR;
                if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                    RequisitionLines.Validate(No);
                    PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                    PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                end
                else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                        PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                        PurchOrderLine.Validate("No.", RequisitionLines.No);
                    end
                    else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                            PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                            PurchOrderLine.Validate("No.", RequisitionLines.No);
                        end;
                PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                PurchOrderLine."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
                PurchOrderLine."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
                PurchOrderLine.Insert;
                RequisitionLines.Decision:=RequisitionLines.Decision::Order;
                RequisitionLines."Target No.":=PurchOrderHeader."Buy-from Vendor No.";
                RequisitionLines."Order No":=PurchOrderHeader."No.";
                RequisitionLines.Processed:=true;
                RequisitionLines.Modify;
            until RequisitionLines.Next = 0;
        end;
        //Update Requisition
        Requisition."PO Generated Directly":=true;
        Requisition."PO Generated By":=UserId;
        Requisition."PO Generated Date":=Today;
        Requisition."PO Number":=PurchOrderHeader."No.";
        Requisition."PR Closed":=true;
        Requisition."PR Closed By":=Requisition."PR Closed By"::"Purchase Order";
        Requisition.Modify;
        Message('Purchase Order No. %1 has been created for this Requisition.', PurchOrderHeader."No.");
        PAGE.Run(50, PurchOrderHeader);
    end;
    procedure SuggestLPOInspection(var Inspection: Record "Inspection Header")
    var
        LPO: Record "Purchase Header";
        LPOLines: Record "Purchase Line";
        Quote: Record "Purchase Header";
        QuoteLines: Record "Purchase Line";
        RFQ: Record "RFQ Header";
        RFQLines: Record "RFQ Lines";
        PurchaseOrders: Page "Purchase Order List";
        SelectedRecord: Record "Purchase Header";
        InspectionLines: Record "Inspection Lines";
    begin
        //Header
        LPO.Reset;
        LPO.SetCurrentKey("Document Type", "No.");
        LPO.SetRange("Document Type", LPO."Document Type"::Order);
        LPO.SETRANGE(Status, LPO.Status::Released);
        if Inspection."Supplier No." <> '' then LPO.SetRange("Buy-from Vendor No.", Inspection."Supplier No.");
        PurchaseOrders.SetTableView(LPO);
        PurchaseOrders.LookupMode(true);
        if PurchaseOrders.RunModal = ACTION::LookupOK then begin
            SelectedRecord:=LPO;
            PurchaseOrders.SetSelectionFilter(SelectedRecord);
            if SelectedRecord.FindFirst then begin
                Inspection."LPO No":=SelectedRecord."No.";
                Inspection.Validate("Supplier No.", SelectedRecord."Buy-from Vendor No.");
                Inspection."RFQ No.":=SelectedRecord."Quote No.";
                Quote.Reset;
                Quote.SetRange("Document Type", Quote."Document Type"::Quote);
                Quote.SetRange("No.", SelectedRecord."Quote No.");
                if Quote.FindFirst then Inspection."RFQ Date":=RFQ."Created Date";
                Inspection."LPO Date":=SelectedRecord."Posting Date";
                Inspection."Invoice No.":=SelectedRecord."Vendor Invoice No.";
                Inspection.Modify;
            end;
        end;
        //Lines
        InspectionLines.Reset;
        InspectionLines.SetRange("No.", Inspection.No);
        InspectionLines.DeleteAll;
        LPOLines.Reset;
        LPOLines.SetCurrentKey("Document Type", "Document No.", "Line No.");
        LPOLines.SetRange("Document Type", LPOLines."Document Type"::Order);
        LPOLines.SetRange("Document No.", Inspection."LPO No");
        if LPOLines.FindSet then begin
            repeat InspectionLines.Init;
                InspectionLines."No.":=Inspection.No;
                InspectionLines."Line No.":=LPOLines."Line No.";
                InspectionLines."Item No.":=LPOLines."No.";
                InspectionLines.Description:=LPOLines.Description;
                InspectionLines.Quantity:=LPOLines.Quantity;
                InspectionLines.UoM:=LPOLines."Unit of Measure Code";
                InspectionLines."Unit Cost":=LPOLines."Unit Cost";
                InspectionLines."Total Cost":=LPOLines."Line Amount";
                InspectionLines."Catalog No.":=LPOLines."Catalog No.";
                InspectionLines.MFR:=LPOLines.MFR;
                InspectionLines.Insert;
            until LPOLines.Next = 0;
        end;
    end;
    procedure GenerateRFQEmail(var RFQ: Record "Purchase Header")
    var
        VendorName: Text;
        SMTPSetup: Record "Email Account";
        VendorEmail: List of[Text];
        Supplier: Record Vendor;
        RFQFormatedNo: Text;
        ToReplace: Text;
        ReplaceWith: Text;
        OldRFQNo: Text;
    begin
    /*
        with RFQ do begin
            //Generation
            VendorName := "Buy-from Vendor Name";
            if Supplier.Get("Buy-from Vendor No.") then
                VendorEmail.Add(Supplier."E-Mail");

            OldRFQNo := "No.";
            ToReplace := '\';
            ReplaceWith := ' ';
            RFQFormatedNo := ReplaceString(OldRFQNo, ToReplace, ReplaceWith);

            //MESSAGE(RFQFormatedNo);

            OldRFQNo := RFQFormatedNo;
            ToReplace := '/';
            ReplaceWith := ' ';
            RFQFormatedNo := ReplaceString(OldRFQNo, ToReplace, ReplaceWith);

            //MESSAGE(RFQFormatedNo);

            REPORT.SaveAsPdf(51803, 'C:\Program Files\Microsoft Dynamics 365 Business Central\' + RFQFormatedNo + ' - ' + VendorName + '.pdf', RFQ);
            //Sending

            SMTPSetup.Get;
            CompInfo.Get;
            SMTPMail.CreateMessage(CompInfo.Name, SMTPSetup."User ID", VendorEmail, 'REQUEST FOR QUOTATION' + '-' + "No.", '', true);

            //SMTPMail.AddCC(ClientRec."Company E-Mail");
            SMTPMail.AppendBody('Dear Sir/Madam');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('We are pleased to invite quotations from your company as per attached RFQ document.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('For any queries kindly do not hesitate to contact the undersigned.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Should you experience any difficulty viewing this attachment, kindly click on the link below to download adobe PDF reader');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('from http://www.adobe.com/products/acrobat/readstep2.html.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('You can also login to our vendor portal with your credential to view the RFQ');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<a href = "https://procurement-app-499d9.web.app/"> Click here to vendor portal</a>');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Thank you.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Yours Sincerely,');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<b>Procurement Office<b>');
            SMTPMail.AppendBody('<br>');
            CompInfo.Get;
            SMTPMail.AppendBody(CompInfo.Name);
            SMTPMail.AppendBody('<br>');

            if FILE.Exists('C:\Program Files\Microsoft Dynamics 365 Business Central\' + RFQFormatedNo + ' - ' + VendorName + '.pdf') then begin
                SMTPMail.AddAttachment('C:\Program Files\Microsoft Dynamics 365 Business Central\' + RFQFormatedNo + ' - ' + VendorName + '.pdf', "No." + ' - ' + VendorName + '.pdf');
                SMTPMail.Send;
            end;

            //Deleting
            Erase('C:\Program Files\Microsoft Dynamics 365 Business Central\' + RFQFormatedNo + ' - ' + VendorName + '.pdf');
        end;
        */
    end;
    procedure ReplaceString(var String: Text; var FindWhat: Text; var ReplaceWith: Text)NewString: Text[250]begin
        while StrPos(String, FindWhat) > 0 do String:=DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString:=String;
    end;
    procedure GenerateLPOEmail(var LPO: Record "Purchase Header")
    var
        VendorName: Text;
        SMTPSetup: Record "Email Account";
        VendorEmail: List of[Text];
        Supplier: Record Vendor;
        LPOFormatedNo: Text;
        ToReplace: Text;
        ReplaceWith: Text;
        OldLPONo: Text;
    begin
    /*
        with LPO do begin
            //Generation
            VendorName := "Buy-from Vendor Name";
            if Supplier.Get("Buy-from Vendor No.") then
                VendorEmail.Add(Supplier."E-Mail");

            OldLPONo := "No.";
            ToReplace := '\';
            ReplaceWith := ' ';
            LPOFormatedNo := ReplaceString(OldLPONo, ToReplace, ReplaceWith);

            OldLPONo := LPOFormatedNo;
            ToReplace := '/';
            ReplaceWith := ' ';
            LPOFormatedNo := ReplaceString(OldLPONo, ToReplace, ReplaceWith);

            REPORT.SaveAsPdf(51805, 'C:\Program Files\Microsoft Dynamics 365 Business Central\' + LPOFormatedNo + ' - ' + VendorName + '.pdf', LPO);
            //Sending

            SMTPSetup.Get;
            CompInfo.Get;
            SMTPMail.CreateMessage(CompInfo.Name, SMTPSetup."User ID", VendorEmail, 'PURCHASE ORDER' + '-' + "No.", '', true);

            //SMTPMail.AddCC(ClientRec."Company E-Mail");
            SMTPMail.AppendBody('Dear Sir/Madam');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Kindly find attached our Purchase Order attached for the listed items/services.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Please read and understand the terms and conditions of the LPO carefully.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('For any queries kindly do not hesitate to contact the undersigned.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Should you experience any difficulty viewing this attachment, kindly click on the link below to download adobe PDF reader');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('from http://www.adobe.com/products/acrobat/readstep2.html.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('You can also login to our vendor portal with your credential to view the LPO');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<a href = "https://procurement-app-499d9.web.app/"> Click here to vendor portal</a>');
            SMTPMail.AppendBody('Thank you.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Yours Sincerely,');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<b>Procurement Office<b>');
            SMTPMail.AppendBody('<br>');
            CompInfo.Get;
            SMTPMail.AppendBody(CompInfo.Name);
            SMTPMail.AppendBody('<br>');

            if FILE.Exists('C:\Program Files\Microsoft Dynamics 365 Business Central\' + LPOFormatedNo + ' - ' + VendorName + '.pdf') then begin
                SMTPMail.AddAttachment('C:\Program Files\Microsoft Dynamics 365 Business Central\' + LPOFormatedNo + ' - ' + VendorName + '.pdf', "No." + ' - ' + VendorName + '.pdf');
                SMTPMail.Send;
            end;

            //Deleting
            Erase('C:\Program Files\Microsoft Dynamics 365 Business Central\' + LPOFormatedNo + ' - ' + VendorName + '.pdf');
        end;
        */
    end;
    procedure CopyRequisitionDetails(var Requisition: Record "Requisition Header")
    var
        SourceHeader: Record "Requisition Header";
        SourceLines: Record "Requisition Lines";
        DestinationLines: Record "Requisition Lines";
        SelectedRecord: Record "Requisition Header";
        RequisitionsPage: Page "Purchase Requisitions";
        LineNo: Integer;
    begin
        LineNo:=0;
        RequisitionHeader.Reset;
        RequisitionHeader.SetCurrentKey("No.");
        RequisitionHeader.SetRange("Requisition Type", RequisitionHeader."Requisition Type"::"Purchase Requisition");
        //RequisitionHeader.SETRANGE(Status,RequisitionHeader.Status::Released);
        RequisitionsPage.SetTableView(RequisitionHeader);
        RequisitionsPage.LookupMode(true);
        if RequisitionsPage.RunModal = ACTION::LookupOK then begin
            SelectedRecord:=RequisitionHeader;
            RequisitionsPage.SetSelectionFilter(SelectedRecord);
            if SelectedRecord.Find('-')then begin
                repeat SourceLines.Reset;
                    SourceLines.SetCurrentKey("Requisition No", "Line No");
                    SourceLines.SetRange("Requisition No", SelectedRecord."No.");
                    if SourceLines.Find('-')then begin
                        repeat LineNo:=LineNo + 1;
                            DestinationLines.Init;
                            DestinationLines."Requisition No":=Requisition."No.";
                            DestinationLines."Line No":=LineNo;
                            DestinationLines.Type:=SourceLines.Type;
                            DestinationLines.No:=SourceLines.No;
                            DestinationLines.Description:=SourceLines.Description;
                            DestinationLines.Quantity:=SourceLines.Quantity;
                            DestinationLines."Unit of Measure":=SourceLines."Unit of Measure";
                            DestinationLines."Unit Price":=SourceLines."Unit Price";
                            DestinationLines.Amount:=SourceLines.Amount;
                            DestinationLines."Procurement Plan":=SourceLines."Procurement Plan";
                            DestinationLines."Procurement Plan Item":=SourceLines."Procurement Plan Item";
                            DestinationLines."Budget Line":=SourceLines."Budget Line";
                            DestinationLines."Quantity Approved":=SourceLines."Quantity Approved";
                            DestinationLines."Quantity in Store":=SourceLines."Quantity in Store";
                            DestinationLines."Location Code":=SourceLines."Location Code";
                            DestinationLines."GL Account":=SourceLines."GL Account";
                            DestinationLines."Global Dimension 1 Code":=SourceLines."Global Dimension 1 Code";
                            DestinationLines."Global Dimension 2 Code":=SourceLines."Global Dimension 2 Code";
                            DestinationLines."Global Dimension 3 Code":=SourceLines."Global Dimension 3 Code";
                            DestinationLines."Global Dimension 4 Code":=SourceLines."Global Dimension 4 Code";
                            DestinationLines."Global Dimension 5 Code":=SourceLines."Global Dimension 5 Code";
                            DestinationLines.MFR:=SourceLines.MFR;
                            DestinationLines."Catalog No.":=SourceLines."Catalog No.";
                            DestinationLines.Insert;
                        until SourceLines.Next = 0;
                    end;
                until SelectedRecord.Next = 0;
            end;
        end;
    end;
    procedure ProcessPRLines(var RequisitionLines: Record "Requisition Lines")
    var
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        Requisition: Record "Requisition Header";
        PurchOrderLineCopy: Record "Purchase Line";
    begin
        if(RequisitionLines."Global Dimension 1 Code" = '') or (RequisitionLines."Global Dimension 2 Code" = '')then Error('The FundProject Code and Site Code cannot be blank for requisition %1', RequisitionLines."Requisition No");
        if RequisitionLines.Decision = RequisitionLines.Decision::RFQ then begin
        end
        else if RequisitionLines.Decision = RequisitionLines.Decision::Order then begin
                //
                //Create Header
                PurchOrderHeader.Init;
                PurchOrderHeader."Document Type":=PurchOrderHeader."Document Type"::Order;
                PurchOrderHeader."No. Printed":=0;
                PurchOrderHeader.Status:=PurchOrderHeader.Status::Open;
                PurchOrderHeader."No.":='';
                PurchOrderHeader."Requisition No":=RequisitionLines."Requisition No";
                PurchOrderHeader."Order Date":=Today;
                PurchOrderHeader."Document Date":=Today;
                PurchOrderHeader."Expected Receipt Date":=Today;
                if Requisition.Get(RequisitionLines."Requisition No")then begin
                    PurchOrderHeader."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
                    PurchOrderHeader."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
                end;
                PurchOrderHeader."Currency Code":=RequisitionLines."Currency Code";
                PurchOrderHeader."Location Code":=RequisitionLines."Location Code";
                PurchOrderHeader."Posting Date":=WorkDate;
                PurchOrderHeader.Insert(true);
                PurchOrderHeader.Validate("Buy-from Vendor No.", RequisitionLines."Target No.");
                PurchOrderHeader.Validate("Shortcut Dimension 1 Code", RequisitionLines."Global Dimension 1 Code");
                PurchOrderHeader.Validate("Shortcut Dimension 2 Code", RequisitionLines."Global Dimension 2 Code");
                PurchOrderHeader.Modify(true);
                //Create Lines
                PurchOrderLine.Init;
                PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
                PurchOrderLine."Document No.":=PurchOrderHeader."No.";
                PurchOrderLine."Line No.":=RequisitionLines."Line No";
                PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                PurchOrderLine.MFR:=RequisitionLines.MFR;
                if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                    RequisitionLines.Validate(No);
                    PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                    PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                end
                else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                        PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                        PurchOrderLine.Validate("No.", RequisitionLines.No);
                    end
                    else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                            PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                            PurchOrderLine.Validate("No.", RequisitionLines.No);
                        end;
                PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                if Requisition.Get(RequisitionLines."Requisition No")then begin
                    PurchOrderLine."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
                    PurchOrderLine."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
                end;
                PurchOrderLine.Insert;
                RequisitionLines."Order No":=PurchOrderHeader."No.";
                RequisitionLines.Processed:=true;
                RequisitionLines.Modify;
            //
            end
            else if RequisitionLines.Decision = RequisitionLines.Decision::"Blanket Order" then begin
                    //Create Header
                    PurchOrderHeader.Init;
                    PurchOrderHeader."Document Type":=PurchOrderHeader."Document Type"::"Blanket Order";
                    PurchOrderHeader."No. Printed":=0;
                    PurchOrderHeader.Status:=PurchOrderHeader.Status::Open;
                    PurchOrderHeader."No.":='';
                    PurchOrderHeader."Requisition No":=RequisitionLines."Requisition No";
                    PurchOrderHeader."Order Date":=Today;
                    PurchOrderHeader."Document Date":=Today;
                    PurchOrderHeader."Expected Receipt Date":=Today;
                    if Requisition.Get(RequisitionLines."Requisition No")then begin
                        PurchOrderHeader."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
                        PurchOrderHeader."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
                    end;
                    PurchOrderHeader."Currency Code":=RequisitionLines."Currency Code";
                    PurchOrderHeader."Location Code":=RequisitionLines."Location Code";
                    PurchOrderHeader."Posting Date":=WorkDate;
                    PurchOrderHeader.Insert(true);
                    PurchOrderHeader.Validate("Buy-from Vendor No.", RequisitionLines."Target No.");
                    PurchOrderHeader.Validate("Shortcut Dimension 1 Code", RequisitionLines."Global Dimension 1 Code");
                    PurchOrderHeader.Validate("Shortcut Dimension 2 Code", RequisitionLines."Global Dimension 2 Code");
                    PurchOrderHeader.Modify(true);
                    //Create Lines
                    PurchOrderLine.Init;
                    PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::"Blanket Order";
                    PurchOrderLine."Document No.":=PurchOrderHeader."No.";
                    PurchOrderLine."Line No.":=RequisitionLines."Line No";
                    PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                    PurchOrderLine.MFR:=RequisitionLines.MFR;
                    if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                        PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                        PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                    end
                    else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                            PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                            PurchOrderLine.Validate("No.", RequisitionLines.No);
                        end
                        else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                                PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                                PurchOrderLine.Validate("No.", RequisitionLines.No);
                            end;
                    PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                    PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                    PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                    PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                    PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                    PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                    PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                    if Requisition.Get(RequisitionLines."Requisition No")then begin
                        PurchOrderLine.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
                        PurchOrderLine.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
                    end;
                    PurchOrderLine.Insert;
                    RequisitionLines."Order No":=PurchOrderHeader."No.";
                    RequisitionLines.Processed:=true;
                    RequisitionLines.Modify;
                //
                end
                else if RequisitionLines.Decision = RequisitionLines.Decision::"Append to Order" then begin
                        PurchOrderLineCopy.Reset;
                        PurchOrderLineCopy.SetRange("Document Type", PurchOrderLineCopy."Document Type"::Order);
                        PurchOrderLineCopy.SetRange("Document No.", RequisitionLines."Target No.");
                        if PurchOrderLineCopy.FindLast then LastLineNo:=PurchOrderLineCopy."Line No.";
                        //Create Lines
                        PurchOrderLine.Init;
                        PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
                        PurchOrderLine."Document No.":=RequisitionLines."Target No.";
                        PurchOrderLine."Line No.":=LastLineNo + 1000;
                        PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                        PurchOrderLine.MFR:=RequisitionLines.MFR;
                        if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                            PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                            PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                        end
                        else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                                PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                                PurchOrderLine.Validate("No.", RequisitionLines.No);
                            end
                            else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                                    PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                                    PurchOrderLine.Validate("No.", RequisitionLines.No);
                                end;
                        PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                        PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                        PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                        PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                        PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                        PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                        PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                        if Requisition.Get(RequisitionLines."Requisition No")then begin
                            PurchOrderLine.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
                            PurchOrderLine.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
                        end;
                        PurchOrderLine.Insert;
                        RequisitionLines."Order No":=PurchOrderHeader."No.";
                        RequisitionLines.Processed:=true;
                        RequisitionLines.Modify;
                    end
                    else if RequisitionLines.Decision = RequisitionLines.Decision::"Append to Blanket Order" then begin
                            PurchOrderLineCopy.Reset;
                            PurchOrderLineCopy.SetRange("Document Type", PurchOrderLineCopy."Document Type"::"Blanket Order");
                            PurchOrderLineCopy.SetRange("Document No.", RequisitionLines."Target No.");
                            if PurchOrderLineCopy.FindLast then LastLineNo:=PurchOrderLineCopy."Line No.";
                            //Create Lines
                            PurchOrderLine.Init;
                            PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::"Blanket Order";
                            PurchOrderLine."Document No.":=RequisitionLines."Target No.";
                            PurchOrderLine."Line No.":=LastLineNo + 1000;
                            PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                            PurchOrderLine.MFR:=RequisitionLines.MFR;
                            if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                                PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                                PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                            end
                            else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                                    PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                                    PurchOrderLine.Validate("No.", RequisitionLines.No);
                                end
                                else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                                        PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                                        PurchOrderLine.Validate("No.", RequisitionLines.No);
                                    end;
                            PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                            PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                            PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                            PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                            PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                            PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                            PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                            if Requisition.Get(RequisitionLines."Requisition No")then begin
                                PurchOrderLine.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
                                PurchOrderLine.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
                            end;
                            PurchOrderLine.Insert;
                            RequisitionLines."Order No":=PurchOrderHeader."No.";
                            RequisitionLines.Processed:=true;
                            RequisitionLines.Modify;
                        end
                        else if RequisitionLines.Decision = RequisitionLines.Decision::" " then begin
                            end;
    end;
    procedure AppendRequisitionToOrder(var Requisition: Record "Requisition Header")
    var
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        RequisitionLines: Record "Requisition Lines";
        LineNo: Integer;
    begin
        if Requisition.Status <> Requisition.Status::Released then Error('This requisition has not been fully approved.');
        if Requisition."PO Generated Directly" then Error('A Purchase Order No. %1 has already been generated for this Requisition.', Requisition."PO Number");
        //Create Header
        PurchOrderHeader.Reset;
        PurchOrderHeader.SetRange("Document Type", PurchOrderHeader."Document Type"::Order);
        PurchOrderHeader.SetRange(Status, PurchOrderHeader.Status::Open);
        if PAGE.RunModal(PAGE::"Purchase Order List", PurchOrderHeader) = ACTION::LookupOK then begin
            PurchOrderHeader."Requisition No":=Requisition."No.";
            PurchOrderHeader."Order Date":=Today;
            PurchOrderHeader."Document Date":=Today;
            PurchOrderHeader."Expected Receipt Date":=Today;
            PurchOrderHeader."Shortcut Dimension 1 Code":=Requisition."Global Dimension 1 Code";
            PurchOrderHeader."Shortcut Dimension 2 Code":=Requisition."Global Dimension 2 Code";
            /*PurchOrderHeader."Shortcut Dimension 3 Code" := "Global Dimension 3 Code";
            PurchOrderHeader.THLValidateShortcutDimCode(3,PurchOrderHeader."Shortcut Dimension 3 Code");
            PurchOrderHeader."Cost Center" := "Cost Center";
            PurchOrderHeader.THLValidateShortcutDimCode(3,PurchOrderHeader."Cost Center");*/
            PurchOrderHeader."Location Code":=Requisition."Location Code";
            PurchOrderHeader."Currency Code":=Requisition."Currency Code";
            PurchOrderHeader."Posting Date":=WorkDate;
            PurchOrderHeader.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
            PurchOrderHeader.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
            PurchOrderHeader.Modify;
            //Append Lines
            RequisitionLines.Reset;
            RequisitionLines.SetRange("Requisition No", Requisition."No.");
            if RequisitionLines.FindLast then LineNo:=RequisitionLines."Line No";
            RequisitionLines.Reset;
            RequisitionLines.SetRange("Requisition No", Requisition."No.");
            if RequisitionLines.Find('-')then begin
                repeat LineNo:=LineNo + 1000;
                    PurchOrderLine.Init;
                    PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
                    PurchOrderLine."Document No.":=PurchOrderHeader."No.";
                    PurchOrderLine."Line No.":=LineNo;
                    PurchOrderLine."Catalog No.":=RequisitionLines."Catalog No.";
                    PurchOrderLine.MFR:=RequisitionLines.MFR;
                    if RequisitionLines.Type = RequisitionLines.Type::Expense then begin
                        PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
                        PurchOrderLine.Validate("No.", RequisitionLines."GL Account");
                    end
                    else if RequisitionLines.Type = RequisitionLines.Type::Item then begin
                            PurchOrderLine.Type:=PurchOrderLine.Type::Item;
                            PurchOrderLine.Validate("No.", RequisitionLines.No);
                        end
                        else if RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" then begin
                                PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
                                PurchOrderLine.Validate("No.", RequisitionLines.No);
                            end;
                    PurchOrderLine.Description:=CopyStr(RequisitionLines.Description, 1, 250);
                    PurchOrderLine."Location Code":=RequisitionLines."Location Code";
                    PurchOrderLine."Currency Code":=RequisitionLines."Currency Code";
                    PurchOrderLine.Validate(Quantity, RequisitionLines.Quantity);
                    PurchOrderLine.Validate("Unit of Measure Code", RequisitionLines."Unit of Measure");
                    PurchOrderLine.Validate("Direct Unit Cost", RequisitionLines."Unit Price");
                    PurchOrderLine.Validate("Unit Cost", RequisitionLines."Unit Price");
                    PurchOrderLine.Validate("Shortcut Dimension 1 Code", Requisition."Global Dimension 1 Code");
                    PurchOrderLine.Validate("Shortcut Dimension 2 Code", Requisition."Global Dimension 2 Code");
                    PurchOrderLine.Insert;
                    RequisitionLines.Decision:=RequisitionLines.Decision::Order;
                    RequisitionLines."Target No.":=PurchOrderHeader."Buy-from Vendor No.";
                    RequisitionLines."Order No":=PurchOrderHeader."No.";
                    RequisitionLines.Processed:=true;
                    RequisitionLines.Modify;
                until RequisitionLines.Next = 0;
            end;
            //Update Requisition
            Requisition."PO Generated Directly":=true;
            Requisition."PO Generated By":=UserId;
            Requisition."PO Generated Date":=Today;
            Requisition."PO Number":=PurchOrderHeader."No.";
            Requisition."PR Closed":=true;
            Requisition."PR Closed By":=Requisition."PR Closed By"::"Purchase Order";
            Requisition.Modify;
            Message('Purchase Order No. %1 has been updated with this Requisition.', PurchOrderHeader."No.");
            PAGE.Run(50, PurchOrderHeader);
        end;
    end;
    //***Ibrahim Wasiu
    procedure ProcurementCheck(var ReqHeader: Record "Requisition Header")
    var
        ProcureHeader: Record "Procurement Plan Header";
        ProcureLines: Record "Procurement Plan Lines";
        Lines: Record "Requisition Lines";
    begin
        //Fixed Asset or Item
        Lines.Reset;
        Lines.SetRange("Requisition No", ReqHeader."No.");
        if Lines.FindFirst then begin
            if(Lines.Type = Lines.Type::"Fixed Asset") OR (Lines.Type = Lines.Type::Item)then begin
                ProcureLines.Reset;
                ProcureLines.SetRange("No.", Lines.No);
                ProcureLines.SetRange("Department Code", Lines."Global Dimension 1 Code");
                ProcureLines.SetRange("Plan Status", ProcureLines."Plan Status"::Released);
                if ProcureLines.FindFirst then begin
                end
                else if ProcureLines."Plan No" = '' then Error('Procurement plan for item/service has neither been prepared nor approved for requisition line %1', Lines."Line No");
            end;
        end;
        //Expense
        Lines.Reset();
        Lines.SetRange("Requisition No", ReqHeader."No.");
        if Lines.FindFirst then begin
            if Lines.Type = Lines.type::Expense then begin
                ProcureLines.Reset;
                ProcureLines.SetFilter(ProcureLines."No.", Lines."GL Account");
                ProcureLines.SetFilter(ProcureLines."Department Code", Lines."Global Dimension 1 Code");
                ProcureLines.SetRange(ProcureLines."Plan Status", ProcureLines."Plan Status"::Released);
                if ProcureLines.FindFirst then begin
                end
                else if ProcureLines."No." = '' then Error('Procurement plan for service has neither been prepared nor approved for requisition line %1', Lines."Line No");
            end;
        end;
    end;
}
