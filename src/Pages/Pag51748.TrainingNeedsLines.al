page 51748 "Training Needs Lines"
{
    // version THL- HRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Employee Training Needs";
    SourceTableView = sorting("Document No.", "Employee No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ApplyHeaderFilters();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ApplyHeaderFilters();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ApplyHeaderFilters();
        exit(false);
    end;

    local procedure ApplyHeaderFilters()
    var
        CurrentFilterGroup: Integer;
    begin
        if HeaderDocumentNo <> '' then
            Rec."Document No." := HeaderDocumentNo;

        if HeaderEmployeeNo <> '' then
            Rec."Employee No." := HeaderEmployeeNo;

        if (Rec."Document No." <> '') and (Rec."Employee No." <> '') then
            exit;

        CurrentFilterGroup := Rec.FilterGroup;
        Rec.FilterGroup(4);

        if Rec.GetFilter("Document No.") <> '' then
            Rec."Document No." := Rec.GetRangeMin("Document No.");

        if Rec.GetFilter("Employee No.") <> '' then
            Rec."Employee No." := Rec.GetRangeMin("Employee No.");

        Rec.FilterGroup(CurrentFilterGroup);
    end;

    procedure SetHeaderContext(DocumentNo: Code[20]; EmployeeNo: Code[20])
    begin
        HeaderDocumentNo := DocumentNo;
        HeaderEmployeeNo := EmployeeNo;
    end;

    var
        HeaderDocumentNo: Code[20];
        HeaderEmployeeNo: Code[20];
}
