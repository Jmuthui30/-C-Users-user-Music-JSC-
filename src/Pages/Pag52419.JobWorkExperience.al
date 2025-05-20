page 52419 "Job Work Experience"
{
    PageType = ListPart;
    SourceTable = "Job Qualifications";
    SourceTableView = where("Qualification Type"=const("Work Experience"));
    Caption = 'Work Experience';

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field("Job Id"; Rec."Job Id")
                {
                    Visible = WebServiceVisibility;
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    Visible = WebServiceVisibility;
                    ApplicationArea = All;
                }
                field(Code; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field(Experience; Rec.Qualification)
                {
                    ApplicationArea = All;
                }
                field("Area of Specialization"; Rec."Area of Specialization")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if LoginMgmt.IsWebServiceUser(UserId)then WebServiceVisibility:=true
        else
            WebServiceVisibility:=false;
    end;
    var LoginMgmt: Codeunit "Login Management Ext";
    WebServiceVisibility: Boolean;
}
