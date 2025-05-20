page 50027 "Relevant Course & Trainings"
{
    PageType = ListPart;
    SourceTable = "Relevant Courses & Trainings";

    layout
    {
        area(content)
        {
            repeater(Control9)
            {
                ShowCaption = false;

                field("Source No"; Rec."Source No")
                {
                    ApplicationArea = All;
                    Visible = WebServiceVisibility;
                }
                field("Name of the Course"; Rec."Name of the Course")
                {
                    ApplicationArea = All;
                }
                field("University/College/Institution"; Rec."University/College/Institution")
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
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Editable = WebServiceVisibility;
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
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
