page 51983 "All Emp Leave Applications"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Leave Application-Approval";
    SourceTable = "Employee Leave Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Approved Days"; Rec."Approved Days")
                {
                    ApplicationArea = All;
                }
                field("Approved Start Date"; Rec."Approved Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = All;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    ApplicationArea = All;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    ApplicationArea = All;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control25; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control26; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control27; Links)
            {
                ApplicationArea = All;
            }
        }
    }
}
