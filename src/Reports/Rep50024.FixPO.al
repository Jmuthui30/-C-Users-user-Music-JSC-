report 50024 "Fix PO"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            trigger OnAfterGetRecord()
            begin
                "Purchase Header".CALCFIELDS("Pending Approvals");
                IF("Purchase Header"."Pending Approvals" = 0) AND ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")THEN BEGIN
                    "Purchase Header".Status:="Purchase Header".Status::Committed;
                    "Purchase Header".Status:="Purchase Header".Status::Released;
                    "Purchase Header".MODIFY;
                    Commitment.POCommitment("Purchase Header");
                END;
                "Purchase Header".CALCFIELDS("Pending Approvals");
                IF("Purchase Header"."Pending Approvals" = 1) AND ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")THEN BEGIN
                    Approval.RESET;
                    Approval.SETRANGE("Table ID", 38);
                    Approval.SETRANGE("Document No.", "Purchase Header"."No.");
                    IF Approval.FIND('-')THEN BEGIN
                        REPEAT IF(Approval."Sequence No." = 3) AND (Approval.Status = Approval.Status::Open)THEN Approval.VALIDATE(Status, Approval.Status::Canceled);
                            Approval.MODIFY;
                        UNTIL Approval.NEXT = 0;
                    END;
                END;
                IF("Purchase Header"."Pending Approvals" = 1) AND ("Purchase Header".Status = "Purchase Header".Status::Released)THEN BEGIN
                    Approval.RESET;
                    Approval.SETRANGE("Table ID", 38);
                    Approval.SETRANGE("Document No.", "Purchase Header"."No.");
                    IF Approval.FIND('-')THEN BEGIN
                        REPEAT IF(Approval."Sequence No." = 3) AND (Approval.Status = Approval.Status::Created)THEN Approval.VALIDATE(Status, Approval.Status::Canceled);
                            IF(Approval."Sequence No." = 3) AND (Approval.Status = Approval.Status::Open)THEN Approval.VALIDATE(Status, Approval.Status::Canceled);
                            Approval.MODIFY;
                        UNTIL Approval.NEXT = 0;
                    END;
                END;
                "Purchase Header".CALCFIELDS("Pending Approvals");
                IF("Purchase Header"."Pending Approvals" = 3) AND ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")THEN BEGIN
                    Approval.RESET;
                    Approval.SETRANGE("Table ID", 38);
                    Approval.SETRANGE("Document No.", "Purchase Header"."No.");
                    IF Approval.FIND('-')THEN BEGIN
                        REPEAT IF(Approval."Sequence No." = 2) AND (Approval.Status = Approval.Status::Created)THEN Approval.VALIDATE(Status, Approval.Status::Open);
                            Approval.MODIFY;
                        UNTIL Approval.NEXT = 0;
                    END;
                END;
                "Purchase Header".CALCFIELDS("Pending Approvals");
                IF("Purchase Header"."Pending Approvals" = 2) AND ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")THEN BEGIN //AND ("Purchase Header"."Shortcut Dimension 2 Code" = 'KISUMU') THEN BEGIN
                    Approval.RESET;
                    Approval.SETRANGE("Table ID", 38);
                    Approval.SETRANGE("Document No.", "Purchase Header"."No.");
                    IF Approval.FIND('-')THEN BEGIN
                        REPEAT IF(Approval."Sequence No." = 1) AND (Approval.Status = Approval.Status::Open)THEN Approval.VALIDATE(Status, Approval.Status::Canceled);
                            IF(Approval."Sequence No." = 3) AND (Approval.Status = Approval.Status::Created)THEN Approval.VALIDATE(Status, Approval.Status::Open);
                            Approval.MODIFY;
                        UNTIL Approval.NEXT = 0;
                    END;
                END;
                "Purchase Header".CALCFIELDS("Pending Approvals");
                IF("Purchase Header"."Pending Approvals" = 4) AND ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval") AND ("Purchase Header"."Shortcut Dimension 2 Code" = 'KISUMU')THEN BEGIN
                    Approval.RESET;
                    Approval.SETRANGE("Table ID", 38);
                    Approval.SETRANGE("Document No.", "Purchase Header"."No.");
                    IF Approval.FIND('-')THEN BEGIN
                        REPEAT IF(Approval."Sequence No." = 1) AND (Approval.Status = Approval.Status::Open)THEN Approval.VALIDATE(Status, Approval.Status::Canceled);
                            Approval.MODIFY;
                        UNTIL Approval.NEXT = 0;
                    END;
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
    var Approval: Record "Approval Entry";
    Commitment: Codeunit "Commitment Management";
}
