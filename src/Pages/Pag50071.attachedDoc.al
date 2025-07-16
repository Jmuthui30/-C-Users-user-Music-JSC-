page 52971 "Attached Document"
{
    // version BUDGET
    Caption = 'Attached Document';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "SharePoint Intergration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Uploaded On"; Rec.LocalUrl)
                {
                    ApplicationArea = All;
                }
                field("Uploaded By"; Rec.SP_URL_Returned)
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Upload)
            {
                Caption = 'Upload Document';
                Visible = false; // Set to true if you want the action to be visible
                trigger OnAction()
                begin
                    // Code to upload document
                end;
            }
        }
    }
}