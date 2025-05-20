page 51660 "Orientation Checklist Lines"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Staff Orientation Checklist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = ListStyle;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = ListStyle;
                }
                field(Timeline; Rec.Timeline)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = ListStyle;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = ListStyle;

                    trigger OnValidate()
                    begin
                        //Style:
                        if Rec.Status = Rec.Status::Completed then ListStyle:='Favorable'
                        else if Rec.Status = Rec.Status::"Not Applicable" then ListStyle:='Ambiguous'
                            else if Rec.Status = Rec.Status::Pending then ListStyle:='Standard';
                    end;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        //Style:
        if Rec.Status = Rec.Status::Completed then ListStyle:='Favorable'
        else if Rec.Status = Rec.Status::"Not Applicable" then ListStyle:='Ambiguous'
            else if Rec.Status = Rec.Status::Pending then ListStyle:='Standard';
    end;
    trigger OnAfterGetRecord()
    begin
        //Style:
        if Rec.Status = Rec.Status::Completed then ListStyle:='Favorable'
        else if Rec.Status = Rec.Status::"Not Applicable" then ListStyle:='Ambiguous'
            else if Rec.Status = Rec.Status::Pending then ListStyle:='Standard';
    end;
    var ListStyle: Text;
}
