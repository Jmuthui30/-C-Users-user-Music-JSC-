page 53071 "Sample Writings Setup"
{
    ApplicationArea = All;
    Caption = 'Sample Writings Setup';
    PageType = ListPart;
    SourceTable = "Sample Writtings Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Sample No"; "Sample No")
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Sample Header"; "Sample Header")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Job ID"; "Job ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }
}
