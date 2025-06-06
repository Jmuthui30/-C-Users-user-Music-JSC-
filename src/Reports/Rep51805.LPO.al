report 51805 "LPO"
{
    // version NAVW111.00
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/LPO.rdl';
    Caption = 'Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';

            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_; "No.")
            {
            }
            column(Originarity; Originarity)
            {
            }
            column(LPO_LPO; LPO_LPO)
            {
            }
            column(LSO_LPODesc; LSO_LPODesc)
            {
            }
            column(LSO_LPOWordtxt; LSO_LPOWordtxt)
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(PurchaseNo; PurchLine."No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(Logo2; CompInfo.Picture2)
            {
            }
            column(Watermark; AdvancedFinanceSetup."Watermark Portrait")
            {
            }
            column(CompName; CompName)
            {
            }
            column(CompAddress; CompAddress)
            {
            }
            column(CompAddress2; CompAddressTwo)
            {
            }
            column(CompCity; CompCity)
            {
            }
            column(CompPhone; CompPhone)
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(TermAndConditionOne; TermAndCondition[1])
            {
            }
            column(TermAndConditionTwo; TermAndCondition[2])
            {
            }
            column(TermAndConditionThree; TermAndCondition[3])
            {
            }
            column(TermAndConditionFour; TermAndCondition[4])
            {
            }
            column(TermAndConditionFive; TermAndCondition[5])
            {
            }
            column(TermAndConditionSix; TermAndCondition[6])
            {
            }
            column(TermAndConditionSeven; TermAndCondition[7])
            {
            }
            column(TermAndConditionEight; TermAndCondition[8])
            {
            }
            column(TermAndConditionNine; TermAndCondition[9])
            {
            }
            column(TermAndConditionTen; TermAndCondition[10])
            {
            }
            column(FirstApprover; "1stapprover")
            {
            }
            column(SecondApprover; "2ndapprover")
            {
            }
            column(ThirdApprover; "3rdapprover")
            {
            }
            column(FourthApprover; "4thapprover")
            {
            }
            column(FirstApproverDate; "1stapproverdate")
            {
            }
            column(SecondApproverDate; "2ndapproverdate")
            {
            }
            column(ThirdApproverDate; "3rdapproverdate")
            {
            }
            column(FourthApproverDate; "4thapproverdate")
            {
            }
            column(FirstApproverSignature; UserRecApp1.Signature)
            {
            }
            column(SecondApproverSignature; UserRecApp2.Signature)
            {
            }
            column(ThirdApproverSignature; UserRecApp3.Signature)
            {
            }
            column(FourthApproverSignature; UserRecApp4.Signature)
            {
            }
            column(AccountClassification; AccountClassification)
            {
            }
            column(ShipToAddressText; ShipToAddressText)
            {
            }
            column(AttentionText; AttentionText)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(ReportTitleCopyText; StrSubstNo(Text004, CopyText))
                    {
                    }
                    /* column(CurrRepPageNo;StrSubstNo(Text005,Format(CurrReport.PageNo)))
                     {
                     }*/
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchHeader; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(DimText; DimText)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue:=false;
                            repeat OldDimText:=DimText;
                                if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                    DimText:=OldDimText;
                                    Continue:=true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;
                        end;
                        trigger OnAfterGetRecord()
                        begin
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(Counter; Counter)
                        {
                        }
                        column(LineAmt_PurchLine; PurchLine."Line Amount")
                        {
                        AutoFormatExpression = "Purchase Line"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine; Format("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage; CompanyInfo."Home Page")
                        {
                        }
                        column(EMail; CompanyInfo."E-Mail")
                        {
                        }
                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine;-PurchLine."Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Purchase Line"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInclVAT; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption; "Purchase Line".FieldCaption("No."))
                        {
                        }
                        column(Desc_PurchLineCaption; LSO_LPODesc)
                        {
                        }
                        column(Qty_PurchLineCaption; "Purchase Line".FieldCaption(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption; "Purchase Line".FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(MFR; "Purchase Line".MFR)
                        {
                        }
                        column(CatalogueNo; "Purchase Line"."Catalog No.")
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue:=false;
                                repeat OldDimText:=DimText;
                                    if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                        DimText:=OldDimText;
                                        Continue:=true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then PurchLine.Find('-')
                            else
                                PurchLine.Next;
                            "Purchase Line":=PurchLine;
                            if not "Purchase Header"."Prices Including VAT" and (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")then PurchLine."Line Amount":=0;
                            if("Purchase Line"."Item Reference No." <> '') and (not ShowInternalInfo)then "Purchase Line"."No.":="Purchase Line"."Item Reference No.";
                            if(PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo)then "Purchase Line"."No.":='';
                            AllowInvDisctxt:=Format("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal+="Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount-="Purchase Line"."Inv. Discount Amount";
                            TotalAmount+="Purchase Line".Amount;
                            //VOO
                            Counter:=Counter + 1;
                        end;
                        trigger OnPostDataItem()
                        begin
                            PurchLine.DeleteAll;
                        end;
                        trigger OnPreDataItem()
                        begin
                            MoreLines:=PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and (PurchLine."No." = '') and (PurchLine.Quantity = 0) and (PurchLine.Amount = 0)do MoreLines:=PurchLine.Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            PurchLine.SetRange("Line No.", 0, PurchLine."Line No.");
                            SetRange(Number, 1, PurchLine.Count);
                        /*CurrReport.CreateTotals(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");*/
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                        /*CurrReport.CreateTotals(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                        */
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                        AutoFormatType = 1;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            if(not GLSetup."Print VAT specification in LCY") or ("Purchase Header"."Currency Code" = '') or (VATAmountLine.GetTotalVATAmount = 0)then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            /*CurrReport.CreateTotals(VALVATBaseLCY,VALVATAmountLCY);*/
                            if GLSetup."LCY Code" = '' then VALSpecLCYHeader:=Text007 + Text008
                            else
                                VALSpecLCYHeader:=Text007 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate:=StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then CurrReport.Break;
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '')then CurrReport.Break;
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; PrepmtInvBuf.Amount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        column(PrepmtLoopLineNo; PrepmtLoopLineNo)
                        {
                        }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(DummyColumn;0)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FindSet then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue:=false;
                                repeat OldDimText:=DimText;
                                    if DimText = '' then DimText:=StrSubstNo('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText:=StrSubstNo('%1, %2 %3', DimText, PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                        DimText:=OldDimText;
                                        Continue:=true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.Next = 0;
                                if Number > 1 then PrepmtLineAmount:=0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                PrepmtDimSetEntry.SetRange("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.Find('-')then CurrReport.Break;
                            end
                            else if PrepmtInvBuf.Next = 0 then CurrReport.Break;
                            if "Purchase Header"."Prices Including VAT" then PrepmtLineAmount:=PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount:=PrepmtInvBuf.Amount;
                            PrepmtLoopLineNo+=1;
                        end;
                        trigger OnPreDataItem()
                        begin
                        /* CurrReport.CreateTotals(
                               PrepmtInvBuf.Amount,PrepmtInvBuf."Amount Incl. VAT",
                               PrepmtVATAmountLine."Line Amount",PrepmtVATAmountLine."VAT Base",
                               PrepmtVATAmountLine."VAT Amount",
                               PrepmtLineAmount);
                             PrepmtLoopLineNo := 0;*/
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Purchase Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(PrepmtVATAmtLineVATId; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, PrepmtVATAmountLine.Count);
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
                    PurchLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount:=VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount:=VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount:=VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT:=VATAmountLine.GetTotalAmountInclVAT;
                    PrepmtInvBuf.DeleteAll;
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.IsEmpty then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty then PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrePmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    /*Commented by Henry*/
                    //PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header",PrepmtPurchLine,0,PrepmtInvBuf);
                    PrepmtVATAmount:=PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount:=PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT:=PrepmtVATAmountLine.GetTotalAmountInclVAT;
                    if Number > 1 then CopyText:=FormatDocument.GetCOPYText;
                    /*CurrReport.PageNo := 1;*/
                    OutputNo:=OutputNo + 1;
                    TotalSubTotal:=0;
                    TotalAmount:=0;
                end;
                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + 1;
                    CopyText:='';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if "Purchase Header"."Shortcut Dimension 2 Code" = 'KISUMU' then begin
                    CompName:=CompInfo."Branch Name";
                    CompAddress:=CompInfo."Branch Address";
                    CompAddressTwo:=CompInfo."Branch Address 2";
                    CompCity:=CompInfo."Branch City";
                    CompPhone:=CompInfo."Branch Phone No.";
                end;
                CurrReport.Language:=SLanguage."Windows Language ID";
                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                PricesInclVATtxt:=Format("Prices Including VAT");
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                if not CurrReport.Preview then begin
                    /*IF ArchiveDocument THEN
                      ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);*/
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                i:=0;
                TandC.Reset;
                TandC.SetRange("Document Type", TandC."Document Type"::Order);
                if TandC.Find('-')then begin
                    repeat i:=i + 1;
                        TermAndCondition[i]:=TandC.Description + TandC."Further Description";
                    until TandC.Next = 0;
                end;
                GLSetup.Get;
                AccountClassification:='';
                if DimensionValueRec.Get(GLSetup."Global Dimension 1 Code", "Purchase Header"."Shortcut Dimension 1 Code")then AccountClassification:=DimensionValueRec.Name;
                //Approvers
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange(ApprovalEntries."Table ID", 38);
                ApprovalEntries.SetRange(ApprovalEntries."Document Type", ApprovalEntries."Document Type"::Order);
                ApprovalEntries.SetRange(ApprovalEntries."Document No.", "Purchase Header"."No.");
                ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-')then begin
                    j:=0;
                    repeat j:=j + 1;
                        if j = 1 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Sender ID");
                            if Users.FindFirst then begin
                                "1stapprover":=Users."Full Name";
                            end;
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "2ndapprover":=Users."Full Name";
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            end;
                            "1stapproverdate":=ApprovalEntries."Date-Time Sent for Approval";
                            "2ndapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp1.Get(ApprovalEntries."Sender ID")then UserRecApp1.CalcFields(UserRecApp1.Signature);
                            if UserRecApp2.Get(ApprovalEntries."Approver ID")then UserRecApp2.CalcFields(UserRecApp2.Signature);
                            if UserRecApp3.Get(ApprovalEntries."Approver ID")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                        if j = 2 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            end;
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.Get(ApprovalEntries."Approver ID")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                        if j = 3 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "4thapprover":=Users."Full Name";
                            end;
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
                ShipToAddressText:='';
                AttentionText:='';
                if "Purchase Header"."International LPO" then begin
                    ProcurementSetup.Get;
                    ShipToAddressText:='PLEASE SHIP TO: ' + ProcurementSetup."International PO Address";
                    AttentionText:='ATTN MRU-' + "Purchase Header"."No.";
                end;
                if(("Purchase Header"."Document Type" = "Purchase Header"."Document Type"::Order) and ("Purchase Header"."No. Printed" = 0))then Originarity:='ORIGINAL'
                else
                    Originarity:='COPY!!!';
                if "Purchase Header"."Order Type" = "Purchase Header"."Order Type"::"Local Service Order" then LSO_LPODesc:='Description of Service'
                else
                    LSO_LPODesc:='Description of Goods';
                if(("Purchase Header"."Order Type" = "Purchase Header"."Order Type"::"Local Service Order") and ("Purchase Header"."Document Type" = "Purchase Header"."Document Type"::Order))then LSO_LPOWordtxt:='Please carry out the services listed here below at(Full Address)'
                else
                    LSO_LPOWordtxt:='Please deliver the goods listed here below to (Full Address)';
                if "Purchase Header"."Order Type" = "Purchase Header"."Order Type"::"Local Purchase Order" then LPO_LPO:='LOCAL PURCHASE ORDER'
                else
                    LPO_LPO:='LOCAL SERVICE ORDER';
            end;
            trigger OnPreDataItem()
            begin
                if not CurrReport.Preview then begin
                    if PurchaseHeader.Get("Purchase Header"."Document Type"::Order, "Purchase Header"."No.")then begin
                        PurchaseHeader.Printed:=true;
                        PurchaseHeader."Last Printed by":=UserId;
                        // PurchaseHeader."Last Print Date" := ;
                        PurchaseHeader."Last Print Time":=Time;
                        PurchaseHeader."Last Print No.":=PurchaseHeader."Last Print No." + 1;
                        PurchaseHeader.Modify;
                    end end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoofCopies; NoOfCopies)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies whether to archive the order.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then LogInteraction:=false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want the program to log this interaction.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then ArchiveDocument:=ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            /*ArchiveDocument := PurchSetup."Archive Quotes and Orders";*/
            InitLogInteraction;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        PurchSetup.Get;
    end;
    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields(Picture2);
        CompName:=CompInfo.Name;
        CompAddress:=CompInfo.Address;
        CompAddressTwo:=CompInfo."Address 2";
        CompCity:=CompInfo.City;
        CompPhone:=CompInfo."Phone No.";
        AdvancedFinanceSetup.Get;
        //AdvancedFinanceSetup.CALCFIELDS("Watermark Portrait");
        Counter:=0;
    end;
    var LSO_LPODesc: Text[250];
    LSO_LPOWordtxt: text[250];
    Text004: Label 'Order %1', Comment = '%1 = Document No.';
    Text005: Label 'Page %1', Comment = '%1 = Page No.';
    GLSetup: Record "General Ledger Setup";
    CompanyInfo: Record "Company Information";
    ShipmentMethod: Record "Shipment Method";
    PaymentTerms: Record "Payment Terms";
    PrepmtPaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    VATAmountLine: Record "VAT Amount Line" temporary;
    PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
    PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
    PurchLine: Record "Purchase Line" temporary;
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    PrepmtDimSetEntry: Record "Dimension Set Entry";
    PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
    RespCenter: Record "Responsibility Center";
    SLanguage: Record Language;
    CurrExchRate: Record "Currency Exchange Rate";
    PurchSetup: Record "Purchases & Payables Setup";
    FormatAddr: Codeunit 365;
    FormatDocument: Codeunit 368;
    PurchPost: Codeunit "Purch.-Post";
    ArchiveManagement: Codeunit 5063;
    SegManagement: Codeunit 5051;
    PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
    VendAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    BuyFromAddr: array[8]of Text[50];
    PurchaserText: Text[30];
    VATNoText: Text[80];
    ReferenceText: Text[80];
    TotalText: Text[50];
    TotalInclVATText: Text[50];
    TotalExclVATText: Text[50];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    OutputNo: Integer;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    ArchiveDocument: Boolean;
    LogInteraction: Boolean;
    VATAmount: Decimal;
    VATBaseAmount: Decimal;
    VATDiscountAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    VALSpecLCYHeader: Text[80];
    VALExchRate: Text[50];
    Text007: Label 'VAT Amount Specification in ';
    Text008: Label 'Local Currency';
    Text009: Label 'Exchange rate: %1/%2';
    PrepmtVATAmount: Decimal;
    PrepmtVATBaseAmount: Decimal;
    PrepmtTotalAmountInclVAT: Decimal;
    PrepmtLineAmount: Decimal;
    PricesInclVATtxt: Text[30];
    AllowInvDisctxt: Text[30];
    [InDataSet]
    ArchiveDocumentEnable: Boolean;
    [InDataSet]
    LogInteractionEnable: Boolean;
    TotalSubTotal: Decimal;
    TotalAmount: Decimal;
    TotalInvoiceDiscountAmount: Decimal;
    CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
    CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
    CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
    CompanyInfoBankNameCaptionLbl: Label 'Bank';
    CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
    OrderNoCaptionLbl: Label 'Order No.';
    PageCaptionLbl: Label 'Page';
    DocumentDateCaptionLbl: Label 'Document Date';
    HdrDimCaptionLbl: Label 'Header Dimensions';
    DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
    PurchLineLineDiscCaptionLbl: Label 'Discount %';
    VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
    LineDimCaptionLbl: Label 'Line Dimensions';
    PaymentDetailsCaptionLbl: Label 'Payment Details';
    VendNoCaptionLbl: Label 'Vendor No.';
    ShiptoAddressCaptionLbl: Label 'Ship-to Address';
    PrepmtInvBuDescCaptionLbl: Label 'Description';
    PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
    PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
    PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
    AmountCaptionLbl: Label 'Amount';
    PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
    SubtotalCaptionLbl: Label 'Subtotal';
    VATAmtLineVATCaptionLbl: Label 'VAT %';
    VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
    VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
    VATIdentifierCaptionLbl: Label 'VAT Identifier';
    VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
    VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
    VALVATBaseLCYCaptionLbl: Label 'VAT Base';
    TotalCaptionLbl: Label 'Total';
    PaymentTermsDescCaptionLbl: Label 'Payment Terms';
    ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
    PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
    HomePageCaptionLbl: Label 'Home Page';
    EmailIDCaptionLbl: Label 'Email';
    AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
    PrepmtLoopLineNo: Integer;
    "**************************": Text;
    CompInfo: Record "Company Information";
    TandC: Record "Procurement Terms & Conditions";
    i: Integer;
    TermAndCondition: array[20]of Text;
    ApprovalEntries: Record "Approval Entry";
    "1stapprover": Text[100];
    "2ndapprover": Text[100];
    "3rdapprover": Text[100];
    "4thapprover": Text[100];
    j: Integer;
    "1stapproverdate": DateTime;
    "2ndapproverdate": DateTime;
    "3rdapproverdate": DateTime;
    "4thapproverdate": DateTime;
    UserRec: Record "User Setup";
    UserRecApp1: Record "User Setup";
    UserRecApp2: Record "User Setup";
    UserRecApp3: Record "User Setup";
    UserRecApp4: Record "User Setup";
    x: Integer;
    DimensionRec: Record Dimension;
    DimensionValueRec: Record "Dimension Value";
    AIEHolder: Code[20];
    UserSetup: Record "User Setup";
    Users: Record User;
    PurchaseHeader: Record "Purchase Header";
    Counter: Integer;
    AccountClassification: Text;
    ProcurementSetup: Record "Procurement Setup";
    ShipToAddressText: Text;
    AttentionText: Text;
    CompName: Text;
    CompAddress: Text;
    CompAddressTwo: Text;
    CompCity: Text;
    CompPhone: Text;
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Originarity: Text[20];
    LPO_LPO: Text[70];
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        ArchiveDocument:=NewArchiveDocument;
        LogInteraction:=NewLogInteraction;
    end;
    local procedure InitLogInteraction()
    begin
    // LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
    end;
    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;
    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");
        ReferenceText:=FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FieldCaption("Your Reference"));
        VATNoText:=FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FieldCaption("VAT Registration No."));
    end;
}
