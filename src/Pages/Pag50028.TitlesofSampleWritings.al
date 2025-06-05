page 50028 "Titles of Sample Writings"
{
    PageType = ListPart;
    SourceTable = "Titles of Sample Writings";

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
                    Visible = false;
                }
                field("Sample No"; "Sample No")
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Entry No"; "Entry No")
                {
                    Visible = false;
                    ApplicationArea = All;

                }
                field("Job ID"; "Job ID")
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
