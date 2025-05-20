page 50052 "Recruitment Plan Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Recruitment Plan Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job ID"; Rec."Job ID")
                {
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
            }
        }
    }
}
