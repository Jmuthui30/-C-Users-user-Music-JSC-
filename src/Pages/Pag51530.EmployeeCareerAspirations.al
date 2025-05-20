page 51530 "Employee Career Aspirations"
{
    AutoSplitKey = true;
    Caption = 'Career Aspirations';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "HR_Employee Career Aspirations";

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
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    end;
}
