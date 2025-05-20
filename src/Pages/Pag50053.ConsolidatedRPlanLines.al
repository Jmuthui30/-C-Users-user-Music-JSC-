page 50053 "Consolidated R. Plan Lines"
{
    ApplicationArea = All;
    Caption = 'Consolidated Recruitment Plan Lines';
    PageType = ListPart;
    SourceTable = "Consolidated R. Plan Lines";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Plan No"; Rec."Plan No")
                {
                    Editable = false;
                }
                field("Job ID"; Rec."Job ID")
                {
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    Editable = false;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Editable = false;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    Editable = false;
                }
                field("Position Reporting to Code"; Rec."Position Reporting to Code")
                {
                    Editable = false;
                }
                field("Position Reporting to Name"; Rec."Position Reporting to Name")
                {
                    Editable = false;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    Editable = false;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
            }
        }
    }
}
