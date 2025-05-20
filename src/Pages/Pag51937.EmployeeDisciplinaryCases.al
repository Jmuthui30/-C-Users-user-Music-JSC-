page 51937 "Employee Disciplinary Cases"
{
    PageType = ListPart;
    SourceTable = "Employee Disciplinary Cases";
    SourceTableView = where(Status=filter("Action Taken"|Closed));
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                ShowCaption = false;

                field("Refference No"; Rec."Refference No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Case"; Rec."Disciplinary Case")
                {
                    ApplicationArea = All;
                }
                field("Cases Discusion"; Rec."Cases Discusion")
                {
                    ApplicationArea = All;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = All;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = All;
                }
                field("Accused Defence"; Rec."Accused Defence")
                {
                    ApplicationArea = All;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    ApplicationArea = All;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    ApplicationArea = All;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = All;
                }
                field("Date Taken"; Rec."Date Taken")
                {
                    ApplicationArea = All;
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
