report 50027 "Fix PO Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix PO Lines.rdlc';

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            DataItemTableView = WHERE("PO Generated Directly"=FILTER('Yes'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                RequisitionLines.RESET;
                RequisitionLines.SETRANGE("Requisition No", "Requisition Header"."No.");
                IF RequisitionLines.FIND('-')THEN BEGIN
                    REPEAT POLines.RESET;
                        POLines.SETRANGE("Document Type", POLines."Document Type"::Order);
                        POLines.SETRANGE("Document No.", "Requisition Header"."PO Number");
                        POLines.SETRANGE("Line No.", RequisitionLines."Line No");
                        POLines.SETRANGE("Quantity Received", 0);
                        IF POLines.FIND('-')THEN BEGIN
                            POLines.VALIDATE("No.", RequisitionLines."GL Account");
                            POLines."Catalog No.":=RequisitionLines."Catalog No.";
                            POLines.MFR:=RequisitionLines.MFR;
                            IF RequisitionLines.Type = RequisitionLines.Type::Expense THEN BEGIN
                                POLines.Type:=POLines.Type::"G/L Account";
                                POLines.VALIDATE("No.", RequisitionLines."GL Account");
                            END
                            ELSE IF RequisitionLines.Type = RequisitionLines.Type::Item THEN BEGIN
                                    POLines.Type:=POLines.Type::Item;
                                    POLines.VALIDATE("No.", RequisitionLines.No);
                                END
                                ELSE IF RequisitionLines.Type = RequisitionLines.Type::"Fixed Asset" THEN BEGIN
                                        POLines.Type:=POLines.Type::"Fixed Asset";
                                        POLines.VALIDATE("No.", RequisitionLines.No);
                                    END;
                            POLines.Description:=COPYSTR(RequisitionLines.Description, 1, 50);
                            POLines."Location Code":=RequisitionLines."Location Code";
                            POLines.VALIDATE(Quantity, RequisitionLines.Quantity);
                            POLines.VALIDATE("Unit of Measure Code", RequisitionLines."Unit of Measure");
                            POLines.VALIDATE("Direct Unit Cost", RequisitionLines."Unit Price");
                            POLines.VALIDATE("Unit Cost", RequisitionLines."Unit Price");
                            POLines.VALIDATE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            POLines.VALIDATE("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            POLines.MODIFY;
                        END;
                    UNTIL RequisitionLines.NEXT = 0;
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var RequisitionLines: Record "Requisition Lines";
    POLines: Record "Purchase Line";
}
