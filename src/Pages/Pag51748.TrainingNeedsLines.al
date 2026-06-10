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
        Rec.Status := Rec.Status::Pending;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ApplyHeaderFilters();
        EnsureLineKeys();
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ApplyHeaderFilters();
        exit(true);
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

    local procedure EnsureLineKeys()
    var
        EmployeeTrainingNeeds: Record "Employee Training Needs";
    begin
        Rec.TestField("Document No.");
        Rec.TestField("Employee No.");

        if Rec."Line No." <> 0 then
            exit;

        EmployeeTrainingNeeds.Reset();
        EmployeeTrainingNeeds.SetRange("Document No.", Rec."Document No.");
        EmployeeTrainingNeeds.SetRange("Employee No.", Rec."Employee No.");
        if EmployeeTrainingNeeds.FindLast() then
            Rec."Line No." := EmployeeTrainingNeeds."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    var
        HeaderDocumentNo: Code[20];
        HeaderEmployeeNo: Code[20];
}
