page 51988 "Applicant Qualification"
{
    PageType = ListPart;
    SourceTable = "Applicants Qualification";

    layout
    {
        area(content)
        {
            repeater(Control9)
            {
                ShowCaption = false;

                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Area of Specialization"; Rec."Area of Specialization")
                {
                    ApplicationArea = All;
                }
                field("Grade/Class"; Rec."Grade/Class")
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = All;
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                //field(Qualification;Qualification){}
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
