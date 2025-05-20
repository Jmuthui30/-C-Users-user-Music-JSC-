page 50026 "Applicant Professional Bodies"
{
    PageType = ListPart;
    SourceTable = "Applicant Professional Bodies";
    Caption = 'Professional Bodies';

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Visible = WebServiceVisibility;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Membership/Registration No."; Rec."Membership/Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                }
                field("Membership Type"; Rec."Membership Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if LoginMgmt.IsWebServiceUser(UserId) then
            WebServiceVisibility := true
        else
            WebServiceVisibility := false;
    end;

    var
        LoginMgmt: Codeunit "Login Management Ext";
        WebServiceVisibility: Boolean;
}
