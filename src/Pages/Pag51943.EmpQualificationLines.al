page 51943 "Emp Qualification Lines"
{
    AutoSplitKey = true;
    Caption = 'Qualifications';
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "HR_Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                ShowCaption = false;

                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(CourseType; Rec.CourseType)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Grad. Date"; Rec."Grad. Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("City/State"; Rec."City/State")
                {
                    ApplicationArea = All;
                }
                field("Zip/Postal Code"; Rec."Zip/Postal Code")
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Caption = 'Select to Print Letter';
                }
                field("Score ID"; Rec."Score ID")
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
